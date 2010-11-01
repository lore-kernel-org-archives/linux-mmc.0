From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Mon, 1 Nov 2010 10:27:24 +0200
Message-ID: <AANLkTi=EaZbdnJzJWGH2fUadvNkUhdQgTU1rAoS5wMAs@mail.gmail.com>
References: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com>
 <AANLkTinEes6Er6-WW_t8esjazrLWZ0Z7jvYJDSZL9PNG@mail.gmail.com>
 <AANLkTinJ2K2cz9PSdyNoNGUS8GWfLpqRBH2C3XjO5vjO@mail.gmail.com>
 <AANLkTi=VAU=9Q+Ga7yQyu3aL7gV0vbzymQ-2uJAg1jf8@mail.gmail.com>
 <AANLkTi=QT6_zyddRz=3f6GDx-RVoiROOumhegm8pFuHU@mail.gmail.com>
 <AANLkTimfp0pPqpO03-R4yBsADQ27RLQ_PxLTfBAMfPGk@mail.gmail.com>
 <AANLkTi=gFmq47Xq+CxnU18aHyhcaF78WrWYDhga4Xf2X@mail.gmail.com>
 <AANLkTimqFBBsDCCDNOq22fuqjw7pezizZ9At+1ucGZ-j@mail.gmail.com>
 <AANLkTi=RP0i5cWO4AogGJx-sQ+17YKuiptQWi0ypYVnA@mail.gmail.com>
 <AANLkTiktD13-UC8=gwWhp9oR9_vGcM98VpRQ9i0CQg_-@mail.gmail.com>
 <AANLkTi=8Xd1xTfFvAJkicR_89JOu4P2uwyoMHvXCBKv8@mail.gmail.com> <AANLkTi=cPURFAitedD=mjkNiD_=ZCjakkMN6z7ecqv6k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3054a165226ef10493f9954b
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40349 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388Ab0KAI1q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Nov 2010 04:27:46 -0400
Received: by iwn10 with SMTP id 10so6774746iwn.19
        for <linux-mmc@vger.kernel.org>; Mon, 01 Nov 2010 01:27:45 -0700 (PDT)
In-Reply-To: <AANLkTi=cPURFAitedD=mjkNiD_=ZCjakkMN6z7ecqv6k@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

--20cf3054a165226ef10493f9954b
Content-Type: text/plain; charset=ISO-8859-1

Hi Daniel,

On Sun, Oct 31, 2010 at 9:06 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
...
> we need to support boards with controllers/cards
> which we can't power off in runtime.
>
> On such boards, the right thing to do would be to disable runtime PM altogether.

The patch below (/attached) should trivially fix the problem - can you
please check it out ?

It's very simple: it just requires hosts to explicitly indicate they
support runtime powering off/on their cards (by means of
MMC_CAP_RUNTIME_PM).

There is no way around this I'm afraid: it is legitimate for a
board/host/card configuration not to support powering off the card
after boot, and we must allow it.

In addition having an explicit MMC_CAP_RUNTIME_PM will also allow us
smoother transition to runtime PM behavior. Developers will have to
explicitly turn it on, and will not be surprised if things won't
immediately work.

Please note that this cap is not interchangeable, and can't be replace
with CONFIG_PM_RUNTIME.

Having said that, I still think we need to understand why CMD3 timed
out on the XO-1.5.

Thanks,
Ohad.

>From 6b5691bdd8184cc0876d209c69d38844ea10f678 Mon Sep 17 00:00:00 2001
From: Ohad Ben-Cohen <ohad@wizery.com>
Date: Mon, 1 Nov 2010 09:41:44 +0200
Subject: [PATCH] mmc: add MMC_CAP_RUNTIME_PM

Some board/card/host configurations are not capable of powering off/on
on the card during runtime.

To support such configurations, and to allow smoother transition to
runtime PM behavior, MMC_CAP_RUNTIME_PM is added, so hosts need to
explicitly indicate that it's OK to power off their cards after boot.

This will prevent sdio_bus_probe() from failing to power on the card
when the driver is loaded on such setups.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/core/sdio.c     |   37 +++++++++++++++++++++++--------------
 drivers/mmc/core/sdio_bus.c |   33 ++++++++++++++++++++++-----------
 include/linux/mmc/host.h    |    1 +
 3 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 6a9ad40..373d56d 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -547,9 +547,11 @@ static void mmc_sdio_detect(struct mmc_host *host)
 	BUG_ON(!host->card);

 	/* Make sure card is powered before detecting it */
