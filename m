Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EB11DC1A8;
	Fri, 13 Sep 2024 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223405; cv=none; b=RqW2+ljCJ2Lbu68CvL0nckUHFioE1b4yPWvsj7I9hRYOxzOAgPX1JpLZYiwk6suY3Gm1Z52G8ZtuB49Z0xcUY+/NcreMydXUj1PfSgADMZr7CbiIqw9TfJdx7fUWz7cLjYeT1xYRwjpkgPi1L5KOJ+PwcK3K8du+pxMX/8V49Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223405; c=relaxed/simple;
	bh=CFzQ4Vv7dL/101A5xPHXt02EkDI0vj/zsYXvMDV0jEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aAXAMpeRYctb/8R548dY7AM/0JwTDBf4KwuIELE7x4jScPGpEZkMRYoaI6ajlrxsD6+htxve1jotmwh6aLkUKl5Og+I0R6lFLQkPpFu4bzhrMAhDXTilRVcMgtWhdV7LKtX+Rgry45sfUFNW9jmhXgep6ovkddLwBxRgTyA+QgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EraK9ZcO; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EraK9ZcO"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-717849c0dcaso774674b3a.3;
        Fri, 13 Sep 2024 03:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726223403; x=1726828203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7uSYeaZZwxXwIQD3LCDHDP91xIJh8wcjYWHXNSRfSs=;
        b=EraK9ZcOXqRJM1Qh9972q5cMor8ZVMqce5YvHW4aRH+uew7C2qaSZr6c0hsS9ZiVZN
         kcdOx2yHaaDBeuJ18x+PkhOODWHeNZ6kmnbZlzt7K01Sidszl7g7B26xIUMa53prgJ1V
         /ZFpemvbPD6C1ptiPz8iPXr9SnSTI+E1OE3HBsHhujJOh4CzcOhboGZ9LfFQOcOPSVne
         P30CW8NhHpvZcPAXH0HsPgbb7n0Iu/00TqdhF0Ex6+Czwgs9WOYji6OhWMnD6UATfXAr
         3C1usqE+5+vFXfK2Q0/6lhSa6mSRAxz4VRUcCxJ12woH6aUdX7vBUN8t2GCnUnTHt0j7
         JcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726223403; x=1726828203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7uSYeaZZwxXwIQD3LCDHDP91xIJh8wcjYWHXNSRfSs=;
        b=iNXA8wsY3lzQ3cVHzDW0MyYYnsnQzY3i+5Zi0EwSoCmk9NXsf9IvXPtXNbAo5jltuq
         WaYO21G9iAdpfxaxKtsEcqBdAReVHmOHOTmBUxtqr2L5YwJikKrVSeJ80VxIqZ5IF0dF
         tU5+BEEOZsvyAXiXHgANWGH+vggN7LbB3zUr4TVEd0cELIj+8d86Wf8evSixrecUEU1t
         QjxssnZdEtTfWu44oaKDe2xlcNMqE156ZkQYwpf6qqAEIFV4q6Pq/vY9QiVSO7ataTqJ
         zdu8OwCr1tZv117zwfy9UYPeZsoK4qezyobeUQGibr2TfXMafiQtVmk9gfq8SP4qFvVc
         lHeg==
X-Forwarded-Encrypted: i=1; AJvYcCXFxC0VziKtEEdLre8w249KvjS6mznXInhXyQ9ElPWUN+eHy1U64PHuro6hS9n+4/8wL6LYM2iQFRlrAo4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6CQH4vhhcWeySPajMJNGdHeKGzE+jJnRp8aowIlqziM5Znbu8
	0YDFn8s5tdCK8YarzPeT+afR86r9zxJlpSZLgLzdv+rinUk25yJWKU6HZL24
X-Google-Smtp-Source: AGHT+IFSx1UxvzEfTS67t6k/wLKwa9hVC37FtD1CLnlYEoXkPgkSexn5/1svva4WJts+wTzd5DuguA==
X-Received: by 2002:a05:6a20:cd91:b0:1d0:7df8:2484 with SMTP id adf61e73a8af0-1d112eae052mr3185523637.43.1726223402767;
        Fri, 13 Sep 2024 03:30:02 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:568:acb8:4bcf:ada3:4620:3cfb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fad0ac6sm3137683a12.0.2024.09.13.03.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:30:02 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	Lucas.Lai@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V22 18/22] mmc: sdhci-uhs2: add request() and others
