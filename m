From: Will Newton <will.newton@gmail.com>
Subject: [PATCH 2/2] dw_mmc: Enable low-power mode for the card clock.
Date: Fri, 4 Feb 2011 11:17:59 +0000
Message-ID: <AANLkTim4XwhXsBA78WD_0Gsu0=Y4QE6fjGWJdO9D3R5X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636c5bf46e8d915049b7308c0
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60945 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab1BDLSA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Feb 2011 06:18:00 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so2595721bwz.19
        for <linux-mmc@vger.kernel.org>; Fri, 04 Feb 2011 03:18:00 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

--001636c5bf46e8d915049b7308c0
Content-Type: text/plain; charset=ISO-8859-1

Setting this bit in the clock enable register will stop the clock
when the card is in the IDLE state.

Signed-off-by: Will Newton <will.newton@imgtec.com>
---
 drivers/mmc/host/dw_mmc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0b0bedd..4cf560d 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -562,7 +562,8 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot)
 			     SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);

 		/* enable clock */
-		mci_writel(host, CLKENA, SDMMC_CLKEN_ENABLE);
+		mci_writel(host, CLKENA, SDMMC_CLKEN_ENABLE |
+			   SDMMC_CLKEN_LOW_PWR);

 		/* inform CIU */
 		mci_send_cmd(slot,
-- 
1.7.3.4

--001636c5bf46e8d915049b7308c0
Content-Type: text/x-patch; charset=US-ASCII;
	name="0002-dw_mmc-Enable-low-power-mode-for-the-card-clock.patch"
Content-Disposition: attachment;
	filename="0002-dw_mmc-Enable-low-power-mode-for-the-card-clock.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gjr022e40

RnJvbSBhZjU0ZTM5OTkyYTIzYTViNmI2Yzg1M2ZlZGU2NTJiMWRmM2JlMzdmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXaWxsIE5ld3RvbiA8d2lsbC5uZXd0b25AaW1ndGVjLmNvbT4K
RGF0ZTogVGh1LCAzIEZlYiAyMDExIDEyOjE4OjQ0ICswMDAwClN1YmplY3Q6IFtQQVRDSCAyLzJd
IGR3X21tYzogRW5hYmxlIGxvdy1wb3dlciBtb2RlIGZvciB0aGUgY2FyZCBjbG9jay4KClNldHRp
bmcgdGhpcyBiaXQgaW4gdGhlIGNsb2NrIGVuYWJsZSByZWdpc3RlciB3aWxsIHN0b3AgdGhlIGNs
b2NrCndoZW4gdGhlIGNhcmQgaXMgaW4gdGhlIElETEUgc3RhdGUuCgpTaWduZWQtb2ZmLWJ5OiBX
aWxsIE5ld3RvbiA8d2lsbC5uZXd0b25AaW1ndGVjLmNvbT4KLS0tCiBkcml2ZXJzL21tYy9ob3N0
L2R3X21tYy5jIHwgICAgMyArKy0KIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvZHdfbW1jLmMgYi9k
cml2ZXJzL21tYy9ob3N0L2R3X21tYy5jCmluZGV4IDBiMGJlZGQuLjRjZjU2MGQgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvbW1jL2hvc3QvZHdfbW1jLmMKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9kd19t
bWMuYwpAQCAtNTYyLDcgKzU2Miw4IEBAIHN0YXRpYyB2b2lkIGR3X21jaV9zZXR1cF9idXMoc3Ry
dWN0IGR3X21jaV9zbG90ICpzbG90KQogCQkJICAgICBTRE1NQ19DTURfVVBEX0NMSyB8IFNETU1D
X0NNRF9QUlZfREFUX1dBSVQsIDApOwogCiAJCS8qIGVuYWJsZSBjbG9jayAqLwotCQltY2lfd3Jp
dGVsKGhvc3QsIENMS0VOQSwgU0RNTUNfQ0xLRU5fRU5BQkxFKTsKKwkJbWNpX3dyaXRlbChob3N0
LCBDTEtFTkEsIFNETU1DX0NMS0VOX0VOQUJMRSB8CisJCQkgICBTRE1NQ19DTEtFTl9MT1dfUFdS
KTsKIAogCQkvKiBpbmZvcm0gQ0lVICovCiAJCW1jaV9zZW5kX2NtZChzbG90LAotLSAKMS43LjMu
NAoK
--001636c5bf46e8d915049b7308c0--