-	err = pm_runtime_get_sync(&host->card->dev);
-	if (err < 0)
-		goto out;
+	if (host->caps & MMC_CAP_RUNTIME_PM) {
+		err = pm_runtime_get_sync(&host->card->dev);
+		if (err < 0)
+			goto out;
+	}

 	mmc_claim_host(host);

@@ -570,7 +572,8 @@ out:
 	}

 	/* Tell PM core that we're done */
-	pm_runtime_put(&host->card->dev);
+	if (host->caps & MMC_CAP_RUNTIME_PM)
+		pm_runtime_put(&host->card->dev);
 }

 /*
@@ -720,16 +723,21 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
 	card = host->card;

 	/*
-	 * Let runtime PM core know our card is active
+	 * Enable runtime PM only if supported by host+card+board
 	 */
-	err = pm_runtime_set_active(&card->dev);
-	if (err)
-		goto remove;
+	if (host->caps & MMC_CAP_RUNTIME_PM) {
+		/*
+		 * Let runtime PM core know our card is active
+		 */
+		err = pm_runtime_set_active(&card->dev);
+		if (err)
+			goto remove;

-	/*
-	 * Enable runtime PM for this card
-	 */
-	pm_runtime_enable(&card->dev);
+		/*
+		 * Enable runtime PM for this card
+		 */
+		pm_runtime_enable(&card->dev);
+	}

 	/*
 	 * The number of functions on the card is encoded inside
@@ -747,9 +755,10 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
 			goto remove;

 		/*
-		 * Enable Runtime PM for this func
+		 * Enable Runtime PM for this func (if supported)
 		 */
-		pm_runtime_enable(&card->sdio_func[i]->dev);
+		if (host->caps & MMC_CAP_RUNTIME_PM)
+			pm_runtime_enable(&card->sdio_func[i]->dev);
 	}

 	mmc_release_host(host);
diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 2716c7a..f3ce21b 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -17,6 +17,7 @@
 #include <linux/pm_runtime.h>

 #include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
 #include <linux/mmc/sdio_func.h>

 #include "sdio_cis.h"
@@ -132,9 +133,11 @@ static int sdio_bus_probe(struct device *dev)
 	 * it should call pm_runtime_put_noidle() in its probe routine and
 	 * pm_runtime_get_noresume() in its remove routine.
 	 */
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
-		goto out;
+	if (func->card->host->caps & MMC_CAP_RUNTIME_PM) {
+		ret = pm_runtime_get_sync(dev);
+		if (ret < 0)
+			goto out;
+	}

 	/* Set the default block size so the driver is sure it's something
 	 * sensible. */
@@ -151,7 +154,8 @@ static int sdio_bus_probe(struct device *dev)
 	return 0;

 disable_runtimepm:
-	pm_runtime_put_noidle(dev);
+	if (func->card->host->caps & MMC_CAP_RUNTIME_PM)
+		pm_runtime_put_noidle(dev);
 out:
 	return ret;
 }
@@ -160,12 +164,14 @@ static int sdio_bus_remove(struct device *dev)
 {
 	struct sdio_driver *drv = to_sdio_driver(dev->driver);
 	struct sdio_func *func = dev_to_sdio_func(dev);
-	int ret;
+	int ret = 0;

 	/* Make sure card is powered before invoking ->remove() */
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
-		goto out;
+	if (func->card->host->caps & MMC_CAP_RUNTIME_PM) {
+		ret = pm_runtime_get_sync(dev);
+		if (ret < 0)
+			goto out;
+	}

 	drv->remove(func);

@@ -178,10 +184,12 @@ static int sdio_bus_remove(struct device *dev)
 	}

 	/* First, undo the increment made directly above */
-	pm_runtime_put_noidle(dev);
+	if (func->card->host->caps & MMC_CAP_RUNTIME_PM)
+		pm_runtime_put_noidle(dev);

 	/* Then undo the runtime PM settings in sdio_bus_probe() */
-	pm_runtime_put_noidle(dev);
+	if (func->card->host->caps & MMC_CAP_RUNTIME_PM)
+		pm_runtime_put_noidle(dev);

 out:
 	return ret;