Date: Fri, 13 Sep 2024 18:28:32 +0800
Message-Id: <20240913102836.6144-19-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913102836.6144-1-victorshihgli@gmail.com>
References: <20240913102836.6144-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

This is a sdhci version of mmc's request operation.
It covers both UHS-I and UHS-II.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V22:
 - Adjust the patch order from v21 patch#16 to v22 patch#18 and
   add necessary code to avoid defined but not used warnings.

Updates in V19:
 - cmd->uhs2_cmd->uhs2_resp is always true, remove it from safety check
   in the __sdhci_uhs2_finish_command().

Updates in V17:
 - Add new parameter to __sdhci_finish_data_common().

Updates in V16:
 - Remove irrelevant definition in the sdhci_calc_timeout_uhs2().

Updates in V15:
 - Adjust the parameters used in the __sdhci_uhs2_finish_command()
   to match changes in the Patch#7.

Updates in V14:
 - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
   sdhci_uhs2_request().

Updates in V13:
 - Re-order function to avoid declaration.
 - Remove unnecessary function.

Updates in V11:
 - Drop the check mmc_card_uhs2_hd_mode(host->mmc)
   in sdhci_uhs2_set_transfer_mode().

Updates in V10:
 - Use tmode_half_duplex to instead of uhs2_tmode0_flag
   in sdhci_uhs2_set_transfer_mode().

Updates in V9:
 - Modify the annotations in __sdhci_uhs2_send_command().

Updates in V8:
 - Adjust the position of matching brackets in
   sdhci_uhs2_send_command_retry().
 - Modify CameCase definition in __sdhci_uhs2_finish_command().
 - Modify error message in __sdhci_uhs2_finish_command().
 - sdhci_uhs2_send_command_retry() to instead of sdhci_uhs2_send_command()
   in sdhci_uhs2_request().
 - Use sdhci_uhs2_mode() to simplify code in sdhci_uhs2_request_atomic().
 - Add forward declaration for sdhci_send_command().

Updates in V7:
 - Cancel export state of some functions.
 - Remove unnecessary whitespace changes.

Updates in V6:
 - Add uhs2_dev_cmd() to simplify code.
 - Remove unnecessary functions.
 - Cancel export state of some functions.
 - Drop use CONFIG_MMC_DEBUG().
 - Wrap at 100 columns in some functions.

---

 drivers/mmc/host/sdhci-uhs2.c | 392 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c      |  53 +++--
 drivers/mmc/host/sdhci.h      |   8 +
 3 files changed, 437 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 76f1af8b0486..d99ea05098cb 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -15,6 +15,8 @@
 #include <linux/iopoll.h>
 #include <linux/bitfield.h>
 #include <linux/regulator/consumer.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/host.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -30,6 +32,8 @@
 #define UHS2_INTERFACE_DETECT_TIMEOUT_100MS	100000
 #define UHS2_LANE_SYNC_TIMEOUT_150MS		150000
 
+#define UHS2_ARG_IOADR_MASK 0xfff
+
 void sdhci_uhs2_dump_regs(struct sdhci_host *host)
 {
 	if (!(mmc_card_uhs2(host->mmc)))
@@ -64,6 +68,11 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
  *                                                                           *
 \*****************************************************************************/
 
+static inline u16 uhs2_dev_cmd(struct mmc_command *cmd)
+{
+	return be16_to_cpu((__be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR_MASK;
+}
+
 static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
 					    struct regulator *supply,
 					    unsigned short vdd_bit)
@@ -542,6 +551,374 @@ static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_operation op)
 	return err;
 }
 
