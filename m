From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 07/12] auxdisplay: Only descend into directory when
 CONFIG_AUXDISPLAY is set
Date: Mon, 13 Jun 2016 15:02:06 -0500
Message-ID: <20160613200211.14790-8-afd@ti.com>
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

V2hlbiBDT05GSUdfQVVYRElTUExBWSBpcyBub3Qgc2V0IG1ha2Ugd2lsbCBzdGlsbCBkZXNjZW5k
IGludG8gdGhlCmF1eGRpc3BsYXkgZGlyZWN0b3J5IGJ1dCBub3RoaW5nIHdpbGwgYmUgYnVpbHQu
IFRoaXMgcHJvZHVjZXMgdW5uZWVkZWQKYnVpbGQgYXJ0aWZhY3RzIGFuZCBtZXNzYWdlcyBpbiBh
ZGRpdGlvbiB0byBzbG93aW5nIHRoZSBidWlsZC4KRml4IHRoaXMgaGVyZS4KClNpZ25lZC1vZmYt
Ynk6IEFuZHJldyBGLiBEYXZpcyA8YWZkQHRpLmNvbT4KLS0tCiBkcml2ZXJzL01ha2VmaWxlIHwg
MiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9NYWtlZmlsZSBiL2RyaXZlcnMvTWFrZWZpbGUKaW5kZXggNzgxNjJi
YS4uYjQyMDJkMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9NYWtlZmlsZQorKysgYi9kcml2ZXJzL01h
a2VmaWxlCkBAIC05MCw3ICs5MCw3IEBAIG9iai15CQkJCSs9IGZpcmV3aXJlLwogb2JqLSQoQ09O
RklHX1VJTykJCSs9IHVpby8KIG9iai0kKENPTkZJR19WRklPKQkJKz0gdmZpby8KIG9iai15CQkJ
CSs9IGNkcm9tLwotb2JqLXkJCQkJKz0gYXV4ZGlzcGxheS8KK29iai0kKENPTkZJR19BVVhESVNQ
TEFZKQkrPSBhdXhkaXNwbGF5Lwogb2JqLSQoQ09ORklHX1BDQ0FSRCkJCSs9IHBjbWNpYS8KIG9i
ai0kKENPTkZJR19ESU8pCQkrPSBkaW8vCiBvYmotJChDT05GSUdfU0JVUykJCSs9IHNidXMvCi0t
IAoyLjguMwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXhwcGMtZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpo
dHRwczovL2xpc3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2
