Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF544239562
	for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2026 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317770; cv=none; b=UcdwKgWgCReZ58bPlxE+uLQhyBJJ/m22O11q7usACvFKBL2uZo2U5YM0birQBOkcqsWKdsjNzN3rygJbhqL0X3iUW/hGvcgAQk1iMhm6VGSgRaxAMDNKmu+xJ94pvtE1rWxMnkz9XUiWw7W5FxzpmhT4W8WEATdj4OvcqoNnfBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317770; c=relaxed/simple;
	bh=q7K+v3piZJcrosJPTRdRPWUfVCCMq202FgtLyEjDs48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7i3OSXcVDUCePyddBWHo06FWHGKUjQ4NZIJyhs/Ta5kbj8eFnicB2Nvf5TcnJKXIWYxIXZlThHHQ0wj8YGhs410d8PX5j0/79Hl7e/yXthu7w85RubrzEgba/MzDaWmUp9CK/q1W6AJzE2exHozOfOXxN+uE7lwnh/tHUWWgTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=Cz+Al66g; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="Cz+Al66g"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439baf33150so859420f8f.0
        for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2026 05:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1773317764; x=1773922564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpvL5W3u/QtSEFCecru0A3tqQQejPltz3A2r1FTtM90=;
        b=Cz+Al66g7/kVsYoAqCwETrymvjChAVZgkMe4q6S33PNUsQOSFk8LLnAC4+Z/C1xvmi
         bfa8Z0JDSo+E1oExYEXqNsTKX74JhQnuTbmzRPQH6rUzFJKFR2wkXA5LMj1yBE+ouYUQ
         mUi5HmxNpON8X0G0f9RyqueYA/uMlHlXDBHb+xG5w6zuZKT+2HYR5osgpli64JyvVG97
         Tv61MmcYRh3bTm9jWT7Al0se5l8EtaOyJt+ZN6c1Q0aY5uuN4W6ugT60Gnqp8UIzfGeU
         OuBtUqN34O3Gx3X3fmCr4YO/U2DJaxi8GBdsToiKeRxfxgV3juozqnck4KpGH2ioT+BJ
         yiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773317764; x=1773922564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dpvL5W3u/QtSEFCecru0A3tqQQejPltz3A2r1FTtM90=;
        b=xDr0yz9IdAdHjWgEUGtMEVQdiji0oCbjDgdnv2c/nok9tTMca8uubEURM8NqcnyCiv
         GiloWZn3xWS9re+u4h8KCfk30981GkyxDJ78XZ0N6nfhEAOEc5T0Yoycz3K6neJQ61Kd
         N9FMS6ImoHHcp9k5sUvoK+ku1JyuGv0tDSVh5LCPsoz3yad3wAUwnkLbg5a09f7mBtML
         4nfpP2NxbUN1FLxJo6bNq8MSqRkPxM3IMIRp2QXPUYSCve5ZzaW7BV/E67TqNRLbg+Oz
         f896jhsRMEpRROW1SewmFp6/LJkYNWKrPX/xJCEB22oSo9EID0sPaLbXOEeUVhQ77Ql0
         ifhA==
X-Gm-Message-State: AOJu0YwljS5BsdM9NSwaTjPWZUDXLLkDdjBrepqTFbXwgCcq/jKxRRoN
	o2A7duA5cvanbjKXVN0OK5yfjgTF6sxZOXFfxQ6gDoUYYZ0RaMtR5HGkq1kS0ZCLR9abFIBHxFw
	YHm9P4w==
X-Gm-Gg: ATEYQzw75BPs6Nut3Dje4/q7wHG/MEjwrpOOXbJS2cvLPBUzl4csJyOl7SKcaX4hLI5
	TZxPehylg9hj/+B/2RjkcBuFQ3eD8AgR8jnoHixZhkDb4tHmsmG/jH6B4A68nRIIsBrEa7xu86U
	n/NEpxu7bU2QVxx3qiyoTN8MjjOEUbA3Z2CR/tU+yeyO35JATWWuNxff26zBxfvxMuE/4BRmGeM
	/TlvyECfBRNd2G7FktQ9W1mXwCrmS9WFwqZWRR8vttttIFHmMgKR3bNporyRJQuSzhI2LycRoNR
	1fXHhdGZIcGtn68ujKxdOM4v2XBtroM/NLqBnQjD+qu8ZQY0MkMJz/qpurf3AZJEKqD07vLNux3
	iwSPPw/w/OFgwZVA5U8M5x5HfVw93BipvIwD2DHIZ12x9svloUZbUnPh4uCN3PJt/HktNGfPgms
	M8P1uK9vnrcFnom6yR0YDtO1gsFV+o7VLY97w+h8f9nzGdn5YGz+CcaJTxR5sWapY5qhVakA==
