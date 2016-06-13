From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 02/12] pwm: Only descend into pwm directory when CONFIG_PWM is
 set
Date: Mon, 13 Jun 2016 15:02:01 -0500
Message-ID: <20160613200211.14790-3-afd@ti.com>
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

V2hlbiBDT05GSUdfUFdNIGlzIG5vdCBzZXQgbWFrZSB3aWxsIHN0aWxsIGRlc2NlbmQgaW50byB0
aGUgcHdtCmRpcmVjdG9yeSBidXQgbm90aGluZyB3aWxsIGJlIGJ1aWx0LiBUaGlzIHByb2R1Y2Vz
IHVubmVlZGVkIGJ1aWxkCmFydGlmYWN0cyBhbmQgbWVzc2FnZXMgaW4gYWRkaXRpb24gdG8gc2xv
d2luZyB0aGUgYnVpbGQuIEZpeCB0aGlzIGhlcmUuCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgRi4g
RGF2aXMgPGFmZEB0aS5jb20+Ci0tLQogZHJpdmVycy9NYWtlZmlsZSB8IDIgKy0KIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvTWFrZWZpbGUgYi9kcml2ZXJzL01ha2VmaWxlCmluZGV4IDUwZjYxMzEuLjAxZTcwN2IgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvTWFrZWZpbGUKKysrIGIvZHJpdmVycy9NYWtlZmlsZQpAQCAtMTMs
NyArMTMsNyBAQCBvYmotJChDT05GSUdfR0VORVJJQ19QSFkpCSs9IHBoeS8KICMgR1BJTyBtdXN0
IGNvbWUgYWZ0ZXIgcGluY3RybCBhcyBncGlvcyBtYXkgbmVlZCB0byBtdXggcGlucyBldGMKIG9i
ai0kKENPTkZJR19QSU5DVFJMKQkJKz0gcGluY3RybC8KIG9iai0kKENPTkZJR19HUElPTElCKQkJ
Kz0gZ3Bpby8KLW9iai15CQkJCSs9IHB3bS8KK29iai0kKENPTkZJR19QV00pCQkrPSBwd20vCiBv
YmotJChDT05GSUdfUENJKQkJKz0gcGNpLwogb2JqLSQoQ09ORklHX1BBUklTQykJCSs9IHBhcmlz
Yy8KIG9iai0kKENPTkZJR19SQVBJRElPKQkJKz0gcmFwaWRpby8KLS0gCjIuOC4zCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eHBwYy1kZXYgbWFp
bGluZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3ps
YWJzLm9yZy9saXN0aW5mby9saW51eHBwYy1kZXY=
