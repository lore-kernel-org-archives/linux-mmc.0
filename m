Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C0144C94;
	Mon, 21 Apr 2025 03:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745204422; cv=none; b=LR7knpmvtQSgpn3/ebH1x6eaynRkeptlt8wXBgWYvljVUwp17FOljafgcrL3dCBnAthVtEnMqVQ7ubXI+jqZ82zBp/kluFL2jwhTidYNUc1ywPEWz9LKgHXVCy9ErUNQ0EjZF6cTQziXMVg4Sp7982C2R2E9ijq25z6buWLQjIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745204422; c=relaxed/simple;
	bh=UuHrUYX1W7yHBu8AM642EYG+ilnGxuIr3kEp3UHs3YM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IAoljpYyv4D8aGrdGownenAL7jCrfO3G4Pu5F/WExQiUwKLp0iFwjMYEIhfFh/LE8AwyjghQAu0JZAM7WEyPqOR+R9xs2RyLCaW78GYq+CcMQxTQvGawZFab6Lwh3iJuklZsU9J5xvKkqku+lXCH6HyQqZ/PWmyi1nEaWgMfY8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ejRu1aiM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ejRu1aiM"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53L30B5L01389258, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745204411; bh=UuHrUYX1W7yHBu8AM642EYG+ilnGxuIr3kEp3UHs3YM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ejRu1aiMtaQF39hTO2tdO+XJz10w0s51UFIiz7ENTcBTmuR4ezGXBXF7yt9ApU4HY
	 6YwFCIcQ2HCU6uQKfCmUNTAXLivPskXE1V6yAO6tlSLvJ7JsuoV8Qua6AkBqEo/AZ1
	 W8xHFBaUTHHZ+/bX9d4fif8OqvfP2Wno1jQqElLm2Y4SuGbut0grXd3JXOOCvV/8EB
	 KTcf/zUgc96eJfaMOhe5HQiPLzE/Ht1ZhkhIiZThmo7rhc85TMECWrGzRVgYYkXmGN
	 I4bmaAx3TtrYNOgp3Pm3dEcIzFCFeEg9Uzlnv1bIGCd3BEIOYqz31tysOg5U1htV6S
	 FNJZp/Np2An/g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53L30B5L01389258
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 11:00:11 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Apr 2025 11:00:12 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 21 Apr 2025 11:00:11 +0800
Received: from localhost (172.22.144.1) by RTEXH36505.realtek.com.tw
 (172.21.6.25) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 21 Apr 2025 11:00:11 +0800
From: Ricky Wu <ricky_wu@realtek.com>
To: <linux-kernel@vger.kernel.org>, <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <ricky_wu@realtek.com>
Subject: [PATCH v2] mmc: rtsx: usb add 74 clocks in poweron flow
Date: Mon, 21 Apr 2025 11:00:08 +0800
Message-ID: <20250421030008.1172901-1-ricky_wu@realtek.com>
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

add if statement to issue/stop the clock signal to card:
The power state from POWER_OFF to POWER_UP issue the signal to card,
POWER_UP to POWER_ON stop the signal

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---

v2: remove delay 100ms in power_on
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index d229c2b83ea9..1edfe2acf809 100644
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
@@ -1014,6 +1014,16 @@ static int sd_set_power_mode(struct rtsx_usb_sdmmc *host,
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
@@ -1029,9 +1039,18 @@ static int sd_set_power_mode(struct rtsx_usb_sdmmc *host,
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
 
@@ -1316,6 +1335,7 @@ static void rtsx_usb_init_host(struct rtsx_usb_sdmmc *host)
 	mmc->max_req_size = 524288;
 
 	host->power_mode = MMC_POWER_OFF;
+	host->prev_power_mode = MMC_POWER_OFF;
 }
 
 static int rtsx_usb_sdmmc_drv_probe(struct platform_device *pdev)
-- 
2.25.1

