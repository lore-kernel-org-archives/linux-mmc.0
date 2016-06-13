From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 08/12] i2c: Only descend into i2c directory when CONFIG_I2C is
 set
Date: Mon, 13 Jun 2016 15:02:07 -0500
Message-ID: <20160613200211.14790-9-afd@ti.com>
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

V2hlbiBDT05GSUdfSTJDIGlzIG5vdCBzZXQgbWFrZSB3aWxsIHN0aWxsIGRlc2NlbmQgaW50byB0
aGUgaTJjCmRpcmVjdG9yeSBidXQgbm90aGluZyB3aWxsIGJlIGJ1aWx0LiBUaGlzIHByb2R1Y2Vz
IHVubmVlZGVkIGJ1aWxkCmFydGlmYWN0cyBhbmQgbWVzc2FnZXMgaW4gYWRkaXRpb24gdG8gc2xv
d2luZyB0aGUgYnVpbGQuIEZpeCB0aGlzIGhlcmUuCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgRi4g
RGF2aXMgPGFmZEB0aS5jb20+Ci0tLQogZHJpdmVycy9NYWtlZmlsZSB8IDMgKystCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9NYWtlZmlsZSBiL2RyaXZlcnMvTWFrZWZpbGUKaW5kZXggYjQyMDJkMC4uMmQ5OWQ0ZSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9NYWtlZmlsZQorKysgYi9kcml2ZXJzL01ha2VmaWxlCkBAIC0x
MDcsNyArMTA3LDggQEAgb2JqLSQoQ09ORklHX1NFUklPKQkJKz0gaW5wdXQvc2VyaW8vCiBvYmot
JChDT05GSUdfR0FNRVBPUlQpCQkrPSBpbnB1dC9nYW1lcG9ydC8KIG9iai0kKENPTkZJR19JTlBV
VCkJCSs9IGlucHV0Lwogb2JqLSQoQ09ORklHX1JUQ19MSUIpCQkrPSBydGMvCi1vYmoteQkJCQkr
PSBpMmMvIG1lZGlhLworb2JqLSQoQ09ORklHX0kyQykJCSs9IGkyYy8KK29iai15CQkJCSs9IG1l
ZGlhLwogb2JqLSQoQ09ORklHX1BQUykJCSs9IHBwcy8KIG9iai0kKENPTkZJR19QVFBfMTU4OF9D
TE9DSykJKz0gcHRwLwogb2JqLSQoQ09ORklHX1cxKQkJKz0gdzEvCi0tIAoyLjguMwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMtZGV2IG1h
aWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xpc3RzLm96
bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2
