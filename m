From: Jun Nie <niej0001@gmail.com>
Subject: [PATCH v1 1/1]mmc: check SDIO card wake up during suspending
Date: Fri, 12 Nov 2010 12:56:19 +0800
Message-ID: <AANLkTimgPjY0=+mQxf+qa73L_2KfhH+A3XHhb_z1xp58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0022152d5fb54c5ec90494d3e99d
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36836 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702Ab0KLE4U (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Nov 2010 23:56:20 -0500
Received: by iwn10 with SMTP id 10so3026787iwn.19
        for <linux-mmc@vger.kernel.org>; Thu, 11 Nov 2010 20:56:20 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Michal Miroslaw <mirqus@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Bing Zhao <bzhao@marvell.com>, zhangfei gao <zhangfei.gao@gmail.com>

--0022152d5fb54c5ec90494d3e99d
Content-Type: text/plain; charset=ISO-8859-1

>From 5d0f058eaa125df9a3b53ec3cbe9c385acaee959 Mon Sep 17 00:00:00 2001
From: Jun Nie <njun@marvell.com>
Date: Fri, 12 Nov 2010 19:43:49 +0800
Subject: [PATCH] mmc: check SDIO card wake up during suspending

It is possible that SDIO card issue card interrupt to wake up
system just after SDIO func driver and SDIO card firmware commit
suspend state, while system is still in suspending process and
mmc interrupt is not release yet.

Interrupt storm may happen if func driver does not notify firmware
to clear the wake up source. If func driver issue SDIO bus transaction
to have firmware clear the source and driver try to handle the wake
up event, system may enter suspend before all transaction done.
In this case, SDIO card will not enter lower power mode never. But
system can not be wake up for only card insert/remove/interrupt irq are
listed in wake up source in SD spec. Data/command done irq can
not wake up system.

This patch check SDIO card interrupt and stop system suspend if there
are card interrupt after func driver suspend.

Signed-off-by: Jun Nie <njun@marvell.com>
---
 drivers/mmc/core/sdio.c       |   14 ++++++++++++++
 drivers/mmc/core/sdio_irq.c   |    5 +++++
 drivers/mmc/host/sdhci.c      |   14 +++++++++++++-
 include/linux/mmc/card.h      |    2 ++
 include/linux/mmc/sdio_func.h |    2 ++
 5 files changed, 36 insertions(+), 1 deletions(-)

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
index bb192f9..2665974 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -49,6 +49,11 @@ static int process_sdio_pending_irqs(struct mmc_card *card)
 					mmc_card_id(card));
 				ret = -EINVAL;
 			} else if (func->irq_handler) {
+				if (func->suspended) {
+					card->pending_interrupt = true;
+					printk(KERN_WARNING "%s: IRQ that arrives in suspend mode"
+						" mode\n", sdio_func_id(func));
+				}
 				func->irq_handler(func);
 				count++;
 			} else {
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 782c0ee..670c141 100644
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

@@ -1644,6 +1645,14 @@ int sdhci_suspend_host(struct sdhci_host *host,
pm_message_t state)
 	if (host->vmmc)
 		ret = regulator_disable(host->vmmc);

+	if (host->mmc->card && host->mmc->card->pending_interrupt) {
+		DBG("*** %s wake up event after suspend, resuming to handle it\n",
+			mmc_hostname(host->mmc));
+		host->mmc->card->pending_interrupt = 0;
+		sdhci_resume_host(host);
+		ret = -EBUSY;
+	}
+
 	return ret;
 }

@@ -1659,6 +1668,9 @@ int sdhci_resume_host(struct sdhci_host *host)
 			return ret;
 	}

+	if (host->mmc->card && host->mmc->card->pending_interrupt)
+		host->mmc->card->pending_interrupt = 0;
+

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

--0022152d5fb54c5ec90494d3e99d
Content-Type: text/x-diff; charset=US-ASCII;
	name="0001-mmc-check-SDIO-card-wake-up-during-suspending.patch"
Content-Disposition: attachment;
	filename="0001-mmc-check-SDIO-card-wake-up-during-suspending.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ggelbbiy1

