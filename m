From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 05/46] ARM: pxa: split up mach/hardware.h
Date: Mon, 28 Oct 2019 02:18:24 -0700
Message-ID: <20191028091825.A1F3B20717@mail.kernel.org>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-5-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20191018154201.1276638-5-arnd@arndb.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-usb@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-mtd@lists.infradead.org, Pavel Machek <pavel@ucw.cz>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-
List-Id: linux-mmc@vger.kernel.org

UXVvdGluZyBBcm5kIEJlcmdtYW5uICgyMDE5LTEwLTE4IDA4OjQxOjIwKQo+IFRoZSBtYWNoL2hh
cmR3YXJlLmggaXMgaW5jbHVkZWQgaW4gbG90cyBvZiBwbGFjZXMsIGFuZCBpdCBwcm92aWRlcwo+
IHRocmVlIGRpZmZlcmVudCB0aGluZ3Mgb24gcHhhOgo+IAo+IC0gdGhlIGNwdV9pc19weGEqIG1h
Y3Jvcwo+IC0gYW4gaW5kaXJlY3QgaW5jbHVzaW9uIG9mIG1hY2gvYWRkci1tYXAuaAo+IC0gdGhl
IF9fUkVHKCkgYW5kIGlvX3B2MigpIGhlbHBlciBtYWNyb3MKPiAKPiBTcGxpdCBpdCB1cCBpbnRv
IHNlcGFyYXRlIDxsaW51eC9zb2MvcHhhL2NwdS5oPiBhbmQgbWFjaC9weGEtcmVncy5oCj4gaGVh
ZGVycywgdGhlbiBjaGFuZ2UgYWxsIHRoZSBmaWxlcyB0aGF0IHVzZSBtYWNoL2hhcmR3YXJlLmgg
dG8KPiBpbmNsdWRlIHRoZSBleGFjdCBzZXQgb2YgdGhvc2UgdGhyZWUgaGVhZGVycyB0aGF0IHRo
ZXkgYWN0dWFsbHkKPiBuZWVkLCBhbGxvd2luZyBmb3IgZnVydGhlciBtb3JlIHRhcmdldGVkIGNs
ZWFudXAuCj4gCj4gbGludXgvc29jL3B4YS9jcHUuaCBjYW4gcmVtYWluIHBlcm1hbmVudGx5IGV4
cG9ydGVkIGFuZCBpcyBub3cgaW4KPiBhIGdsb2JhbCBsb2NhdGlvbiBhbG9uZyB3aXRoIHNpbWls
YXIgaGVhZGVycy4gcHhhLXJlZ3MuaCBhbmQKPiBhZGRyLW1hcC5oIGFyZSBvbmx5IHVzZWQgaW4g
YSB2ZXJ5IHNtYWxsIG51bWJlciBvZiBkcml2ZXJzIG5vdwo+IGFuZCBjYW4gYmUgbW92ZWQgdG8g
YXJjaC9hcm0vbWFjaC1weGEvIGRpcmVjdGx5IHdoZW4gdGhvc2UgZHJpdmVycwo+IGFyZSB0byBw
YXNzIHRoZSBuZWNlc3NhcnkgZGF0YSBhcyByZXNvdXJjZXMuCj4gCj4gQ2M6IE1pY2hhZWwgVHVy
cXVldHRlIDxtdHVycXVldHRlQGJheWxpYnJlLmNvbT4KPiBDYzogU3RlcGhlbiBCb3lkIDxzYm95
ZEBrZXJuZWwub3JnPgo+IENjOiBWaXJlc2ggS3VtYXIgPHZpcmVzaC5rdW1hckBsaW5hcm8ub3Jn
Pgo+IENjOiBEbWl0cnkgVG9yb2tob3YgPGRtaXRyeS50b3Jva2hvdkBnbWFpbC5jb20+Cj4gQ2M6
IEphY2VrIEFuYXN6ZXdza2kgPGphY2VrLmFuYXN6ZXdza2lAZ21haWwuY29tPgo+IENjOiBQYXZl
bCBNYWNoZWsgPHBhdmVsQHVjdy5jej4KPiBDYzogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxp
bmFyby5vcmc+Cj4gQ2M6IERvbWluaWsgQnJvZG93c2tpIDxsaW51eEBkb21pbmlrYnJvZG93c2tp
Lm5ldD4KPiBDYzogQWxleGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4u
Y29tPgo+IENjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3Jn
Pgo+IENjOiBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+Cj4gQ2M6IE1hcmsgQnJv
d24gPGJyb29uaWVAa2VybmVsLm9yZz4KPiBDYzogbGludXgtY2xrQHZnZXIua2VybmVsLm9yZwo+
IENjOiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogbGludXgtaW5wdXRAdmdlci5rZXJu
ZWwub3JnCj4gQ2M6IGxpbnV4LWxlZHNAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGxpbnV4LW1tY0B2
Z2VyLmtlcm5lbC5vcmcKPiBDYzogbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBDYzog
bGludXgtcnRjQHZnZXIua2VybmVsLm9yZwo+IENjOiBsaW51eC11c2JAdmdlci5rZXJuZWwub3Jn
Cj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogbGludXgtZmJkZXZA
dmdlci5rZXJuZWwub3JnCj4gQ2M6IGxpbnV4LXdhdGNoZG9nQHZnZXIua2VybmVsLm9yZwo+IENj
OiBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKPiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdt
YW5uIDxhcm5kQGFybmRiLmRlPgo+IC0tLQoKQWNrZWQtYnk6IFN0ZXBoZW4gQm95ZCA8c2JveWRA
a2VybmVsLm9yZz4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZl
bA==
