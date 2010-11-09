From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [patch] sdhci: remove SDHCI_QUIRK_FORCE_1_BIT_DATA
Date: Tue, 9 Nov 2010 06:37:58 -0500
Message-ID: <AANLkTimBGorfWHVCnVtUWx6n-22anXmQnKFXVGzB6TUf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf30433f7a233f5c04949d2c1e
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46805 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203Ab0KILh7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2010 06:37:59 -0500
Received: by fxm16 with SMTP id 16so4839236fxm.19
        for <linux-mmc@vger.kernel.org>; Tue, 09 Nov 2010 03:37:58 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Xiaobo Xie <X.Xie@freescale.com>, Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kmpark@infradead.org>, Philip Rakity <prakity@marvell.com>

--20cf30433f7a233f5c04949d2c1e
Content-Type: text/plain; charset=ISO-8859-1

Hi, Xiaobo & Anton

Here is patch to remove SDHCI_QUIRK_FORCE_1_BIT_DATA, which only used
in drivers/mmc/host/sdhci-of-core.c.
The reason is quirk is too valuable resource, the type is u32, while
the highest is (1<<29) now.

1. MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA  is opened by default in sdhci.c
2. platform driver could close such flag after sdhci_add_host.

We have verified on our platform, would you mind check whether it
impact your driver behavior.

>From a5460d2fe6294287c4e86cedde5ac0f47b6b0368 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Tue, 9 Nov 2010 07:17:32 -0500
Subject: [PATCH] sdhci: remove SDHCI_QUIRK_FORCE_1_BIT_DATA

	SDHCI_QUIRK_FORCE_1_BIT_DATA only used for modify caps, which could
