Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCEE19D093;
	Tue,  5 Aug 2025 03:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754364202; cv=none; b=QZOn8Df7uL6a+ukC0RKkHG3lnpVKa9kqbqm6ccjBRFwpNEDBFxlZPsczje07Puz0e5IegyOrzYfzXluf93YQy38byNY9ygIpaNHiHTGNrRSgzQ+/li6N9oncvLIgw//0NRJZf20VYY+nAPj76uhsvmhMxVtg2UG0RBsoUlc3EG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754364202; c=relaxed/simple;
	bh=vT9AQs1JvRF7Eh3W0MiofWlA7/STiws+EgyOFyrS1GQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WMLCa2OJCUmWdViG4c2RiS84jRYQe3qpBJpMVlo8lD0mxrFaTUsP3AW0mPkn1iNn1s/o6GiMpW+a3JseVk7lIN+fT57bMcauTZrL0axwPRlpjV7waXxy7i1dLDw1deuE+li7CJJQeNJrJWaGDn3PKWH48iMuYXqBHg6Mjw87EjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IIW4VlXB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IIW4VlXB"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5753Mh5qA1454643, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754364164; bh=yAOu5JL5wnfykAuhT113dv3FxNzRgEe8JxQ2jg7LQEQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=IIW4VlXBPT6PgOWQjtdVieP2UzQHyAOXxuCoi6GvXrEYy1M8gCaCIyaZzZb5LY97H
	 V1TfoL7VtqGY4JfHDu9q3LjrRhyPoRiA6SQsGc5v/HuQMN6EOuWUaVhSqRoXEtlxam
	 vo9dempnh6GWato70alitRllpN6+vR+nDPLATKyTJZZ2MkTicDE5t1kk539NkbpEV8
	 jHgef1gLLyJbnE5H5e4YqZncBwXn4eU9WN+vMfkqB9cRVes+iUKYKqFFpopZZtPbjb
	 HzAvnqbuIIXnHdJPJFKC+xpEvze0EjWfDPh2wr8RoV+RsrHbtDDQFWJj1eRiwVuPcT
	 rkUNjjOthKrgw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5753Mh5qA1454643
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 11:22:43 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 5 Aug 2025 11:22:44 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Aug 2025 11:22:43 +0800
Received: from localhost (172.22.144.1) by RTEXH36506.realtek.com.tw
 (172.21.6.27) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 5 Aug 2025 11:22:43 +0800
From: Ricky Wu <ricky_wu@realtek.com>
To: <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <chenhuacai@kernel.org>,
        <ricky_wu@realtek.com>, <ulf.hansson@linaro.org>,
        <maximlevitsky@gmail.com>
Subject: [PATCH] misc: rtsx: usb card reader: add OCP support
Date: Tue, 5 Aug 2025 11:22:20 +0800
Message-ID: <20250805032220.2355160-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

This patch adds support for Over Current Protection (OCP) to the Realtek
USB card reader driver.

The OCP mechanism protects the hardware by detecting and handling current
overload conditions.
This implementation includes:

- Register configurations to enable OCP monitoring.
- Handling of OCP interrupt events and associated error reporting.
- Card power management changes in response to OCP triggers.

This enhancement improves the robustness of the driver when operating in
environments where electrical anomalies may occur, particularly with SD
and MS card interfaces.

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/memstick/host/rtsx_usb_ms.c |  5 ++++-
 drivers/misc/cardreader/rtsx_usb.c  |  7 +++++++
 drivers/mmc/host/rtsx_usb_sdmmc.c   | 32 +++++++++++++++++++++++++----
 include/linux/rtsx_usb.h            | 11 ++++++++++
 4 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index 3878136227e4..9389e9643c24 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -216,7 +216,10 @@ static int ms_power_off(struct rtsx_usb_ms *host)
 
 	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_CLK_EN, MS_CLK_EN, 0);
 	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_OE, MS_OUTPUT_EN, 0);
-
+	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_PWR_CTL,
+			POWER_MASK, POWER_OFF);
+	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_PWR_CTL,
+			POWER_MASK | LDO3318_PWR_MASK, POWER_OFF | LDO_SUSPEND);
 	err = rtsx_usb_send_cmd(ucr, MODE_C, 100);
 	if (err < 0)
 		return err;
diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index d007a4455ce5..1830e9ed2521 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -552,6 +552,10 @@ static int rtsx_usb_reset_chip(struct rtsx_ucr *ucr)
 	ret = rtsx_usb_send_cmd(ucr, MODE_C, 100);
 	if (ret)
 		return ret;
+	/* config OCP */
+	rtsx_usb_write_register(ucr, OCPCTL, MS_OCP_DETECT_EN, MS_OCP_DETECT_EN);
+	rtsx_usb_write_register(ucr, OCPPARA1, 0xF0, 0x50);
+	rtsx_usb_write_register(ucr, OCPPARA2, 0x7, 0x3);
 
 	/* config non-crystal mode */
 	rtsx_usb_read_register(ucr, CFG_MODE, &val);