+/*****************************************************************************\
+ *                                                                           *
+ * Core functions                                                            *
+ *                                                                           *
+\*****************************************************************************/
+
+static void sdhci_uhs2_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	struct mmc_data *data = cmd->data;
+
+	sdhci_initialize_data(host, data);
+
+	sdhci_prepare_dma(host, data);
+
+	sdhci_writew(host, data->blksz, SDHCI_UHS2_BLOCK_SIZE);
+	sdhci_writew(host, data->blocks, SDHCI_UHS2_BLOCK_COUNT);
+}
+
+static void sdhci_uhs2_finish_data(struct sdhci_host *host)
+{
+	struct mmc_data *data = host->data;
+
+	__sdhci_finish_data_common(host, true);
+
+	__sdhci_finish_mrq(host, data->mrq);
+}
+
+static void sdhci_uhs2_set_transfer_mode(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	u16 mode;
+	struct mmc_data *data = cmd->data;
+
+	if (!data) {
+		/* clear Auto CMD settings for no data CMDs */
+		if (uhs2_dev_cmd(cmd) == UHS2_DEV_CMD_TRANS_ABORT) {
+			mode =  0;
+		} else {
+			mode = sdhci_readw(host, SDHCI_UHS2_TRANS_MODE);
+			if (cmd->opcode == MMC_STOP_TRANSMISSION || cmd->opcode == MMC_ERASE)
+				mode |= SDHCI_UHS2_TRNS_WAIT_EBSY;
+			else
+				/* send status mode */
+				if (cmd->opcode == MMC_SEND_STATUS)
+					mode = 0;
+		}
+
+		DBG("UHS2 no data trans mode is 0x%x.\n", mode);
+
+		sdhci_writew(host, mode, SDHCI_UHS2_TRANS_MODE);
+		return;
+	}
+
+	WARN_ON(!host->data);
+
+	mode = SDHCI_UHS2_TRNS_BLK_CNT_EN | SDHCI_UHS2_TRNS_WAIT_EBSY;
+	if (data->flags & MMC_DATA_WRITE)
+		mode |= SDHCI_UHS2_TRNS_DATA_TRNS_WRT;
+
+	if (data->blocks == 1 &&
+	    data->blksz != 512 &&
+	    cmd->opcode != MMC_READ_SINGLE_BLOCK &&
+	    cmd->opcode != MMC_WRITE_BLOCK) {
+		mode &= ~SDHCI_UHS2_TRNS_BLK_CNT_EN;
+		mode |= SDHCI_UHS2_TRNS_BLK_BYTE_MODE;
+	}
+
+	if (host->flags & SDHCI_REQ_USE_DMA)
+		mode |= SDHCI_UHS2_TRNS_DMA;
+
+	if (cmd->uhs2_cmd->tmode_half_duplex)
+		mode |= SDHCI_UHS2_TRNS_2L_HD;
+
+	sdhci_writew(host, mode, SDHCI_UHS2_TRANS_MODE);
+
+	DBG("UHS2 trans mode is 0x%x.\n", mode);
+}
+
+static void __sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	int i, j;
+	int cmd_reg;
+
+	i = 0;
+	sdhci_writel(host,
+		     ((u32)cmd->uhs2_cmd->arg << 16) |
+				(u32)cmd->uhs2_cmd->header,
+		     SDHCI_UHS2_CMD_PACKET + i);
+	i += 4;
+
+	/*
+	 * Per spec, payload (config) should be MSB before sending out.
+	 * But we don't need convert here because had set payload as
+	 * MSB when preparing config read/write commands.
+	 */
+	for (j = 0; j < cmd->uhs2_cmd->payload_len / sizeof(u32); j++) {
+		sdhci_writel(host, *(cmd->uhs2_cmd->payload + j), SDHCI_UHS2_CMD_PACKET + i);
+		i += 4;
+	}
+
+	for ( ; i < SDHCI_UHS2_CMD_PACK_MAX_LEN; i += 4)
+		sdhci_writel(host, 0, SDHCI_UHS2_CMD_PACKET + i);
+
+	DBG("UHS2 CMD packet_len = %d.\n", cmd->uhs2_cmd->packet_len);
+	for (i = 0; i < cmd->uhs2_cmd->packet_len; i++)
+		DBG("UHS2 CMD_PACKET[%d] = 0x%x.\n", i,
+		    sdhci_readb(host, SDHCI_UHS2_CMD_PACKET + i));
+
+	cmd_reg = FIELD_PREP(SDHCI_UHS2_CMD_PACK_LEN_MASK, cmd->uhs2_cmd->packet_len);
+	if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC)
+		cmd_reg |= SDHCI_UHS2_CMD_DATA;
+	if (cmd->opcode == MMC_STOP_TRANSMISSION)
+		cmd_reg |= SDHCI_UHS2_CMD_CMD12;
+
+	/* UHS2 Native ABORT */
+	if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
+	    (uhs2_dev_cmd(cmd) == UHS2_DEV_CMD_TRANS_ABORT))
+		cmd_reg |= SDHCI_UHS2_CMD_TRNS_ABORT;
+
+	/* UHS2 Native DORMANT */
+	if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
+	    (uhs2_dev_cmd(cmd) == UHS2_DEV_CMD_GO_DORMANT_STATE))
+		cmd_reg |= SDHCI_UHS2_CMD_DORMANT;
+
+	DBG("0x%x is set to UHS2 CMD register.\n", cmd_reg);
+
+	sdhci_writew(host, cmd_reg, SDHCI_UHS2_CMD);
+}
+
+static bool sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	int flags;
+	u32 mask;
+	unsigned long timeout;
+
+	WARN_ON(host->cmd);
+
+	/* Initially, a command has no error */
+	cmd->error = 0;
+
+	if (cmd->opcode == MMC_STOP_TRANSMISSION)
+		cmd->flags |= MMC_RSP_BUSY;
+
+	mask = SDHCI_CMD_INHIBIT;
+
+	if (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask)
+		return false;
+
+	host->cmd = cmd;
+	host->data_timeout = 0;
+	if (sdhci_data_line_cmd(cmd)) {
+		WARN_ON(host->data_cmd);
+		host->data_cmd = cmd;
+		__sdhci_uhs2_set_timeout(host);
+	}
+
+	if (cmd->data)
+		sdhci_uhs2_prepare_data(host, cmd);
+
+	sdhci_uhs2_set_transfer_mode(host, cmd);
+
+	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
+		WARN_ONCE(1, "Unsupported response type!\n");
+		/*
+		 * This does not happen in practice because 136-bit response
+		 * commands never have busy waiting, so rather than complicate
+		 * the error path, just remove busy waiting and continue.
+		 */
+		cmd->flags &= ~MMC_RSP_BUSY;
+	}
+
+	if (!(cmd->flags & MMC_RSP_PRESENT))
+		flags = SDHCI_CMD_RESP_NONE;
+	else if (cmd->flags & MMC_RSP_136)
+		flags = SDHCI_CMD_RESP_LONG;
+	else if (cmd->flags & MMC_RSP_BUSY)
+		flags = SDHCI_CMD_RESP_SHORT_BUSY;
+	else
+		flags = SDHCI_CMD_RESP_SHORT;
+
+	if (cmd->flags & MMC_RSP_CRC)
+		flags |= SDHCI_CMD_CRC;
+	if (cmd->flags & MMC_RSP_OPCODE)
+		flags |= SDHCI_CMD_INDEX;
+
+	timeout = jiffies;
+	if (host->data_timeout)
+		timeout += nsecs_to_jiffies(host->data_timeout);
+	else if (!cmd->data && cmd->busy_timeout > 9000)
+		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
+	else
+		timeout += 10 * HZ;
+	sdhci_mod_timer(host, cmd->mrq, timeout);
+
+	__sdhci_uhs2_send_command(host, cmd);
+
+	return true;
+}
+
+static bool sdhci_uhs2_send_command_retry(struct sdhci_host *host,
+					  struct mmc_command *cmd,
+					  unsigned long flags)
+	__releases(host->lock)
+	__acquires(host->lock)
+{
+	struct mmc_command *deferred_cmd = host->deferred_cmd;
+	int timeout = 10; /* Approx. 10 ms */
+	bool present;
+
+	while (!sdhci_uhs2_send_command(host, cmd)) {
+		if (!timeout--) {
+			pr_err("%s: Controller never released inhibit bit(s).\n",
+			       mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			cmd->error = -EIO;
+			return false;
+		}
+
+		spin_unlock_irqrestore(&host->lock, flags);
+
+		usleep_range(1000, 1250);
+
+		present = host->mmc->ops->get_cd(host->mmc);
+
+		spin_lock_irqsave(&host->lock, flags);
+
+		/* A deferred command might disappear, handle that */
+		if (cmd == deferred_cmd && cmd != host->deferred_cmd)
+			return true;
+
+		if (sdhci_present_error(host, cmd, present))
+			return false;
+	}
+
+	if (cmd == host->deferred_cmd)
+		host->deferred_cmd = NULL;
+
+	return true;
+}
+
+static void __sdhci_uhs2_finish_command(struct sdhci_host *host)
+{
+	struct mmc_command *cmd = host->cmd;
+	u8 resp;
+	u8 error_code;
+	bool breada0 = 0;
+	int i;
+
+	if (host->mmc->uhs2_sd_tran) {
+		resp = sdhci_readb(host, SDHCI_UHS2_RESPONSE + 2);
+		if (resp & UHS2_RES_NACK_MASK) {
+			error_code = (resp >> UHS2_RES_ECODE_POS) & UHS2_RES_ECODE_MASK;
+			pr_err("%s: NACK response, ECODE=0x%x.\n",
+			       mmc_hostname(host->mmc), error_code);
+		}
+		breada0 = 1;
+	}
+
+	if (cmd->uhs2_cmd->uhs2_resp_len) {
+		int len = min_t(int, cmd->uhs2_cmd->uhs2_resp_len, UHS2_MAX_RESP_LEN);
+
+		/* Get whole response of some native CCMD, like
+		 * DEVICE_INIT, ENUMERATE.
+		 */
+		for (i = 0; i < len; i++)
+			cmd->uhs2_cmd->uhs2_resp[i] = sdhci_readb(host, SDHCI_UHS2_RESPONSE + i);
+	} else {
+		/* Get SD CMD response and Payload for some read
+		 * CCMD, like INQUIRY_CFG.
+		 */
+		/* Per spec (p136), payload field is divided into
+		 * a unit of DWORD and transmission order within
+		 * a DWORD is big endian.
+		 */
+		if (!breada0)
+			sdhci_readl(host, SDHCI_UHS2_RESPONSE);
+		for (i = 4; i < 20; i += 4) {
+			cmd->resp[i / 4 - 1] =
+				(sdhci_readb(host,
+					     SDHCI_UHS2_RESPONSE + i) << 24) |
+				(sdhci_readb(host,
+					     SDHCI_UHS2_RESPONSE + i + 1)
+					<< 16) |
+				(sdhci_readb(host,
+					     SDHCI_UHS2_RESPONSE + i + 2)
+					<< 8) |
+				sdhci_readb(host, SDHCI_UHS2_RESPONSE + i + 3);
+		}
+	}
+}
+
+static void sdhci_uhs2_finish_command(struct sdhci_host *host)
+{
+	struct mmc_command *cmd = host->cmd;
+
+	__sdhci_uhs2_finish_command(host);
+
+	host->cmd = NULL;
+
+	if (cmd->mrq->cap_cmd_during_tfr && cmd == cmd->mrq->cmd)
+		mmc_command_done(host->mmc, cmd->mrq);
+
+	/*
+	 * The host can send and interrupt when the busy state has
+	 * ended, allowing us to wait without wasting CPU cycles.
+	 * The busy signal uses DAT0 so this is similar to waiting
+	 * for data to complete.
+	 *
+	 * Note: The 1.0 specification is a bit ambiguous about this
+	 *       feature so there might be some problems with older
+	 *       controllers.
+	 */
+	if (cmd->flags & MMC_RSP_BUSY) {
+		if (cmd->data) {
+			DBG("Cannot wait for busy signal when also doing a data transfer");
+		} else if (!(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
+			   cmd == host->data_cmd) {
+			/* Command complete before busy is ended */
+			return;
+		}
+	}
+
+	/* Processed actual command. */
+	if (host->data && host->data_early)
+		sdhci_uhs2_finish_data(host);
+
+	if (!cmd->data)
+		__sdhci_finish_mrq(host, cmd->mrq);
+}
+
+static void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct mmc_command *cmd;
+	unsigned long flags;
+	bool present;
+
+	if (!(mmc_card_uhs2(mmc))) {
+		sdhci_request(mmc, mrq);
+		return;
+	}
+
+	mrq->stop = NULL;
+	mrq->sbc = NULL;
+	if (mrq->data)
+		mrq->data->stop = NULL;
+
+	/* Firstly check card presence */
+	present = mmc->ops->get_cd(mmc);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (sdhci_present_error(host, mrq->cmd, present))
+		goto out_finish;
+
+	cmd = mrq->cmd;
+
+	if (!sdhci_uhs2_send_command_retry(host, cmd, flags))
+		goto out_finish;
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return;
+
+out_finish:
+	sdhci_finish_mrq(host, mrq);
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Request done                                                              *
@@ -638,6 +1015,8 @@ static void sdhci_uhs2_complete_work(struct work_struct *work)
 
 static void __sdhci_uhs2_irq(struct sdhci_host *host, u32 uhs2mask)
 {
+	struct mmc_command *cmd = host->cmd;
+
 	DBG("*** %s got UHS2 error interrupt: 0x%08x\n",
 	    mmc_hostname(host->mmc), uhs2mask);
 
@@ -677,6 +1056,12 @@ static void __sdhci_uhs2_irq(struct sdhci_host *host, u32 uhs2mask)
 			host->data->error = -EILSEQ;
 		}
 	}
+
+	if (host->data && host->data->error)
+		sdhci_uhs2_finish_data(host);
+	else
+		sdhci_finish_mrq(host, cmd->mrq);
+
 }
 
 u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask)
