From: "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
Subject: Re: [PATCH v6 09/11] mmc: sdhci-acpi: Make PCI dependency explicit
Date: Mon, 7 Jan 2019 12:48:41 +0000
Message-ID: <39e66940-87ea-f492-5e3b-3bdbe74edf78@amd.com>
References: <20190105100606.6673-1-okaya@kernel.org>
 <20190105100606.6673-10-okaya@kernel.org>
 <CAJZ5v0gXM3d0uuaQPyeafVS3S1tNbo0gY5TMskpQptNGvmVKzA@mail.gmail.com>
 <39fa9438-8928-5a1b-2a86-617df39e4c73@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <39fa9438-8928-5a1b-2a86-617df39e4c73@intel.com>
Content-Language: en-US
Content-ID: <07B7F27FE1EB5F44B54E9D16F6E13622@namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Sinan Kaya <okaya@kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Paul Cercueil <paul@crapouillou.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Faiz Abbas <faiz_abbas@ti.com>, Chunyan Zhang <chunyan.zhang@unisoc.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Ludovic Barre <ludovic.barre@st.com>, Arnd Bergmann <arnd@arndb.de>, Alex Smith <alex.smith@imgtec.com>, Chris Brandt <chris.brandt@renesas.com>, "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
List-Id: linux-mmc@vger.kernel.org

SGkNCg0KT24gMS83LzIwMTkgNjoxMiBQTSwgQWRyaWFuIEh1bnRlciB3cm90ZToNCj4gT24gNy8w
MS8xOSAxOjE3IFBNLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90ZToNCj4+IE9uIFNhdCwgSmFuIDUs
IDIwMTkgYXQgMTE6MDYgQU0gU2luYW4gS2F5YSA8b2theWFAa2VybmVsLm9yZz4gd3JvdGU6DQo+
Pj4NCj4+PiBBZnRlciAnY29tbWl0IDVkMzJhNjY1NDFjNCAoIlBDSS9BQ1BJOiBBbGxvdyBBQ1BJ
IHRvIGJlIGJ1aWx0IHdpdGhvdXQNCj4+PiBDT05GSUdfUENJIHNldCIpJyBkZXBlbmRlbmNpZXMg
b24gQ09ORklHX1BDSSB0aGF0IHByZXZpb3VzbHkgd2VyZQ0KPj4+IHNhdGlzZmllZCBpbXBsaWNp
dGx5IHRocm91Z2ggZGVwZW5kZW5jaWVzIG9uIENPTkZJR19BQ1BJIGhhdmUgdG8gYmUNCj4+PiBz
cGVjaWZpZWQgZGlyZWN0bHkuIFRoaXMgZHJpdmVyIHJlbGllcyBvbiBJT1NGX01CSSBhbmQgSU9T
Rl9NQkkgZGVwZW5kcw0KPj4+IG9uIFBDSS4gRm9yIHRoaXMgcmVhc29uLCBhZGQgYSBkaXJlY3Qg
ZGVwZW5kZW5jeSB0byBDT05GSUdfUENJIGhlcmUuDQo+Pj4NCj4+PiBGaXhlczogNWQzMmE2NjU0
MWM0NiAoIlBDSS9BQ1BJOiBBbGxvdyBBQ1BJIHRvIGJlIGJ1aWx0IHdpdGhvdXQgQ09ORklHX1BD
SSBzZXQiKQ0KPj4+IFNpZ25lZC1vZmYtYnk6IFNpbmFuIEtheWEgPG9rYXlhQGtlcm5lbC5vcmc+
DQo+Pj4gLS0tDQo+Pj4gIGRyaXZlcnMvbW1jL2hvc3QvS2NvbmZpZyB8IDIgKy0NCj4+PiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9LY29uZmlnIGIvZHJpdmVycy9tbWMvaG9zdC9LY29u
ZmlnDQo+Pj4gaW5kZXggZTI2YjgxNDVlZmIzLi4xYjk0MDFmZTk0YzAgMTAwNjQ0DQo+Pj4gLS0t
IGEvZHJpdmVycy9tbWMvaG9zdC9LY29uZmlnDQo+Pj4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9L
Y29uZmlnDQo+Pj4gQEAgLTExNiw3ICsxMTYsNyBAQCBjb25maWcgTU1DX1JJQ09IX01NQw0KPj4+
DQo+Pj4gIGNvbmZpZyBNTUNfU0RIQ0lfQUNQSQ0KPj4+ICAgICAgICAgdHJpc3RhdGUgIlNESENJ
IHN1cHBvcnQgZm9yIEFDUEkgZW51bWVyYXRlZCBTREhDSSBjb250cm9sbGVycyINCj4+PiAtICAg
ICAgIGRlcGVuZHMgb24gTU1DX1NESENJICYmIEFDUEkNCj4+PiArICAgICAgIGRlcGVuZHMgb24g
TU1DX1NESENJICYmIEFDUEkgJiYgUENJDQo+Pj4gICAgICAgICBzZWxlY3QgSU9TRl9NQkkgaWYg
WDg2DQo+Pj4gICAgICAgICBoZWxwDQo+Pj4gICAgICAgICAgIFRoaXMgc2VsZWN0cyBzdXBwb3J0
IGZvciBBQ1BJIGVudW1lcmF0ZWQgU0RIQ0kgY29udHJvbGxlcnMsDQo+Pj4gLS0NCj4+DQo+PiBB
bnkgb2JqZWN0aW9ucyBhZ2FpbnN0IHRoaXMgb25lIGZyb20gYW55b25lPw0KPiANCj4gKyBRQ09N
IGFuZCBBTUQgY29udHJpYnV0b3JzDQo+IA0KDQpObyBpc3N1ZXMgd2l0aCB1cyBhcyB3ZSBoYXZl
IHNlcGFyYXRlIFBDSSBiYXNlZCBkcml2ZXIgYW5kIEFDUEkgYmFzZWQgZHJpdmVyLg0KDQpSZWdh
cmRzDQpOZWhhbCBTaGFoDQo=
