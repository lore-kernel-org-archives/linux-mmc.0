From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 01/13] mmc: bcm2835: add bcm2835_read_wait_sdcmd
Date: Fri, 27 Jan 2017 11:28:32 +0100
Message-ID: <1485512912.19754.60.camel@redhat.com>
References: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
 <1485473846-24537-2-git-send-email-kraxel@redhat.com>
 <ff0170ef-2566-1c12-0b27-dccb3bff2e7e@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-cnJZ8YYRGRgSb3bxl1mh"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <ff0170ef-2566-1c12-0b27-dccb3bff2e7e@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Ray Jui <rjui@broadcom.com>, Lee Jones <lee@kernel.org>, linux-mmc@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, Eric Anholt <eric@anholt.net>, "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX
 ARM ARCHITE..." <bcm-kernel-feedback-list@broadcom.com>, linux-rpi-kernel@lists.infradead.org, "moderated
 list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org


--=-cnJZ8YYRGRgSb3bxl1mh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  Hi,

> > +	for (;;) {
> > +		value =3D readl(host->ioaddr + SDCMD);
> > +		if (!(value & SDCMD_NEW_FLAG))
> > +			break;
> > +		if (check_fail && (value & SDCMD_FAIL_FLAG))
> > +			break;
> > +		if (time_after(jiffies, end)) {
> > +			dev_err(dev, "%s: timeout (%d us)\n",
> > +				__func__, timeout);
> > +			break;
> > +		}
> > +
> > +		/* if it takes longer reduce poll interval */
> > +		if (time_after(jiffies, fastpoll))
> > +			udelay(10);
> > +		else
> > +			cpu_relax();
> > +	}
>=20
> Use readl_poll_timeout intead of open-coding them..

Cool.  Didn't know this exists.  Incremental fixup attached.

thanks,
  Gerd


--=-cnJZ8YYRGRgSb3bxl1mh
Content-Description: 
Content-Disposition: inline;
	filename*0=0001-mmc-bcm2835-use-readl_poll_timeout-in-bcm2835_read_w.pat;
	filename*1=ch
Content-Type: text/x-patch;
	name="0001-mmc-bcm2835-use-readl_poll_timeout-in-bcm2835_read_w.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSBkZTYwZDczODQ5ZDgzYjBkZGY0ZWU4YmQ2YTdlMTc1YzY5MTU3YTkwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxAcmVkaGF0LmNvbT4KRGF0