be updated after sdhci_add_host

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/host/sdhci-of-core.c |    7 +++----
 drivers/mmc/host/sdhci.c         |    3 +--
 include/linux/mmc/sdhci.h        |    2 --
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhci-of-core.c
index c51b711..620d5bf 100644
--- a/drivers/mmc/host/sdhci-of-core.c
+++ b/drivers/mmc/host/sdhci-of-core.c
@@ -157,10 +157,6 @@ static int __devinit sdhci_of_probe(struct
platform_device *ofdev,
 	if (of_get_property(np, "sdhci,auto-cmd12", NULL))
 		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;

-
-	if (of_get_property(np, "sdhci,1-bit-only", NULL))
-		host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
-
 	if (sdhci_of_wp_inverted(np))
 		host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;

@@ -172,6 +168,9 @@ static int __devinit sdhci_of_probe(struct
platform_device *ofdev,
 	if (ret)
 		goto err_add_host;

+	if (of_get_property(np, "sdhci,1-bit-only", NULL))
+		host->mmc->caps &= ~(MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA);
+
 	return 0;

 err_add_host:
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 154cbf8..8114bd3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1858,8 +1858,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	mmc->f_max = host->max_clk;
 	mmc->caps |= MMC_CAP_SDIO_IRQ;

-	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
-		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
+	mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;

 	if (caps & SDHCI_CAN_DO_HISPD)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 1fdc673..ede02a4 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -67,8 +67,6 @@ struct sdhci_host {
 #define SDHCI_QUIRK_FORCE_BLK_SZ_2048			(1<<20)
 /* Controller cannot do multi-block transfers */
 #define SDHCI_QUIRK_NO_MULTIBLOCK			(1<<21)
-/* Controller can only handle 1-bit data transfers */
-#define SDHCI_QUIRK_FORCE_1_BIT_DATA			(1<<22)
 /* Controller needs 10ms delay between applying power and clock */
 #define SDHCI_QUIRK_DELAY_AFTER_POWER			(1<<23)
 /* Controller uses SDCLK instead of TMCLK for data timeouts */
-- 
1.7.0.4

--20cf30433f7a233f5c04949d2c1e
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-sdhci-remove-SDHCI_QUIRK_FORCE_1_BIT_DATA.patch"
Content-Disposition: attachment;
	filename="0001-sdhci-remove-SDHCI_QUIRK_FORCE_1_BIT_DATA.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ggarl9kt1

RnJvbSBhNTQ2MGQyZmU2Mjk0Mjg3YzRlODZjZWRkZTVhYzBmNDdiNmIwMzY4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogVHVlLCA5IE5vdiAyMDEwIDA3OjE3OjMyIC0wNTAwClN1YmplY3Q6IFtQQVRDSF0g
c2RoY2k6IHJlbW92ZSBTREhDSV9RVUlSS19GT1JDRV8xX0JJVF9EQVRBCgoJU0RIQ0lfUVVJUktf
Rk9SQ0VfMV9CSVRfREFUQSBvbmx5IHVzZWQgZm9yIG1vZGlmeSBjYXBzLCB3aGljaCBjb3VsZCBi
ZSB1cGRhdGVkIGFmdGVyIHNkaGNpX2FkZF9ob3N0CgpTaWduZWQtb2ZmLWJ5OiBaaGFuZ2ZlaSBH
YW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNvbT4KLS0tCiBkcml2ZXJzL21tYy9ob3N0L3NkaGNp
LW9mLWNvcmUuYyB8ICAgIDcgKysrLS0tLQogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jICAgICAg
ICAgfCAgICAzICstLQogaW5jbHVkZS9saW51eC9tbWMvc2RoY2kuaCAgICAgICAgfCAgICAyIC0t
CiAzIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWNvcmUuYyBiL2RyaXZlcnMvbW1jL2hv
c3Qvc2RoY2ktb2YtY29yZS5jCmluZGV4IGM1MWI3MTEuLjYyMGQ1YmYgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtY29yZS5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2ktb2YtY29yZS5jCkBAIC0xNTcsMTAgKzE1Nyw2IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IHNk
aGNpX29mX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKm9mZGV2LAogCWlmIChvZl9nZXRf
cHJvcGVydHkobnAsICJzZGhjaSxhdXRvLWNtZDEyIiwgTlVMTCkpCiAJCWhvc3QtPnF1aXJrcyB8
PSBTREhDSV9RVUlSS19NVUxUSUJMT0NLX1JFQURfQUNNRDEyOwogCi0KLQlpZiAob2ZfZ2V0X3By
b3BlcnR5KG5wLCAic2RoY2ksMS1iaXQtb25seSIsIE5VTEwpKQotCQlob3N0LT5xdWlya3MgfD0g
U0RIQ0lfUVVJUktfRk9SQ0VfMV9CSVRfREFUQTsKLQogCWlmIChzZGhjaV9vZl93cF9pbnZlcnRl
ZChucCkpCiAJCWhvc3QtPnF1aXJrcyB8PSBTREhDSV9RVUlSS19JTlZFUlRFRF9XUklURV9QUk9U
RUNUOwogCkBAIC0xNzIsNiArMTY4LDkgQEAgc3RhdGljIGludCBfX2RldmluaXQgc2RoY2lfb2Zf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqb2ZkZXYsCiAJaWYgKHJldCkKIAkJZ290byBl
cnJfYWRkX2hvc3Q7CiAKKwlpZiAob2ZfZ2V0X3Byb3BlcnR5KG5wLCAic2RoY2ksMS1iaXQtb25s
eSIsIE5VTEwpKQorCQlob3N0LT5tbWMtPmNhcHMgJj0gfihNTUNfQ0FQXzRfQklUX0RBVEEgfCBN
TUNfQ0FQXzhfQklUX0RBVEEpOworCiAJcmV0dXJuIDA7CiAKIGVycl9hZGRfaG9zdDoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ku
YwppbmRleCAxNTRjYmY4Li44MTE0YmQzIDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9ob3N0L3Nk
aGNpLmMKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jCkBAIC0xODU4LDggKzE4NTgsNyBA
QCBpbnQgc2RoY2lfYWRkX2hvc3Qoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpCiAJbW1jLT5mX21h
eCA9IGhvc3QtPm1heF9jbGs7CiAJbW1jLT5jYXBzIHw9IE1NQ19DQVBfU0RJT19JUlE7CiAKLQlp
ZiAoIShob3N0LT5xdWlya3MgJiBTREhDSV9RVUlSS19GT1JDRV8xX0JJVF9EQVRBKSkKLQkJbW1j
LT5jYXBzIHw9IE1NQ19DQVBfNF9CSVRfREFUQSB8IE1NQ19DQVBfOF9CSVRfREFUQTsKKwltbWMt
PmNhcHMgfD0gTU1DX0NBUF80X0JJVF9EQVRBIHwgTU1DX0NBUF84X0JJVF9EQVRBOwogCiAJaWYg
KGNhcHMgJiBTREhDSV9DQU5fRE9fSElTUEQpCiAJCW1tYy0+Y2FwcyB8PSBNTUNfQ0FQX1NEX0hJ
R0hTUEVFRCB8IE1NQ19DQVBfTU1DX0hJR0hTUEVFRDsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvbW1jL3NkaGNpLmggYi9pbmNsdWRlL2xpbnV4L21tYy9zZGhjaS5oCmluZGV4IDFmZGM2NzMu
LmVkZTAyYTQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvbW1jL3NkaGNpLmgKKysrIGIvaW5j
bHVkZS9saW51eC9tbWMvc2RoY2kuaApAQCAtNjcsOCArNjcsNiBAQCBzdHJ1Y3Qgc2RoY2lfaG9z
dCB7CiAjZGVmaW5lIFNESENJX1FVSVJLX0ZPUkNFX0JMS19TWl8yMDQ4CQkJKDE8PDIwKQogLyog
Q29udHJvbGxlciBjYW5ub3QgZG8gbXVsdGktYmxvY2sgdHJhbnNmZXJzICovCiAjZGVmaW5lIFNE
SENJX1FVSVJLX05PX01VTFRJQkxPQ0sJCQkoMTw8MjEpCi0vKiBDb250cm9sbGVyIGNhbiBvbmx5
IGhhbmRsZSAxLWJpdCBkYXRhIHRyYW5zZmVycyAqLwotI2RlZmluZSBTREhDSV9RVUlSS19GT1JD
RV8xX0JJVF9EQVRBCQkJKDE8PDIyKQogLyogQ29udHJvbGxlciBuZWVkcyAxMG1zIGRlbGF5IGJl
dHdlZW4gYXBwbHlpbmcgcG93ZXIgYW5kIGNsb2NrICovCiAjZGVmaW5lIFNESENJX1FVSVJLX0RF
TEFZX0FGVEVSX1BPV0VSCQkJKDE8PDIzKQogLyogQ29udHJvbGxlciB1c2VzIFNEQ0xLIGluc3Rl
YWQgb2YgVE1DTEsgZm9yIGRhdGEgdGltZW91dHMgKi8KLS0gCjEuNy4wLjQKCg==
--20cf30433f7a233f5c04949d2c1e--
