From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [patch 1/1] sdhci: support MMC_CAP_MMC_HIGHSPEED
Date: Mon, 16 Aug 2010 09:22:30 -0400
Message-ID: <AANLkTim8q285b==R7Q+QdqgJG5Q5D9yXpft7wZNA6Suw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016361e88027fb276048df0b9db
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40643 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788Ab0HPNWb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2010 09:22:31 -0400
Received: by gxk23 with SMTP id 23so1874574gxk.19
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2010 06:22:30 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Matt Fleming <matt@console-pimps.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

--0016361e88027fb276048df0b9db
Content-Type: text/plain; charset=ISO-8859-1

>From 165986b1ce3da7de57089ceb4547e84a5b530e64 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zgao6@marvell.com>
Date: Mon, 16 Aug 2010 21:15:32 -0400
Subject: [PATCH] sdhci: support MMC_CAP_MMC_HIGHSPEED


Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
---
 drivers/mmc/host/sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7855121..913555e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1823,7 +1823,7 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->caps |= MMC_CAP_4_BIT_DATA;

 	if (caps & SDHCI_CAN_DO_HISPD)
-		mmc->caps |= MMC_CAP_SD_HIGHSPEED;
+		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;

 	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
-- 
1.7.0.4

--0016361e88027fb276048df0b9db
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-sdhci-support-MMC_CAP_MMC_HIGHSPEED.patch"
Content-Disposition: attachment;
	filename="0001-sdhci-support-MMC_CAP_MMC_HIGHSPEED.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcy2if0i0

RnJvbSAxNjU5ODZiMWNlM2RhN2RlNTcwODljZWI0NTQ3ZTg0YTViNTMwZTY0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpnYW82QG1hcnZlbGwuY29tPgpEYXRl
OiBNb24sIDE2IEF1ZyAyMDEwIDIxOjE1OjMyIC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gc2RoY2k6
IHN1cHBvcnQgTU1DX0NBUF9NTUNfSElHSFNQRUVECgoKU2lnbmVkLW9mZi1ieTogWmhhbmdmZWkg
R2FvIDx6Z2FvNkBtYXJ2ZWxsLmNvbT4KLS0tCiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMgfCAg
ICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMgYi9kcml2ZXJzL21tYy9ob3N0
L3NkaGNpLmMKaW5kZXggNzg1NTEyMS4uOTEzNTU1ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMv
aG9zdC9zZGhjaS5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYwpAQCAtMTgyMyw3ICsx
ODIzLDcgQEAgaW50IHNkaGNpX2FkZF9ob3N0KHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KQogCQlt
bWMtPmNhcHMgfD0gTU1DX0NBUF80X0JJVF9EQVRBOwogCiAJaWYgKGNhcHMgJiBTREhDSV9DQU5f
RE9fSElTUEQpCi0JCW1tYy0+Y2FwcyB8PSBNTUNfQ0FQX1NEX0hJR0hTUEVFRDsKKwkJbW1jLT5j
YXBzIHw9IE1NQ19DQVBfU0RfSElHSFNQRUVEIHwgTU1DX0NBUF9NTUNfSElHSFNQRUVEOwogCiAJ
aWYgKGhvc3QtPnF1aXJrcyAmIFNESENJX1FVSVJLX0JST0tFTl9DQVJEX0RFVEVDVElPTikKIAkJ
bW1jLT5jYXBzIHw9IE1NQ19DQVBfTkVFRFNfUE9MTDsKLS0gCjEuNy4wLjQKCg==
--0016361e88027fb276048df0b9db--
