From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH] leds: Add no-op gpio_led_register_device when LED
 subsystem is disabled
Date: Tue, 21 Jun 2016 06:48:10 -0500
Message-ID: <5769297A.4050608@ti.com>
References: <20160613200211.14790-1-afd@ti.com>
 <20160613200211.14790-13-afd@ti.com> <5760FA52.7010806@samsung.com>
 <57647DBD.2010406@ti.com> <57679E38.3080901@samsung.com>
 <57686A94.2010704@ti.com> <5768E815.5080706@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <5768E815.5080706@samsung.com>
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
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, linux-i2c@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Aloisio Almeida Jr <aloisio.almeida@openbossa.org>, lguest@lists.ozlabs.org, Samuel Ortiz <sameo@linux.intel.com>, Russell King <linux@armlinux.org.uk>, linux-leds@vger.kernel.org, linux-mmc@vger.kernel.org, linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Rusty Russell <rusty@rustcorp.com.au>, linux-gpio@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Lauro Ramos Venancio <lauro.venancio@openbossa.org>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

T24gMDYvMjEvMjAxNiAwMjowOSBBTSwgSmFjZWsgQW5hc3pld3NraSB3cm90ZToKPiBIaSBBbmRy
ZXcsCj4gCj4gVGhpcyBwYXRjaCBkb2Vzbid0IGFwcGx5LCBwbGVhc2UgcmViYXNlIG9udG8gcmVj
ZW50IExFRCB0cmVlLgo+IAo+IE9uIDA2LzIxLzIwMTYgMTI6MTMgQU0sIEFuZHJldyBGLiBEYXZp
cyB3cm90ZToKPj4gU29tZSBzeXN0ZW1zIHVzZSAnZ3Bpb19sZWRfcmVnaXN0ZXJfZGV2aWNlJyB0
byBtYWtlIGFuIGluLW1lbW9yeSBjb3B5IG9mCj4+IHRoZWlyIExFRCBkZXZpY2UgdGFibGUgc28g
dGhlIG9yaWdpbmFsIGNhbiBiZSByZW1vdmVkIGFzIC5pbml0LnJvZGF0YS4KPj4gV2hlbiB0aGUg
TEVEIHN1YnN5c3RlbSBpcyBub3QgZW5hYmxlZCBzb3VyY2UgaW4gdGhlIGxlZCBkaXJlY3Rvcnkg
aXMgbm90Cj4+IGJ1aWx0IGFuZCBzbyB0aGlzIGZ1bmN0aW9uIG1heSBiZSB1bmRlZmluZWQuIEZp
eCB0aGlzIGhlcmUuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJldyBGLiBEYXZpcyA8YWZkQHRp
LmNvbT4KPj4gLS0tCj4+ICAgaW5jbHVkZS9saW51eC9sZWRzLmggfCA4ICsrKysrKysrCj4+ICAg
MSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9sZWRzLmggYi9pbmNsdWRlL2xpbnV4L2xlZHMuaAo+PiBpbmRleCBkMmIxMzA2Li5h
NGEzZGE2IDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2xlZHMuaAo+PiArKysgYi9pbmNs
dWRlL2xpbnV4L2xlZHMuaAo+PiBAQCAtMzg2LDggKzM4NiwxNiBAQCBzdHJ1Y3QgZ3Bpb19sZWRf
cGxhdGZvcm1fZGF0YSB7Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdW5zaWduZWQgbG9uZyAqZGVsYXlfb2ZmKTsKPiAKPiBDdXJyZW50bHkgdGhlcmUgaXMgc29t
ZSBzdHVmZiBoZXJlLCBhbmQgaW4gZmFjdCBpdCBoYXMgYmVlbiBmb3IKPiBhIGxvbmcgdGltZS4K
PiAKPiBQYXRjaCAiW1BBVENIIDEyLzEyXSBsZWRzOiBPbmx5IGRlc2NlbmQgaW50byBsZWRzIGRp
cmVjdG9yeSB3aGVuCj4gQ09ORklHX05FV19MRURTIGlzIHNldCIgYWxzbyBkb2Vzbid0IGFwcGx5
Lgo+IFdoYXQgcmVwb3NpdG9yeSBhcmUgeW91IHVzaW5nPwo+IAoKdjQuNy1yYzQsIGl0IG1heSBu
b3QgYXBwbHkgZHVlIHRvIHRoZSBzdXJyb3VuZGluZyBsaW5lcyBiZWluZyBjaGFuZ2VkIGluCnRo
ZSBvdGhlciBwYXRjaGVzIHdoaWNoIG1heSBub3QgYmUgYXBwbGllZCB0byB5b3VyIHRyZWUuIEl0
IGlzIGEgc2luZ2xlCmxpbmUgY2hhbmdlIHBlciBwYXRjaCBzbyBob3BlZnVsbHkgdGhlIG1lcmdl
IGNvbmZsaWN0IHJlc29sdXRpb25zIHdpbGwKYmUgdHJpdmlhbC4KCkEgYmV0dGVyIHNvbHV0aW9u
IGNvdWxkIGhhdmUgYmVlbiBnZXR0aW5nIGFuIGFjayBmcm9tIGVhY2ggbWFpbnRhaW5lcgphbmQg
aGF2aW5nIHNvbWVvbmUgcHVsbCB0aGUgd2hvbGUgc2VyaWVzIGludG8gb25lIHRyZWUsIGJ1dCBw
YXJ0cyBoYXZlCmFscmVhZHkgYmVlbiBwaWNrZWQgc28gaXQgbWF5IGJlIGEgbGl0dGxlIGxhdGUg
Zm9yIHRoYXQuCgo+PiAgIH07Cj4+Cj4+ICsjaWZkZWYgQ09ORklHX05FV19MRURTCj4+ICAgc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqZ3Bpb19sZWRfcmVnaXN0ZXJfZGV2aWNlKAo+PiAgICAgICAg
ICAgICAgICAgIGludCBpZCwgY29uc3Qgc3RydWN0IGdwaW9fbGVkX3BsYXRmb3JtX2RhdGEgKnBk
YXRhKTsKPj4gKyNlbHNlCj4+ICtzdGF0aWMgaW5saW5lIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KmdwaW9fbGVkX3JlZ2lzdGVyX2RldmljZSgKPj4gKyAgICAgICAgICAgICAgIGludCBpZCwgY29u
c3Qgc3RydWN0IGdwaW9fbGVkX3BsYXRmb3JtX2RhdGEgKnBkYXRhKQo+PiArewo+PiArICAgICAg
IHJldHVybiAwOwo+PiArfQo+PiArI2VuZGlmCj4+Cj4+ICAgZW51bSBjcHVfbGVkX2V2ZW50IHsK
Pj4gICAgICAgICAgQ1BVX0xFRF9JRExFX1NUQVJULCAgICAgLyogQ1BVIGVudGVycyBpZGxlICov
Cj4+Cj4gCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QKTGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcK
aHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xpbnV4cHBjLWRldg==
