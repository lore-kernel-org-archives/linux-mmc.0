Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54233C433EF
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Dec 2021 10:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352098AbhLCKyr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Dec 2021 05:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351999AbhLCKyq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Dec 2021 05:54:46 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC151C06173E
        for <linux-mmc@vger.kernel.org>; Fri,  3 Dec 2021 02:51:22 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id k4so2622217pgb.8
        for <linux-mmc@vger.kernel.org>; Fri, 03 Dec 2021 02:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IG2whwN84mSqa3Jxn15Bzkw/yuqh3uMIOd87VEE33lM=;
        b=Z3G0rAn2JtZupR5rqbv6BBKAh6u0qwpj+twdT180BbJxabBgSmQPVhSYbnusf2EX7G
         sGN3GSejEKsPUSTke71cLJb0O9OzMVFyWLCv9UCvaYgx8cMta8p14W1GQSunVK3OrujK
         tgU27Gqx0dUChaK7zF06Uab8ZJGoe4fbe9dgOVyU8WknQ+OCR8vSMqqgB2yAzbPr8hDV
         NJbMaRFdUvc5vuXHI0pXmRSQ8knqlTHj78d6vjNFdWqDeBtYyOgx70oFJFOb2IXQRusR
         QHbR1HRyNc9atADSj94hET6gnNLdowLU2LCLDzS/qK8D5pvy2+rD8RxrW4Sa5ogxzMYT
         CfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IG2whwN84mSqa3Jxn15Bzkw/yuqh3uMIOd87VEE33lM=;
        b=fatUv9rHvzGcHgnKQWXnwckvwU5Mum3uJs1kJ1aHMMrZLCUJLjP7o62Yy+MdMINZ/4
         75XyPIahZOA3pbmdM2s2IQv3lBwchAbh23Ui4MYIWmHNZH54gCotKCTJDLUW8nHJgfBq
         Fd4p9523TSo0kQVugy/0oRIoQGjgeKK2U9t/T5EuoAyJVNAUk5/PxnH8czMomBdDswL3
         0Idhzxu2Tz9GYinfnhw6Cqt3v0q8kRSOUvLFdqzUv4gRFzYlpsOeYKFQ63N1al1r3h33
         50rfYOBAtQoW8xwqkHwIw6Ed2u9bEokzVj0dGHx/fq36k6V5hDnNh8VAcFz3xvL5fAsw
         a56w==
X-Gm-Message-State: AOAM5310IsEdfmml54MigeXvF22jvhsXbGhwIx5XQNtmoviWuQIsxM+3
        FNlnq2WW9T6Ol4U75va1xDGfZqVvG3xRsA==
X-Google-Smtp-Source: ABdhPJzYTSWTWZuGkdNKJPYcLwZP2KORMJm9KG2d0tJD/pPTDirkRMxnxSbtE+uITV81proOVO7uVQ==
X-Received: by 2002:a05:6a00:99e:b0:49f:f9e2:c116 with SMTP id u30-20020a056a00099e00b0049ff9e2c116mr18277377pfg.83.1638528682113;
        Fri, 03 Dec 2021 02:51:22 -0800 (PST)
Received: from jason-z170xgaming7.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id x18sm2868699pfh.210.2021.12.03.02.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 02:51:21 -0800 (PST)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        otis.wu@genesyslogic.com.tw, benchuanggli@gmail.com,
        Jason Lai <jasonlai.genesyslogic@gmail.com>
Subject: [PATCH 6/7] mmc: Implement content of UHS-II card initialization functions
Date:   Fri,  3 Dec 2021 18:51:02 +0800
Message-Id: <20211203105103.11306-7-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211203105103.11306-1-jasonlai.genesyslogic@gmail.com>
References: <20211203105103.11306-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jason Lai <jason.lai@genesyslogic.com.tw>

UHS-II card initialization flow is divided into 2 categories: PHY & Card.
Part 1 - PHY Initialization:
         Every host controller may need their own avtivation operation
         to establish LINK between controller and card. So we add a new
         member function(uhs2_detect_init) in struct mmc_host_ops for host
         controller use.
Part 2 - Card Initialization:
         This part can be divided into 6 substeps.
         1. Send UHS-II CCMD DEVICE_INIT to card.
         2. Send UHS-II CCMD ENUMERATE to card.
         3. Send UHS-II Native Read CCMD to obtain capabilities in CFG_REG
            of card.
         4. Host compares capabilities of host controller and  card,
            then write the negotiated values to Setting field in CFG_REG
            of card through UHS-II Native Write CCMD.
         5. Switch host controller's clock to Range B if it is supported
            by both host controller and card.
         6. Execute legacy SD initialization flow.
Part 3 - Provide a function to tranaform legacy SD command packet into
         UHS-II SD-TRAN DCMD packet.

Most of the code added above came from Intel's original patch[1].

[1]
https://patchwork.kernel.org/project/linux-mmc/patch/1419672479-30852-2-
git-send-email-yi.y.sun@intel.com/

Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
---
 drivers/mmc/core/sd_uhs2.c | 831 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 810 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
