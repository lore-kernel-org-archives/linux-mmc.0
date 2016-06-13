From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 04/12] NFC: Only descend into nfc directory when CONFIG_NFC is
 set
Date: Mon, 13 Jun 2016 15:02:03 -0500
Message-ID: <20160613200211.14790-5-afd@ti.com>
References: <20160613200211.14790-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20160613200211.14790-1-afd@ti.com>
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
To: Russell King <linux@armlinux.org.uk>, Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, Rusty Russell <rusty@rustcorp.com.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lauro Ramos Venancio <lauro.venancio@openbossa.org>, Aloisio Almeida Jr <aloisio.almeida@openbossa.org>, Samuel Ortiz <sameo@linux.intel.com>, Ingo Molnar <mingo@kernel.org>
Cc: linux-pwm@vger.kernel.org, lguest@lists.ozlabs.org, linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F .
 Davis" <afd@ti.com>, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-leds@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

V2hlbiBDT05GSUdfTkZDIGlzIG5vdCBzZXQgbWFrZSB3aWxsIHN0aWxsIGRlc2NlbmQgaW50byB0
aGUgbmZjCmRpcmVjdG9yeSBidXQgbm90aGluZyB3aWxsIGJlIGJ1aWx0LiBUaGlzIHByb2R1Y2Vz
IHVubmVlZGVkIGJ1aWxkCmFydGlmYWN0cyBhbmQgbWVzc2FnZXMgaW4gYWRkaXRpb24gdG8gc2xv
d2luZyB0aGUgYnVpbGQuIEZpeCB0aGlzIGhlcmUuCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgRi4g
RGF2aXMgPGFmZEB0aS5jb20+Ci0tLQogZHJpdmVycy9NYWtlZmlsZSB8IDYgKysrKystCiAxIGZp
bGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9NYWtlZmlsZSBiL2RyaXZlcnMvTWFrZWZpbGUKaW5kZXggODQxYzJkYy4uNGE4ODVk
OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9NYWtlZmlsZQorKysgYi9kcml2ZXJzL01ha2VmaWxlCkBA
IC02NCw3ICs2NCwxMSBAQCBvYmotJChDT05GSUdfRkJfSU5URUwpICAgICAgICAgICs9IHZpZGVv
L2ZiZGV2L2ludGVsZmIvCiAKIG9iai0kKENPTkZJR19QQVJQT1JUKQkJKz0gcGFycG9ydC8KIG9i
ai0kKENPTkZJR19OVk0pCQkrPSBsaWdodG52bS8KLW9iai15CQkJCSs9IGJhc2UvIGJsb2NrLyBt
aXNjLyBtZmQvIG5mYy8KK29iai15CQkJCSs9IGJhc2UvCitvYmoteQkJCQkrPSBibG9jay8KK29i
ai15CQkJCSs9IG1pc2MvCitvYmoteQkJCQkrPSBtZmQvCitvYmotJChDT05GSUdfTkZDKQkJKz0g
bmZjLwogb2JqLSQoQ09ORklHX0xJQk5WRElNTSkJCSs9IG52ZGltbS8KIG9iai0kKENPTkZJR19E
RVZfREFYKQkJKz0gZGF4Lwogb2JqLSQoQ09ORklHX0RNQV9TSEFSRURfQlVGRkVSKSArPSBkbWEt
YnVmLwotLSAKMi44LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QKTGludXhwcGMtZGV2QGxpc3RzLm96bGFi
cy5vcmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xpbnV4cHBjLWRldg==
