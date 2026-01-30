Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6DB33F397;
	Fri, 30 Jan 2026 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769742367; cv=none; b=aTKPGFeRA1W6JRt/ZM/ujap9lI5VOi1OJjfu4n/eKK9HfjIzr2M5ZD1KO3ZQFcjZt/MOAoRFtlgeQlTYiMvjxBjgF3ccOixBpSyiMEuoJ5VCiXwkrx1XT8afVqVb7bp0gYo29exmy41RdzMSWdxo6ra+HvaVQn/XJ0gz48SVwoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769742367; c=relaxed/simple;
	bh=Az0h0hm7AxpqouPkmXCCFmxS55kAulLVtXsxEq7dsuA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WClD3H+5y+ot/CiQSGfD095mIZeatL6CrUJPcSajB8sIHHZxn0axB+eU/Gj+4/Fbp7U9B8M2LsPGz/qwzo1ebBmVRKQkwOiU9Qiyxc9+1k3zthlFMyT6Aw1MVJieOTI3zpwxi37rAkOi6V2I96pFDT3v1/DNy96q11pNLHjkPdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=BredjQhL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="BredjQhL"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60U35LXN0142063, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1769742321; bh=Q0n46PWNmJTbZ9JI/m6WF3sIGfFzgkWN5MRCNLDIg6k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=BredjQhL5Kr5/4qeFypscDTbRHT+mPOR0JDWVtmCjyXwszOP4KEGr+X9PtkO7tuTH
	 SXJSeDL06rcpaWh1toJ7VzblTyJib1cvpqzKPvWSZwmss7p/wkAKC1F0oMDv1gG2vM
	 Cizz3CvDunxtkxGkfts+jEIJJhVTZOeDG+ypa/mjEYvjQys8IWWUKfk6v3DH0pWhPI
	 O8Z1Ss3nhDWFxSZFtvYdQcYD5+MoMYAIlqIN2nks+CZYj1zW2+lEyGFmDKKMR679It
	 iicWhhhLUnkovHDPnccXMI7wpsXguRQ8tg9J1wL9thbdxj/ypESOAliPo/0znuqItk
	 DXIFxFcgtjqxA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60U35LXN0142063
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 11:05:21 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 30 Jan 2026 11:05:20 +0800
Received: from localhost (172.22.144.1) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 30 Jan 2026 11:05:20 +0800
From: <ricky_wu@realtek.com>
To: <ricky_wu@realtek.com>, <ulf.hansson@linaro.org>,
        <matthew.schwartz@linux.dev>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: rtsx_pci_sdmmc: simplify voltage switch handling after card_busy()
Date: Fri, 30 Jan 2026 11:05:01 +0800
Message-ID: <20260130030501.373630-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ricky Wu <ricky_wu@realtek.com>

Now that the Realtek PCIe SDMMC host implements the card_busy() callback,
the MMC core performs the required DAT[3:0] validation during the signal
voltage switch sequence.

As a result, the driver-side voltage stabilization helpers
sd_wait_voltage_stable_1() and sd_wait_voltage_stable_2() become redundant.
These helpers duplicate DAT line checks that are now handled centrally by
the MMC core via card_busy().

Remove the two stabilization helpers and simplify sdmmc_switch_voltage()
accordingly, keeping only the minimal clock control needed around the
voltage switch.

No functional changes and intended.

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 88 +++----------------------------
 1 file changed, 6 insertions(+), 82 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 4db3328f46df..8dfbc62f165b 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1181,79 +1181,6 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
 	return cd;
 }
 
-static int sd_wait_voltage_stable_1(struct realtek_pci_sdmmc *host)
-{
-	struct rtsx_pcr *pcr = host->pcr;
-	int err;
-	u8 stat;
-
-	/* Reference to Signal Voltage Switch Sequence in SD spec.
-	 * Wait for a period of time so that the card can drive SD_CMD and
-	 * SD_DAT[3:0] to low after sending back CMD11 response.
-	 */
-	mdelay(1);
-
-	/* SD_CMD, SD_DAT[3:0] should be driven to low by card;
-	 * If either one of SD_CMD,SD_DAT[3:0] is not low,
-	 * abort the voltage switch sequence;
-	 */
-	err = rtsx_pci_read_register(pcr, SD_BUS_STAT, &stat);
-	if (err < 0)
-		return err;
-
-	if (stat & (SD_CMD_STATUS | SD_DAT3_STATUS | SD_DAT2_STATUS |
-				SD_DAT1_STATUS | SD_DAT0_STATUS))
-		return -EINVAL;
-
-	/* Stop toggle SD clock */
-	err = rtsx_pci_write_register(pcr, SD_BUS_STAT,
-			0xFF, SD_CLK_FORCE_STOP);
-	if (err < 0)
-		return err;
-
-	return 0;
-}
-
-static int sd_wait_voltage_stable_2(struct realtek_pci_sdmmc *host)
-{
-	struct rtsx_pcr *pcr = host->pcr;
-	int err;
-	u8 stat, mask, val;
-
-	/* Wait 1.8V output of voltage regulator in card stable */
-	msleep(50);
-
-	/* Toggle SD clock again */
-	err = rtsx_pci_write_register(pcr, SD_BUS_STAT, 0xFF, SD_CLK_TOGGLE_EN);
-	if (err < 0)
-		return err;
-
-	/* Wait for a period of time so that the card can drive
-	 * SD_DAT[3:0] to high at 1.8V
-	 */
-	msleep(20);
-
-	/* SD_CMD, SD_DAT[3:0] should be pulled high by host */
-	err = rtsx_pci_read_register(pcr, SD_BUS_STAT, &stat);
-	if (err < 0)
-		return err;
-
-	mask = SD_CMD_STATUS | SD_DAT3_STATUS | SD_DAT2_STATUS |
-		SD_DAT1_STATUS | SD_DAT0_STATUS;
-	val = SD_CMD_STATUS | SD_DAT3_STATUS | SD_DAT2_STATUS |
-		SD_DAT1_STATUS | SD_DAT0_STATUS;
-	if ((stat & mask) != val) {
-		dev_dbg(sdmmc_dev(host),
-			"%s: SD_BUS_STAT = 0x%x\n", __func__, stat);
-		rtsx_pci_write_register(pcr, SD_BUS_STAT,
-				SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
-		rtsx_pci_write_register(pcr, CARD_CLK_EN, 0xFF, 0);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int sdmmc_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
@@ -1281,7 +1208,9 @@ static int sdmmc_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 		voltage = OUTPUT_1V8;
 
 	if (voltage == OUTPUT_1V8) {
-		err = sd_wait_voltage_stable_1(host);
+		/* Stop toggle SD clock */
+		err = rtsx_pci_write_register(pcr, SD_BUS_STAT,
+				0xFF, SD_CLK_FORCE_STOP);
 		if (err < 0)
 			goto out;
 	}
@@ -1290,16 +1219,11 @@ static int sdmmc_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (err < 0)
 		goto out;
 
-	if (voltage == OUTPUT_1V8) {
-		err = sd_wait_voltage_stable_2(host);
-		if (err < 0)
-			goto out;
-	}
-
 out:
 	/* Stop toggle SD clock in idle */
-	err = rtsx_pci_write_register(pcr, SD_BUS_STAT,
-			SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
+	if (err < 0)
+		rtsx_pci_write_register(pcr, SD_BUS_STAT,
+				SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
 
 	mutex_unlock(&pcr->pcr_mutex);
 
-- 
2.25.1