X-Received: by 2002:a5d:5f96:0:b0:439:c8b3:a3e9 with SMTP id ffacd0b85a97d-439fe194765mr6267301f8f.14.1773317763477;
        Thu, 12 Mar 2026 05:16:03 -0700 (PDT)
Received: from starbook.localdomain ([212.105.129.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c473sm8139874f8f.24.2026.03.12.05.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:16:02 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ricky Wu <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND 1/6] mmc: rtsx_usb_sdmmc: avoid false card-detect on tray readers
Date: Thu, 12 Mar 2026 12:15:54 +0000
Message-ID: <20260312121559.19197-2-sean@starlabs.systems>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312121559.19197-1-sean@starlabs.systems>
References: <20260305194052.5120-1-sean@starlabs.systems>
 <20260312121559.19197-1-sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Realtek USB SD readers with a tray can assert SD_CD even when no
card is present. This can make the MMC core believe a card exists and
trigger unnecessary initialization and suspend/shutdown failures.

Debounce the CD signal and validate a newly detected card by probing for
a response (CMD0 + CMD8/CMD55/CMD1) before reporting it present. Also
treat SD_INT as a removal indication even if SD_CD stays asserted.

Tested: Realtek RTS5129 (0bda:0129), tray inserted, no card (2026-02-24)
Tested: Realtek RTS5129 (0bda:0129), tray + SDXC card, mmcblk0 (2026-02-24)

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 156 ++++++++++++++++++++++++++++--
 1 file changed, 148 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 84674659a84d..ec3eeea78e95 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -19,6 +19,7 @@
 #include <linux/scatterlist.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/jiffies.h>
 
 #include <linux/rtsx_usb.h>
 #include <linux/unaligned.h>
@@ -30,6 +31,9 @@
 #define RTSX_USB_USE_LEDS_CLASS
 #endif
 
+#define RTSX_USB_SD_CD_DEBOUNCE_CNT	2
+#define RTSX_USB_SD_INSERT_RETRY_MS	1000
+
 struct rtsx_usb_sdmmc {
 	struct platform_device	*pdev;
 	struct rtsx_ucr	*ucr;
@@ -46,6 +50,8 @@ struct rtsx_usb_sdmmc {
 	bool			card_exist;
 	bool			initial_mode;
 	bool			ddr_mode;
+	u8			cd_debounce;
+	unsigned long		next_insert_check;
 
 	unsigned char		power_mode;
 	u16			ocp_stat;
@@ -72,6 +78,13 @@ static inline void sd_clear_error(struct rtsx_usb_sdmmc *host)
 	rtsx_usb_clear_fsm_err(ucr);
 }
 
+static int sd_set_bus_width(struct rtsx_usb_sdmmc *host,
+			    unsigned char bus_width);
+static int sd_set_timing(struct rtsx_usb_sdmmc *host,
+			 unsigned char timing, bool *ddr_mode);
+static int sd_power_on(struct rtsx_usb_sdmmc *host);
+static int sd_power_off(struct rtsx_usb_sdmmc *host);
+
 #ifdef DEBUG
 static void sd_print_debug_regs(struct rtsx_usb_sdmmc *host)
 {
@@ -768,12 +781,94 @@ static int sdmmc_get_ro(struct mmc_host *mmc)
 	return 0;
 }
 
+static bool sdmmc_validate_insert_locked(struct rtsx_usb_sdmmc *host)
+{
+	struct rtsx_ucr *ucr = host->ucr;
+	struct mmc_command cmd = { };
+	int err = 0;
+	bool probe_powered = false;
+	bool ddr_mode = false;
+
+	/*
+	 * Some readers with a tray assert the mechanical SD_CD pin even when no
+	 * card is present. Only report a card present when it responds to a
+	 * minimal reset/probe sequence, similar to the old rts5139 behavior.
+	 *
+	 * Must be called with ucr->dev_mutex held.
+	 */
+	if (host->power_mode == MMC_POWER_OFF) {
+		err = sd_power_on(host);
+		if (err)
+			return false;
+		probe_powered = true;
+
+		/* Issue clock signals to card for at least 74 clocks. */
+		rtsx_usb_write_register(ucr, SD_BUS_STAT,
+					SD_CLK_TOGGLE_EN, SD_CLK_TOGGLE_EN);
+		usleep_range(200, 400);
+		rtsx_usb_write_register(ucr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, 0);
+	}
+
+	/*
+	 * Ensure the interface is in a safe, legacy / initial-clock mode before
+	 * probing for a response. The MMC core may not have configured ios yet.
+	 */
+	err = sd_set_bus_width(host, MMC_BUS_WIDTH_1);
+	if (err)
+		goto out;
+
+	err = sd_set_timing(host, MMC_TIMING_LEGACY, &ddr_mode);
+	if (err)
+		goto out;
+
+	ucr->cur_clk = 0;
+	err = rtsx_usb_switch_clock(ucr, 400000, SSC_DEPTH_512K,
+				    true, true, false);
+	if (err)
+		goto out;
+
+	cmd.opcode = MMC_GO_IDLE_STATE;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_NONE | MMC_CMD_BC;
+	sd_send_cmd_get_rsp(host, &cmd);
+
+	/* SD v2.0+: CMD8 */
+	cmd.opcode = SD_SEND_IF_COND;
+	cmd.arg = 0x1aa;
+	cmd.flags = MMC_RSP_R7 | MMC_CMD_BCR;
+	sd_send_cmd_get_rsp(host, &cmd);
+	if (!cmd.error)
+		goto out;
+
+	/* SD v1.x: CMD55 */
+	cmd.opcode = MMC_APP_CMD;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	sd_send_cmd_get_rsp(host, &cmd);
+	if (!cmd.error)
+		goto out;
+
+	/* MMC: CMD1 */
+	cmd.opcode = MMC_SEND_OP_COND;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_R3 | MMC_CMD_BCR;
+	sd_send_cmd_get_rsp(host, &cmd);
+
+out:
+	if (probe_powered)
+		sd_power_off(host);
+	return !err && !cmd.error;
+}
+
 static int sdmmc_get_cd(struct mmc_host *mmc)
 {
 	struct rtsx_usb_sdmmc *host = mmc_priv(mmc);
 	struct rtsx_ucr *ucr = host->ucr;
 	int err;
 	u16 val;
+	u8 pend;
+	bool sd_int = false;
+	bool cd_raw = false;
 
 	if (host->host_removal)
 		return -ENOMEDIUM;
@@ -782,28 +877,71 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
 
 	/* Check SD card detect */
 	err = rtsx_usb_get_card_status(ucr, &val);
-
-	mutex_unlock(&ucr->dev_mutex);
-
-	/* Treat failed detection as non-exist */
 	if (err)
-		goto no_card;
+		goto no_card_unlock;
 
 	/* get OCP status */
 	host->ocp_stat = (val >> 4) & 0x03;
 
-	if (val & SD_CD) {
-		host->card_exist = true;
+	cd_raw = !!(val & SD_CD);
+
+	/* Use SD_INT as a reliable removal indication on some tray readers. */
+	err = rtsx_usb_read_register(ucr, CARD_INT_PEND, &pend);
+	if (!err) {
+		sd_int = !!(pend & SD_INT);
+		if (sd_int)
+			rtsx_usb_write_register(ucr, CARD_INT_PEND,
+						SD_INT, SD_INT);
+	}
+
+	if (!cd_raw) {
+		host->cd_debounce = 0;
+		host->next_insert_check = 0;
+		goto no_card_unlock;
+	}
+
+	/*
+	 * rts5139-style: when a card is already known present, treat SD_INT as
+	 * a removal event even if SD_CD stays high (e.g. tray-based readers).
+	 */
+	if (host->card_exist) {
+		if (sd_int) {
+			host->cd_debounce = 0;
+			host->next_insert_check = 0;
+			goto no_card_unlock;
+		}
+		mutex_unlock(&ucr->dev_mutex);
 		return 1;
 	}
 
-no_card:
+	/* Debounce mechanical CD before probing for a response. */
+	if (host->cd_debounce < RTSX_USB_SD_CD_DEBOUNCE_CNT) {
+		host->cd_debounce++;
+		goto no_card_unlock;
+	}
+
+	/* Avoid pounding the bus with probes if CD is stuck asserted. */
+	if (time_before(jiffies, host->next_insert_check))
+		goto no_card_unlock;
+
+	if (!sdmmc_validate_insert_locked(host)) {
+		host->next_insert_check = jiffies +
+			msecs_to_jiffies(RTSX_USB_SD_INSERT_RETRY_MS);
+		goto no_card_unlock;
+	}
+
+	host->card_exist = true;
+	mutex_unlock(&ucr->dev_mutex);
+	return 1;
+
+no_card_unlock:
 	/* clear OCP status */
 	if (host->ocp_stat & (MS_OCP_NOW | MS_OCP_EVER)) {
 		rtsx_usb_write_register(ucr, OCPCTL, MS_OCP_CLEAR, MS_OCP_CLEAR);
 		host->ocp_stat = 0;
 	}
 	host->card_exist = false;
+	mutex_unlock(&ucr->dev_mutex);
 	return 0;
 }
 
@@ -1359,6 +1497,8 @@ static void rtsx_usb_init_host(struct rtsx_usb_sdmmc *host)
 
 	host->power_mode = MMC_POWER_OFF;
 	host->ocp_stat = 0;
+	host->cd_debounce = 0;
+	host->next_insert_check = 0;
 }
 
 static int rtsx_usb_sdmmc_drv_probe(struct platform_device *pdev)
-- 
2.51.0