@@ -191,6 +199,8 @@ out:

 static int sdio_bus_pm_prepare(struct device *dev)
 {
+	struct sdio_func *func = dev_to_sdio_func(dev);
+
 	/*
 	 * Resume an SDIO device which was suspended at run time at this
 	 * point, in order to allow standard SDIO suspend/resume paths
@@ -212,7 +222,8 @@ static int sdio_bus_pm_prepare(struct device *dev)
 	 * since there is little point in failing system suspend if a
 	 * device can't be resumed.
 	 */
-	pm_runtime_resume(dev);
+	if (func->card->host->caps & MMC_CAP_RUNTIME_PM)
+		pm_runtime_resume(dev);

 	return 0;
 }
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index c3ffad8..e5eee0e 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -167,6 +167,7 @@ struct mmc_host {
 						/* DDR mode at 1.8V */
 #define MMC_CAP_1_2V_DDR	(1 << 12)	/* can support */
 						/* DDR mode at 1.2V */
+#define MMC_CAP_RUNTIME_PM	(1 << 13)	/* Can power off/on in runtime */

 	mmc_pm_flag_t		pm_caps;	/* supported pm features */

-- 
1.7.0.4

--20cf3054a165226ef10493f9954b
Content-Type: text/x-patch; charset=US-ASCII; name="0001-mmc-add-MMC_CAP_RUNTIME_PM.patch"
Content-Disposition: attachment;
	filename="0001-mmc-add-MMC_CAP_RUNTIME_PM.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gfz2nne20

RnJvbSA2YjU2OTFiZGQ4MTg0Y2MwODc2ZDIwOWM2OWQzODg0NGVhMTBmNjc4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPaGFkIEJlbi1Db2hlbiA8b2hhZEB3aXplcnkuY29tPgpEYXRl
OiBNb24sIDEgTm92IDIwMTAgMDk6NDE6NDQgKzAyMDAKU3ViamVjdDogW1BBVENIXSBtbWM6IGFk
ZCBNTUNfQ0FQX1JVTlRJTUVfUE0KClNvbWUgYm9hcmQvY2FyZC9ob3N0IGNvbmZpZ3VyYXRpb25z
IGFyZSBub3QgY2FwYWJsZSBvZiBwb3dlcmluZyBvZmYvb24Kb24gdGhlIGNhcmQgZHVyaW5nIHJ1
bnRpbWUuCgpUbyBzdXBwb3J0IHN1Y2ggY29uZmlndXJhdGlvbnMsIGFuZCB0byBhbGxvdyBzbW9v
dGhlciB0cmFuc2l0aW9uIHRvCnJ1bnRpbWUgUE0gYmVoYXZpb3IsIE1NQ19DQVBfUlVOVElNRV9Q
TSBpcyBhZGRlZCwgc28gaG9zdHMgbmVlZCB0bwpleHBsaWNpdGx5IGluZGljYXRlIHRoYXQgaXQn
cyBPSyB0byBwb3dlciBvZmYgdGhlaXIgY2FyZHMgYWZ0ZXIgYm9vdC4KClRoaXMgd2lsbCBwcmV2
ZW50IHNkaW9fYnVzX3Byb2JlKCkgZnJvbSBmYWlsaW5nIHRvIHBvd2VyIG9uIHRoZSBjYXJkCndo
ZW4gdGhlIGRyaXZlciBpcyBsb2FkZWQgb24gc3VjaCBzZXR1cHMuCgpTaWduZWQtb2ZmLWJ5OiBP
aGFkIEJlbi1Db2hlbiA8b2hhZEB3aXplcnkuY29tPgotLS0KIGRyaXZlcnMvbW1jL2NvcmUvc2Rp
by5jICAgICB8ICAgMzcgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQogZHJp
dmVycy9tbWMvY29yZS9zZGlvX2J1cy5jIHwgICAzMyArKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0KIGluY2x1ZGUvbGludXgvbW1jL2hvc3QuaCAgICB8ICAgIDEgKwogMyBmaWxlcyBj
aGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCAyNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL21tYy9jb3JlL3NkaW8uYyBiL2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5jCmluZGV4IDZh
OWFkNDAuLjM3M2Q1NmQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5jCisrKyBi
L2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5jCkBAIC01NDcsOSArNTQ3LDExIEBAIHN0YXRpYyB2b2lk
IG1tY19zZGlvX2RldGVjdChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpCiAJQlVHX09OKCFob3N0LT5j
YXJkKTsKIAogCS8qIE1ha2Ugc3VyZSBjYXJkIGlzIHBvd2VyZWQgYmVmb3JlIGRldGVjdGluZyBp
dCAqLwotCWVyciA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoJmhvc3QtPmNhcmQtPmRldik7Ci0JaWYg
KGVyciA8IDApCi0JCWdvdG8gb3V0OworCWlmIChob3N0LT5jYXBzICYgTU1DX0NBUF9SVU5USU1F
X1BNKSB7CisJCWVyciA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoJmhvc3QtPmNhcmQtPmRldik7CisJ
CWlmIChlcnIgPCAwKQorCQkJZ290byBvdXQ7CisJfQogCiAJbW1jX2NsYWltX2hvc3QoaG9zdCk7
CiAKQEAgLTU3MCw3ICs1NzIsOCBAQCBvdXQ6CiAJfQogCiAJLyogVGVsbCBQTSBjb3JlIHRoYXQg
d2UncmUgZG9uZSAqLwotCXBtX3J1bnRpbWVfcHV0KCZob3N0LT5jYXJkLT5kZXYpOworCWlmICho
b3N0LT5jYXBzICYgTU1DX0NBUF9SVU5USU1FX1BNKQorCQlwbV9ydW50aW1lX3B1dCgmaG9zdC0+
Y2FyZC0+ZGV2KTsKIH0KIAogLyoKQEAgLTcyMCwxNiArNzIzLDIxIEBAIGludCBtbWNfYXR0YWNo
X3NkaW8oc3RydWN0IG1tY19ob3N0ICpob3N0LCB1MzIgb2NyKQogCWNhcmQgPSBob3N0LT5jYXJk
OwogCiAJLyoKLQkgKiBMZXQgcnVudGltZSBQTSBjb3JlIGtub3cgb3VyIGNhcmQgaXMgYWN0aXZl
CisJICogRW5hYmxlIHJ1bnRpbWUgUE0gb25seSBpZiBzdXBwb3J0ZWQgYnkgaG9zdCtjYXJkK2Jv
YXJkCiAJICovCi0JZXJyID0gcG1fcnVudGltZV9zZXRfYWN0aXZlKCZjYXJkLT5kZXYpOwotCWlm
IChlcnIpCi0JCWdvdG8gcmVtb3ZlOworCWlmIChob3N0LT5jYXBzICYgTU1DX0NBUF9SVU5USU1F
X1BNKSB7CisJCS8qCisJCSAqIExldCBydW50aW1lIFBNIGNvcmUga25vdyBvdXIgY2FyZCBpcyBh
Y3RpdmUKKwkJICovCisJCWVyciA9IHBtX3J1bnRpbWVfc2V0X2FjdGl2ZSgmY2FyZC0+ZGV2KTsK
KwkJaWYgKGVycikKKwkJCWdvdG8gcmVtb3ZlOwogCi0JLyoKLQkgKiBFbmFibGUgcnVudGltZSBQ
TSBmb3IgdGhpcyBjYXJkCi0JICovCi0JcG1fcnVudGltZV9lbmFibGUoJmNhcmQtPmRldik7CisJ
CS8qCisJCSAqIEVuYWJsZSBydW50aW1lIFBNIGZvciB0aGlzIGNhcmQKKwkJICovCisJCXBtX3J1
bnRpbWVfZW5hYmxlKCZjYXJkLT5kZXYpOworCX0KIAogCS8qCiAJICogVGhlIG51bWJlciBvZiBm
dW5jdGlvbnMgb24gdGhlIGNhcmQgaXMgZW5jb2RlZCBpbnNpZGUKQEAgLTc0Nyw5ICs3NTUsMTAg
QEAgaW50IG1tY19hdHRhY2hfc2RpbyhzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QsIHUzMiBvY3IpCiAJ
CQlnb3RvIHJlbW92ZTsKIAogCQkvKgotCQkgKiBFbmFibGUgUnVudGltZSBQTSBmb3IgdGhpcyBm
dW5jCisJCSAqIEVuYWJsZSBSdW50aW1lIFBNIGZvciB0aGlzIGZ1bmMgKGlmIHN1cHBvcnRlZCkK
IAkJICovCi0JCXBtX3J1bnRpbWVfZW5hYmxlKCZjYXJkLT5zZGlvX2Z1bmNbaV0tPmRldik7CisJ
CWlmIChob3N0LT5jYXBzICYgTU1DX0NBUF9SVU5USU1FX1BNKQorCQkJcG1fcnVudGltZV9lbmFi
bGUoJmNhcmQtPnNkaW9fZnVuY1tpXS0+ZGV2KTsKIAl9CiAKIAltbWNfcmVsZWFzZV9ob3N0KGhv
c3QpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9zZGlvX2J1cy5jIGIvZHJpdmVycy9t
bWMvY29yZS9zZGlvX2J1cy5jCmluZGV4IDI3MTZjN2EuLmYzY2UyMWIgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvbW1jL2NvcmUvc2Rpb19idXMuYworKysgYi9kcml2ZXJzL21tYy9jb3JlL3NkaW9fYnVz
LmMKQEAgLTE3LDYgKzE3LDcgQEAKICNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+CiAKICNp
bmNsdWRlIDxsaW51eC9tbWMvY2FyZC5oPgorI2luY2x1ZGUgPGxpbnV4L21tYy9ob3N0Lmg+CiAj
aW5jbHVkZSA8bGludXgvbW1jL3NkaW9fZnVuYy5oPgogCiAjaW5jbHVkZSAic2Rpb19jaXMuaCIK
QEAgLTEzMiw5ICsxMzMsMTEgQEAgc3RhdGljIGludCBzZGlvX2J1c19wcm9iZShzdHJ1Y3QgZGV2
aWNlICpkZXYpCiAJICogaXQgc2hvdWxkIGNhbGwgcG1fcnVudGltZV9wdXRfbm9pZGxlKCkgaW4g
aXRzIHByb2JlIHJvdXRpbmUgYW5kCiAJICogcG1fcnVudGltZV9nZXRfbm9yZXN1bWUoKSBpbiBp
dHMgcmVtb3ZlIHJvdXRpbmUuCiAJICovCi0JcmV0ID0gcG1fcnVudGltZV9nZXRfc3luYyhkZXYp
OwotCWlmIChyZXQgPCAwKQotCQlnb3RvIG91dDsKKwlpZiAoZnVuYy0+Y2FyZC0+aG9zdC0+Y2Fw
cyAmIE1NQ19DQVBfUlVOVElNRV9QTSkgeworCQlyZXQgPSBwbV9ydW50aW1lX2dldF9zeW5jKGRl
dik7CisJCWlmIChyZXQgPCAwKQorCQkJZ290byBvdXQ7CisJfQogCiAJLyogU2V0IHRoZSBkZWZh
dWx0IGJsb2NrIHNpemUgc28gdGhlIGRyaXZlciBpcyBzdXJlIGl0J3Mgc29tZXRoaW5nCiAJICog
c2Vuc2libGUuICovCkBAIC0xNTEsNyArMTU0LDggQEAgc3RhdGljIGludCBzZGlvX2J1c19wcm9i
ZShzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJcmV0dXJuIDA7CiAKIGRpc2FibGVfcnVudGltZXBtOgot
CXBtX3J1bnRpbWVfcHV0X25vaWRsZShkZXYpOworCWlmIChmdW5jLT5jYXJkLT5ob3N0LT5jYXBz
ICYgTU1DX0NBUF9SVU5USU1FX1BNKQorCQlwbV9ydW50aW1lX3B1dF9ub2lkbGUoZGV2KTsKIG91
dDoKIAlyZXR1cm4gcmV0OwogfQpAQCAtMTYwLDEyICsxNjQsMTQgQEAgc3RhdGljIGludCBzZGlv
X2J1c19yZW1vdmUoc3RydWN0IGRldmljZSAqZGV2KQogewogCXN0cnVjdCBzZGlvX2RyaXZlciAq
ZHJ2ID0gdG9fc2Rpb19kcml2ZXIoZGV2LT5kcml2ZXIpOwogCXN0cnVjdCBzZGlvX2Z1bmMgKmZ1
bmMgPSBkZXZfdG9fc2Rpb19mdW5jKGRldik7Ci0JaW50IHJldDsKKwlpbnQgcmV0ID0gMDsKIAog
CS8qIE1ha2Ugc3VyZSBjYXJkIGlzIHBvd2VyZWQgYmVmb3JlIGludm9raW5nIC0+cmVtb3ZlKCkg
Ki8KLQlyZXQgPSBwbV9ydW50aW1lX2dldF9zeW5jKGRldik7Ci0JaWYgKHJldCA8IDApCi0JCWdv
dG8gb3V0OworCWlmIChmdW5jLT5jYXJkLT5ob3N0LT5jYXBzICYgTU1DX0NBUF9SVU5USU1FX1BN
KSB7CisJCXJldCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoZGV2KTsKKwkJaWYgKHJldCA8IDApCisJ
CQlnb3RvIG91dDsKKwl9CiAKIAlkcnYtPnJlbW92ZShmdW5jKTsKIApAQCAtMTc4LDEwICsxODQs
MTIgQEAgc3RhdGljIGludCBzZGlvX2J1c19yZW1vdmUoc3RydWN0IGRldmljZSAqZGV2KQogCX0K
IAogCS8qIEZpcnN0LCB1bmRvIHRoZSBpbmNyZW1lbnQgbWFkZSBkaXJlY3RseSBhYm92ZSAqLwot
CXBtX3J1bnRpbWVfcHV0X25vaWRsZShkZXYpOworCWlmIChmdW5jLT5jYXJkLT5ob3N0LT5jYXBz
ICYgTU1DX0NBUF9SVU5USU1FX1BNKQorCQlwbV9ydW50aW1lX3B1dF9ub2lkbGUoZGV2KTsKIAog
CS8qIFRoZW4gdW5kbyB0aGUgcnVudGltZSBQTSBzZXR0aW5ncyBpbiBzZGlvX2J1c19wcm9iZSgp
ICovCi0JcG1fcnVudGltZV9wdXRfbm9pZGxlKGRldik7CisJaWYgKGZ1bmMtPmNhcmQtPmhvc3Qt
PmNhcHMgJiBNTUNfQ0FQX1JVTlRJTUVfUE0pCisJCXBtX3J1bnRpbWVfcHV0X25vaWRsZShkZXYp
OwogCiBvdXQ6CiAJcmV0dXJuIHJldDsKQEAgLTE5MSw2ICsxOTksOCBAQCBvdXQ6CiAKIHN0YXRp
YyBpbnQgc2Rpb19idXNfcG1fcHJlcGFyZShzdHJ1Y3QgZGV2aWNlICpkZXYpCiB7CisJc3RydWN0
IHNkaW9fZnVuYyAqZnVuYyA9IGRldl90b19zZGlvX2Z1bmMoZGV2KTsKKwogCS8qCiAJICogUmVz
dW1lIGFuIFNESU8gZGV2aWNlIHdoaWNoIHdhcyBzdXNwZW5kZWQgYXQgcnVuIHRpbWUgYXQgdGhp
cwogCSAqIHBvaW50LCBpbiBvcmRlciB0byBhbGxvdyBzdGFuZGFyZCBTRElPIHN1c3BlbmQvcmVz
dW1lIHBhdGhzCkBAIC0yMTIsNyArMjIyLDggQEAgc3RhdGljIGludCBzZGlvX2J1c19wbV9wcmVw
YXJlKHN0cnVjdCBkZXZpY2UgKmRldikKIAkgKiBzaW5jZSB0aGVyZSBpcyBsaXR0bGUgcG9pbnQg
aW4gZmFpbGluZyBzeXN0ZW0gc3VzcGVuZCBpZiBhCiAJICogZGV2aWNlIGNhbid0IGJlIHJlc3Vt
ZWQuCiAJICovCi0JcG1fcnVudGltZV9yZXN1bWUoZGV2KTsKKwlpZiAoZnVuYy0+Y2FyZC0+aG9z
dC0+Y2FwcyAmIE1NQ19DQVBfUlVOVElNRV9QTSkKKwkJcG1fcnVudGltZV9yZXN1bWUoZGV2KTsK
IAogCXJldHVybiAwOwogfQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tbWMvaG9zdC5oIGIv
aW5jbHVkZS9saW51eC9tbWMvaG9zdC5oCmluZGV4IGMzZmZhZDguLmU1ZWVlMGUgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvbGludXgvbW1jL2hvc3QuaAorKysgYi9pbmNsdWRlL2xpbnV4L21tYy9ob3N0
LmgKQEAgLTE2Nyw2ICsxNjcsNyBAQCBzdHJ1Y3QgbW1jX2hvc3QgewogCQkJCQkJLyogRERSIG1v
ZGUgYXQgMS44ViAqLwogI2RlZmluZSBNTUNfQ0FQXzFfMlZfRERSCSgxIDw8IDEyKQkvKiBjYW4g
c3VwcG9ydCAqLwogCQkJCQkJLyogRERSIG1vZGUgYXQgMS4yViAqLworI2RlZmluZSBNTUNfQ0FQ
X1JVTlRJTUVfUE0JKDEgPDwgMTMpCS8qIENhbiBwb3dlciBvZmYvb24gaW4gcnVudGltZSAqLwog
CiAJbW1jX3BtX2ZsYWdfdAkJcG1fY2FwczsJLyogc3VwcG9ydGVkIHBtIGZlYXR1cmVzICovCiAK
LS0gCjEuNy4wLjQKCg==
--20cf3054a165226ef10493f9954b--