ZTogRnJpLCAyNyBKYW4gMjAxNyAxMToyNTo1NCArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIG1tYzog
YmNtMjgzNTogdXNlIHJlYWRsX3BvbGxfdGltZW91dCBpbgogYmNtMjgzNV9yZWFkX3dhaXRfc2Rj
bWQKClNpZ25lZC1vZmYtYnk6IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPgotLS0K
IGRyaXZlcnMvbW1jL2hvc3QvYmNtMjgzNS5jIHwgMzcgKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDIxIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvYmNtMjgzNS5jIGIvZHJpdmVy
cy9tbWMvaG9zdC9iY20yODM1LmMKaW5kZXggNjRhMjMzNC4uZThhM2Y2ZSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9tbWMvaG9zdC9iY20yODM1LmMKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9iY20yODM1
LmMKQEAgLTMxLDYgKzMxLDcgQEAKICNpbmNsdWRlIDxsaW51eC9lcnIuaD4KICNpbmNsdWRlIDxs
aW51eC9oaWdobWVtLmg+CiAjaW5jbHVkZSA8bGludXgvaW8uaD4KKyNpbmNsdWRlIDxsaW51eC9p
b3BvbGwuaD4KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KICNpbmNsdWRlIDxsaW51eC9vZl9h
ZGRyZXNzLmg+CiAjaW5jbHVkZSA8bGludXgvb2ZfaXJxLmg+CkBAIC02MDksMzMgKzYxMCwyNyBA
QCBzdGF0aWMgdm9pZCBiY20yODM1X3ByZXBhcmVfZGF0YShzdHJ1Y3QgYmNtMjgzNV9ob3N0ICpo
b3N0LAogCXdyaXRlbChkYXRhLT5ibG9ja3MsIGhvc3QtPmlvYWRkciArIFNESEJMQyk7CiB9CiAK
LXN0YXRpYyB1MzIgYmNtMjgzNV9yZWFkX3dhaXRfc2RjbWQoc3RydWN0IGJjbTI4MzVfaG9zdCAq
aG9zdCwgdTMyIHRpbWVvdXQsCitzdGF0aWMgdTMyIGJjbTI4MzVfcmVhZF93YWl0X3NkY21kKHN0
cnVjdCBiY20yODM1X2hvc3QgKmhvc3QsIHUzMiBtYXhfbXMsCiAJCQkJICAgYm9vbCBjaGVja19m
YWlsKQogewogCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZob3N0LT5wZGV2LT5kZXY7Ci0JdW5zaWdu
ZWQgbG9uZyBzdGFydCA9IGppZmZpZXM7Ci0JdW5zaWduZWQgbG9uZyBmYXN0cG9sbCA9IHN0YXJ0
ICsgdXNlY3NfdG9famlmZmllcygxMCk7Ci0JdW5zaWduZWQgbG9uZyBlbmQgPSBzdGFydCArIG1z
ZWNzX3RvX2ppZmZpZXModGltZW91dCk7CiAJdTMyIHZhbHVlOworCWludCByZXQ7CiAKLQlmb3Ig
KDs7KSB7Ci0JCXZhbHVlID0gcmVhZGwoaG9zdC0+aW9hZGRyICsgU0RDTUQpOwotCQlpZiAoISh2
YWx1ZSAmIFNEQ01EX05FV19GTEFHKSkKLQkJCWJyZWFrOwotCQlpZiAoY2hlY2tfZmFpbCAmJiAo
dmFsdWUgJiBTRENNRF9GQUlMX0ZMQUcpKQotCQkJYnJlYWs7Ci0JCWlmICh0aW1lX2FmdGVyKGpp
ZmZpZXMsIGVuZCkpIHsKLQkJCWRldl9lcnIoZGV2LCAiJXM6IHRpbWVvdXQgKCVkIHVzKVxuIiwK
LQkJCQlfX2Z1bmNfXywgdGltZW91dCk7Ci0JCQlicmVhazsKLQkJfQorCXJldCA9IHJlYWRsX3Bv
bGxfdGltZW91dChob3N0LT5pb2FkZHIgKyBTRENNRCwgdmFsdWUsCisJCQkJICghKHZhbHVlICYg
U0RDTURfTkVXX0ZMQUcpKSB8fAorCQkJCSAoY2hlY2tfZmFpbCAmJiAodmFsdWUgJiBTRENNRF9G
QUlMX0ZMQUcpKSwKKwkJCQkgMSwgMTApOworCWlmIChyZXQgPT0gLUVUSU1FRE9VVCkKKwkJLyog
aWYgaXQgdGFrZXMgYSB3aGlsZSBtYWtlIHBvbGwgaW50ZXJ2YWwgYmlnZ2VyICovCisJCXJldCA9
IHJlYWRsX3BvbGxfdGltZW91dChob3N0LT5pb2FkZHIgKyBTRENNRCwgdmFsdWUsCisJCQkJCSAo
ISh2YWx1ZSAmIFNEQ01EX05FV19GTEFHKSkgfHwKKwkJCQkJIChjaGVja19mYWlsICYmICh2YWx1
ZSAmIFNEQ01EX0ZBSUxfRkxBRykpLAorCQkJCQkgMTAsIG1heF9tcyAqIDEwMDApOworCWlmIChy
ZXQgPT0gLUVUSU1FRE9VVCkKKwkJZGV2X2VycihkZXYsICIlczogdGltZW91dCAoJWQgbXMpXG4i
LAorCQkJX19mdW5jX18sIG1heF9tcyk7CiAKLQkJLyogaWYgaXQgdGFrZXMgbG9uZ2VyIHJlZHVj
ZSBwb2xsIGludGVydmFsICovCi0JCWlmICh0aW1lX2FmdGVyKGppZmZpZXMsIGZhc3Rwb2xsKSkK
LQkJCXVkZWxheSgxMCk7Ci0JCWVsc2UKLQkJCWNwdV9yZWxheCgpOwotCX0KIAlyZXR1cm4gdmFs
dWU7CiB9CiAKLS0gCjEuOC4zLjEKCg==


--=-cnJZ8YYRGRgSb3bxl1mh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=-cnJZ8YYRGRgSb3bxl1mh--
