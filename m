From: Patrice CHOTARD <patrice.chotard@st.com>
Subject: Re: [PATCH v2 14/15] clk: stm32: Add clk entry for SDMMC2 on
 stm32F769
Date: Mon, 26 Feb 2018 08:41:13 +0000
Message-ID: <fb3b26e8-0102-122b-1386-68a661139706@st.com>
References: <1516105859-3525-1-git-send-email-patrice.chotard@st.com>
 <1516105859-3525-15-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516105859-3525-15-git-send-email-patrice.chotard@st.com>
Content-Language: en-US
Content-ID: <A88FDEF8E44142408AB72F0919C1903F@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre TORGUE <alexandre.torgue@st.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

SGkgU3RlcGhlbiwgTWljaGFlbA0KDQpJdCdzIGEgZ2VudGxlIHJlbWluZGVyIGFzIHRoaXMgcGF0
Y2ggaXMgcHJlc2VudCBvbiBtYWlsaW5nIGxpc3QgYW5kIA0KYWNrZWQtYnkgc2luY2UgMDEvMTIv
MjAxOA0KDQpUaGFua3MNCg0KUGF0cmljZQ0KDQpPbiAwMS8xNi8yMDE4IDAxOjMwIFBNLCBwYXRy
aWNlLmNob3RhcmRAc3QuY29tIHdyb3RlOg0KPiBGcm9tOiBQYXRyaWNlIENob3RhcmQgPHBhdHJp
Y2UuY2hvdGFyZEBzdC5jb20+DQo+IA0KPiBTVE0zMkY3NjkgaGFzIDIgU0RNTUMgcG9ydCwgYWRk
IGNsb2NrIGVudHJ5IGZvciB0aGUgc2Vjb25kIG9uZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFs
ZXhhbmRyZSBUT1JHVUUgPGFsZXhhbmRyZS50b3JndWVAc3QuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBQYXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+DQo+IEFja2VkLWJ5OiBT
dGVwaGVuIEJveWQgPHNib3lkQGNvZGVhdXJvcmEub3JnPg0KPiAtLS0NCj4gDQo+IHYyIF8gQWRk
IEFja2VkLWJ5DQo+IA0KPiAgIGRyaXZlcnMvY2xrL2Nsay1zdG0zMmY0LmMgfCAzICsrLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9jbGstc3RtMzJmNC5jIGIvZHJpdmVycy9jbGsvY2xrLXN0
bTMyZjQuYw0KPiBpbmRleCA5NmM2YjZiLi44ZjhhMTc4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2Nsay9jbGstc3RtMzJmNC5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2Nsay1zdG0zMmY0LmMNCj4g
QEAgLTI4Miw2ICsyODIsNyBAQCBzdHJ1Y3Qgc3RtMzJmNF9nYXRlX2RhdGEgew0KPiAgIA0KPiAg
IAl7IFNUTTMyRjRfUkNDX0FQQjJFTlIsICAwLAkidGltMSIsCQkiYXBiMl9tdWwiIH0sDQo+ICAg
CXsgU1RNMzJGNF9SQ0NfQVBCMkVOUiwgIDEsCSJ0aW04IiwJCSJhcGIyX211bCIgfSwNCj4gKwl7
IFNUTTMyRjRfUkNDX0FQQjJFTlIsICA3LAkic2RtbWMyIiwJInNkbXV4IiAgICB9LA0KPiAgIAl7
IFNUTTMyRjRfUkNDX0FQQjJFTlIsICA4LAkiYWRjMSIsCQkiYXBiMl9kaXYiIH0sDQo+ICAgCXsg
U1RNMzJGNF9SQ0NfQVBCMkVOUiwgIDksCSJhZGMyIiwJCSJhcGIyX2RpdiIgfSwNCj4gICAJeyBT
VE0zMkY0X1JDQ19BUEIyRU5SLCAxMCwJImFkYzMiLAkJImFwYjJfZGl2IiB9LA0KPiBAQCAtMzE1
LDcgKzMxNiw3IEBAIHN0cnVjdCBzdG0zMmY0X2dhdGVfZGF0YSB7DQo+ICAgDQo+ICAgc3RhdGlj
IGNvbnN0IHU2NCBzdG0zMmY3NDZfZ2F0ZV9tYXBbTUFYX0dBVEVfTUFQXSA9IHsgMHgwMDAwMDBm
MTdlZjQxN2ZmdWxsLA0KPiAgIAkJCQkJCSAgICAgIDB4MDAwMDAwMDAwMDAwMDAwM3VsbCwNCj4g
LQkJCQkJCSAgICAgIDB4MDRmNzdmMDMzZTAxYzlmZnVsbCB9Ow0KPiArCQkJCQkJICAgICAgMHgw
NGY3N2Y4MzNlMDFjOWZmdWxsIH07DQo+ICAgDQo+ICAgc3RhdGljIGNvbnN0IHU2NCAqc3RtMzJm
NF9nYXRlX21hcDsNCj4gICANCj4g
