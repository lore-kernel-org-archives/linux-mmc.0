From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 05/12] macintosh: Only descend into directory when
 CONFIG_MACINTOSH_DRIVERS is set
Date: Mon, 13 Jun 2016 15:02:04 -0500
Message-ID: <20160613200211.14790-6-afd@ti.com>
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

V2hlbiBDT05GSUdfTUFDSU5UT1NIX0RSSVZFUlMgaXMgbm90IHNldCBtYWtlIHdpbGwgc3RpbGwg
ZGVzY2VuZCBpbnRvIHRoZQptYWNpbnRvc2ggZGlyZWN0b3J5IGJ1dCBub3RoaW5nIHdpbGwgYmUg
YnVpbHQuIFRoaXMgcHJvZHVjZXMgdW5uZWVkZWQKYnVpbGQgYXJ0aWZhY3RzIGFuZCBtZXNzYWdl
cyBpbiBhZGRpdGlvbiB0byBzbG93aW5nIHRoZSBidWlsZC4KRml4IHRoaXMgaGVyZS4KClNpZ25l
ZC1vZmYtYnk6IEFuZHJldyBGLiBEYXZpcyA8YWZkQHRpLmNvbT4KLS0tCiBkcml2ZXJzL01ha2Vm
aWxlIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9NYWtlZmlsZSBiL2RyaXZlcnMvTWFrZWZpbGUKaW5kZXgg
NGE4ODVkOC4uNWJlNTYxOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9NYWtlZmlsZQorKysgYi9kcml2
ZXJzL01ha2VmaWxlCkBAIC03Myw3ICs3Myw3IEBAIG9iai0kKENPTkZJR19MSUJOVkRJTU0pCQkr
PSBudmRpbW0vCiBvYmotJChDT05GSUdfREVWX0RBWCkJCSs9IGRheC8KIG9iai0kKENPTkZJR19E
TUFfU0hBUkVEX0JVRkZFUikgKz0gZG1hLWJ1Zi8KIG9iai0kKENPTkZJR19OVUJVUykJCSs9IG51
YnVzLwotb2JqLXkJCQkJKz0gbWFjaW50b3NoLworb2JqLSQoQ09ORklHX01BQ0lOVE9TSF9EUklW
RVJTKQkrPSBtYWNpbnRvc2gvCiBvYmotJChDT05GSUdfSURFKQkJKz0gaWRlLwogb2JqLSQoQ09O
RklHX1NDU0kpCQkrPSBzY3NpLwogb2JqLXkJCQkJKz0gbnZtZS8KLS0gCjIuOC4zCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eHBwYy1kZXYgbWFp
bGluZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3ps
YWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1kZXY=
