// Simple Express server that serves seller locations for development
// Usage:
// 1. cd server
// 2. npm install
// 3. node server.js

const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const locations = [
  {
    id: '1',
    nama: 'Warung Kita - Pusat',
    latitude: -7.2504,
    longitude: 112.7488,
    alamat: 'Jl. Ahmad Yani No. 1, Surabaya, Jawa Timur',
    nomor_telepon: '081234567890',
    jam_buka: '10:00',
    jam_tutup: '22:00',
    rating: 4.5,
    foto_url: 'assets/LOGO.png',
    kategori_makanan: ['Nasi Goreng', 'Mie Ayam', 'Soto Ayam']
  },
  {
    id: '2',
    nama: 'Warung Kita - Cabang Jemursari',
    latitude: -7.2546,
    longitude: 112.7623,
    alamat: 'Jl. Jemursari No. 45, Surabaya, Jawa Timur',
  nomor_telepon: '081298765432',
  jam_buka: '09:00',
  jam_tutup: '23:00',
  rating: 4.7,
  foto_url: 'assets/LOGO.png',
  kategori_makanan: ['Bakso', 'Lumpia', 'Martabak'],
  },
  {
    id: '3',
    nama: 'Warung Kita - Cabang Kenjeran',
    latitude: -7.2276,
    longitude: 112.7457,
    alamat: 'Jl. Kenjeran No. 78, Surabaya, Jawa Timur',
  nomor_telepon: '081345678901',
  jam_buka: '08:00',
  jam_tutup: '22:00',
  rating: 4.3,
  foto_url: 'assets/LOGO.png',
  kategori_makanan: ['Es Cendol', 'Es Jeruk', 'Teh Manis'],
  },
  {
    id: '4',
    nama: 'Warung Kita - Cabang Tegalsari',
    latitude: -7.2394,
    longitude: 112.7334,
    alamat: 'Jl. Tegalsari No. 123, Surabaya, Jawa Timur',
  nomor_telepon: '081567890123',
  jam_buka: '10:30',
  jam_tutup: '21:30',
  rating: 4.6,
  foto_url: 'assets/LOGO.png',
  kategori_makanan: ['Rendang', 'Sate Ayam', 'Gado-Gado'],
  },
  {
    id: '5',
    nama: 'Warung Kita - Cabang Genteng',
    latitude: -7.2569,
    longitude: 112.7416,
    alamat: 'Jl. Genteng Kali No. 56, Surabaya, Jawa Timur',
  nomor_telepon: '081678901234',
  jam_buka: '11:00',
  jam_tutup: '23:30',
  rating: 4.4,
  foto_url: 'assets/LOGO.png',
  kategori_makanan: ['Crispy Calamari', 'Pasta', 'Steak'],
  }
];

app.get('/api/locations', (req, res) => {
  res.json(locations);
});

app.get('/', (req, res) => {
  res.send('Seller locations API is running. Endpoint: /api/locations');
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
