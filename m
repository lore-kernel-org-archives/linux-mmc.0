From: Jun Nie <niej0001@gmail.com>
Subject: [PATCH v2 1/1]mmc: check SDIO card wake up during suspending
Date: Thu, 18 Nov 2010 10:20:31 +0800
Message-ID: <AANLkTimYfU1EMOPZ7R+vmf7cbPD2+BmdwQErPOx8FrD0@mail.gmail.com>
References: <AANLkTimgPjY0=+mQxf+qa73L_2KfhH+A3XHhb_z1xp58@mail.gmail.com>
	<AANLkTikP7o=H6MC9LYVm=TKMZtj2Y=o7DAq3NEHXx8o+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=002215048ad3234fa504954a6f33
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40235 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754533Ab0KRCUf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Nov 2010 21:20:35 -0500
Received: by iwn35 with SMTP id 35so2868582iwn.19
        for <linux-mmc@vger.kernel.org>; Wed, 17 Nov 2010 18:20:34 -0800 (PST)
In-Reply-To: <AANLkTikP7o=H6MC9LYVm=TKMZtj2Y=o7DAq3NEHXx8o+@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Michal Miroslaw <mirqus@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Bing Zhao <bzhao@marvell.com>, zhangfei gao <zhangfei.gao@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>

--002215048ad3234fa504954a6f33
Content-Type: text/plain; charset=ISO-8859-1

>From 642b2e88fc4b6344290c88ce506fcda1bcc860a3 Mon Sep 17 00:00:00 2001
From: Jun Nie <njun@marvell.com>
Date: Fri, 12 Nov 2010 19:43:49 +0800
Subject: [PATCH] mmc: check SDIO card wake up during suspending

It is possible that SDIO card send card interrupt to wake up
system just after SDIO func driver and SDIO card firmware commit
suspend state, while system is still in suspending process and
mmc interrupt is not release yet.

Interrupt storm may happen if func driver does not notify firmware
to clear the wake up source. If func driver issue SDIO bus transaction
to have firmware clear the source and driver continue to handle the
wake up event, system may enter suspend before all transaction done.
In this case, SDIO card will not enter lower power mode never. But
system can not be wake up for only card insert/remove/interrupt irq are
listed in wake up source in SD spec. Data/command done irq can
not wake up system.

This patch check SDIO card interrupt and stop system suspend if there
are card interrupt after func driver suspend.