index 24aa51a6d..d13283d54 100644
--- a/drivers/mmc/core/sd_uhs2.c
+++ b/drivers/mmc/core/sd_uhs2.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2021 Linaro Ltd
  *
  * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ * Author: Jason Lai <jason.lai@genesyslogic.com.tw>
  *
  * Support for SD UHS-II cards
  */
@@ -10,29 +11,31 @@
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
+#include <linux/mmc/sd_uhs2.h>
 
 #include "core.h"
 #include "bus.h"
 #include "sd.h"
 #include "mmc_ops.h"
+#include "sd_uhs2.h"
 
 static const unsigned int sd_uhs2_freqs[] = { 52000000, 26000000 };
 
-static int sd_uhs2_set_ios(struct mmc_host *host)
+static void sd_uhs2_set_ios(struct mmc_host *host)
 {
 	struct mmc_ios *ios = &host->ios;
 
-	return host->ops->uhs2_set_ios(host, ios);
+	host->ops->set_ios(host, ios);
 }
 
-static int sd_uhs2_power_up(struct mmc_host *host)
+static void sd_uhs2_power_up(struct mmc_host *host)
 {
 	host->ios.vdd = fls(host->ocr_avail) - 1;
 	host->ios.clock = host->f_init;
 	host->ios.timing = MMC_TIMING_SD_UHS2;
 	host->ios.power_mode = MMC_POWER_UP;
 
-	return sd_uhs2_set_ios(host);
+	sd_uhs2_set_ios(host);
 }
 
 static void sd_uhs2_power_off(struct mmc_host *host)
@@ -45,6 +48,50 @@ static void sd_uhs2_power_off(struct mmc_host *host)
 	sd_uhs2_set_ios(host);
 }
 
+/**
+ * sd_uhs2_cmd_assemble() - build up UHS-II command packet which is embeded in
+ *                          mmc_command structure
+ * @cmd:	MMC command to executed
+ * @uhs2_cmd:	UHS2 command corresponded to MMC command
+ * @header:	Header field of UHS-II command cxpacket
+ * @arg:	Argument field of UHS-II command packet
+ * @payload:	Payload field of UHS-II command packet
+ * @plen:	Payload length
+ * @resp:	Response buffer is allocated by caller and it is used to keep
+ *              the response of CM-TRAN command. For SD-TRAN command, uhs2_resp
+ *              should be null and SD-TRAN command response should be stored in
+ *              resp of mmc_command.
+ * @resp_len:	Response buffer length
+ *
+ * Different from legacy SD command, there defined several types of packets
+ * in UHS-II, which include CM-TRAN and SD-TRAN. These packets are then
+ * transformed to differential signals and transmitted/received between
+ * transceiver and receiver.
+ *
+ * The UHS-II packet structure(uhs2_cmd) are added in structure mmc_command
+ * and be filled according to the inputed parameters provided by caller.
+ *
+ * For mmc requests, call this function before issuing command to SD card.
+ * Host controller specific request function will send packet in uhs2_cmd
+ * to UHS-II SD card.
+ *
+ */
+static void sd_uhs2_cmd_assemble(struct mmc_command *cmd,
+			      struct uhs2_command *uhs2_cmd,
+			      u16 header, u16 arg,
+			      u32 *payload, u8 plen, u8 *resp, u8 resp_len)
+{
+	uhs2_cmd->header = header;
+	uhs2_cmd->arg = arg;
+	uhs2_cmd->payload = payload;
+	uhs2_cmd->payload_len = plen * sizeof(u32);
+	uhs2_cmd->packet_len = uhs2_cmd->payload_len + 4;
+
+	cmd->uhs2_cmd = uhs2_cmd;
+	cmd->uhs2_resp = resp;
+	cmd->uhs2_resp_len = resp_len;
+}
+
 /*
  * Run the phy initialization sequence, which mainly relies on the UHS-II host
  * to check that we reach the expected electrical state, between the host and
@@ -52,16 +99,98 @@ static void sd_uhs2_power_off(struct mmc_host *host)
  */
 static int sd_uhs2_phy_init(struct mmc_host *host)
 {
-	return 0;
+	int err = 0;
+
+	/*
+	 * Every host controller can assign its own function which is used
+	 * to initialize PHY.
+	 */
+	err = host->ops->uhs2_detect_init(host)
+	if (err) {
+		pr_err("%s: fail to detect UHS2!\n", mmc_hostname(host));
+	}
+
+	return err;
 }
 
 /*
- * Do the early initialization of the card, by sending the device init
-roadcast
+ * Do the early initialization of the card, by sending the device init broadcast
  * command and wait for the process to be completed.
  */
 static int sd_uhs2_dev_init(struct mmc_host *host)
 {
+	struct mmc_command cmd = {0};
+	struct uhs2_command uhs2_cmd = {};
+	u32 cnt;
+	u32 dap, gap, resp_gap;
+	u16 header = 0, arg = 0;
+	u32 payload[1];
+	u8 plen = 1;
+	u8 gd = 0, cf = 1;
+	u8 resp[6] = {0};
+	u8 resp_len = 6;
+	int err;
+
+	dap = host->uhs2_caps.dap;
+	gap = host->uhs2_caps.gap;
+
+	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
+	arg = ((UHS2_DEV_CMD_DEVICE_INIT & 0xFF) << 8) |
+	       UHS2_NATIVE_CMD_WRITE |
+	       UHS2_NATIVE_CMD_PLEN_4B |
+	       (UHS2_DEV_CMD_DEVICE_INIT >> 8);
+
+	/*
+	 * Refer to UHS-II Addendum Version 1.02 section 6.3.1.
+	 * Max. time from DEVICE_INIT CCMD EOP reception on Device
+	 * Rx to its SOP transmission on Device Tx(Tfwd_init_cmd) is
+	 * 1 second.
+	 */
+	cmd.busy_timeout = 1000;
+
+	/*
+	 * Refer to UHS-II Addendum Version 1.02 section 6.2.6.3.
+	 * When the number of the DEVICE_INIT commands is reach to
+	 * 30 tiems, Host shall stop issuing DEVICE_INIT command
+	 * and regard it as an error.
+	 */
+	for (cnt = 0; cnt < 30; cnt++) {
+		payload[0] = ((dap & 0xF) << 12) |
+			     (cf << 11)         |
+			     ((gd & 0xF) << 4)  |
+			     (gap & 0xF);
+
+		sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg,
+				  payload, plen, resp, resp_len);
+
+		err = mmc_wait_for_cmd(host, &cmd, 0);
+
+		if (err) {
+			pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+			       mmc_hostname(host), __func__, err);
+			return -EIO;
+		}
+
+		if (resp[3] != (UHS2_DEV_CMD_DEVICE_INIT & 0xFF)) {
+			pr_err("%s: DEVICE_INIT response is wrong!\n",
+			       mmc_hostname(host));
+			return -EIO;
+		}
+
+		if (resp[5] & 0x8) {
+			host->group_desc = gd;
+			break;
+		}
+		resp_gap = resp[4] & 0x0F;
+		if (gap == resp_gap)
+			gd++;
+	}
+	if (cnt == 30) {
+		pr_err("%s: DEVICE_INIT fail, already 30 times!\n",
+		       mmc_hostname(host));
+		return -EIO;
+	}
+
 	return 0;
 }
 
