From: Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH 12/12] leds: Only descend into leds directory when
 CONFIG_NEW_LEDS is set
Date: Mon, 20 Jun 2016 09:41:44 +0200
Message-ID: <57679E38.3080901@samsung.com>
References: <20160613200211.14790-1-afd@ti.com>
 <20160613200211.14790-13-afd@ti.com> <5760FA52.7010806@samsung.com>
 <57647DBD.2010406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-reply-to: <57647DBD.2010406@ti.com>
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

T24gMDYvMTgvMjAxNiAxMjo0NiBBTSwgQW5kcmV3IEYuIERhdmlzIHdyb3RlOgo+IE9uIDA2LzE1
LzIwMTYgMDE6NDggQU0sIEphY2VrIEFuYXN6ZXdza2kgd3JvdGU6Cj4+IEhpIEFuZHJldywKPj4K
Pj4gVGhhbmtzIGZvciB0aGUgcGF0Y2guCj4+Cj4+IFBsZWFzZSBhZGRyZXNzIHRoZSBpc3N1ZSBb
MV0gcmFpc2VkIGJ5IHRlc3QgYm90IGFuZCByZXN1Ym1pdC4KPj4KPj4gVGhhbmtzLAo+PiBKYWNl
ayBBbmFzemV3c2tpCj4+Cj4+IFsxXSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxNi82LzEzLzEw
OTEKPj4KPgo+IEl0IGxvb2tzIGxpa2Ugc29tZSBzeXN0ZW1zIHVzZSAnZ3Bpb19sZWRfcmVnaXN0
ZXJfZGV2aWNlJyB0byBtYWtlIGFuCj4gaW4tbWVtb3J5IGNvcHkgb2YgdGhlaXIgTEVEIGRldmlj
ZSB0YWJsZSBzbyB0aGUgb3JpZ2luYWwgY2FuIGJlIHJlbW92ZWQKPiBhcyAuaW5pdC5yb2RhdGEu
IFRoaXMgZG9lc24ndCBuZWNlc3NhcmlseSBkZXBlbmQgb24gdGhlIExFRCBzdWJzeXN0ZW0KPiBi
dXQgaXQga2luZCBvZiBzZWVtcyB1c2VsZXNzIHdoZW4gdGhlIHJlc3Qgb2YgdGhlIHN1YnN5c3Rl
bSBpcyBkaXNhYmxlZC4KPgo+IE9uZSBzb2x1dGlvbiBjb3VsZCBiZSB0byB1c2UgYSBkdW1teSAn
Z3Bpb19sZWRfcmVnaXN0ZXJfZGV2aWNlJyB3aGVuIHRoZQo+IHN1YnN5c3RlbSBpcyBub3QgZW5h
YmxlZC4KCkl0IHNvdW5kcyBnb29kLiBQbGVhc2UgYWRkIGEgbm8tb3AgdmVyc2lvbiBvZiBncGlv
X2xlZF9yZWdpc3Rlcl9kZXZpY2UoKQp0byBpbmNsdWRlL2xlZHMuaCwgaW4gYSBzZXBhcmF0ZSBw
YXRjaC4KClRoYW5rcywKSmFjZWsgQW5hc3pld3NraQoKPiBBbm90aGVyIGlzIGp1c3QgdG8gcmVt
b3ZlIHRoZSBmaXZlIG9yIHNvIHVzZXMKPiBvZiAnZ3Bpb19sZWRfcmVnaXN0ZXJfZGV2aWNlJyBh
bmQgaGF2ZSB0aG9zZSBzeXN0ZW1zIHJlZ2lzdGVyIExFRCBkZXZpY2UKPiB0YWJsZXMgbGlrZSBv
dGhlciBzeXN0ZW1zIGRvLgo+Cj4gSWYgbmV0aGVyIG9mIHRoZXNlIGFyZSBhY2NlcHRhYmxlIHRo
ZW4gdGhpcyBwYXRjaCBjYW4gYmUgZHJvcHBlZCBmcm9tCj4gdGhpcyBzZXJpZXMgZm9yIG5vdy4K
Pgo+IFRoYW5rcywKPiBBbmRyZXcKPgo+PiBPbiAwNi8xMy8yMDE2IDEwOjAyIFBNLCBBbmRyZXcg
Ri4gRGF2aXMgd3JvdGU6Cj4+PiBXaGVuIENPTkZJR19ORVdfTEVEUyBpcyBub3Qgc2V0IG1ha2Ug
d2lsbCBzdGlsbCBkZXNjZW5kIGludG8gdGhlIGxlZHMKPj4+IGRpcmVjdG9yeSBidXQgbm90aGlu
ZyB3aWxsIGJlIGJ1aWx0LiBUaGlzIHByb2R1Y2VzIHVubmVlZGVkIGJ1aWxkCj4+PiBhcnRpZmFj
dHMgYW5kIG1lc3NhZ2VzIGluIGFkZGl0aW9uIHRvIHNsb3dpbmcgdGhlIGJ1aWxkLiBGaXggdGhp
cyBoZXJlLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJldyBGLiBEYXZpcyA8YWZkQHRpLmNv
bT4KPj4+IC0tLQo+Pj4gICAgZHJpdmVycy9NYWtlZmlsZSB8IDIgKy0KPj4+ICAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pj4KPj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL01ha2VmaWxlIGIvZHJpdmVycy9NYWtlZmlsZQo+Pj4gaW5kZXggNTY3ZTMyYy4u
ZmE1MTRkNSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvTWFrZWZpbGUKPj4+ICsrKyBiL2RyaXZl
cnMvTWFrZWZpbGUKPj4+IEBAIC0xMjcsNyArMTI3LDcgQEAgb2JqLSQoQ09ORklHX0NQVV9GUkVR
KSAgICAgICAgKz0gY3B1ZnJlcS8KPj4+ICAgIG9iai0kKENPTkZJR19DUFVfSURMRSkgICAgICAg
ICs9IGNwdWlkbGUvCj4+PiAgICBvYmotJChDT05GSUdfTU1DKSAgICAgICAgKz0gbW1jLwo+Pj4g
ICAgb2JqLSQoQ09ORklHX01FTVNUSUNLKSAgICAgICAgKz0gbWVtc3RpY2svCj4+PiAtb2JqLXkg
ICAgICAgICAgICAgICAgKz0gbGVkcy8KPj4+ICtvYmotJChDT05GSUdfTkVXX0xFRFMpICAgICAg
ICArPSBsZWRzLwo+Pj4gICAgb2JqLSQoQ09ORklHX0lORklOSUJBTkQpICAgICs9IGluZmluaWJh
bmQvCj4+PiAgICBvYmotJChDT05GSUdfU0dJX1NOKSAgICAgICAgKz0gc24vCj4+PiAgICBvYmot
eSAgICAgICAgICAgICAgICArPSBmaXJtd2FyZS8KPj4+Cj4+Cj4+Cj4KPgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMtZGV2IG1haWxpbmcg
bGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xpc3RzLm96bGFicy5v
cmcvbGlzdGluZm8vbGludXhwcGMtZGV2
