Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08F14F98;
	Fri,  6 Jun 2025 03:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749179159; cv=none; b=b7gWbjiupToae2BeBk29bouicQ7mHZw//wiZOeBvJL+M9TwtEIlip6uEBrpgucaFBqJYGMCpTBZ8CbwFi0ZDsomrEGKQ/O+3mrk1XlvcVF3FixO7Ej20X0FF4srtA5kpxYfTdryeg3ZNPHOl6dQehIQdPK+4SdQDs4m1m7jG+aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749179159; c=relaxed/simple;
	bh=KHGFMaZE4Rzua4WevqCtNsMm7jbCTpM8wx1yap/Lns0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hsomA+LDeS17ia04nB7haP69z1n04ZEox41oFTviws0fAPWfqhpzCgAhcYmkmA+wQd2IA8bVhttDlBBFxTh0bm0uhbbt9pZLY+ixkKHglfaO7u2b4fDAXXC2M80nqhpUEG8HtOfYTTOPZVOAsr4GbcMkwN9N3GXlWjew3nBgS8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=eGneFpvL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="eGneFpvL"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55635nMQ22715425, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749179149; bh=TSLyLk9wHkv/TXeJyn5hX7quEcNOqXLmOOcUYhqXfZE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=eGneFpvL25qxMWdXgEPwS/STWO4gq8MmabZVeiG6VnYcs5eXnGFBArfgTgqVVKzET
	 PJva3T2o05zsQ2YDLfWPFc21IDF4US6nnT/NvlxsL44KtNEqbfTwmmWr2Z8aBzddxH
	 HjvLVmR9EF0aJPhwVAa1qSJT05qKVM7jce6exCD59BGS8O+4hiOIKk5BAtqgfChhw2
	 PHcDJFg07wjEPqgDzE+y+vbInGwo5Amrk7rRZkZ1trgqrW0IUBbvvAofI6QmMefBUM
	 hO+ZhP93gKvkkE+DhkGnqYLXPiIctOSYHWobK+qt5fWo+5OV3YtG++afO1RSglmvRB
	 K1oxq5u9+vTFQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55635nMQ22715425
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Jun 2025 11:05:49 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Jun 2025 11:05:49 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 6 Jun 2025 11:05:48 +0800
Received: from localhost (172.22.144.1) by RTEXH36506.realtek.com.tw
 (172.21.6.27) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 6 Jun 2025 11:05:48 +0800
From: Ricky Wu <ricky_wu@realtek.com>
To: <linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <ricky_wu@realtek.com>
Subject: [PATCH v3] mmc: rtsx: usb add 74 clocks in poweron flow
Date: Fri, 6 Jun 2025 11:05:45 +0800
Message-ID: <20250606030545.1743961-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

SD spec definition:
"Host provides at least 74 Clocks before issuing first command"

add issue the clocks when power_mode is POWER_UP
and stop the signal when power_mode is POWER_up to POWER_ON

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
v2: remove delay 100ms in power_on
v3: Use switch-case instead of if statements
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 36 ++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index d229c2b83ea9..1c808cfb44ff 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1014,24 +1014,40 @@ static int sd_set_power_mode(struct rtsx_usb_sdmmc *host,
 		unsigned char power_mode)
 {
 	int err;
+	struct rtsx_ucr *ucr = host->ucr;
 
-	if (power_mode != MMC_POWER_OFF)
-		power_mode = MMC_POWER_ON;
-
-	if (power_mode == host->power_mode)
-		return 0;
-
-	if (power_mode == MMC_POWER_OFF) {
+	switch (power_mode) {
+	case MMC_POWER_OFF:
+		if (host->power_mode == MMC_POWER_OFF)
+			return 0;
 		err = sd_power_off(host);
 		pm_runtime_put_noidle(sdmmc_dev(host));
-	} else {
+		break;
+	case MMC_POWER_UP:
+	case MMC_POWER_ON:
+		if (host->power_mode == MMC_POWER_ON) {
+			return 0;
+		} else if (host->power_mode == MMC_POWER_UP) {
+			/* stop to send the clock signals */
+			rtsx_usb_write_register(ucr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, 0x00);
+			host->power_mode = power_mode;
+			return 0;
+		}
 		pm_runtime_get_noresume(sdmmc_dev(host));
 		err = sd_power_on(host);
+		break;
+	default:
+		return 0;
 	}
+	if (!err) {
+		if (power_mode == MMC_POWER_UP) {
+			/* issue the clock signals to card */
+			rtsx_usb_write_register(ucr, SD_BUS_STAT, SD_CLK_TOGGLE_EN,
+				SD_CLK_TOGGLE_EN);
+		}
 
-	if (!err)
 		host->power_mode = power_mode;
-
+	}
 	return err;
 }
 
-- 
2.25.1