@@ -72,32 +201,519 @@ static int sd_uhs2_dev_init(struct mmc_host *host)
  */
 static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
 {
+	struct mmc_command cmd = {0};
+	struct uhs2_command uhs2_cmd = {};
+	u16 header = 0, arg = 0;
+	u32 payload[1];
+	u8 plen = 1;
+	u8 id_f = 0xF, id_l = 0x0;
+	u8 resp[8] = {0};
+	u8 resp_len = 8;
+	int err;
+
+	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD;
+	arg = ((UHS2_DEV_CMD_ENUMERATE & 0xFF) << 8) |
+	       UHS2_NATIVE_CMD_WRITE |
+	       UHS2_NATIVE_CMD_PLEN_4B |
+	       (UHS2_DEV_CMD_ENUMERATE >> 8);
+
+	payload[0] = (id_f << 4) | id_l;
+
+	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen,
+			  resp, resp_len);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	if (resp[3] != (UHS2_DEV_CMD_ENUMERATE & 0xFF)) {
+		pr_err("%s: ENUMERATE response is wrong!\n",
+		       mmc_hostname(host));
+		return -EIO;
+	}
+
+	id_f = (resp[4] >> 4) & 0xF;
+	id_l = resp[4] & 0xF;
+	*node_id = id_f;
+
 	return 0;
 }
 
 /*
  * Read the UHS-II configuration registers (CFG_REG) of the card, by sending it
  * commands and by parsing the responses. Store a copy of the relevant data in
- * card->uhs2_config.
+ * host->uhs2_card_prop.
  */
 static int sd_uhs2_config_read(struct mmc_host *host, struct mmc_card *card)
 {
+	struct mmc_command cmd = {0};
+	struct uhs2_command uhs2_cmd = {};
+	u16 header = 0, arg = 0;
+	u32 cap;
+	int err;
+
+	header = UHS2_NATIVE_PACKET |
+		 UHS2_PACKET_TYPE_CCMD |
+		 card->uhs2_config.node_id;
+	arg = ((UHS2_DEV_CONFIG_GEN_CAPS & 0xFF) << 8) |
+	       UHS2_NATIVE_CMD_READ |
+	       UHS2_NATIVE_CMD_PLEN_4B |
+	       (UHS2_DEV_CONFIG_GEN_CAPS >> 8);
+
+	/* There is no payload because per spec, there should be
+	 * no payload field for read CCMD.
+	 * Plen is set in arg. Per spec, plen for read CCMD
+	 * represents the len of read data which is assigned in payload
+	 * of following RES (p136).
+	 */
+	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL, 0);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return err;
+	}
+
+	cap = cmd.resp[0];
+	card->uhs2_config.n_lanes =
+				(cap >> UHS2_DEV_CONFIG_N_LANES_POS) &
+				UHS2_DEV_CONFIG_N_LANES_MASK;
+	card->uhs2_config.dadr_len =
+				(cap >> UHS2_DEV_CONFIG_DADR_POS) &
+				UHS2_DEV_CONFIG_DADR_MASK;
+	card->uhs2_config.app_type =
+				(cap >> UHS2_DEV_CONFIG_APP_POS) &
+				UHS2_DEV_CONFIG_APP_MASK;
+
+	arg = ((UHS2_DEV_CONFIG_PHY_CAPS & 0xFF) << 8) |
+	       UHS2_NATIVE_CMD_READ |
+	       UHS2_NATIVE_CMD_PLEN_8B |
+	      (UHS2_DEV_CONFIG_PHY_CAPS >> 8);
+
+	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL, 0);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	cap = cmd.resp[0];
+	card->uhs2_config.phy_minor_rev =
+				cap & UHS2_DEV_CONFIG_PHY_MINOR_MASK;
+	card->uhs2_config.phy_major_rev =
+				(cap >> UHS2_DEV_CONFIG_PHY_MAJOR_POS) &
+				 UHS2_DEV_CONFIG_PHY_MAJOR_MASK;
+	card->uhs2_config.can_hibernate =
+				(cap >> UHS2_DEV_CONFIG_CAN_HIBER_POS) &
+				 UHS2_DEV_CONFIG_CAN_HIBER_MASK;
+
+	cap = cmd.resp[1];
+	card->uhs2_config.n_lss_sync =
+				cap & UHS2_DEV_CONFIG_N_LSS_SYN_MASK;
+	card->uhs2_config.n_lss_dir =
+				(cap >> UHS2_DEV_CONFIG_N_LSS_DIR_POS) &
+				UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
+	if (card->uhs2_config.n_lss_sync == 0)
+		card->uhs2_config.n_lss_sync = 16 << 2;
+	else
+		card->uhs2_config.n_lss_sync <<= 2;
+
+	if (card->uhs2_config.n_lss_dir == 0)
+		card->uhs2_config.n_lss_dir = 16 << 3;
+	else
+		card->uhs2_config.n_lss_dir <<= 3;
+
+	arg = ((UHS2_DEV_CONFIG_LINK_TRAN_CAPS & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_READ |
+		UHS2_NATIVE_CMD_PLEN_8B |
+		(UHS2_DEV_CONFIG_LINK_TRAN_CAPS >> 8);
+
+	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, NULL, 0, NULL, 0);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	cap = cmd.resp[0];
+	card->uhs2_config.link_minor_rev =
+				cap & UHS2_DEV_CONFIG_LT_MINOR_MASK;
+	card->uhs2_config.link_major_rev =
+				(cap >> UHS2_DEV_CONFIG_LT_MAJOR_POS) &
+				UHS2_DEV_CONFIG_LT_MAJOR_MASK;
+	card->uhs2_config.n_fcu =
+				(cap >> UHS2_DEV_CONFIG_N_FCU_POS) &
+				UHS2_DEV_CONFIG_N_FCU_MASK;
+	card->uhs2_config.dev_type =
+				(cap >>UHS2_DEV_CONFIG_DEV_TYPE_POS) &
+				UHS2_DEV_CONFIG_DEV_TYPE_MASK;
+	card->uhs2_config.maxblk_len =
+				(cap >>UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) &
+				UHS2_DEV_CONFIG_MAX_BLK_LEN_MASK;
+
+	cap = cmd.resp[1];
+	card->uhs2_config.n_data_gap =
+				cap & UHS2_DEV_CONFIG_N_DATA_GAP_MASK;
+	if (card->uhs2_config.n_fcu == 0)
+		card->uhs2_config.n_fcu = 256;
+
 	return 0;
 }
 
