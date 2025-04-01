Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BAA59B71;
	Tue,  1 Apr 2025 02:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743475896; cv=none; b=iS/6XpvdKD+xuNOGvuRRQGcwpWlroNv5WH5/bZFuSj840+UozC8p5ZpGQVj007dzWIokgIRhUbraMvVXiwYbmCKTl7CdZtkxz0qfAi4r3zoG24Ud9bCyE3uYLMhPXtv3Gsseyz/8BtlMSYYjQbwty98hjL2qM0HM4SCRZWqNzZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743475896; c=relaxed/simple;
	bh=xwD9fXC742YoiMkB28g64Ee+KLt7yC3cgvk3V2DweOM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XJUVMe6B8hjXMbaqF3wGEV31XMrS0jrc0Nad060HiNniNPUeNj4lDi21aX+Z6rmEgYx4FQeQ7sSr8fPFxeM8mQl8BZ983P96gpGwuUHqzrcnsTmDS+QfnwbKZ1OIr2x0Dc3OoqtMNeZkICS7r04rUbqAsOu+RXSWiTnFPR5FVBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=rqKtic+3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="rqKtic+3"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5312pQhB5799497, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1743475886; bh=xwD9fXC742YoiMkB28g64Ee+KLt7yC3cgvk3V2DweOM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=rqKtic+3He4u22CFp4S85LbMHWw6GXR/LH3ZWbPtl12+keZcdYKU/1HeVb5PsNNTk
	 7b3BQr/FqhxSNeyjxmlm3XF/nntMWEHYSJc7IxyslxB6sXSuCwep9YkYk9xTDxuil0
	 Bgkctmx8PQ4mA8ptr7lsNtfz3+NbeM5rB7nvrPDtz4uQ1qLF5/0Ui8LHkbRYf1p24O
	 lAbjRfiFzh96T5aMzVkBAkS30BUHfrtTm3EMvttWqZAWkxmj4S42rG8RvhY52a2cXc
	 0b8wEsNw6IeuBSVhhvFqDIYYmZiQq5j23hpYADZy2FpDPo9oC5WC2wXc2giDlCOpBD
	 9+KKwQ/3oCtNA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5312pQhB5799497
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Apr 2025 10:51:26 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Apr 2025 10:51:26 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 1 Apr 2025 10:51:26 +0800
Received: from localhost (172.22.144.1) by RTEXH36506.realtek.com.tw
 (172.21.6.27) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 1 Apr 2025 10:51:26 +0800
From: Ricky Wu <ricky_wu@realtek.com>
To: <linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <ricky_wu@realtek.com>
Subject: [PATCH] mmc: rtsx: usb add 74 clocks in poweron flow
Date: Tue, 1 Apr 2025 10:51:23 +0800
Message-ID: <20250401025123.895307-1-ricky_wu@realtek.com>
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
After 1ms for the voltage stable then start issuing the Clock signals

add if statement to issue/stop the clock signal to card:
The power state from POWER_OFF to POWER_UP issue the signal to card,
POWER_UP to POWER_ON stop the signal

add 100ms delay in power_on to make sure the power cycle complete

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index d229c2b83ea9..e5820b2bb380 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -48,7 +48,7 @@ struct rtsx_usb_sdmmc {
 	bool			ddr_mode;
 
 	unsigned char		power_mode;
-
+	unsigned char		prev_power_mode;
 #ifdef RTSX_USB_USE_LEDS_CLASS
 	struct led_classdev	led;
 	char			led_name[32];
@@ -952,6 +952,8 @@ static int sd_power_on(struct rtsx_usb_sdmmc *host)
 	struct rtsx_ucr *ucr = host->ucr;
 	int err;
 
+	msleep(100);
+
 	dev_dbg(sdmmc_dev(host), "%s\n", __func__);
 	rtsx_usb_init_cmd(ucr);
 	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_SELECT, 0x07, SD_MOD_SEL);
@@ -1014,6 +1016,16 @@ static int sd_set_power_mode(struct rtsx_usb_sdmmc *host,
 		unsigned char power_mode)
 {
 	int err;
+	int power_mode_temp;
+	struct rtsx_ucr *ucr = host->ucr;
+
+	power_mode_temp = power_mode;
+
+	if ((power_mode == MMC_POWER_ON) && (host->power_mode == MMC_POWER_ON) &&
+			(host->prev_power_mode == MMC_POWER_UP)) {
+		host->prev_power_mode = MMC_POWER_ON;
+		rtsx_usb_write_register(ucr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, 0x00);
+	}
 
 	if (power_mode != MMC_POWER_OFF)
 		power_mode = MMC_POWER_ON;
@@ -1029,9 +1041,18 @@ static int sd_set_power_mode(struct rtsx_usb_sdmmc *host,
 		err = sd_power_on(host);
 	}
 
-	if (!err)
-		host->power_mode = power_mode;
+	if (!err) {
+		if ((power_mode_temp == MMC_POWER_UP) && (host->power_mode == MMC_POWER_OFF)) {
+			host->prev_power_mode = MMC_POWER_UP;
+			rtsx_usb_write_register(ucr, SD_BUS_STAT, SD_CLK_TOGGLE_EN,
+					SD_CLK_TOGGLE_EN);
+		}
+
+		if ((power_mode_temp == MMC_POWER_OFF) && (host->power_mode == MMC_POWER_ON))
+			host->prev_power_mode = MMC_POWER_OFF;
 
+		host->power_mode = power_mode;
+	}
 	return err;
 }
 
@@ -1316,6 +1337,7 @@ static void rtsx_usb_init_host(struct rtsx_usb_sdmmc *host)
 	mmc->max_req_size = 524288;
 
 	host->power_mode = MMC_POWER_OFF;
+	host->prev_power_mode = MMC_POWER_OFF;
 }
 
 static int rtsx_usb_sdmmc_drv_probe(struct platform_device *pdev)
-- 
2.25.1