@@ -708,6 +1093,10 @@ u32 sdhci_uhs2_irq(struct sdhci_host *host, u32 intmask)
 		/* Clear command interrupt */
 		sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK, SDHCI_INT_STATUS);
 
+		/* Handle command interrupt */
+		if (intmask & SDHCI_INT_RESPONSE)
+			sdhci_uhs2_finish_command(host);
+
 		/* Caller, sdhci_irq(), doesn't have to care about UHS-2 commands */
 		intmask &= ~SDHCI_INT_CMD_MASK;
 		mask &= SDHCI_INT_CMD_MASK;
@@ -740,6 +1129,8 @@ static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
 	host->thread_isr = 0;
 
 	cmd = host->deferred_cmd;
+	if (cmd && !sdhci_uhs2_send_command_retry(host, cmd, flags))
+		sdhci_finish_mrq(host, cmd->mrq);
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
@@ -762,6 +1153,7 @@ static irqreturn_t sdhci_uhs2_thread_irq(int irq, void *dev_id)
 static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 {
 	host->mmc_host_ops.uhs2_control = sdhci_uhs2_control;
+	host->mmc_host_ops.request = sdhci_uhs2_request;
 
 	return 0;
 }
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 871b4fe2a1b2..f4a7733a8ad2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -147,10 +147,11 @@ void sdhci_enable_v4_mode(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_enable_v4_mode);
 