-/*
+/**
  * Based on the card's and host's UHS-II capabilities, let's update the
  * configuration of the card and the host. This may also include to move to a
  * greater speed range/mode. Depending on the updated configuration, we may
-eed
- * to do a soft reset of the card via sending it a GO_DORMANT_STATE command.
+ * need to do a soft reset of the card via sending it a GO_DORMANT_STATE
+ * command.
  *
  * In the final step, let's check if the card signals "config completion",
-hich
- * indicates that the card has moved from config state into active state.
+ * which indicates that the card has moved from config state into active state.
  */
 static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
 {
+	struct mmc_command cmd = {0};
+	struct uhs2_command uhs2_cmd = {};
+	u16 header = 0, arg = 0;
+	u32 payload[2];
+	u8 nMinDataGap;
+	u8 plen;
+	u8 try;
+	int err;
+	u8 resp[5] = {0};
+	u8 resp_len = 5;
+
+	header = UHS2_NATIVE_PACKET |
+		 UHS2_PACKET_TYPE_CCMD | card->uhs2_config.node_id;
+	arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
+	       UHS2_NATIVE_CMD_WRITE |
+	       UHS2_NATIVE_CMD_PLEN_8B |
+	       (UHS2_DEV_CONFIG_GEN_SET >> 8);
+
+	if (card->uhs2_config.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD &&
+	    host->uhs2_caps.n_lanes == UHS2_DEV_CONFIG_2L_HD_FD) {
+		/* Support HD */
+		host->flags |= MMC_UHS2_2L_HD;
+		nMinDataGap = 1;
+	} else {
+		/* Only support 2L-FD so far */
+		host->flags &= ~MMC_UHS2_2L_HD;
+		nMinDataGap = 3;
+	}
+
+	/*
+	 * Most UHS-II cards only support FD and 2L-HD mode. Other lane numbers
+	 * defined in UHS-II addendem Ver1.01 are optional.
+	 */
+	host->uhs2_caps.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
+	card->uhs2_config.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
+
+	plen = 2;
+	payload[0] = card->uhs2_config.n_lanes_set <<
+		     UHS2_DEV_CONFIG_N_LANES_POS;
+	payload[1] = 0;
+	payload[0] = cpu_to_be32(payload[0]);
+	payload[1] = cpu_to_be32(payload[1]);
+
+	/*
+	 * There is no payload because per spec, there should be
+	 * no payload field for read CCMD.
+	 * Plen is set in arg. Per spec, plen for read CCMD
+	 * represents the len of read data which is assigned in payload
+	 * of following RES (p136).
+	 */
+	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen,
+			  NULL, 0);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	arg = ((UHS2_DEV_CONFIG_PHY_SET & 0xFF) << 8) |
+	       UHS2_NATIVE_CMD_WRITE |
+	       UHS2_NATIVE_CMD_PLEN_8B |
+	       (UHS2_DEV_CONFIG_PHY_SET >> 8);
+
+	for (try = 0; try < 2; try++) {
+		plen = 2;
+
+		if (host->uhs2_caps.speed_range ==
+			UHS2_DEV_CONFIG_PHY_SET_SPEED_B) {
+			host->flags |= MMC_UHS2_SPEED_B;
+			card->uhs2_config.speed_range_set =
+					UHS2_DEV_CONFIG_PHY_SET_SPEED_B;
+		} else {
+			card->uhs2_config.speed_range_set =
+					UHS2_DEV_CONFIG_PHY_SET_SPEED_A;
+			host->flags &= ~MMC_UHS2_SPEED_B;
+		}
+
+		payload[0] = card->uhs2_config.speed_range_set <<
+					UHS2_DEV_CONFIG_PHY_SET_SPEED_POS;
+
+		card->uhs2_config.n_lss_sync_set =
+			(min(card->uhs2_config.n_lss_sync,
+			     host->uhs2_caps.n_lss_sync) >> 2) &
+			UHS2_DEV_CONFIG_N_LSS_SYN_MASK;
+		host->uhs2_caps.n_lss_sync_set =
+			card->uhs2_config.n_lss_sync_set;
+
+		if (try == 0) {
+			host->uhs2_caps.n_lss_dir_set =
+				(card->uhs2_config.n_lss_dir >> 3) &
+				UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
+			card->uhs2_config.n_lss_dir_set =
+				((host->uhs2_caps.n_lss_dir >> 3) + 1) &
+				UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
+		} else {
+			card->uhs2_config.n_lss_dir_set =
+				(max(card->uhs2_config.n_lss_dir,
+				     host->uhs2_caps.n_lss_dir) >> 3) &
+				UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
+			host->uhs2_caps.n_lss_dir_set =
+				card->uhs2_config.n_lss_dir_set;
+		}
+
+		payload[1] = (card->uhs2_config.n_lss_dir_set <<
+					UHS2_DEV_CONFIG_N_LSS_DIR_POS) |
+			     card->uhs2_config.n_lss_sync_set;
+		payload[0] = cpu_to_be32(payload[0]);
+		payload[1] = cpu_to_be32(payload[1]);
+
+		resp_len = 4;
+		memset(resp, 0, sizeof(resp));
+
+		sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg,
+				  payload, plen, resp, resp_len);
+
+		err = mmc_wait_for_cmd(host, &cmd, 0);
+		if (err) {
+			pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+			       mmc_hostname(host), __func__, err);
+			return -EIO;
+		}
+
+		if (!(resp[2] & 0x80))
+			break;
+	}
+
+	arg = ((UHS2_DEV_CONFIG_LINK_TRAN_SET & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_8B |
+		(UHS2_DEV_CONFIG_LINK_TRAN_SET >> 8);
+
+	plen = 2;
+
+	if (card->uhs2_config.app_type == UHS2_DEV_CONFIG_APP_SD_MEM)
+		card->uhs2_config.maxblk_len_set =
+			UHS2_DEV_CONFIG_LT_SET_MAX_BLK_LEN;
+	else
+		card->uhs2_config.maxblk_len_set =
+			min(card->uhs2_config.maxblk_len,
+			    host->uhs2_caps.maxblk_len);
+	host->uhs2_caps.maxblk_len_set =
+			card->uhs2_config.maxblk_len_set;
+
+	card->uhs2_config.n_fcu_set =
+			min(card->uhs2_config.n_fcu,
+			    host->uhs2_caps.n_fcu);
+	host->uhs2_caps.n_fcu_set = card->uhs2_config.n_fcu_set;
+
+	card->uhs2_config.n_data_gap_set =
+			max(nMinDataGap, card->uhs2_config.n_data_gap);
+	host->uhs2_caps.n_data_gap_set =
+			card->uhs2_config.n_data_gap_set;
+
+	host->uhs2_caps.max_retry_set = 3;
+	card->uhs2_config.max_retry_set = host->uhs2_caps.max_retry_set;
+
+	payload[0] = (card->uhs2_config.maxblk_len_set <<
+					UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) |
+		     (card->uhs2_config.max_retry_set <<
+					UHS2_DEV_CONFIG_LT_SET_MAX_RETRY_POS) |
+		     (card->uhs2_config.n_fcu_set <<
+					UHS2_DEV_CONFIG_N_FCU_POS);
+	payload[1] = card->uhs2_config.n_data_gap_set;
+	payload[0] = cpu_to_be32(payload[0]);
+	payload[1] = cpu_to_be32(payload[1]);
+
+	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen,
+			  NULL, 0);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+			mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
+	       UHS2_NATIVE_CMD_WRITE |
+	       UHS2_NATIVE_CMD_PLEN_8B |
+	       (UHS2_DEV_CONFIG_GEN_SET >> 8);
+
+	plen = 2;
+	payload[0] = 0;
+	payload[1] = UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE;
+	payload[0] = cpu_to_be32(payload[0]);
+	payload[1] = cpu_to_be32(payload[1]);
+
+	resp_len = 5;
+	memset(resp, 0, sizeof(resp));
+	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen,
+			  resp, resp_len);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	/* Set host Config Setting registers */
+	if (!host->ops->uhs2_set_reg ||
+	    host->ops->uhs2_set_reg(host, SET_CONFIG)) {
+		pr_err("%s: %s: UHS2 SET_CONFIG fail!\n",
+			mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int sd_uhs2_go_dormant(struct mmc_host *host, bool hibernate, u32 node_id)
+{
+	struct mmc_command cmd = {0};
+	struct uhs2_command uhs2_cmd = {};
+	u16 header = 0, arg = 0;
+	u32 payload[1];
+	u8 plen = 1;
+	int err;
+
+	/* Disable Normal INT */
+	if (!host->ops->uhs2_set_reg ||
+	    host->ops->uhs2_set_reg(host, DISABLE_INT)) {
+		pr_err("%s: %s: UHS2 DISABLE_INT fail!\n",
+		       mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD | node_id;
+
+	arg = ((UHS2_DEV_CMD_GO_DORMANT_STATE & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_WRITE |
+		UHS2_NATIVE_CMD_PLEN_4B |
+		(UHS2_DEV_CMD_GO_DORMANT_STATE >> 8);
+
+	if (hibernate)
+		payload[0] = UHS2_DEV_CMD_DORMANT_HIBER;
+
+	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, header, arg, payload, plen,
+			  NULL, 0);
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	if (err) {
+		pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	/* Check Dormant State in Present */
+	if (!host->ops->uhs2_set_reg ||
+	    host->ops->uhs2_set_reg(host, CHECK_DORMANT)) {
+		pr_err("%s: %s: UHS2 GO_DORMANT_STATE fail!\n",
+		       mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+	if (host->ops->uhs2_disable_clk)
+		host->ops->uhs2_disable_clk(host);
+
+	return 0;
+}
+
+static int sd_uhs2_change_speed(struct mmc_host *host, u32 node_id)
+{
+	struct mmc_command cmd = {0};
+	struct uhs2_command uhs2_cmd = {};
+	u16 header = 0, arg = 0;
+	int err;
+	int timeout = 100;
+
+	/* Change Speed Range at controller side. */
+	if (!host->ops->uhs2_set_reg ||
+	    host->ops->uhs2_set_reg(host, SET_SPEED_B)) {
+		pr_err("%s: %s: UHS2 SET_SPEED fail!\n",
+		       mmc_hostname(host), __func__);
+		return -EIO;
+	}
+
+	err = sd_uhs2_go_dormant(host, false, node_id);
+	if (err) {
+		pr_err("%s: %s: UHS2 GO_DORMANT_STATE fail, err= 0x%x!\n",
+		       mmc_hostname(host), __func__, err);
+		return -EIO;
+	}
+
+	/* restore sd clock */
+	mmc_delay(5);
+	if (host->ops->uhs2_enable_clk)
+		host->ops->uhs2_enable_clk(host);
+
+	/* Enable Normal INT */
+	if (!host->ops->uhs2_set_reg ||
+	    host->ops->uhs2_set_reg(host, ENABLE_INT)) {
+		pr_err("%s: %s: UHS2 ENABLE_INT fail!\n",
+		       mmc_hostname(host), __func__);
+		return -EIO;
+	}
+	
+	/*
+	 * According to UHS-II Addendum Version 1.01, chapter 6.2.3, wait card
+	 * switch to Active State
+	 */
+	header = UHS2_NATIVE_PACKET | UHS2_PACKET_TYPE_CCMD |
+		 host->card->uhs2_config.node_id;
+	arg = ((UHS2_DEV_CONFIG_GEN_SET & 0xFF) << 8) |
+		UHS2_NATIVE_CMD_READ |
+		UHS2_NATIVE_CMD_PLEN_8B |
+		(UHS2_DEV_CONFIG_GEN_SET >> 8);
+	do {
+		sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd,
+				  header, arg,
+				  NULL, 0,
+				  NULL, 0);
+		err = mmc_wait_for_cmd(host, &cmd, 0);
+		if (err) {
+			pr_err("%s: %s: UHS2 CMD send fail, err= 0x%x!\n",
+			       mmc_hostname(host), __func__, err);
+			return -EIO;
+		}
+
+		if (cmd.resp[1] & UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE)
+			break;
+
+		timeout--;
+		if (timeout == 0) {
+			pr_err("%s: %s: Not switch to Active in 100 ms\n",
+			       mmc_hostname(host->mmc), __func__);
+			return -EIO;
+		}
+
+		mmc_delay(1);
+	} while (1);
+
 	return 0;
 }
 
@@ -108,8 +724,70 @@ static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
  * be set through a legacy CMD6. Note that, the power limit that becomes set,
  * survives a soft reset through the GO_DORMANT_STATE command.
  */
-static int sd_uhs2_legacy_init(struct mmc_host *host, struct mmc_card *card)
+static int sd_uhs2_legacy_init(struct mmc_host *host)
 {
+	int err;
+	u32 ocr, rocr;
+
+	WARN_ON(!host->claimed);
+
+	/* Send CMD0 to reset SD card */
+	mmc_go_idle(host);
+
+	/* Send CMD8 to communicate SD interface operation condition */
+	err = mmc_send_if_cond(host, host->ocr_avail);
+	if (err) {
+		pr_err("%s: %s: SEND_IF_COND fail!\n",
+		       mmc_hostname(host), __func__);
+		return err;
+	}
+
+	/*
+	 * Send host capacity support information and activate card's
+	 * initialization process.
+	 */
+	err = mmc_send_app_op_cond(host, 0, &ocr);
+	if (err) {
+		pr_err("%s: %s: SD_SEND_OP_COND fail!\n",
+		       mmc_hostname(host), __func__);
+		return err;
+	}
+
+	if (host->ocr_avail_sd)
+		host->ocr_avail = host->ocr_avail_sd;
+
+	/*
+	 * Some SD cards claims an out of spec VDD voltage range. Let's treat
+	 * these bits as being in-valid and especially also bit7.
+	 */
+	ocr &= ~0x7FFF;
+	rocr = mmc_select_voltage(host, ocr);
+
+	/*
+	 * Some cards have zero value of rocr in UHS-II mode. Assign host's
+	 * ocr value to rocr.
+	 */
+	if (!rocr) {
+		if (host->ocr_avail) {
+			rocr = host->ocr_avail;
+		} else {
+			pr_err("%s: %s: there is no valid OCR.\n",
+			       mmc_hostname(host), __func__);
+			return -EINVAL;
+		}
+	}
+
+	/*
+	 * Get CID, send relative address, get CSD are the same as legacy
+	 * sd, call mmc_sd_init_card() in sd.c directly
+	 */
+	err = mmc_sd_init_card(host, rocr, NULL);
+	if (err) {
+		pr_err("%s: %s: mmc_sd_init_card() fail!\n",
+		       mmc_hostname(host), __func__);
+		return err;
+	}
+
 	return 0;
 }
 
@@ -124,12 +802,16 @@ static int sd_uhs2_init_card(struct mmc_host *host)
 	int err;
 
 	err = sd_uhs2_dev_init(host);
-	if (err)
+	if (err) {
+		pr_err("%s: UHS2 DEVICE_INIT fail!\n", mmc_hostname(host));
 		return err;
+	}
 
 	err = sd_uhs2_enum(host, &node_id);
-	if (err)
+	if (err) {
+		pr_err("%s: UHS2 ENUMERATE fail!\n", mmc_hostname(host));
 		return err;
+	}
 
 	card = mmc_alloc_card(host, &sd_type);
 	if (IS_ERR(card))
@@ -142,15 +824,26 @@ static int sd_uhs2_init_card(struct mmc_host *host)
 	if (err)
 		goto err;
 
+	/* Change to Speed Range B if it is supported */
+	if (host->flags & MMC_UHS2_SPEED_B) {
+		err = sd_uhs2_change_speed(host, node_id);
+		if (err) {
+			pr_err("%s: %s: UHS2 sd_uhs2_change_speed() fail!\n",
+				mmc_hostname(host), __func__);
+			return err;
+		}
+	}
+
 	err = sd_uhs2_config_write(host, card);
 	if (err)
 		goto err;
 
-	err = sd_uhs2_legacy_init(host, card);
+	host->card = card;
+
+	err = sd_uhs2_legacy_init(host);
 	if (err)
 		goto err;
 
-	host->card = card;
 	return 0;
 
 err:
@@ -217,6 +910,78 @@ static int sd_uhs2_hw_reset(struct mmc_host *host)
 	return 0;
 }
 
+/*
+ * sd_uhs2_prepare_cmd - prepare for SD command packet
+ * @host:	MMC host
+ * @mrq:	MMC request
+ *
+ * Initialize and fill in a header and a payload of SD command packet.
+ * The caller should allocate uhs2_command in host->cmd->uhs2_cmd in
+ * advance.
+ *
+ * Return:	0 on success, non-zero error on failure
+ */
+int sd_uhs2_prepare_cmd(struct mmc_host *host, struct mmc_request *mrq)
+{
+	struct mmc_command *cmd;
+	struct uhs2_command *uhs2_cmd;
+	u16 header = 0, arg = 0;
+	u32 *payload;
+	u8 plen = 0;
+
+	cmd = mrq->cmd;
+	header = host->card->uhs2_config.node_id;
+	if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC)
+		header |= UHS2_PACKET_TYPE_DCMD;
+	else
+		header |= UHS2_PACKET_TYPE_CCMD;
+
+	arg = cmd->opcode << UHS2_SD_CMD_INDEX_POS;
+	if (host->flags & MMC_UHS2_APP_CMD) {
+		arg |= UHS2_SD_CMD_APP;
+		host->flags &= ~MMC_UHS2_APP_CMD;
+	}
+
+	uhs2_cmd = cmd->uhs2_cmd;
+	payload = uhs2_cmd->payload;
+	plen = 2; /* at the maximum */
+
+	if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC &&
+	    !cmd->uhs2_tmode0_flag) {
+		if (host->flags & MMC_UHS2_2L_HD)
+			arg |= UHS2_DCMD_2L_HD_MODE;
+
+		arg |= UHS2_DCMD_LM_TLEN_EXIST;
+
+		if (cmd->data->blocks == 1 &&
+		    cmd->data->blksz != 512 &&
+		    cmd->opcode != MMC_READ_SINGLE_BLOCK &&
+		    cmd->opcode != MMC_WRITE_BLOCK) {
+			arg |= UHS2_DCMD_TLUM_BYTE_MODE;
+			payload[1] = cpu_to_be32(cmd->data->blksz);
+		} else {
+			payload[1] = cpu_to_be32(cmd->data->blocks);
+		}
+
+		if (cmd->opcode == SD_IO_RW_EXTENDED) {
+			arg &= ~(UHS2_DCMD_LM_TLEN_EXIST |
+				UHS2_DCMD_TLUM_BYTE_MODE |
+				UHS2_NATIVE_DCMD_DAM_IO);
+			payload[1] = 0;
+			plen = 1;
+		}
+	} else {
+		plen = 1;
+	}
+
+	payload[0] = cpu_to_be32(cmd->arg);
+
+	sd_uhs2_cmd_assemble(cmd, uhs2_cmd, header, arg, payload, plen, NULL, 0);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sd_uhs2_prepare_cmd);
+
 static const struct mmc_bus_ops sd_uhs2_ops = {
 	.remove = sd_uhs2_remove,
 	.alive = sd_uhs2_alive,
@@ -254,18 +1019,34 @@ static int sd_uhs2_attach(struct mmc_host *host)
 		goto remove_card;
 
 	mmc_claim_host(host);
+
+	if (host->ops->uhs2_post_attach_sd)
+		host->ops->uhs2_post_attach_sd(host);
+
 	return 0;
 
 remove_card:
-	mmc_remove_card(host->card);
-	host->card = NULL;
+	sd_uhs2_remove(host);
 	mmc_claim_host(host);
-	mmc_detach_bus(host);
+
 err:
+	mmc_detach_bus(host);
 	sd_uhs2_power_off(host);
+	if (host->flags & MMC_UHS2_INITIALIZED)
+		host->flags &= ~MMC_UHS2_INITIALIZED;
+	host->flags &= ~MMC_UHS2_SUPPORT;
 	return err;
 }
 
+/**
+ * mmc_attach_sd_uhs2 - select UHS2 interface
+ * @host: MMC host
+ *
+ * Try to select UHS2 interface and initialize the bus for a given
+ * frequency, @freq.
+ *
+ * Return:	0 on success, non-zero error on failure
+ */
 int mmc_attach_sd_uhs2(struct mmc_host *host)
 {
 	int i, err = 0;
@@ -276,6 +1057,8 @@ int mmc_attach_sd_uhs2(struct mmc_host *host)
 	/* Turn off the legacy SD interface before trying with UHS-II. */
 	mmc_power_off(host);
 
+	host->flags |= MMC_UHS2_SUPPORT;
+
 	/*
 	 * Start UHS-II initialization at 52MHz and possibly make a retry at
 	 * 26MHz according to the spec. It's required that the host driver
@@ -283,9 +1066,15 @@ int mmc_attach_sd_uhs2(struct mmc_host *host)
 	 */
 	for (i = 0; i < ARRAY_SIZE(sd_uhs2_freqs); i++) {
 		host->f_init = sd_uhs2_freqs[i];
+		pr_info("%s: %s: trying to init UHS-II card at %u Hz\n",
+			 mmc_hostname(host), __func__, host->f_init);
+
 		err = sd_uhs2_attach(host);
 		if (!err)
 			break;
+		else
+			pr_err("%s: %s: init card at %u Hz failed\n",
+			       mmc_hostname(host), __func__, host->f_init);
 	}
 
 	return err;
-- 
2.34.0

