/* =====================================================================
   ไฟล์ตั้งค่าระบบคิว — แก้ค่าตรงนี้ที่เดียว
   =====================================================================

   วิธีตั้งค่า Supabase:
   1. ไปที่ https://supabase.com สร้างโปรเจกต์ใหม่ (ฟรี)
   2. เมนูซ้าย → Project Settings → Data API (หรือ API)
      - คัดลอก "Project URL" มาวางที่ SUPABASE_URL
      - คัดลอก "anon public" key มาวางที่ SUPABASE_ANON_KEY
   3. เมนูซ้าย → SQL Editor → วางเนื้อหาไฟล์ supabase_setup.sql แล้วกด Run
   4. บันทึกไฟล์นี้ แล้วอัปขึ้น GitHub พร้อมไฟล์อื่น

   ถ้าปล่อยค่าว่างไว้ (ไม่ใส่คีย์) ระบบจะทำงานแบบเครื่องเดียว
   (sync เฉพาะแท็บในเครื่องเดียวกัน เหมือนเวอร์ชันก่อน)
   ===================================================================== */

window.APP_CONFIG = {
  // วาง URL และ anon key ของ Supabase ตรงนี้
  SUPABASE_URL:      "https://ebtrutumbctxixnkksgg.supabase.co",   // เช่น "https://abcdefgh.supabase.co"
  SUPABASE_ANON_KEY: "sb_publishable_FNONS70MgJNZ4FCtgbQx6w__PfI0N0Z",   // เช่น "eyJhbGciOi....."

  // รหัสผ่านเข้าหน้า Admin (6 หลัก)
  ADMIN_PIN: "000596",
};