@@ -722,6 +726,9 @@ static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
 			if (val & (SD_CD | MS_CD)) {
 				device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
 				return -EAGAIN;
+			} else {
+				/* if the card does not exists, clear OCP status */
+				rtsx_usb_write_register(ucr, OCPCTL, MS_OCP_CLEAR, MS_OCP_CLEAR);
 			}
 		} else {
 			/* There is an ongoing operation*/
diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index c5f6b9df066b..0632d294b12f 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -48,7 +48,7 @@ struct rtsx_usb_sdmmc {
 	bool			ddr_mode;
 
 	unsigned char		power_mode;
-
+	u16			ocp_stat;
 #ifdef RTSX_USB_USE_LEDS_CLASS
 	struct led_classdev	led;
 	char			led_name[32];
@@ -785,6 +785,9 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
 
 	mutex_unlock(&ucr->dev_mutex);
 
+	/* get OCP status */
+	host->ocp_stat = (val >> 4) & 0x03;
+
 	/* Treat failed detection as non-exist */
 	if (err)
 		goto no_card;
@@ -795,6 +798,11 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
 	}
 
 no_card:
+	/* clear OCP status */
+	if (host->ocp_stat & (MS_OCP_NOW | MS_OCP_EVER)) {
+		rtsx_usb_write_register(ucr, OCPCTL, MS_OCP_CLEAR, MS_OCP_CLEAR);
+		host->ocp_stat = 0;
+	}
 	host->card_exist = false;
 	return 0;
 }
@@ -818,7 +826,11 @@ static void sdmmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		cmd->error = -ENOMEDIUM;
 		goto finish_detect_card;
 	}
-
+	/* check OCP stat */
+	if (host->ocp_stat & (MS_OCP_NOW | MS_OCP_EVER)) {
+		cmd->error = -ENOMEDIUM;
+		goto finish_detect_card;
+	}
 	mutex_lock(&ucr->dev_mutex);
 
 	mutex_lock(&host->host_mutex);
@@ -977,9 +989,19 @@ static int sd_power_on(struct rtsx_usb_sdmmc *host)
 
 	usleep_range(800, 1000);
 
+	rtsx_usb_init_cmd(ucr);
+	/* WA OCP issue: after OCP, there were problems with reopen card power */
+	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_PWR_CTL, POWER_MASK, POWER_ON);
+	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, FPDCTL, SSC_POWER_MASK, SSC_POWER_DOWN);
+	err = rtsx_usb_send_cmd(ucr, MODE_C, 100);
+	if (err)
+		return err;
+	msleep(20);
+	rtsx_usb_write_register(ucr, FPDCTL, SSC_POWER_MASK, SSC_POWER_ON);
+	usleep_range(180, 200);
 	rtsx_usb_init_cmd(ucr);
 	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_PWR_CTL,
-			POWER_MASK|LDO3318_PWR_MASK, POWER_ON|LDO_ON);
+			LDO3318_PWR_MASK, LDO_ON);
 	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CARD_OE,
 			SD_OUTPUT_EN, SD_OUTPUT_EN);
 
@@ -1029,7 +1051,8 @@ static void sd_set_power_mode(struct rtsx_usb_sdmmc *host,
 
 	case MMC_POWER_UP:
 		pm_runtime_get_noresume(sdmmc_dev(host));
-		err = sd_power_on(host);
+		if (!(host->ocp_stat & (MS_OCP_NOW | MS_OCP_EVER)))
+			err = sd_power_on(host);
 		if (err)
 			dev_dbg(sdmmc_dev(host), "power-on (err = %d)\n", err);
 		/* issue the clock signals to card at least 74 clocks */
@@ -1332,6 +1355,7 @@ static void rtsx_usb_init_host(struct rtsx_usb_sdmmc *host)
 	mmc->max_req_size = 524288;
 
 	host->power_mode = MMC_POWER_OFF;
+	host->ocp_stat = 0;
 }
 
 static int rtsx_usb_sdmmc_drv_probe(struct platform_device *pdev)
diff --git a/include/linux/rtsx_usb.h b/include/linux/rtsx_usb.h
index f267a06c6b1e..276b509c03e3 100644
--- a/include/linux/rtsx_usb.h
+++ b/include/linux/rtsx_usb.h
@@ -99,6 +99,17 @@ extern int rtsx_usb_card_exclusive_check(struct rtsx_ucr *ucr, int card);
 #define CD_MASK		(SD_CD | MS_CD | XD_CD)
 #define SD_WP		0x08
 
+/* OCPCTL */
+#define MS_OCP_DETECT_EN		0x08
+#define	MS_OCP_INT_EN			0x04
+#define	MS_OCP_INT_CLR			0x02
+#define	MS_OCP_CLEAR			0x01
+
+/* OCPSTAT */
+#define MS_OCP_DETECT			0x80
+#define MS_OCP_NOW			0x02
+#define MS_OCP_EVER			0x01
+
 /* reader command field offset & parameters */
 #define READ_REG_CMD		0
 #define WRITE_REG_CMD		1
-- 
2.25.1

