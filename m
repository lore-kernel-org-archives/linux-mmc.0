From: Lihua Yao <ylhuajnu@outlook.com>
Subject: Re: [PATCH 00/36] ARM: samsung platform cleanup
Date: Wed, 23 Oct 2019 15:17:57 +0000
Message-ID: <BY5PR12MB3699C846E761F257D0FB1373C46B0@BY5PR12MB3699.namprd12.prod.outlook.com>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191023131049.GG11048@pi3>
 <CAK8P3a1v2-+geD+JbNP-t418ZjntQNSte4rt8c7N6sJdpb3+DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK8P3a1v2-+geD+JbNP-t418ZjntQNSte4rt8c7N6sJdpb3+DQ@mail.gmail.com>
Content-Language: en-US
Content-ID: <DCE39A5A7726614091BE95843816F1DC@namprd12.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, dri-devel <dri-devel@lists.freedesktop.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "moderated
 list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "open list:HID
 CORE LAYER" <linux-input@vger.kernel.org>, =?utf-8?B?UGF3ZcWCIENobWllbA==?= <pawel.mikolaj.chmiel@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Sergio Prado <sergio.prado@e-labworks.com>, Linux PM list <linux-pm@vger.kernel.org>, Lihua Yao <ylhuajnu@163.com>Linux ARM <linu>
List-Id: linux-mmc@vger.kernel.org

SGkgQXJuZCwgS3J6eXN6dG9mLA0KDQpPbiAyMy8xMC8yMDE5IDk6MzkgUE0sIEFybmQgQmVyZ21h
bm4gd3JvdGU6DQo+IE9uIFdlZCwgT2N0IDIzLCAyMDE5IGF0IDM6MTEgUE0gS3J6eXN6dG9mIEtv
emxvd3NraSA8a3J6a0BrZXJuZWwub3JnPiB3cm90ZToNCj4+IE9uIFRodSwgT2N0IDEwLCAyMDE5
IGF0IDEwOjI4OjAyUE0gKzAyMDAsIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+Pj4gVGhlIGNvbnRl
bnRzIGFyZSBhdmFpbGFibGUgZm9yIHRlc3RpbmcgaW4NCj4+Pg0KPj4+IGdpdDovL2tlcm5lbC5v
cmc6L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9hcm5kL3BsYXlncm91bmQuZ2l0IHMzYy1tdWx0
aXBsYXRmb3JtDQo+PiBXaGVuIHNlbmRpbmcgdjIsIGNhbiB5b3UgQ2M6DQo+Pg0KPj4gUGF3ZcWC
IENobWllbCA8cGF3ZWwubWlrb2xhai5jaG1pZWxAZ21haWwuY29tPg0KPj4gTGlodWEgWWFvIDx5
bGh1YWpudUBvdXRsb29rLmNvbT4NCj4+IChvciBMaWh1YSBZYW8gPHlsaHVham51QDE2My5jb20+
IGlmIG91dGxvb2suY29tIGJvdW5jZXMpDQoNCllvdSBjb3VsZCByZWFjaCBtZSBieSBlLW1haWwg
dG8gTGlodWEgWWFvIDxsaWh1YS55YW9AZ214LmNvbT4uDQoNCk5laXRoZXIgMTYzLmNvbSBub3Ig
b3V0bG9vay5jb20gZS1tYWlsIHNlcnZlciBjb29wZXJhdGVzIHdlbGwgd2l0aA0KDQp2Z2VyLmtl
cm5lbC5vcmcgbWFpbCBsaXN0Lg0KDQo+PiBTZXJnaW8gUHJhZG8gPHNlcmdpby5wcmFkb0BlLWxh
YndvcmtzLmNvbT4NCj4+IFN5bHdlc3RlciBOYXdyb2NraSA8cy5uYXdyb2NraUBzYW1zdW5nLmNv
bT4NCj4+DQo+PiBUaGVzZSBhcmUgZm9sa3Mgd2hpY2ggdG8gbXkga25vd2xlZGdlIGhhZCB3b3Jr
aW5nIFMzQyBhbmQgUzVQIGJvYXJkcw0KPj4gc28gbWF5YmUgdGhleSBjb3VsZCBwcm92aWRlIHRl
c3RpbmcuDQo+IE9rLCB3aWxsIGRvLiBJJ3ZlIHVwbG9hZGVkIHRoZSBtb2RpZmllZCB2ZXJzaW9u
IGJhc2VkIG9uIHlvdXIgY29tbWVudHMgdG8NCj4gdGhlIGFib3ZlIFVSTCBmb3Igbm93Lg0KPg0K
PiBJJ2xsIHByb2JhYmx5IGdpdmUgaXQgYSBsaXR0bGUgbW9yZSB0aW1lIGJlZm9yZSByZXNlbmRp
bmcsIGJ1dCB0aGV5DQo+IGNvdWxkIGFscmVhZHkNCj4gc3RhcnQgdGVzdGluZyB0aGF0IHZlcnNp
b24uDQoNCk5pY2XvvIHCoCBTYWRseSBJIGFtIG9uIHZvY2F0aW9uIGFuZCB3aWxsIHRlc3QgaXQg
dW50aWwgTm92IDE1Lg0KDQpCZXN0IFJlZ2FyZHMNCg0KTGlodWENCg0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5n
IGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
