From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH] leds: Add no-op gpio_led_register_device when LED
 subsystem is disabled
Date: Tue, 21 Jun 2016 09:09:09 +0200
Message-ID: <5768E815.5080706@samsung.com>
References: <20160613200211.14790-1-afd@ti.com>
 <20160613200211.14790-13-afd@ti.com> <5760FA52.7010806@samsung.com>
 <57647DBD.2010406@ti.com> <57679E38.3080901@samsung.com>
 <57686A94.2010704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-reply-to: <57686A94.2010704@ti.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: "Andrew F. Davis" <afd@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, linux-i2c@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Aloisio Almeida Jr <aloisio.almeida@openbossa.org>, lguest@lists.ozlabs.org, Samuel Ortiz <sameo@linux.intel.com>, Russell King <linux@armlinux.org.uk>, linux-leds@vger.kernel.org, linux-mmc@vger.kernel.org, linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Rusty Russell <rusty@rustcorp.com.au>, linux-gpio@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Lauro Ramos Venancio <lauro.venancio@openbossa.org>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

SGkgQW5kcmV3LAoKVGhpcyBwYXRjaCBkb2Vzbid0IGFwcGx5LCBwbGVhc2UgcmViYXNlIG9udG8g
cmVjZW50IExFRCB0cmVlLgoKT24gMDYvMjEvMjAxNiAxMjoxMyBBTSwgQW5kcmV3IEYuIERhdmlz
IHdyb3RlOgo+IFNvbWUgc3lzdGVtcyB1c2UgJ2dwaW9fbGVkX3JlZ2lzdGVyX2RldmljZScgdG8g
bWFrZSBhbiBpbi1tZW1vcnkgY29weSBvZgo+IHRoZWlyIExFRCBkZXZpY2UgdGFibGUgc28gdGhl
IG9yaWdpbmFsIGNhbiBiZSByZW1vdmVkIGFzIC5pbml0LnJvZGF0YS4KPiBXaGVuIHRoZSBMRUQg
c3Vic3lzdGVtIGlzIG5vdCBlbmFibGVkIHNvdXJjZSBpbiB0aGUgbGVkIGRpcmVjdG9yeSBpcyBu
b3QKPiBidWlsdCBhbmQgc28gdGhpcyBmdW5jdGlvbiBtYXkgYmUgdW5kZWZpbmVkLiBGaXggdGhp
cyBoZXJlLgo+Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmV3IEYuIERhdmlzIDxhZmRAdGkuY29tPgo+
IC0tLQo+ICAgaW5jbHVkZS9saW51eC9sZWRzLmggfCA4ICsrKysrKysrCj4gICAxIGZpbGUgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9sZWRz
LmggYi9pbmNsdWRlL2xpbnV4L2xlZHMuaAo+IGluZGV4IGQyYjEzMDYuLmE0YTNkYTYgMTAwNjQ0
Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9sZWRzLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L2xlZHMu
aAo+IEBAIC0zODYsOCArMzg2LDE2IEBAIHN0cnVjdCBncGlvX2xlZF9wbGF0Zm9ybV9kYXRhIHsK
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcg
KmRlbGF5X29mZik7CgpDdXJyZW50bHkgdGhlcmUgaXMgc29tZSBzdHVmZiBoZXJlLCBhbmQgaW4g
ZmFjdCBpdCBoYXMgYmVlbiBmb3IKYSBsb25nIHRpbWUuCgpQYXRjaCAiW1BBVENIIDEyLzEyXSBs
ZWRzOiBPbmx5IGRlc2NlbmQgaW50byBsZWRzIGRpcmVjdG9yeSB3aGVuCkNPTkZJR19ORVdfTEVE
UyBpcyBzZXQiIGFsc28gZG9lc24ndCBhcHBseS4KV2hhdCByZXBvc2l0b3J5IGFyZSB5b3UgdXNp
bmc/Cgo+ICAgfTsKPgo+ICsjaWZkZWYgQ09ORklHX05FV19MRURTCj4gICBzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpncGlvX2xlZF9yZWdpc3Rlcl9kZXZpY2UoCj4gICAgICAgICAgICAgICAgICBp
bnQgaWQsIGNvbnN0IHN0cnVjdCBncGlvX2xlZF9wbGF0Zm9ybV9kYXRhICpwZGF0YSk7Cj4gKyNl
bHNlCj4gK3N0YXRpYyBpbmxpbmUgc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZ3Bpb19sZWRfcmVn
aXN0ZXJfZGV2aWNlKAo+ICsgICAgICAgICAgICAgICBpbnQgaWQsIGNvbnN0IHN0cnVjdCBncGlv
X2xlZF9wbGF0Zm9ybV9kYXRhICpwZGF0YSkKPiArewo+ICsgICAgICAgcmV0dXJuIDA7Cj4gK30K
PiArI2VuZGlmCj4KPiAgIGVudW0gY3B1X2xlZF9ldmVudCB7Cj4gICAgICAgICAgQ1BVX0xFRF9J
RExFX1NUQVJULCAgICAgLyogQ1BVIGVudGVycyBpZGxlICovCj4KCgotLSAKQmVzdCByZWdhcmRz
LApKYWNlayBBbmFzemV3c2tpCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QKTGludXhwcGMtZGV2QGxpc3RzLm96
bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xpbnV4cHBjLWRldg==
