From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH] leds: Add no-op gpio_led_register_device when LED subsystem
 is disabled
Date: Mon, 20 Jun 2016 17:13:40 -0500
Message-ID: <57686A94.2010704@ti.com>
References: <20160613200211.14790-1-afd@ti.com>
 <20160613200211.14790-13-afd@ti.com> <5760FA52.7010806@samsung.com>
 <57647DBD.2010406@ti.com> <57679E38.3080901@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <57679E38.3080901@samsung.com>
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

U29tZSBzeXN0ZW1zIHVzZSAnZ3Bpb19sZWRfcmVnaXN0ZXJfZGV2aWNlJyB0byBtYWtlIGFuIGlu
LW1lbW9yeSBjb3B5IG9mCnRoZWlyIExFRCBkZXZpY2UgdGFibGUgc28gdGhlIG9yaWdpbmFsIGNh
biBiZSByZW1vdmVkIGFzIC5pbml0LnJvZGF0YS4KV2hlbiB0aGUgTEVEIHN1YnN5c3RlbSBpcyBu
b3QgZW5hYmxlZCBzb3VyY2UgaW4gdGhlIGxlZCBkaXJlY3RvcnkgaXMgbm90CmJ1aWx0IGFuZCBz
byB0aGlzIGZ1bmN0aW9uIG1heSBiZSB1bmRlZmluZWQuIEZpeCB0aGlzIGhlcmUuCgpTaWduZWQt
b2ZmLWJ5OiBBbmRyZXcgRi4gRGF2aXMgPGFmZEB0aS5jb20+Ci0tLQogaW5jbHVkZS9saW51eC9s
ZWRzLmggfCA4ICsrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9sZWRzLmggYi9pbmNsdWRlL2xpbnV4L2xlZHMuaAppbmRl
eCBkMmIxMzA2Li5hNGEzZGE2IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2xlZHMuaAorKysg
Yi9pbmNsdWRlL2xpbnV4L2xlZHMuaApAQCAtMzg2LDggKzM4NiwxNiBAQCBzdHJ1Y3QgZ3Bpb19s
ZWRfcGxhdGZvcm1fZGF0YSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB1bnNpZ25lZCBsb25nICpkZWxheV9vZmYpOwogfTsKCisjaWZkZWYgQ09ORklHX05FV19MRURT
CiBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpncGlvX2xlZF9yZWdpc3Rlcl9kZXZpY2UoCiAgICAg
ICAgICAgICAgICBpbnQgaWQsIGNvbnN0IHN0cnVjdCBncGlvX2xlZF9wbGF0Zm9ybV9kYXRhICpw
ZGF0YSk7CisjZWxzZQorc3RhdGljIGlubGluZSBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpncGlv
X2xlZF9yZWdpc3Rlcl9kZXZpY2UoCisgICAgICAgICAgICAgICBpbnQgaWQsIGNvbnN0IHN0cnVj
dCBncGlvX2xlZF9wbGF0Zm9ybV9kYXRhICpwZGF0YSkKK3sKKyAgICAgICByZXR1cm4gMDsKK30K
KyNlbmRpZgoKIGVudW0gY3B1X2xlZF9ldmVudCB7CiAgICAgICAgQ1BVX0xFRF9JRExFX1NUQVJU
LCAgICAgLyogQ1BVIGVudGVycyBpZGxlICovCi0tIAoyLjkuMApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eHBwYy1kZXYgbWFpbGluZyBsaXN0Ckxp
bnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3psYWJzLm9yZy9saXN0
aW5mby9saW51eHBwYy1kZXY=
