From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 00/12] Remove unneeded build directory traversals
Date: Mon, 13 Jun 2016 15:01:59 -0500
Message-ID: <20160613200211.14790-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
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

SGVsbG8gYWxsLAoKSSB3YXMgYnVpbGRpbmcgYSBrZXJuZWwgZm9yIHg4NiBhbmQgbm90aWNlZCBN
YWtlIHN0aWxsIGRlc2NlbmRlZCBpbnRvCmRpcmVjdG9yaWVzIGxpa2UgZHJpdmVycy9ncHUvZHJt
L2hpc2lsaWNvbiwgdGhpcyBzZWVtcyBraW5kIG9mIG9kZCBnaXZlbgpub3RoaW5nIHdpbGwgYmUg
YnVpbHQgaGVyZS4gSXQgbG9va3MgdG8gYmUgZHVlIHRvIHNvbWUgZGlyZWN0b3JpZXMgYmVpbmcK
aW5jbHVkZWQgaW4gb2JqLXkgdW5jb25kaXRpb25hbGx5IGluc3RlYWQgb2Ygb25seSB3aGVuIHRo
ZSByZWxldmFudApDT05GSUdfIGlzIHNldC4KClRoZXNlIHBhdGNoZXMgYXJlIHNwbGl0IGJ5IHN1
YnN5c3RlbSBpbi1jYXNlLCBmb3Igc29tZSByZWFzb24sIGEgZmlsZSBpbgphIGRpcmVjdG9yeSBk
b2VzIG5lZWQgdG8gYmUgYnVpbHQsIEkgYmVsaWV2ZSBJIGhhdmUgY2hlY2tlZCBmb3IgYWxsCmlu
c3RhbmNlcyBvZiB0aGlzLCBidXQgYSBxdWljayByZXZpZXcgZnJvbSBzb21lIG1haW50YWluZXJz
IHdvdWxkIGJlIG5pY2UuCgpUaGFua3MsCkFuZHJldwoKQW5kcmV3IEYuIERhdmlzICgxMik6CiAg
Z3BpbzogT25seSBkZXNjZW5kIGludG8gZ3BpbyBkaXJlY3Rvcnkgd2hlbiBDT05GSUdfR1BJT0xJ
QiBpcyBzZXQKICBwd206IE9ubHkgZGVzY2VuZCBpbnRvIHB3bSBkaXJlY3Rvcnkgd2hlbiBDT05G
SUdfUFdNIGlzIHNldAogIGFtYmE6IE9ubHkgZGVzY2VuZCBpbnRvIGFtYmEgZGlyZWN0b3J5IHdo
ZW4gQ09ORklHX0FSTV9BTUJBIGlzIHNldAogIE5GQzogT25seSBkZXNjZW5kIGludG8gbmZjIGRp
cmVjdG9yeSB3aGVuIENPTkZJR19ORkMgaXMgc2V0CiAgbWFjaW50b3NoOiBPbmx5IGRlc2NlbmQg
aW50byBkaXJlY3Rvcnkgd2hlbiBDT05GSUdfTUFDSU5UT1NIX0RSSVZFUlMKICAgIGlzIHNldAog
IGhzaTogT25seSBkZXNjZW5kIGludG8gaHNpIGRpcmVjdG9yeSB3aGVuIENPTkZJR19IU0kgaXMg
c2V0CiAgYXV4ZGlzcGxheTogT25seSBkZXNjZW5kIGludG8gZGlyZWN0b3J5IHdoZW4gQ09ORklH
X0FVWERJU1BMQVkgaXMgc2V0CiAgaTJjOiBPbmx5IGRlc2NlbmQgaW50byBpMmMgZGlyZWN0b3J5
IHdoZW4gQ09ORklHX0kyQyBpcyBzZXQKICBbbWVkaWFdIE9ubHkgZGVzY2VuZCBpbnRvIGRpcmVj
dG9yeSB3aGVuIENPTkZJR19NRURJQV9TVVBQT1JUIGlzIHNldAogIGxndWVzdDogT25seSBkZXNj
ZW5kIGludG8gbGd1ZXN0IGRpcmVjdG9yeSB3aGVuIENPTkZJR19MR1VFU1QgaXMgc2V0CiAgbW1j
OiBPbmx5IGRlc2NlbmQgaW50byBtbWMgZGlyZWN0b3J5IHdoZW4gQ09ORklHX01NQyBpcyBzZXQK
ICBsZWRzOiBPbmx5IGRlc2NlbmQgaW50byBsZWRzIGRpcmVjdG9yeSB3aGVuIENPTkZJR19ORVdf
TEVEUyBpcyBzZXQKCiBkcml2ZXJzL01ha2VmaWxlIHwgMjcgKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0p
CgotLSAKMi44LjMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QKTGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5v
cmcKaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xpbnV4cHBjLWRldg==