-static inline bool sdhci_data_line_cmd(struct mmc_command *cmd)
+bool sdhci_data_line_cmd(struct mmc_command *cmd)
 {
 	return cmd->data || cmd->flags & MMC_RSP_BUSY;
 }
+EXPORT_SYMBOL_GPL(sdhci_data_line_cmd);
 
 static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 {
@@ -503,14 +504,15 @@ static inline void sdhci_led_deactivate(struct sdhci_host *host)
 
 #endif
 
-static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
-			    unsigned long timeout)
+void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
+		     unsigned long timeout)
 {
 	if (sdhci_data_line_cmd(mrq->cmd))
 		mod_timer(&host->data_timer, timeout);
 	else
 		mod_timer(&host->timer, timeout);
 }
+EXPORT_SYMBOL_GPL(sdhci_mod_timer);
 
 static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request *mrq)
 {
@@ -1077,8 +1079,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 		__sdhci_set_timeout(host, cmd);
 }
 
-static void sdhci_initialize_data(struct sdhci_host *host,
-				  struct mmc_data *data)
+void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data)
 {
 	WARN_ON(host->data);
 
@@ -1091,6 +1092,7 @@ static void sdhci_initialize_data(struct sdhci_host *host,
 	host->data_early = 0;
 	host->data->bytes_xfered = 0;
 }
+EXPORT_SYMBOL_GPL(sdhci_initialize_data);
 
 static inline void sdhci_set_block_info(struct sdhci_host *host,
 					struct mmc_data *data)
@@ -1113,12 +1115,8 @@ static inline void sdhci_set_block_info(struct sdhci_host *host,
 	}
 }
 
