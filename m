From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [PATCH 1/1]sdhci-pxa: add MMC_CAP_NONREMOVABLE for on-chip device
Date: Wed, 27 Oct 2010 22:54:56 -0400
Message-ID: <AANLkTik+Kg+po=na4Vx6B+BmJMAN_-bq+cB3VrvDpB38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=485b393aaef38ffc500493a477b7
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34340 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932803Ab0J1Cy6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Oct 2010 22:54:58 -0400
Received: by fxm16 with SMTP id 16so1441305fxm.19
        for <linux-mmc@vger.kernel.org>; Wed, 27 Oct 2010 19:54:56 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Matt Fleming <matt@console-pimps.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>, Philip Rakity <prakity@marvell.com>

--485b393aaef38ffc500493a477b7
Content-Type: text/plain; charset=ISO-8859-1

>From 7f3529c21815990ebe4eec684e3c96156f774637 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Thu, 28 Oct 2010 10:44:15 -0400
Subject: [PATCH] sdhci-pxa: add MMC_CAP_NONREMOVABLE for on-chip device

        To share SDHCI_QUIRK_BROKEN_CARD_DETECTION for on-chip device,
MMC_CAP_NONREMOVABLE also needed, otherwise polling mode used by
default

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
CC: Philip Rakity <prakity@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |    2 ++
 drivers/mmc/host/sdhci-pxa.c           |    8 ++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
b/arch/arm/plat-pxa/include/plat/sdhci.h
index e49c5b6..fc5ceab 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -16,6 +16,8 @@
 /* pxa specific flag */
 /* Require clock free running */
 #define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
+/* card alwayes wired to host, like on-chip emmc */
+#define PXA_FLAG_CARD_PERMANENT	(1<<1)

 /*
  * struct pxa_sdhci_platdata() - Platform device data for PXA SDHCI
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index fc406ac..a88c797 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -138,6 +138,12 @@ static int __devinit sdhci_pxa_probe(struct
platform_device *pdev)
 	host->irq = irq;
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;

+	if (pxa->pdata->flags & PXA_FLAG_CARD_PERMANENT) {
+		/* on-chip device */
+		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+		host->mmc->caps = MMC_CAP_NONREMOVABLE;
+	}
+
 	if (pdata->quirks)
 		host->quirks |= pdata->quirks;

@@ -149,6 +155,8 @@ static int __devinit sdhci_pxa_probe(struct
platform_device *pdev)

 	if (pxa->pdata->max_speed)
 		host->mmc->f_max = pxa->pdata->max_speed;
+	else
+		host->mmc->f_max = 50000000;

 	platform_set_drvdata(pdev, host);

-- 
1.7.0.4

--485b393aaef38ffc500493a477b7
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-sdhci-pxa-add-MMC_CAP_NONREMOVABLE-for-on-chip-devic.patch"
Content-Disposition: attachment;
	filename="0001-sdhci-pxa-add-MMC_CAP_NONREMOVABLE-for-on-chip-devic.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gftr7shf1

