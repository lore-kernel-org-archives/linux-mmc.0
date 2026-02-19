Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB17B30DD00
	for <linux-mmc@vger.kernel.org>; Thu, 19 Feb 2026 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771533596; cv=none; b=RQZfxBcer7YwXn8JyjOu1TCn3D2CpwTDfAQ0wxkZEig7QSNUSgKkgbOAVKzmef6OcFSW+FakEviS8P6lpPjqPwmrVLoDR64gRWPGM4v4kobVWQsXFFQmWqsEHjnSib55LFyoofCGSnRl0INgAfubkcVw90Vj9oOmUfsSsmLMYx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771533596; c=relaxed/simple;
	bh=G+UmSvJ/mogFhvBvrBYtM1J+Zu9ud3Q0gu1d/a4pkLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWlPi4MRIG+yaTfRc+MlQ1vUYlhSzB0vf5WwVri/JNupDhdQsreRkkVWK+mwDY5POvfCW6aHi96Ce5AXu+N1q7MruvjNtuua5TDLK5Az/nvkDV5yEBq2KHZ+Pcmp25D1DUKyLIVBUg6RRn/B2cIsG4qjuK3SrJX4Ai/+FAdojik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=bgCYjOID; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="bgCYjOID"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4837584120eso9977205e9.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Feb 2026 12:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1771533593; x=1772138393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fpZqiageYAEzhLdcOQIy6H2gADhn8PAzdRurtJ0NPdk=;
        b=bgCYjOID26/JYGU/XUgSsVmlTzPpfFHjjMG+XcbA0wKvvd7YCi8Yd7jbsVOqk7oI8r
         zQJIjzmmA2gInVCT8yzYC83bfBuuKPnb48Ozfj/gBFaZS8CKGOi7iqcLNmonIuXCKDNo
         9KeQmIpf1upySjioydn/HaSSjWAqWG/NS7Ud35ataeNhWMnslwG68/2PaNH/ps0qRukE
         gH74bRs4f8uiuWCvD2nBpfgun+zlA8QjOuoeUxE/VnRoXjoVp4j5L4nHH5m2SAtLgR8H
         wnDwFoLGZaYmn4+7iVavgIprL4rJY9vDw9vSYnT1hCrNm018MMf8RyYAMxq68oISWL8w
         e2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771533593; x=1772138393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpZqiageYAEzhLdcOQIy6H2gADhn8PAzdRurtJ0NPdk=;
        b=A9g5cVXtsXvvoqMewW+C6DNbnzN8B75YxehaSQu03Undp63MyJUFHmunzgF24x+br2
         +J49XtZxSEWx04khCrrkeR2xtvgHwL+26S/yajbkX036KRl84GfnJS9kQJl7nQYYWYUA
         LAkBk8HKsglIOHbWBkiG2xKUu1bCmGXc4l1J0fFSTXyxFP6wPLtoXzR19JJH8+7/OkFx
         ph7HVsH9O1rGLlwnfF2N3g3vlCDDO1WAHw3mVJRP6EgzVnccdK9LdRpUoK7pfHV059h6
         jzcAslsTPX0gS272RiGpKaUmagaEcNzNFRy1xRuCpzHLmFYbzuqjcn1bQj3ikd3OHKxw
         LtIg==
X-Forwarded-Encrypted: i=1; AJvYcCXwojNXiutdkTgZ7zDZWpJqGtV1SrsStGls1d/mfyrp4fFjwu4rSbkJnptNiqUcfZTO32GdHMN8OD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmMObZMDD61Bpb+v4r99EafrEn5LwhjJRFfibA1Q5SCGOkYQGJ
	E16z3Y5plsIaP8Si/drUKtYcy+GoICbf3sUANwnWb0iFdqhBGIWc/mjOD935Ifx2RQ==
X-Gm-Gg: AZuq6aIYzzZwgr5XmZoaJj+Lgec1IUWx+gjDe1Ctr2xZDbZKUkej5JueqpsAccvbFDk
	yxCLFFWFebAncTlGKhAuqcEpW8cj2g5xdOv160nq4rWD7C9yGFZns07URzuLuiouxGeQ5nf9O1v
	gAJ93V3HXdeKKsuBg0tPEK0yfKp+2l7rg8PTvY5ECB8+iAFnj6U/bcm+sQeJLjbXNDJ4xlB6Yv5
	NQvI9NNK1qNuqXNmr0UBBm5wl/TBudZBNmUQZ8KqN+Wh6dn4gc9Ltz6/iqDNmfvyd1norVoScCp
	mw4uShbp13Pz0YoB2aQQWbMdQsBukJloaUD2lC7PGQtzOm7qGO7gPaQyNSDZIjymZoaDiQnCyFa
	mlIEy1Tq1vYlFKs13EZVsp3lLUhWO1cd/8E2Eiycbvvcv9opg8Jah0+Esvh59jyd8ktT5DBNFjC
	iVz+xW7uxsxNsTb+Ffvdd8RUEhJAPkht5b2gnAvXBsXa7JZBf/lk8=
X-Received: by 2002:a05:600c:444f:b0:471:1765:839c with SMTP id 5b1f17b1804b1-48379bd7414mr301491845e9.20.1771533592908;
        Thu, 19 Feb 2026 12:39:52 -0800 (PST)
Received: from starbook ([217.155.46.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31efe02sm24947825e9.10.2026.02.19.12.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 12:39:52 -0800 (PST)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Ricky Wu <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Sean Rhodes <sean@starlabs.systems>,
	Jisheng Zhang <jszhang@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: rtsx_usb_sdmmc: avoid false card-detect on tray readers
Date: Thu, 19 Feb 2026 20:39:51 +0000
Message-ID: <1ca7b488a11e03b3f107f1829a40cf2c92c7d5fd.1771533586.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Realtek USB SD readers with a tray can assert SD_CD even when no
card is present. This can make the MMC core believe a card exists, and
may trigger unnecessary initialization and suspend failures.

Debounce the CD signal and validate a newly detected card by probing for
a response (CMD0 + CMD8/CMD55/CMD1) before reporting it present. Also
treat SD_INT as a removal indication even if SD_CD stays asserted.

Tested on a Realtek RTS5129 USB reader (0bda:0129) with tray inserted
and no card. No mmc device was created, and suspend pm_test=devices
passed.

Tested-by: Sean Rhodes <sean@starlabs.systems>
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
