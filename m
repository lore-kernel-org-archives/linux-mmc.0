From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: [PATCH] mmc: add device class attribute for ext_csd
Date: Mon, 26 Jul 2010 17:57:26 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E4176E6@dbde02.ent.ti.com>
References: <20100726100956.GA17996@july> <4C4D6BF9.1040704@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_2A3DCF3DA181AD40BDE86A3150B27B6B030E4176E6dbde02enttico_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43063 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754531Ab0GZM2M (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 26 Jul 2010 08:28:12 -0400
In-Reply-To: <4C4D6BF9.1040704@nokia.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Andrew Morton <akpm@linux-foundation.org>

--_002_2A3DCF3DA181AD40BDE86A3150B27B6B030E4176E6dbde02enttico_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

All,
EXT_CSD is 512byte information (read using CMD8) for the MMC (eMMC) device.
And for the latest and upcoming specification, ext_csd are much relevant th=
en past.

So please let me know your idea to add and get the same ext_csd as MMC devi=
ce attribute. This is the same way currently available for csd, cid, src, e=
tc.
(# cat /sys/class/mmc_host/mmc1/mmc1\:0001/ext_csd)

Regards,
Sukumar Ghorai

From: Sukumar Ghorai <s-ghorai@ti.com>
Date: Mon, 26 Jul 2010 10:47:12 +0530
Subject: [PATCH] mmc: add device class attribute for ext_csd

 ext_csd is getting more informative form eMMC 4.4 onwards and better to
 have this in device information as currently available for csd, cid, src.

Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
---
 drivers/mmc/core/bus.c   |    1 +
 drivers/mmc/core/mmc.c   |   23 +++++++++++++++++------
 include/linux/mmc/card.h |    1 +
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 49d9dca..57d035e 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -191,6 +191,7 @@ static void mmc_release_card(struct device *dev)
 	if (card->info)
 		kfree(card->info);
=20
+	kfree(card->raw_ext_csd);
 	kfree(card);
 }
=20
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 89f7a25..23b1813 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -167,10 +167,6 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 	if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
 		return 0;
=20
-	/*
-	 * As the ext_csd is so large and mostly unused, we don't store the
-	 * raw block in mmc_card.
-	 */
 	ext_csd =3D kmalloc(512, GFP_KERNEL);
 	if (!ext_csd) {
 		printk(KERN_ERR "%s: could not allocate a buffer to "
@@ -250,11 +246,25 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 	}
=20
 out:
-	kfree(ext_csd);
-
+	card->raw_ext_csd =3D ext_csd;
 	return err;
 }
=20
+static ssize_t mmc_ext_csd_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+int i;
+struct mmc_card *card =3D container_of(dev, struct mmc_card, dev);
+
+	for (i =3D 0; i < 512; i++)
+		buf +=3D sprintf(buf, "%02x", card->raw_ext_csd[i]);
+
+	buf -=3D 512;
+	return 512;
+}
+
+static DEVICE_ATTR(ext_csd, S_IRUGO, mmc_ext_csd_show, NULL);
+
 MMC_DEV_ATTR(cid, "%08x%08x%08x%08x\n", card->raw_cid[0], card->raw_cid[1]=
,
 	card->raw_cid[2], card->raw_cid[3]);
 MMC_DEV_ATTR(csd, "%08x%08x%08x%08x\n", card->raw_csd[0], card->raw_csd[1]=
,
@@ -270,6 +280,7 @@ MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
 static struct attribute *mmc_std_attrs[] =3D {
 	&dev_attr_cid.attr,
 	&dev_attr_csd.attr,
+	&dev_attr_ext_csd.attr,
 	&dev_attr_date.attr,
 	&dev_attr_fwrev.attr,
 	&dev_attr_hwrev.attr,
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index d02d2c6..00332ca 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -105,6 +105,7 @@ struct mmc_card {
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
 	u32			raw_scr[2];	/* raw card SCR */
+	u8			*raw_ext_csd;	/* raw card EXT CSD for MMC */
 	struct mmc_cid		cid;		/* card identification */
 	struct mmc_csd		csd;		/* card specific */
 	struct mmc_ext_csd	ext_csd;	/* mmc v4 extended card specific */

--_002_2A3DCF3DA181AD40BDE86A3150B27B6B030E4176E6dbde02enttico_
Content-Type: application/octet-stream; name="emmc-dev-attr-ext-esd.patch"
Content-Description: emmc-dev-attr-ext-esd.patch
Content-Disposition: attachment; filename="emmc-dev-attr-ext-esd.patch";
	size=2819; creation-date="Mon, 26 Jul 2010 17:41:42 GMT";
	modification-date="Mon, 26 Jul 2010 17:41:42 GMT"
Content-Transfer-Encoding: base64

RnJvbTogU3VrdW1hciBHaG9yYWkgPHMtZ2hvcmFpQHRpLmNvbT4KRGF0ZTogTW9uLCAyNiBKdWwg
MjAxMCAxMDo0NzoxMiArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIG1tYzogYWRkIGRldmljZSBjbGFz
cyBhdHRyaWJ1dGUgZm9yIGV4dF9jc2QKCiBleHRfY3NkIGlzIGdldHRpbmcgbW9yZSBpbmZvcm1h
dGl2ZSBmb3JtIGVNTUMgNC40IG9ud2FyZHMgYW5kIGJldHRlciB0bwogaGF2ZSB0aGlzIGluIGRl
dmljZSBpbmZvcm1hdGlvbiBhcyBjdXJyZW50bHkgYXZhaWxhYmxlIGZvciBjc2QsIGNpZCwgc3Jj
LgoKU2lnbmVkLW9mZi1ieTogU3VrdW1hciBHaG9yYWkgPHMtZ2hvcmFpQHRpLmNvbT4KLS0tCiBk
cml2ZXJzL21tYy9jb3JlL2J1cy5jICAgfCAgICAxICsKIGRyaXZlcnMvbW1jL2NvcmUvbW1jLmMg
ICB8ICAgMjMgKysrKysrKysrKysrKysrKystLS0tLS0KIGluY2x1ZGUvbGludXgvbW1jL2NhcmQu
aCB8ICAgIDEgKwogMyBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvYnVzLmMgYi9kcml2ZXJzL21tYy9j
b3JlL2J1cy5jCmluZGV4IDQ5ZDlkY2EuLjU3ZDAzNWUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1j
L2NvcmUvYnVzLmMKKysrIGIvZHJpdmVycy9tbWMvY29yZS9idXMuYwpAQCAtMTkxLDYgKzE5MSw3
IEBAIHN0YXRpYyB2b2lkIG1tY19yZWxlYXNlX2NhcmQoc3RydWN0IGRldmljZSAqZGV2KQogCWlm
IChjYXJkLT5pbmZvKQogCQlrZnJlZShjYXJkLT5pbmZvKTsKIAorCWtmcmVlKGNhcmQtPnJhd19l
eHRfY3NkKTsKIAlrZnJlZShjYXJkKTsKIH0KIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29y
ZS9tbWMuYyBiL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMKaW5kZXggODlmN2EyNS4uMjNiMTgxMyAx
MDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvY29yZS9tbWMuYworKysgYi9kcml2ZXJzL21tYy9jb3Jl
L21tYy5jCkBAIC0xNjcsMTAgKzE2Nyw2IEBAIHN0YXRpYyBpbnQgbW1jX3JlYWRfZXh0X2NzZChz
dHJ1Y3QgbW1jX2NhcmQgKmNhcmQpCiAJaWYgKGNhcmQtPmNzZC5tbWNhX3ZzbiA8IENTRF9TUEVD
X1ZFUl80KQogCQlyZXR1cm4gMDsKIAotCS8qCi0JICogQXMgdGhlIGV4dF9jc2QgaXMgc28gbGFy
Z2UgYW5kIG1vc3RseSB1bnVzZWQsIHdlIGRvbid0IHN0b3JlIHRoZQotCSAqIHJhdyBibG9jayBp
biBtbWNfY2FyZC4KLQkgKi8KIAlleHRfY3NkID0ga21hbGxvYyg1MTIsIEdGUF9LRVJORUwpOwog
CWlmICghZXh0X2NzZCkgewogCQlwcmludGsoS0VSTl9FUlIgIiVzOiBjb3VsZCBub3QgYWxsb2Nh
dGUgYSBidWZmZXIgdG8gIgpAQCAtMjUwLDExICsyNDYsMjUgQEAgc3RhdGljIGludCBtbWNfcmVh
ZF9leHRfY3NkKHN0cnVjdCBtbWNfY2FyZCAqY2FyZCkKIAl9CiAKIG91dDoKLQlrZnJlZShleHRf
Y3NkKTsKLQorCWNhcmQtPnJhd19leHRfY3NkID0gZXh0X2NzZDsKIAlyZXR1cm4gZXJyOwogfQog
CitzdGF0aWMgc3NpemVfdCBtbWNfZXh0X2NzZF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwKKwkJ
CXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpCit7CitpbnQgaTsKK3N0
cnVjdCBtbWNfY2FyZCAqY2FyZCA9IGNvbnRhaW5lcl9vZihkZXYsIHN0cnVjdCBtbWNfY2FyZCwg
ZGV2KTsKKworCWZvciAoaSA9IDA7IGkgPCA1MTI7IGkrKykKKwkJYnVmICs9IHNwcmludGYoYnVm
LCAiJTAyeCIsIGNhcmQtPnJhd19leHRfY3NkW2ldKTsKKworCWJ1ZiAtPSA1MTI7CisJcmV0dXJu
IDUxMjsKK30KKworc3RhdGljIERFVklDRV9BVFRSKGV4dF9jc2QsIFNfSVJVR08sIG1tY19leHRf
Y3NkX3Nob3csIE5VTEwpOworCiBNTUNfREVWX0FUVFIoY2lkLCAiJTA4eCUwOHglMDh4JTA4eFxu
IiwgY2FyZC0+cmF3X2NpZFswXSwgY2FyZC0+cmF3X2NpZFsxXSwKIAljYXJkLT5yYXdfY2lkWzJd
LCBjYXJkLT5yYXdfY2lkWzNdKTsKIE1NQ19ERVZfQVRUUihjc2QsICIlMDh4JTA4eCUwOHglMDh4
XG4iLCBjYXJkLT5yYXdfY3NkWzBdLCBjYXJkLT5yYXdfY3NkWzFdLApAQCAtMjcwLDYgKzI4MCw3
IEBAIE1NQ19ERVZfQVRUUihzZXJpYWwsICIweCUwOHhcbiIsIGNhcmQtPmNpZC5zZXJpYWwpOwog
c3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKm1tY19zdGRfYXR0cnNbXSA9IHsKIAkmZGV2X2F0dHJf
Y2lkLmF0dHIsCiAJJmRldl9hdHRyX2NzZC5hdHRyLAorCSZkZXZfYXR0cl9leHRfY3NkLmF0dHIs
CiAJJmRldl9hdHRyX2RhdGUuYXR0ciwKIAkmZGV2X2F0dHJfZndyZXYuYXR0ciwKIAkmZGV2X2F0
dHJfaHdyZXYuYXR0ciwKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW1jL2NhcmQuaCBiL2lu
Y2x1ZGUvbGludXgvbW1jL2NhcmQuaAppbmRleCBkMDJkMmM2Li4wMDMzMmNhIDEwMDY0NAotLS0g
YS9pbmNsdWRlL2xpbnV4L21tYy9jYXJkLmgKKysrIGIvaW5jbHVkZS9saW51eC9tbWMvY2FyZC5o
CkBAIC0xMDUsNiArMTA1LDcgQEAgc3RydWN0IG1tY19jYXJkIHsKIAl1MzIJCQlyYXdfY2lkWzRd
OwkvKiByYXcgY2FyZCBDSUQgKi8KIAl1MzIJCQlyYXdfY3NkWzRdOwkvKiByYXcgY2FyZCBDU0Qg
Ki8KIAl1MzIJCQlyYXdfc2NyWzJdOwkvKiByYXcgY2FyZCBTQ1IgKi8KKwl1OAkJCSpyYXdfZXh0
X2NzZDsJLyogcmF3IGNhcmQgRVhUIENTRCBmb3IgTU1DICovCiAJc3RydWN0IG1tY19jaWQJCWNp
ZDsJCS8qIGNhcmQgaWRlbnRpZmljYXRpb24gKi8KIAlzdHJ1Y3QgbW1jX2NzZAkJY3NkOwkJLyog
Y2FyZCBzcGVjaWZpYyAqLwogCXN0cnVjdCBtbWNfZXh0X2NzZAlleHRfY3NkOwkvKiBtbWMgdjQg
ZXh0ZW5kZWQgY2FyZCBzcGVjaWZpYyAqLwo=

--_002_2A3DCF3DA181AD40BDE86A3150B27B6B030E4176E6dbde02enttico_--