RnJvbSA3ZjM1MjljMjE4MTU5OTBlYmU0ZWVjNjg0ZTNjOTYxNTZmNzc0NjM3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogVGh1LCAyOCBPY3QgMjAxMCAxMDo0NDoxNSAtMDQwMApTdWJqZWN0OiBbUEFUQ0hd
IHNkaGNpLXB4YTogYWRkIE1NQ19DQVBfTk9OUkVNT1ZBQkxFIGZvciBvbi1jaGlwIGRldmljZQoK
ICAgICAgICBUbyBzaGFyZSBTREhDSV9RVUlSS19CUk9LRU5fQ0FSRF9ERVRFQ1RJT04gZm9yIG9u
LWNoaXAgZGV2aWNlLCBNTUNfQ0FQX05PTlJFTU9WQUJMRSBhbHNvIG5lZWRlZCwgb3RoZXJ3aXNl
IHBvbGxpbmcgbW9kZSB1c2VkIGJ5IGRlZmF1bHQKClNpZ25lZC1vZmYtYnk6IFpoYW5nZmVpIEdh
byA8emhhbmdmZWkuZ2FvQG1hcnZlbGwuY29tPgpDQzogUGhpbGlwIFJha2l0eSA8cHJha2l0eUBt
YXJ2ZWxsLmNvbT4KLS0tCiBhcmNoL2FybS9wbGF0LXB4YS9pbmNsdWRlL3BsYXQvc2RoY2kuaCB8
ICAgIDIgKysKIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMgICAgICAgICAgIHwgICAgOCAr
KysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9zZGhjaS5oIGIv
YXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3NkaGNpLmgKaW5kZXggZTQ5YzViNi4uZmM1
Y2VhYiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3NkaGNpLmgK
KysrIGIvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3NkaGNpLmgKQEAgLTE2LDYgKzE2
LDggQEAKIC8qIHB4YSBzcGVjaWZpYyBmbGFnICovCiAvKiBSZXF1aXJlIGNsb2NrIGZyZWUgcnVu
bmluZyAqLwogI2RlZmluZSBQWEFfRkxBR19ESVNBQkxFX0NMT0NLX0dBVElORyAoMTw8MCkKKy8q
IGNhcmQgYWx3YXllcyB3aXJlZCB0byBob3N0LCBsaWtlIG9uLWNoaXAgZW1tYyAqLworI2RlZmlu
ZSBQWEFfRkxBR19DQVJEX1BFUk1BTkVOVAkoMTw8MSkKIAogLyoKICAqIHN0cnVjdCBweGFfc2Ro
Y2lfcGxhdGRhdGEoKSAtIFBsYXRmb3JtIGRldmljZSBkYXRhIGZvciBQWEEgU0RIQ0kKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMgYi9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLXB4YS5jCmluZGV4IGZjNDA2YWMuLmE4OGM3OTcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1j
L2hvc3Qvc2RoY2ktcHhhLmMKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYwpAQCAt
MTM4LDYgKzEzOCwxMiBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCBzZGhjaV9weGFfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAlob3N0LT5pcnEgPSBpcnE7CiAJaG9zdC0+cXVp
cmtzID0gU0RIQ0lfUVVJUktfQlJPS0VOX0FETUEgfCBTREhDSV9RVUlSS19CUk9LRU5fVElNRU9V
VF9WQUw7CiAKKwlpZiAocHhhLT5wZGF0YS0+ZmxhZ3MgJiBQWEFfRkxBR19DQVJEX1BFUk1BTkVO
VCkgeworCQkvKiBvbi1jaGlwIGRldmljZSAqLworCQlob3N0LT5xdWlya3MgfD0gU0RIQ0lfUVVJ
UktfQlJPS0VOX0NBUkRfREVURUNUSU9OOworCQlob3N0LT5tbWMtPmNhcHMgPSBNTUNfQ0FQX05P
TlJFTU9WQUJMRTsKKwl9CisKIAlpZiAocGRhdGEtPnF1aXJrcykKIAkJaG9zdC0+cXVpcmtzIHw9
IHBkYXRhLT5xdWlya3M7CiAKQEAgLTE0OSw2ICsxNTUsOCBAQCBzdGF0aWMgaW50IF9fZGV2aW5p
dCBzZGhjaV9weGFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAogCWlmIChw
eGEtPnBkYXRhLT5tYXhfc3BlZWQpCiAJCWhvc3QtPm1tYy0+Zl9tYXggPSBweGEtPnBkYXRhLT5t
YXhfc3BlZWQ7CisJZWxzZQorCQlob3N0LT5tbWMtPmZfbWF4ID0gNTAwMDAwMDA7CiAKIAlwbGF0
Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBob3N0KTsKIAotLSAKMS43LjAuNAoK
--485b393aaef38ffc500493a477b7--
