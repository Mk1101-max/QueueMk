-- =====================================================================
-- ระบบคิวรับน้ำมัน — สคริปต์สร้างตารางใน Supabase
-- วิธีใช้: Supabase → SQL Editor → วางทั้งหมดนี้ → กด Run
-- =====================================================================

-- ตารางคิว (ลูกค้าที่รับคิวเข้ามา)
create table if not exists tickets (
  id          text primary key,
  type        text not null,              -- 'in' | 'out'
  no          int  not null,
  name        text,
  car_no      text,
  station     text,
  depot       text,
  trip        text,
  company     text,
  phone       text,
  plate       text,
  note        text,
  product     text,
  volume      text,
  items       jsonb,
  status      text,
  created_at  bigint
);

-- ตารางเที่ยวรถ (อัปโหลดจากไฟล์)
create table if not exists trips (
  id       text primary key,
  car_no   text,
  station  text,
  depot    text,
  trip     text,
  sheet    text
);

-- ตารางสถานะที่เพิ่มเอง (เก็บเฉพาะที่ผู้ใช้เพิ่ม นอกเหนือค่าเริ่มต้น)
create table if not exists statuses (
  name text primary key,
  ord  int
);

-- ตารางเพลย์ลิสต์วิดีโอ
create table if not exists playlist (
  id   text primary key,
  url  text,
  vid  text,
  ord  int
);

-- ตารางประวัติสถานี (สถานีไหนปรากฏวันไหน)
create table if not exists history (
  station text,
  date    text,
  primary key (station, date)
);

-- ตารางตั้งค่าทั่วไป (โหมดเล่นวิดีโอ, คิวที่กำลังเรียก, คำขอพูด)
create table if not exists app_state (
  key   text primary key,
  value jsonb
);

-- =====================================================================
-- เปิด Realtime ให้ทุกตาราง (ให้ทุกจอเห็นการเปลี่ยนแปลงทันที)
-- =====================================================================
alter publication supabase_realtime add table tickets;
alter publication supabase_realtime add table trips;
alter publication supabase_realtime add table statuses;
alter publication supabase_realtime add table playlist;
alter publication supabase_realtime add table history;
alter publication supabase_realtime add table app_state;

-- =====================================================================
-- เปิดสิทธิ์อ่าน/เขียนแบบสาธารณะ (ระบบนี้ใช้ในวงงานภายใน ไม่มี login)
-- ความปลอดภัยอยู่ที่รหัส 6 หลักหน้า Admin + การไม่เผยแพร่ลิงก์
-- =====================================================================
alter table tickets   enable row level security;
alter table trips     enable row level security;
alter table statuses  enable row level security;
alter table playlist  enable row level security;
alter table history   enable row level security;
alter table app_state enable row level security;

do $$
declare t text;
begin
  foreach t in array array['tickets','trips','statuses','playlist','history','app_state']
  loop
    execute format('drop policy if exists "public_all" on %I;', t);
    execute format('create policy "public_all" on %I for all using (true) with check (true);', t);
  end loop;
end $$;
