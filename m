From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 1/1]sdhci-pxa: add MMC_CAP_NONREMOVABLE for on-chip device
Date: Thu, 28 Oct 2010 02:00:10 -0400
Message-ID: <AANLkTim2rF=MfmU81=bBwdFu3QV2qehYmXfQDO8PZrqu@mail.gmail.com>
References: <AANLkTik+Kg+po=na4Vx6B+BmJMAN_-bq+cB3VrvDpB38@mail.gmail.com>
	<AANLkTim6_wuc+zSg7qKwGDAAiYfXTqjiMRJiffzNPvCY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf30433eec02113c0493a70e3a
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43986 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917Ab0J1GAM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Oct 2010 02:00:12 -0400
Received: by fxm16 with SMTP id 16so1581933fxm.19
        for <linux-mmc@vger.kernel.org>; Wed, 27 Oct 2010 23:00:10 -0700 (PDT)
In-Reply-To: <AANLkTim6_wuc+zSg7qKwGDAAiYfXTqjiMRJiffzNPvCY@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>, Philip Rakity <prakity@marvell.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Matt Fleming <matt@console-pimps.org>, eric.y.miao@gmail.com, Haojian Zhuang <haojian.zhuang@gmail.com>

--20cf30433eec02113c0493a70e3a
Content-Type: text/plain; charset=ISO-8859-1

Thanks for your suggestion, here is updated version.

>From 470140b629e3f044a0951368db8e3dc98ebd8ab3 Mon Sep 17 00:00:00 2001
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
 drivers/mmc/host/sdhci-pxa.c           |    6 ++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

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
index fc406ac..8455c46 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -138,6 +138,12 @@ static int __devinit sdhci_pxa_probe(struct
platform_device *pdev)
 	host->irq = irq;
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;

+	if (pxa->pdata->flags & PXA_FLAG_CARD_PERMANENT) {
+		/* on-chip device */
+		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
+	}
+
 	if (pdata->quirks)
 		host->quirks |= pdata->quirks;

-- 
1.7.0.4

--20cf30433eec02113c0493a70e3a
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-sdhci-pxa-add-MMC_CAP_NONREMOVABLE-for-on-chip-devic.patch"
Content-Disposition: attachment;
	filename="0001-sdhci-pxa-add-MMC_CAP_NONREMOVABLE-for-on-chip-devic.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gftxs8fy0

RnJvbSA0NzAxNDBiNjI5ZTNmMDQ0YTA5NTEzNjhkYjhlM2RjOThlYmQ4YWIzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogVGh1LCAyOCBPY3QgMjAxMCAxMDo0NDoxNSAtMDQwMApTdWJqZWN0OiBbUEFUQ0hd
IHNkaGNpLXB4YTogYWRkIE1NQ19DQVBfTk9OUkVNT1ZBQkxFIGZvciBvbi1jaGlwIGRldmljZQoK
ICAgICAgICBUbyBzaGFyZSBTREhDSV9RVUlSS19CUk9LRU5fQ0FSRF9ERVRFQ1RJT04gZm9yIG9u
LWNoaXAgZGV2aWNlLCBNTUNfQ0FQX05PTlJFTU9WQUJMRSBhbHNvIG5lZWRlZCwgb3RoZXJ3aXNl
IHBvbGxpbmcgbW9kZSB1c2VkIGJ5IGRlZmF1bHQKClNpZ25lZC1vZmYtYnk6IFpoYW5nZmVpIEdh
byA8emhhbmdmZWkuZ2FvQG1hcnZlbGwuY29tPgpDQzogUGhpbGlwIFJha2l0eSA8cHJha2l0eUBt
YXJ2ZWxsLmNvbT4KLS0tCiBhcmNoL2FybS9wbGF0LXB4YS9pbmNsdWRlL3BsYXQvc2RoY2kuaCB8
ICAgIDIgKysKIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMgICAgICAgICAgIHwgICAgNiAr
KysrKysKIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9zZGhjaS5oIGIvYXJj
aC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3NkaGNpLmgKaW5kZXggZTQ5YzViNi4uZmM1Y2Vh
YiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3NkaGNpLmgKKysr
IGIvYXJjaC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3NkaGNpLmgKQEAgLTE2LDYgKzE2LDgg
QEAKIC8qIHB4YSBzcGVjaWZpYyBmbGFnICovCiAvKiBSZXF1aXJlIGNsb2NrIGZyZWUgcnVubmlu
ZyAqLwogI2RlZmluZSBQWEFfRkxBR19ESVNBQkxFX0NMT0NLX0dBVElORyAoMTw8MCkKKy8qIGNh
cmQgYWx3YXllcyB3aXJlZCB0byBob3N0LCBsaWtlIG9uLWNoaXAgZW1tYyAqLworI2RlZmluZSBQ
WEFfRkxBR19DQVJEX1BFUk1BTkVOVAkoMTw8MSkKIAogLyoKICAqIHN0cnVjdCBweGFfc2RoY2lf
cGxhdGRhdGEoKSAtIFBsYXRmb3JtIGRldmljZSBkYXRhIGZvciBQWEEgU0RIQ0kKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcHhhLmMgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNp
LXB4YS5jCmluZGV4IGZjNDA2YWMuLjg0NTVjNDYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hv
c3Qvc2RoY2ktcHhhLmMKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYwpAQCAtMTM4
LDYgKzEzOCwxMiBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCBzZGhjaV9weGFfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAlob3N0LT5pcnEgPSBpcnE7CiAJaG9zdC0+cXVpcmtz
ID0gU0RIQ0lfUVVJUktfQlJPS0VOX0FETUEgfCBTREhDSV9RVUlSS19CUk9LRU5fVElNRU9VVF9W
QUw7CiAKKwlpZiAocHhhLT5wZGF0YS0+ZmxhZ3MgJiBQWEFfRkxBR19DQVJEX1BFUk1BTkVOVCkg
eworCQkvKiBvbi1jaGlwIGRldmljZSAqLworCQlob3N0LT5xdWlya3MgfD0gU0RIQ0lfUVVJUktf
QlJPS0VOX0NBUkRfREVURUNUSU9OOworCQlob3N0LT5tbWMtPmNhcHMgfD0gTU1DX0NBUF9OT05S
RU1PVkFCTEU7CisJfQorCiAJaWYgKHBkYXRhLT5xdWlya3MpCiAJCWhvc3QtPnF1aXJrcyB8PSBw
ZGF0YS0+cXVpcmtzOwogCi0tIAoxLjcuMC40Cgo=
--20cf30433eec02113c0493a70e3a--