-static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
+void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data)
 {
-	struct mmc_data *data = cmd->data;
-
-	sdhci_initialize_data(host, data);
-
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
 		struct scatterlist *sg;
 		unsigned int length_mask, offset_mask;
@@ -1203,6 +1201,16 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 
 	sdhci_set_transfer_irqs(host);
+}
+EXPORT_SYMBOL_GPL(sdhci_prepare_dma);
+
+static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	struct mmc_data *data = cmd->data;
+
+	sdhci_initialize_data(host, data);
+
+	sdhci_prepare_dma(host, data);
 
 	sdhci_set_block_info(host, data);
 }
@@ -1521,7 +1529,7 @@ static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
 	WARN_ON(i >= SDHCI_MAX_MRQS);
 }
 
-static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
+void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	if (host->cmd && host->cmd->mrq == mrq)
 		host->cmd = NULL;
@@ -1545,15 +1553,17 @@ static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 	if (!sdhci_has_requests(host))
 		sdhci_led_deactivate(host);
 }
+EXPORT_SYMBOL_GPL(__sdhci_finish_mrq);
 
-static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
+void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	__sdhci_finish_mrq(host, mrq);
 
 	queue_work(host->complete_wq, &host->complete_work);
 }
+EXPORT_SYMBOL_GPL(sdhci_finish_mrq);
 
