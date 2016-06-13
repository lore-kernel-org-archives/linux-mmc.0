From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 01/12] gpio: Only descend into gpio directory when
 CONFIG_GPIOLIB is set
Date: Mon, 13 Jun 2016 15:02:00 -0500
Message-ID: <20160613200211.14790-2-afd@ti.com>
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

V2hlbiBDT05GSUdfR1BJT0xJQiBpcyBub3Qgc2V0IG1ha2Ugd2lsbCBzdGlsbCBkZXNjZW5kIGlu
dG8gdGhlIGdwaW8KZGlyZWN0b3J5IGJ1dCBub3RoaW5nIHdpbGwgYmUgYnVpbHQuIFRoaXMgcHJv
ZHVjZXMgdW5uZWVkZWQgYnVpbGQKYXJ0aWZhY3RzIGFuZCBtZXNzYWdlcyBpbiBhZGRpdGlvbiB0
byBzbG93aW5nIHRoZSBidWlsZC4gRml4IHRoaXMgaGVyZS4KClNpZ25lZC1vZmYtYnk6IEFuZHJl
dyBGLiBEYXZpcyA8YWZkQHRpLmNvbT4KLS0tCiBkcml2ZXJzL01ha2VmaWxlIHwgMiArLQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9NYWtlZmlsZSBiL2RyaXZlcnMvTWFrZWZpbGUKaW5kZXggMGI2ZjNkNi4uNTBmNjEz
MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9NYWtlZmlsZQorKysgYi9kcml2ZXJzL01ha2VmaWxlCkBA
IC0xMiw3ICsxMiw3IEBAIG9iai0kKENPTkZJR19HRU5FUklDX1BIWSkJKz0gcGh5LwogCiAjIEdQ
SU8gbXVzdCBjb21lIGFmdGVyIHBpbmN0cmwgYXMgZ3Bpb3MgbWF5IG5lZWQgdG8gbXV4IHBpbnMg
ZXRjCiBvYmotJChDT05GSUdfUElOQ1RSTCkJCSs9IHBpbmN0cmwvCi1vYmoteQkJCQkrPSBncGlv
Lworb2JqLSQoQ09ORklHX0dQSU9MSUIpCQkrPSBncGlvLwogb2JqLXkJCQkJKz0gcHdtLwogb2Jq
LSQoQ09ORklHX1BDSSkJCSs9IHBjaS8KIG9iai0kKENPTkZJR19QQVJJU0MpCQkrPSBwYXJpc2Mv
Ci0tIAoyLjguMwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXhwcGMtZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9y
ZwpodHRwczovL2xpc3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2