RnJvbSA1ZDBmMDU4ZWFhMTI1ZGY5YTNiNTNlYzNjYmU5YzM4NWFjYWVlOTU5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBGcmks
IDEyIE5vdiAyMDEwIDE5OjQzOjQ5ICswODAwClN1YmplY3Q6IFtQQVRDSF0gbW1jOiBjaGVjayBT
RElPIGNhcmQgd2FrZSB1cCBkdXJpbmcgc3VzcGVuZGluZwoKSXQgaXMgcG9zc2libGUgdGhhdCBT
RElPIGNhcmQgaXNzdWUgY2FyZCBpbnRlcnJ1cHQgdG8gd2FrZSB1cApzeXN0ZW0ganVzdCBhZnRl
ciBTRElPIGZ1bmMgZHJpdmVyIGFuZCBTRElPIGNhcmQgZmlybXdhcmUgY29tbWl0CnN1c3BlbmQg
c3RhdGUsIHdoaWxlIHN5c3RlbSBpcyBzdGlsbCBpbiBzdXNwZW5kaW5nIHByb2Nlc3MgYW5kCm1t
YyBpbnRlcnJ1cHQgaXMgbm90IHJlbGVhc2UgeWV0LgoKSW50ZXJydXB0IHN0b3JtIG1heSBoYXBw
ZW4gaWYgZnVuYyBkcml2ZXIgZG9lcyBub3Qgbm90aWZ5IGZpcm13YXJlCnRvIGNsZWFyIHRoZSB3
YWtlIHVwIHNvdXJjZS4gSWYgZnVuYyBkcml2ZXIgaXNzdWUgU0RJTyBidXMgdHJhbnNhY3Rpb24K
dG8gaGF2ZSBmaXJtd2FyZSBjbGVhciB0aGUgc291cmNlIGFuZCBkcml2ZXIgdHJ5IHRvIGhhbmRs
ZSB0aGUgd2FrZQp1cCBldmVudCwgc3lzdGVtIG1heSBlbnRlciBzdXNwZW5kIGJlZm9yZSBhbGwg
dHJhbnNhY3Rpb24gZG9uZS4KSW4gdGhpcyBjYXNlLCBTRElPIGNhcmQgd2lsbCBub3QgZW50ZXIg
bG93ZXIgcG93ZXIgbW9kZSBuZXZlci4gQnV0CnN5c3RlbSBjYW4gbm90IGJlIHdha2UgdXAgZm9y
IG9ubHkgY2FyZCBpbnNlcnQvcmVtb3ZlL2ludGVycnVwdCBpcnEgYXJlCmxpc3RlZCBpbiB3YWtl
IHVwIHNvdXJjZSBpbiBTRCBzcGVjLiBEYXRhL2NvbW1hbmQgZG9uZSBpcnEgY2FuCm5vdCB3YWtl
IHVwIHN5c3RlbS4KClRoaXMgcGF0Y2ggY2hlY2sgU0RJTyBjYXJkIGludGVycnVwdCBhbmQgc3Rv
cCBzeXN0ZW0gc3VzcGVuZCBpZiB0aGVyZQphcmUgY2FyZCBpbnRlcnJ1cHQgYWZ0ZXIgZnVuYyBk
cml2ZXIgc3VzcGVuZC4KClNpZ25lZC1vZmYtYnk6IEp1biBOaWUgPG5qdW5AbWFydmVsbC5jb20+
Ci0tLQogZHJpdmVycy9tbWMvY29yZS9zZGlvLmMgICAgICAgfCAgIDE0ICsrKysrKysrKysrKysr
CiBkcml2ZXJzL21tYy9jb3JlL3NkaW9faXJxLmMgICB8ICAgIDUgKysrKysKIGRyaXZlcnMvbW1j
L2hvc3Qvc2RoY2kuYyAgICAgIHwgICAxNCArKysrKysrKysrKysrLQogaW5jbHVkZS9saW51eC9t
bWMvY2FyZC5oICAgICAgfCAgICAyICsrCiBpbmNsdWRlL2xpbnV4L21tYy9zZGlvX2Z1bmMuaCB8
ICAgIDIgKysKIDUgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL3NkaW8uYyBiL2RyaXZlcnMvbW1jL2Nv
cmUvc2Rpby5jCmluZGV4IGMzYWQxMDUuLjQ4YTQxMDYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1j
L2NvcmUvc2Rpby5jCisrKyBiL2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5jCkBAIC01ODQsNiArNTg0
LDE0IEBAIHN0YXRpYyBpbnQgbW1jX3NkaW9fc3VzcGVuZChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3Qp
CiAKIAlmb3IgKGkgPSAwOyBpIDwgaG9zdC0+Y2FyZC0+c2Rpb19mdW5jczsgaSsrKSB7CiAJCXN0
cnVjdCBzZGlvX2Z1bmMgKmZ1bmMgPSBob3N0LT5jYXJkLT5zZGlvX2Z1bmNbaV07CisJCS8qIGNh
bmNlbCBzdXNwZW5kIG9uY2Ugd2UgZGV0ZWN0IGV4dGVybmFsIHdha2UgdXAgc291cmNlICovCisJ
CWlmIChob3N0LT5jYXJkLT5wZW5kaW5nX2ludGVycnVwdCkgeworCQkJaG9zdC0+Y2FyZC0+cGVu
ZGluZ19pbnRlcnJ1cHQgPSAwOworCQkJZXJyID0gLUVCVVNZOworCQkJcHJpbnRrKEtFUk5fQUxF
UlQgIiVzOiB3YWtlIHVwIGV2ZW50IGFmdGVyIGRldmljZSBzdXNwZW5kZWRcbiIsCisJCQkJCW1t
Y19ob3N0bmFtZShob3N0KSk7CisJCQlicmVhazsKKwkJfQogCQlpZiAoZnVuYyAmJiBzZGlvX2Z1
bmNfcHJlc2VudChmdW5jKSAmJiBmdW5jLT5kZXYuZHJpdmVyKSB7CiAJCQljb25zdCBzdHJ1Y3Qg
ZGV2X3BtX29wcyAqcG1vcHMgPSBmdW5jLT5kZXYuZHJpdmVyLT5wbTsKIAkJCWlmICghcG1vcHMg
fHwgIXBtb3BzLT5zdXNwZW5kIHx8ICFwbW9wcy0+cmVzdW1lKSB7CkBAIC01OTMsMTAgKzYwMSwx
NSBAQCBzdGF0aWMgaW50IG1tY19zZGlvX3N1c3BlbmQoc3RydWN0IG1tY19ob3N0ICpob3N0KQog
CQkJCWVyciA9IHBtb3BzLT5zdXNwZW5kKCZmdW5jLT5kZXYpOwogCQkJaWYgKGVycikKIAkJCQli
cmVhazsKKwkJCWVsc2UKKwkJCQkvKiBJdCBpcyBwcmVmZXIgdGhhdCBmdW5jIGRyaXZlciBzZXQg
aXQgaW4gaXRzCisJCQkJICAgc3VzcGVuZCBmdW5jdGlvbiB3aXRoIG1tY19jbGFpbV9ob3N0ICov
CisJCQkJZnVuYy0+c3VzcGVuZGVkID0gdHJ1ZTsKIAkJfQogCX0KIAl3aGlsZSAoZXJyICYmIC0t
aSA+PSAwKSB7CiAJCXN0cnVjdCBzZGlvX2Z1bmMgKmZ1bmMgPSBob3N0LT5jYXJkLT5zZGlvX2Z1
bmNbaV07CisJCWZ1bmMtPnN1c3BlbmRlZCA9IGZhbHNlOwogCQlpZiAoZnVuYyAmJiBzZGlvX2Z1
bmNfcHJlc2VudChmdW5jKSAmJiBmdW5jLT5kZXYuZHJpdmVyKSB7CiAJCQljb25zdCBzdHJ1Y3Qg
ZGV2X3BtX29wcyAqcG1vcHMgPSBmdW5jLT5kZXYuZHJpdmVyLT5wbTsKIAkJCXBtb3BzLT5yZXN1
bWUoJmZ1bmMtPmRldik7CkBAIC02MzksNiArNjUyLDcgQEAgc3RhdGljIGludCBtbWNfc2Rpb19y
ZXN1bWUoc3RydWN0IG1tY19ob3N0ICpob3N0KQogCSAqLwogCWZvciAoaSA9IDA7ICFlcnIgJiYg
aSA8IGhvc3QtPmNhcmQtPnNkaW9fZnVuY3M7IGkrKykgewogCQlzdHJ1Y3Qgc2Rpb19mdW5jICpm
dW5jID0gaG9zdC0+Y2FyZC0+c2Rpb19mdW5jW2ldOworCQlmdW5jLT5zdXNwZW5kZWQgPSBmYWxz
ZTsKIAkJaWYgKGZ1bmMgJiYgc2Rpb19mdW5jX3ByZXNlbnQoZnVuYykgJiYgZnVuYy0+ZGV2LmRy
aXZlcikgewogCQkJY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgKnBtb3BzID0gZnVuYy0+ZGV2LmRy
aXZlci0+cG07CiAJCQllcnIgPSBwbW9wcy0+cmVzdW1lKCZmdW5jLT5kZXYpOwpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tbWMvY29yZS9zZGlvX2lycS5jIGIvZHJpdmVycy9tbWMvY29yZS9zZGlvX2ly
cS5jCmluZGV4IGJiMTkyZjkuLjI2NjU5NzQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2NvcmUv
c2Rpb19pcnEuYworKysgYi9kcml2ZXJzL21tYy9jb3JlL3NkaW9faXJxLmMKQEAgLTQ5LDYgKzQ5
LDExIEBAIHN0YXRpYyBpbnQgcHJvY2Vzc19zZGlvX3BlbmRpbmdfaXJxcyhzdHJ1Y3QgbW1jX2Nh
cmQgKmNhcmQpCiAJCQkJCW1tY19jYXJkX2lkKGNhcmQpKTsKIAkJCQlyZXQgPSAtRUlOVkFMOwog
CQkJfSBlbHNlIGlmIChmdW5jLT5pcnFfaGFuZGxlcikgeworCQkJCWlmIChmdW5jLT5zdXNwZW5k
ZWQpIHsKKwkJCQkJY2FyZC0+cGVuZGluZ19pbnRlcnJ1cHQgPSB0cnVlOworCQkJCQlwcmludGso
S0VSTl9XQVJOSU5HICIlczogSVJRIHRoYXQgYXJyaXZlcyBpbiBzdXNwZW5kIG1vZGUiCisJCQkJ
CQkiIG1vZGVcbiIsIHNkaW9fZnVuY19pZChmdW5jKSk7CisJCQkJfQogCQkJCWZ1bmMtPmlycV9o
YW5kbGVyKGZ1bmMpOwogCQkJCWNvdW50Kys7CiAJCQl9IGVsc2UgewpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jCmluZGV4IDc4
MmMwZWUuLjY3MGMxNDEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYworKysg
Yi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMKQEAgLTI0LDYgKzI0LDcgQEAKICNpbmNsdWRlIDxs
aW51eC9sZWRzLmg+CiAKICNpbmNsdWRlIDxsaW51eC9tbWMvaG9zdC5oPgorI2luY2x1ZGUgPGxp
bnV4L21tYy9jYXJkLmg+CiAKICNpbmNsdWRlICJzZGhjaS5oIgogCkBAIC0xNjMxLDcgKzE2MzIs
NyBAQCBvdXQ6CiAKIGludCBzZGhjaV9zdXNwZW5kX2hvc3Qoc3RydWN0IHNkaGNpX2hvc3QgKmhv
c3QsIHBtX21lc3NhZ2VfdCBzdGF0ZSkKIHsKLQlpbnQgcmV0OworCWludCByZXQgPSAwOwogCiAJ
c2RoY2lfZGlzYWJsZV9jYXJkX2RldGVjdGlvbihob3N0KTsKIApAQCAtMTY0NCw2ICsxNjQ1LDE0
IEBAIGludCBzZGhjaV9zdXNwZW5kX2hvc3Qoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QsIHBtX21l
c3NhZ2VfdCBzdGF0ZSkKIAlpZiAoaG9zdC0+dm1tYykKIAkJcmV0ID0gcmVndWxhdG9yX2Rpc2Fi
bGUoaG9zdC0+dm1tYyk7CiAKKwlpZiAoaG9zdC0+bW1jLT5jYXJkICYmIGhvc3QtPm1tYy0+Y2Fy
ZC0+cGVuZGluZ19pbnRlcnJ1cHQpIHsKKwkJREJHKCIqKiogJXMgd2FrZSB1cCBldmVudCBhZnRl
ciBzdXNwZW5kLCByZXN1bWluZyB0byBoYW5kbGUgaXRcbiIsCisJCQltbWNfaG9zdG5hbWUoaG9z
dC0+bW1jKSk7CisJCWhvc3QtPm1tYy0+Y2FyZC0+cGVuZGluZ19pbnRlcnJ1cHQgPSAwOworCQlz
ZGhjaV9yZXN1bWVfaG9zdChob3N0KTsKKwkJcmV0ID0gLUVCVVNZOworCX0KKwogCXJldHVybiBy
ZXQ7CiB9CiAKQEAgLTE2NTksNiArMTY2OCw5IEBAIGludCBzZGhjaV9yZXN1bWVfaG9zdChzdHJ1
Y3Qgc2RoY2lfaG9zdCAqaG9zdCkKIAkJCXJldHVybiByZXQ7CiAJfQogCisJaWYgKGhvc3QtPm1t
Yy0+Y2FyZCAmJiBob3N0LT5tbWMtPmNhcmQtPnBlbmRpbmdfaW50ZXJydXB0KQorCQlob3N0LT5t
bWMtPmNhcmQtPnBlbmRpbmdfaW50ZXJydXB0ID0gMDsKKwogCiAJaWYgKGhvc3QtPmZsYWdzICYg
KFNESENJX1VTRV9TRE1BIHwgU0RIQ0lfVVNFX0FETUEpKSB7CiAJCWlmIChob3N0LT5vcHMtPmVu
YWJsZV9kbWEpCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tYy9jYXJkLmggYi9pbmNsdWRl
L2xpbnV4L21tYy9jYXJkLmgKaW5kZXggOGNlMDgyNy4uMjI1MmZlMiAxMDA2NDQKLS0tIGEvaW5j
bHVkZS9saW51eC9tbWMvY2FyZC5oCisrKyBiL2luY2x1ZGUvbGludXgvbW1jL2NhcmQuaApAQCAt
MTQ2LDYgKzE0Niw4IEBAIHN0cnVjdCBtbWNfY2FyZCB7CiAJc3RydWN0IHNkaW9fZnVuY190dXBs
ZQkqdHVwbGVzOwkvKiB1bmtub3duIGNvbW1vbiB0dXBsZXMgKi8KIAogCXN0cnVjdCBkZW50cnkJ
CSpkZWJ1Z2ZzX3Jvb3Q7CisJLyogZXh0ZXJuYWwgaW50ZXJydXB0IGFycml2ZWQgYWZ0ZXIgc2Rp
byBmdW5jdGlvbiBzdXNwZW5kZWQgKi8KKwl1MzIJCQlwZW5kaW5nX2ludGVycnVwdDsKIH07CiAK
ICNkZWZpbmUgbW1jX2NhcmRfbW1jKGMpCQkoKGMpLT50eXBlID09IE1NQ19UWVBFX01NQykKZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW1jL3NkaW9fZnVuYy5oIGIvaW5jbHVkZS9saW51eC9t
bWMvc2Rpb19mdW5jLmgKaW5kZXggMzFiYWFmOC4uNWMxYzQ2MiAxMDA2NDQKLS0tIGEvaW5jbHVk
ZS9saW51eC9tbWMvc2Rpb19mdW5jLmgKKysrIGIvaW5jbHVkZS9saW51eC9tbWMvc2Rpb19mdW5j
LmgKQEAgLTU5LDYgKzU5LDggQEAgc3RydWN0IHNkaW9fZnVuYyB7CiAJY29uc3QgY2hhcgkJKipp
bmZvOwkJLyogaW5mbyBzdHJpbmdzICovCiAKIAlzdHJ1Y3Qgc2Rpb19mdW5jX3R1cGxlICp0dXBs
ZXM7CisKKwlpbnQJCQlzdXNwZW5kZWQ7IC8qIFNESU8gZnVuY3Rpb24gZHJpdmVyIHN0YXRlICov
CiB9OwogCiAjZGVmaW5lIHNkaW9fZnVuY19wcmVzZW50KGYpCSgoZiktPnN0YXRlICYgU0RJT19T
VEFURV9QUkVTRU5UKQotLSAKMS43LjAuNAoK
--0022152d5fb54c5ec90494d3e99d--
