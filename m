Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD8DA59
	for <linux-mmc@vger.kernel.org>; Sat,  3 Jan 2026 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767472998; cv=none; b=DknP/Kze0Tc4l7LD3WpMmQ8rwdA88ZPGTVj2ZNVbjQXUce5DnoUI1ZJ3b//l/eP5zDqTw69seigMqSFbBBJD0hCpnOcojROXimwwgh81a5HMfHMSL/zOXf9LDgWBO/I1A6y0ChPjFybhnmLFQ26EcRUIs0vjJtmjnr62RuYfEDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767472998; c=relaxed/simple;
	bh=C6ZOWGhjLHBWNsEB+PRa4qKLbY4mQoJgPw6j/3YjgtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eNMko6JveHmjTWTmCl9FDCpyE5FH8l6OOAjYX4KOCrCtfYIAfyyULPEjX1JrGeY81kfeoDnUMgFZR/NsWco516IjCXt/3cxuJ+gauHnHUP0HqtxLbaHZI0zadTQQUSNFAY701uX3pQR8z/p0X6kZxqwuTh/xaEtU1I+U5LAPKH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T8sEh9re; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T8sEh9re"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767472993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jwoYd2vDow/47fJS8TtJp3L4zqIzHNMYsl09ujbOUAk=;
	b=T8sEh9recliIHTCtOn9fW2Q2cOagD+dmEfAgpXX7Sf+Dbe1OFyFMd8RZfVdR8PIZjA5d/+
	5vu4u/fmi3QBTgCv82wHwbQD9URH+2MYe1s55Y2ve75S55KVLh1dmGbHmZQBn+KXSW+SE/
	1vZIhZdFDcfPq6A4SQKLixlDkwJc594=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Ricky Wu <ricky_wu@realtek.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH] mmc: rtsx_pci: add quirk to disable MMC_CAP_AGGRESSIVE_PM for RTS525A
Date: Sat,  3 Jan 2026 12:42:26 -0800
Message-ID: <20260103204226.71752-1-matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Using MMC_CAP_AGGRESSIVE_PM on RTS525A card readers causes game
performance issues when the card reader comes back from idle into active
use. This can be observed in Hades II when loading new sections of the
game or menu after the card reader puts itself into idle, and presents
as a 1-2 second hang.

Add EXTRA_CAPS_NO_AGGRESSIVE_PM quirk to allow cardreader drivers to
opt-out of aggressive PM, and set it for RTS525A.

Closes: https://lore.kernel.org/linux-mmc/ff9a7c20-f465-4afa-bf29-708d4a52974a@linux.dev/
Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
---
 drivers/misc/cardreader/rts5249.c | 3 +++
 drivers/mmc/host/rtsx_pci_sdmmc.c | 4 ++--
 include/linux/rtsx_pci.h          | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index 38aefd8db452..87d576a03e68 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -78,6 +78,9 @@ static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
 	if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A))
 		pcr->rtd3_en = rtsx_reg_to_rtd3_uhsii(reg);
 
+	if (CHK_PCI_PID(pcr, PID_525A))
+		pcr->extra_caps |= EXTRA_CAPS_NO_AGGRESSIVE_PM;
+
 	if (rtsx_check_mmc_support(reg))
 		pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
 	pcr->sd30_drive_sel_3v3 = rtsx_reg_to_sd30_drive_sel_3v3(reg);
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index dc2587ff8519..5d3599ee06bf 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1456,8 +1456,8 @@ static void realtek_init_host(struct realtek_pci_sdmmc *host)
 	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
 		MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
 		MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
-	if (pcr->rtd3_en)
-		mmc->caps = mmc->caps | MMC_CAP_AGGRESSIVE_PM;
+	if (pcr->rtd3_en && !(pcr->extra_caps & EXTRA_CAPS_NO_AGGRESSIVE_PM))
+		mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
 	mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE |
 		MMC_CAP2_NO_SDIO;
 	mmc->max_current_330 = 400;
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index 3c5689356004..f6122349c00e 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -1230,6 +1230,7 @@ struct rtsx_pcr {
 #define EXTRA_CAPS_MMC_8BIT		(1 << 5)
 #define EXTRA_CAPS_NO_MMC		(1 << 7)
 #define EXTRA_CAPS_SD_EXPRESS		(1 << 8)
+#define EXTRA_CAPS_NO_AGGRESSIVE_PM	(1 << 9)
 	u32				extra_caps;
 
 #define IC_VER_A			0
-- 
2.52.0