-static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
+void __sdhci_finish_data_common(struct sdhci_host *host, bool defer_reset)
 {
 	struct mmc_command *data_cmd = host->data_cmd;
 	struct mmc_data *data = host->data;
@@ -1566,7 +1576,9 @@ static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
 	 * conditions.
 	 */
 	if (data->error) {
-		if (!host->cmd || host->cmd == data_cmd)
+		if (defer_reset)
+			host->pending_reset = true;
+		else if (!host->cmd || host->cmd == data_cmd)
 			sdhci_reset_for(host, REQUEST_ERROR);
 		else
 			sdhci_reset_for(host, REQUEST_ERROR_DATA_ONLY);
@@ -1587,6 +1599,14 @@ static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
 		data->bytes_xfered = 0;
 	else
 		data->bytes_xfered = data->blksz * data->blocks;
+}
+EXPORT_SYMBOL_GPL(__sdhci_finish_data_common);
+
+static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
+{
+	struct mmc_data *data = host->data;
+
+	__sdhci_finish_data_common(host, false);
 
 	/*
 	 * Need to send CMD12 if -
@@ -1721,8 +1741,8 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	return true;
 }
 
-static bool sdhci_present_error(struct sdhci_host *host,
-				struct mmc_command *cmd, bool present)
+bool sdhci_present_error(struct sdhci_host *host,
+			 struct mmc_command *cmd, bool present)
 {
 	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
 		cmd->error = -ENOMEDIUM;
@@ -1731,6 +1751,7 @@ static bool sdhci_present_error(struct sdhci_host *host,
 
 	return false;
 }
+EXPORT_SYMBOL_GPL(sdhci_present_error);
 
 static bool sdhci_send_command_retry(struct sdhci_host *host,
 				     struct mmc_command *cmd,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 5f416bc783bd..c636808139d5 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -831,6 +831,14 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
 }
 
 bool sdhci_needs_reset(struct sdhci_host *host, struct mmc_request *mrq);
+bool sdhci_data_line_cmd(struct mmc_command *cmd);
+void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq, unsigned long timeout);
+void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data);
+void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data);
+void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
+void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
+void __sdhci_finish_data_common(struct sdhci_host *host, bool defer_reset);
+bool sdhci_present_error(struct sdhci_host *host, struct mmc_command *cmd, bool present);
 u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		   unsigned int *actual_clock);
 void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
-- 
2.25.1