Signed-off-by: Jun Nie <njun@marvell.com>
---
 drivers/mmc/core/sdio.c       |   14 ++++++++++++++
 drivers/mmc/core/sdio_irq.c   |    6 ++++++
 drivers/mmc/host/sdhci.c      |   18 ++++++++++++++++--
 include/linux/mmc/card.h      |    2 ++
 include/linux/mmc/sdio_func.h |    2 ++
 5 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index c3ad105..48a4106 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -584,6 +584,14 @@ static int mmc_sdio_suspend(struct mmc_host *host)

 	for (i = 0; i < host->card->sdio_funcs; i++) {
 		struct sdio_func *func = host->card->sdio_func[i];
+		/* cancel suspend once we detect external wake up source */
+		if (host->card->pending_interrupt) {
+			host->card->pending_interrupt = 0;
+			err = -EBUSY;
+			printk(KERN_ALERT "%s: wake up event after device suspended\n",
+					mmc_hostname(host));
+			break;
+		}
 		if (func && sdio_func_present(func) && func->dev.driver) {
 			const struct dev_pm_ops *pmops = func->dev.driver->pm;
 			if (!pmops || !pmops->suspend || !pmops->resume) {
@@ -593,10 +601,15 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 				err = pmops->suspend(&func->dev);
 			if (err)
 				break;
+			else
+				/* It is prefer that func driver set it in its
+				   suspend function with mmc_claim_host */
+				func->suspended = true;
 		}
 	}
 	while (err && --i >= 0) {
 		struct sdio_func *func = host->card->sdio_func[i];
+		func->suspended = false;
 		if (func && sdio_func_present(func) && func->dev.driver) {
 			const struct dev_pm_ops *pmops = func->dev.driver->pm;
 			pmops->resume(&func->dev);
@@ -639,6 +652,7 @@ static int mmc_sdio_resume(struct mmc_host *host)
 	 */
 	for (i = 0; !err && i < host->card->sdio_funcs; i++) {
 		struct sdio_func *func = host->card->sdio_func[i];
+		func->suspended = false;
 		if (func && sdio_func_present(func) && func->dev.driver) {
 			const struct dev_pm_ops *pmops = func->dev.driver->pm;
 			err = pmops->resume(&func->dev);
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index bb192f9..727a1a3 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -49,6 +49,12 @@ static int process_sdio_pending_irqs(struct mmc_card *card)
 					mmc_card_id(card));
 				ret = -EINVAL;
 			} else if (func->irq_handler) {
+				if (func->suspended) {
+					card->pending_interrupt = true;
+					printk(KERN_WARNING "%s: IRQ that "
+						"arrives in suspend mode"
+						" mode\n", sdio_func_id(func));
+				}
 				func->irq_handler(func);
 				count++;
 			} else {
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 782c0ee..9c8f1cc 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -24,6 +24,7 @@
 #include <linux/leds.h>

 #include <linux/mmc/host.h>
+#include <linux/mmc/card.h>

 #include "sdhci.h"

@@ -1631,7 +1632,7 @@ out:

 int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
 {
-	int ret;
+	int ret = 0;

 	sdhci_disable_card_detection(host);

@@ -1641,8 +1642,19 @@ int sdhci_suspend_host(struct sdhci_host *host,
pm_message_t state)

 	free_irq(host->irq, host);

-	if (host->vmmc)
+	if (host->vmmc) {
 		ret = regulator_disable(host->vmmc);
+		if (ret)
+			return ret;
+	}
+
+	if (host->mmc->card && host->mmc->card->pending_interrupt) {
+		DBG("%s wake up event after suspend, resuming to handle it\n",
+			mmc_hostname(host->mmc));
+		host->mmc->card->pending_interrupt = 0;
+		sdhci_resume_host(host);
+		return -EBUSY;
+	}

 	return ret;
 }
@@ -1659,6 +1671,8 @@ int sdhci_resume_host(struct sdhci_host *host)
 			return ret;
 	}

+	if (host->mmc->card && host->mmc->card->pending_interrupt)
+		host->mmc->card->pending_interrupt = 0;

 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
 		if (host->ops->enable_dma)
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 8ce0827..2252fe2 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -146,6 +146,8 @@ struct mmc_card {
 	struct sdio_func_tuple	*tuples;	/* unknown common tuples */

 	struct dentry		*debugfs_root;
+	/* external interrupt arrived after sdio function suspended */
+	u32			pending_interrupt;
 };

 #define mmc_card_mmc(c)		((c)->type == MMC_TYPE_MMC)
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index 31baaf8..5c1c462 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -59,6 +59,8 @@ struct sdio_func {
 	const char		**info;		/* info strings */

 	struct sdio_func_tuple *tuples;
+
+	int			suspended; /* SDIO function driver state */
 };

 #define sdio_func_present(f)	((f)->state & SDIO_STATE_PRESENT)
-- 
1.7.0.4

--002215048ad3234fa504954a6f33
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-mmc-check-SDIO-card-wake-up-during-suspending.patch"
Content-Disposition: attachment;
	filename="0001-mmc-check-SDIO-card-wake-up-during-suspending.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ggn0emf30

RnJvbSA2NDJiMmU4OGZjNGI2MzQ0MjkwYzg4Y2U1MDZmY2RhMWJjYzg2MGEzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBGcmks
IDEyIE5vdiAyMDEwIDE5OjQzOjQ5ICswODAwClN1YmplY3Q6IFtQQVRDSF0gbW1jOiBjaGVjayBT
RElPIGNhcmQgd2FrZSB1cCBkdXJpbmcgc3VzcGVuZGluZwoKSXQgaXMgcG9zc2libGUgdGhhdCBT
RElPIGNhcmQgc2VuZCBjYXJkIGludGVycnVwdCB0byB3YWtlIHVwCnN5c3RlbSBqdXN0IGFmdGVy
IFNESU8gZnVuYyBkcml2ZXIgYW5kIFNESU8gY2FyZCBmaXJtd2FyZSBjb21taXQKc3VzcGVuZCBz
dGF0ZSwgd2hpbGUgc3lzdGVtIGlzIHN0aWxsIGluIHN1c3BlbmRpbmcgcHJvY2VzcyBhbmQKbW1j
IGludGVycnVwdCBpcyBub3QgcmVsZWFzZSB5ZXQuCgpJbnRlcnJ1cHQgc3Rvcm0gbWF5IGhhcHBl
biBpZiBmdW5jIGRyaXZlciBkb2VzIG5vdCBub3RpZnkgZmlybXdhcmUKdG8gY2xlYXIgdGhlIHdh
a2UgdXAgc291cmNlLiBJZiBmdW5jIGRyaXZlciBpc3N1ZSBTRElPIGJ1cyB0cmFuc2FjdGlvbgp0
byBoYXZlIGZpcm13YXJlIGNsZWFyIHRoZSBzb3VyY2UgYW5kIGRyaXZlciBjb250aW51ZSB0byBo
YW5kbGUgdGhlCndha2UgdXAgZXZlbnQsIHN5c3RlbSBtYXkgZW50ZXIgc3VzcGVuZCBiZWZvcmUg
YWxsIHRyYW5zYWN0aW9uIGRvbmUuCkluIHRoaXMgY2FzZSwgU0RJTyBjYXJkIHdpbGwgbm90IGVu
dGVyIGxvd2VyIHBvd2VyIG1vZGUgbmV2ZXIuIEJ1dApzeXN0ZW0gY2FuIG5vdCBiZSB3YWtlIHVw
IGZvciBvbmx5IGNhcmQgaW5zZXJ0L3JlbW92ZS9pbnRlcnJ1cHQgaXJxIGFyZQpsaXN0ZWQgaW4g
d2FrZSB1cCBzb3VyY2UgaW4gU0Qgc3BlYy4gRGF0YS9jb21tYW5kIGRvbmUgaXJxIGNhbgpub3Qg
d2FrZSB1cCBzeXN0ZW0uCgpUaGlzIHBhdGNoIGNoZWNrIFNESU8gY2FyZCBpbnRlcnJ1cHQgYW5k
IHN0b3Agc3lzdGVtIHN1c3BlbmQgaWYgdGhlcmUKYXJlIGNhcmQgaW50ZXJydXB0IGFmdGVyIGZ1
bmMgZHJpdmVyIHN1c3BlbmQuCgpTaWduZWQtb2ZmLWJ5OiBKdW4gTmllIDxuanVuQG1hcnZlbGwu
Y29tPgotLS0KIGRyaXZlcnMvbW1jL2NvcmUvc2Rpby5jICAgICAgIHwgICAxNCArKysrKysrKysr
KysrKwogZHJpdmVycy9tbWMvY29yZS9zZGlvX2lycS5jICAgfCAgICA2ICsrKysrKwogZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS5jICAgICAgfCAgIDE4ICsrKysrKysrKysrKysrKystLQogaW5jbHVk
ZS9saW51eC9tbWMvY2FyZC5oICAgICAgfCAgICAyICsrCiBpbmNsdWRlL2xpbnV4L21tYy9zZGlv
X2Z1bmMuaCB8ICAgIDIgKysKIDUgZmlsZXMgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL3NkaW8uYyBiL2RyaXZl
cnMvbW1jL2NvcmUvc2Rpby5jCmluZGV4IGMzYWQxMDUuLjQ4YTQxMDYgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvbW1jL2NvcmUvc2Rpby5jCisrKyBiL2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5jCkBAIC01
ODQsNiArNTg0LDE0IEBAIHN0YXRpYyBpbnQgbW1jX3NkaW9fc3VzcGVuZChzdHJ1Y3QgbW1jX2hv
c3QgKmhvc3QpCiAKIAlmb3IgKGkgPSAwOyBpIDwgaG9zdC0+Y2FyZC0+c2Rpb19mdW5jczsgaSsr
KSB7CiAJCXN0cnVjdCBzZGlvX2Z1bmMgKmZ1bmMgPSBob3N0LT5jYXJkLT5zZGlvX2Z1bmNbaV07
CisJCS8qIGNhbmNlbCBzdXNwZW5kIG9uY2Ugd2UgZGV0ZWN0IGV4dGVybmFsIHdha2UgdXAgc291
cmNlICovCisJCWlmIChob3N0LT5jYXJkLT5wZW5kaW5nX2ludGVycnVwdCkgeworCQkJaG9zdC0+
Y2FyZC0+cGVuZGluZ19pbnRlcnJ1cHQgPSAwOworCQkJZXJyID0gLUVCVVNZOworCQkJcHJpbnRr
KEtFUk5fQUxFUlQgIiVzOiB3YWtlIHVwIGV2ZW50IGFmdGVyIGRldmljZSBzdXNwZW5kZWRcbiIs
CisJCQkJCW1tY19ob3N0bmFtZShob3N0KSk7CisJCQlicmVhazsKKwkJfQogCQlpZiAoZnVuYyAm
JiBzZGlvX2Z1bmNfcHJlc2VudChmdW5jKSAmJiBmdW5jLT5kZXYuZHJpdmVyKSB7CiAJCQljb25z
dCBzdHJ1Y3QgZGV2X3BtX29wcyAqcG1vcHMgPSBmdW5jLT5kZXYuZHJpdmVyLT5wbTsKIAkJCWlm
ICghcG1vcHMgfHwgIXBtb3BzLT5zdXNwZW5kIHx8ICFwbW9wcy0+cmVzdW1lKSB7CkBAIC01OTMs
MTAgKzYwMSwxNSBAQCBzdGF0aWMgaW50IG1tY19zZGlvX3N1c3BlbmQoc3RydWN0IG1tY19ob3N0
ICpob3N0KQogCQkJCWVyciA9IHBtb3BzLT5zdXNwZW5kKCZmdW5jLT5kZXYpOwogCQkJaWYgKGVy
cikKIAkJCQlicmVhazsKKwkJCWVsc2UKKwkJCQkvKiBJdCBpcyBwcmVmZXIgdGhhdCBmdW5jIGRy
aXZlciBzZXQgaXQgaW4gaXRzCisJCQkJICAgc3VzcGVuZCBmdW5jdGlvbiB3aXRoIG1tY19jbGFp
bV9ob3N0ICovCisJCQkJZnVuYy0+c3VzcGVuZGVkID0gdHJ1ZTsKIAkJfQogCX0KIAl3aGlsZSAo
ZXJyICYmIC0taSA+PSAwKSB7CiAJCXN0cnVjdCBzZGlvX2Z1bmMgKmZ1bmMgPSBob3N0LT5jYXJk
LT5zZGlvX2Z1bmNbaV07CisJCWZ1bmMtPnN1c3BlbmRlZCA9IGZhbHNlOwogCQlpZiAoZnVuYyAm
JiBzZGlvX2Z1bmNfcHJlc2VudChmdW5jKSAmJiBmdW5jLT5kZXYuZHJpdmVyKSB7CiAJCQljb25z
dCBzdHJ1Y3QgZGV2X3BtX29wcyAqcG1vcHMgPSBmdW5jLT5kZXYuZHJpdmVyLT5wbTsKIAkJCXBt
b3BzLT5yZXN1bWUoJmZ1bmMtPmRldik7CkBAIC02MzksNiArNjUyLDcgQEAgc3RhdGljIGludCBt
bWNfc2Rpb19yZXN1bWUoc3RydWN0IG1tY19ob3N0ICpob3N0KQogCSAqLwogCWZvciAoaSA9IDA7
ICFlcnIgJiYgaSA8IGhvc3QtPmNhcmQtPnNkaW9fZnVuY3M7IGkrKykgewogCQlzdHJ1Y3Qgc2Rp
b19mdW5jICpmdW5jID0gaG9zdC0+Y2FyZC0+c2Rpb19mdW5jW2ldOworCQlmdW5jLT5zdXNwZW5k
ZWQgPSBmYWxzZTsKIAkJaWYgKGZ1bmMgJiYgc2Rpb19mdW5jX3ByZXNlbnQoZnVuYykgJiYgZnVu
Yy0+ZGV2LmRyaXZlcikgewogCQkJY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgKnBtb3BzID0gZnVu
Yy0+ZGV2LmRyaXZlci0+cG07CiAJCQllcnIgPSBwbW9wcy0+cmVzdW1lKCZmdW5jLT5kZXYpOwpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9zZGlvX2lycS5jIGIvZHJpdmVycy9tbWMvY29y
ZS9zZGlvX2lycS5jCmluZGV4IGJiMTkyZjkuLjcyN2ExYTMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
bW1jL2NvcmUvc2Rpb19pcnEuYworKysgYi9kcml2ZXJzL21tYy9jb3JlL3NkaW9faXJxLmMKQEAg
LTQ5LDYgKzQ5LDEyIEBAIHN0YXRpYyBpbnQgcHJvY2Vzc19zZGlvX3BlbmRpbmdfaXJxcyhzdHJ1
Y3QgbW1jX2NhcmQgKmNhcmQpCiAJCQkJCW1tY19jYXJkX2lkKGNhcmQpKTsKIAkJCQlyZXQgPSAt
RUlOVkFMOwogCQkJfSBlbHNlIGlmIChmdW5jLT5pcnFfaGFuZGxlcikgeworCQkJCWlmIChmdW5j
LT5zdXNwZW5kZWQpIHsKKwkJCQkJY2FyZC0+cGVuZGluZ19pbnRlcnJ1cHQgPSB0cnVlOworCQkJ
CQlwcmludGsoS0VSTl9XQVJOSU5HICIlczogSVJRIHRoYXQgIgorCQkJCQkJImFycml2ZXMgaW4g
c3VzcGVuZCBtb2RlIgorCQkJCQkJIiBtb2RlXG4iLCBzZGlvX2Z1bmNfaWQoZnVuYykpOworCQkJ
CX0KIAkJCQlmdW5jLT5pcnFfaGFuZGxlcihmdW5jKTsKIAkJCQljb3VudCsrOwogCQkJfSBlbHNl
IHsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyBiL2RyaXZlcnMvbW1jL2hv
c3Qvc2RoY2kuYwppbmRleCA3ODJjMGVlLi45YzhmMWNjIDEwMDY0NAotLS0gYS9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLmMKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jCkBAIC0yNCw2ICsy
NCw3IEBACiAjaW5jbHVkZSA8bGludXgvbGVkcy5oPgogCiAjaW5jbHVkZSA8bGludXgvbW1jL2hv
c3QuaD4KKyNpbmNsdWRlIDxsaW51eC9tbWMvY2FyZC5oPgogCiAjaW5jbHVkZSAic2RoY2kuaCIK
IApAQCAtMTYzMSw3ICsxNjMyLDcgQEAgb3V0OgogCiBpbnQgc2RoY2lfc3VzcGVuZF9ob3N0KHN0
cnVjdCBzZGhjaV9ob3N0ICpob3N0LCBwbV9tZXNzYWdlX3Qgc3RhdGUpCiB7Ci0JaW50IHJldDsK
KwlpbnQgcmV0ID0gMDsKIAogCXNkaGNpX2Rpc2FibGVfY2FyZF9kZXRlY3Rpb24oaG9zdCk7CiAK
QEAgLTE2NDEsOCArMTY0MiwxOSBAQCBpbnQgc2RoY2lfc3VzcGVuZF9ob3N0KHN0cnVjdCBzZGhj
aV9ob3N0ICpob3N0LCBwbV9tZXNzYWdlX3Qgc3RhdGUpCiAKIAlmcmVlX2lycShob3N0LT5pcnEs
IGhvc3QpOwogCi0JaWYgKGhvc3QtPnZtbWMpCisJaWYgKGhvc3QtPnZtbWMpIHsKIAkJcmV0ID0g
cmVndWxhdG9yX2Rpc2FibGUoaG9zdC0+dm1tYyk7CisJCWlmIChyZXQpCisJCQlyZXR1cm4gcmV0
OworCX0KKworCWlmIChob3N0LT5tbWMtPmNhcmQgJiYgaG9zdC0+bW1jLT5jYXJkLT5wZW5kaW5n
X2ludGVycnVwdCkgeworCQlEQkcoIiVzIHdha2UgdXAgZXZlbnQgYWZ0ZXIgc3VzcGVuZCwgcmVz
dW1pbmcgdG8gaGFuZGxlIGl0XG4iLAorCQkJbW1jX2hvc3RuYW1lKGhvc3QtPm1tYykpOworCQlo
b3N0LT5tbWMtPmNhcmQtPnBlbmRpbmdfaW50ZXJydXB0ID0gMDsKKwkJc2RoY2lfcmVzdW1lX2hv
c3QoaG9zdCk7CisJCXJldHVybiAtRUJVU1k7CisJfQogCiAJcmV0dXJuIHJldDsKIH0KQEAgLTE2
NTksNiArMTY3MSw4IEBAIGludCBzZGhjaV9yZXN1bWVfaG9zdChzdHJ1Y3Qgc2RoY2lfaG9zdCAq
aG9zdCkKIAkJCXJldHVybiByZXQ7CiAJfQogCisJaWYgKGhvc3QtPm1tYy0+Y2FyZCAmJiBob3N0
LT5tbWMtPmNhcmQtPnBlbmRpbmdfaW50ZXJydXB0KQorCQlob3N0LT5tbWMtPmNhcmQtPnBlbmRp
bmdfaW50ZXJydXB0ID0gMDsKIAogCWlmIChob3N0LT5mbGFncyAmIChTREhDSV9VU0VfU0RNQSB8
IFNESENJX1VTRV9BRE1BKSkgewogCQlpZiAoaG9zdC0+b3BzLT5lbmFibGVfZG1hKQpkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9tbWMvY2FyZC5oIGIvaW5jbHVkZS9saW51eC9tbWMvY2FyZC5o
CmluZGV4IDhjZTA4MjcuLjIyNTJmZTIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvbW1jL2Nh
cmQuaAorKysgYi9pbmNsdWRlL2xpbnV4L21tYy9jYXJkLmgKQEAgLTE0Niw2ICsxNDYsOCBAQCBz
dHJ1Y3QgbW1jX2NhcmQgewogCXN0cnVjdCBzZGlvX2Z1bmNfdHVwbGUJKnR1cGxlczsJLyogdW5r
bm93biBjb21tb24gdHVwbGVzICovCiAKIAlzdHJ1Y3QgZGVudHJ5CQkqZGVidWdmc19yb290Owor
CS8qIGV4dGVybmFsIGludGVycnVwdCBhcnJpdmVkIGFmdGVyIHNkaW8gZnVuY3Rpb24gc3VzcGVu
ZGVkICovCisJdTMyCQkJcGVuZGluZ19pbnRlcnJ1cHQ7CiB9OwogCiAjZGVmaW5lIG1tY19jYXJk
X21tYyhjKQkJKChjKS0+dHlwZSA9PSBNTUNfVFlQRV9NTUMpCmRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L21tYy9zZGlvX2Z1bmMuaCBiL2luY2x1ZGUvbGludXgvbW1jL3NkaW9fZnVuYy5oCmlu
ZGV4IDMxYmFhZjguLjVjMWM0NjIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvbW1jL3NkaW9f
ZnVuYy5oCisrKyBiL2luY2x1ZGUvbGludXgvbW1jL3NkaW9fZnVuYy5oCkBAIC01OSw2ICs1OSw4
IEBAIHN0cnVjdCBzZGlvX2Z1bmMgewogCWNvbnN0IGNoYXIJCSoqaW5mbzsJCS8qIGluZm8gc3Ry
aW5ncyAqLwogCiAJc3RydWN0IHNkaW9fZnVuY190dXBsZSAqdHVwbGVzOworCisJaW50CQkJc3Vz
cGVuZGVkOyAvKiBTRElPIGZ1bmN0aW9uIGRyaXZlciBzdGF0ZSAqLwogfTsKIAogI2RlZmluZSBz
ZGlvX2Z1bmNfcHJlc2VudChmKQkoKGYpLT5zdGF0ZSAmIFNESU9fU1RBVEVfUFJFU0VOVCkKLS0g
CjEuNy4wLjQKCg==
--002215048ad3234fa504954a6f33--
