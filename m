From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 10/12] lguest: Only descend into lguest directory when
 CONFIG_LGUEST is set
Date: Tue, 21 Jun 2016 06:14:30 +0930
Message-ID: <87a8iflhe9.fsf@rustcorp.com.au>
References: <20160613200211.14790-1-afd@ti.com>
 <20160613200211.14790-11-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20160613200211.14790-11-afd@ti.com>
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
To: Russell King <linux@armlinux.org.uk>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lauro Ramos Venancio <lauro.venancio@openbossa.org>, Aloisio Almeida Jr <aloisio.almeida@openbossa.org>, Samuel Ortiz <sameo@linux.intel.com>, Ingo Molnar <mingo@kernel.org>
Cc: linux-pwm@vger.kernel.org, lguest@lists.ozlabs.org, linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

IkFuZHJldyBGLiBEYXZpcyIgPGFmZEB0aS5jb20+IHdyaXRlczoKPiBXaGVuIENPTkZJR19MR1VF
U1QgaXMgbm90IHNldCBtYWtlIHdpbGwgc3RpbGwgZGVzY2VuZCBpbnRvIHRoZSBsZ3Vlc3QKPiBk
aXJlY3RvcnkgYnV0IG5vdGhpbmcgd2lsbCBiZSBidWlsdC4gVGhpcyBwcm9kdWNlcyB1bm5lZWRl
ZCBidWlsZAo+IGFydGlmYWN0cyBhbmQgbWVzc2FnZXMgaW4gYWRkaXRpb24gdG8gc2xvd2luZyB0
aGUgYnVpbGQuIEZpeCB0aGlzIGhlcmUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgRi4gRGF2
aXMgPGFmZEB0aS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvTWFrZWZpbGUgfCAyICstCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKQXBwbGllZCwKClRoYW5r
cyEKUnVzdHkuCgo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvTWFrZWZpbGUgYi9kcml2ZXJzL01h
a2VmaWxlCj4gaW5kZXggMTkzMDVlMC4uYjE3OGUyZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL01h
a2VmaWxlCj4gKysrIGIvZHJpdmVycy9NYWtlZmlsZQo+IEBAIC0xMjIsNyArMTIyLDcgQEAgb2Jq
LSQoQ09ORklHX0FDQ0VTU0lCSUxJVFkpCSs9IGFjY2Vzc2liaWxpdHkvCj4gIG9iai0kKENPTkZJ
R19JU0ROKQkJKz0gaXNkbi8KPiAgb2JqLSQoQ09ORklHX0VEQUMpCQkrPSBlZGFjLwo+ICBvYmot
JChDT05GSUdfRUlTQSkJCSs9IGVpc2EvCj4gLW9iai15CQkJCSs9IGxndWVzdC8KPiArb2JqLSQo
Q09ORklHX0xHVUVTVCkJCSs9IGxndWVzdC8KPiAgb2JqLSQoQ09ORklHX0NQVV9GUkVRKQkJKz0g
Y3B1ZnJlcS8KPiAgb2JqLSQoQ09ORklHX0NQVV9JRExFKQkJKz0gY3B1aWRsZS8KPiAgb2JqLXkJ
CQkJKz0gbW1jLwo+IC0tIAo+IDIuOC4zCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QKTGludXhwcGMtZGV2QGxp
c3RzLm96bGFicy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xpbnV4cHBj
LWRldg==
