Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3165D1684B0;
	Fri,  1 Nov 2024 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457871; cv=none; b=R5i+RHDCh00jy63unVv8o/BKJWoDPaLfoniiKi8hGY/J6ImmFZMEheTOr7xx2CntCLByxkhX9SRfkpPQrhyMrinK909h3PjvhXp3jUCj1mjvqN8LsDQBVDyzFtsddZA1Y/NKvFgIXJnOv1QIsPYaR9lFpm9/DtTZc+7EOJKpPqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457871; c=relaxed/simple;
	bh=ZKiY1iORZWlioL8es6lHdLAYu7osTFVrFn3YzniXUP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kwm5HK7pyJXpJ194alf5zBB717sR6RB+7o3ybYfG2SrxM8IZgoGbgr00gfQ+CFcsAebNUuX3rZYkSCumAIoPknJCo99/BrEHgYVWGf9e7lOxMenqDwrFfwtaGsRaDpPXHCMJjWXqL8fAs31NHDTgAya4FA2h0HlpEUkAe/C10E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nh7Y+TGm; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nh7Y+TGm"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-720d14c8dbfso370955b3a.0;
        Fri, 01 Nov 2024 03:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730457866; x=1731062666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkQmDLCBRQEgdazUaqvyI+7H9NQxo7XslPNy3pnDta8=;
        b=nh7Y+TGmwcqpfLALZFVchMijeDQ6wCCASsO2lLnxxYeQ+5IgquPxucqUqI4X876gR3
         /EPqMEte/bQI2OXHmpHTVxeJyTDmFie8WRM+XEoxdB5JjFrUftOQNyQC9j+xHdtvWyK5
         lvFYV2IS0jRbfYGxCQGLBbbabsBLuobu+heEFbDvSpFLoZLZO2Sih/lGA/TJMGIEnYO5
         v2iPRPiVPX4ZNn5eNsKnr5Umr8duqq/nFQnjICYdeocPVUAQ1ApgAk2SdTOFm9WaH2gU
         sDIGE9m20kS1xhVc2XY/ScETNhtkeSH80jBD/m4fIGJQVUtDqQX3kJb0b6czYm8mEIYz
         NHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730457866; x=1731062666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkQmDLCBRQEgdazUaqvyI+7H9NQxo7XslPNy3pnDta8=;
        b=iX5M9oB0AR7ZHuYjF2zpr9OhMVWyZQ/83FLg+v7sFRSX7oOnUzfQHsAWH/9AW8eKsJ
         o1UN3zdW7x4IuEWo166IzxNeJg8tm4sfNs0c058xZmamcbse4kyKrK8CZNhPkac8bs4h
         sGsJzfQpTI6RGpTxZKPP7JrNO5ZRSWxdmRhrDiFYMOHUl45cuJKuJhyPCJB3Qebeouck
         /oL/6u7IdT+ur2JWVJXKlbCVZRsUaxARs8p4hCfJKp7TEwKYWUWA+uACA1j9Pti/8s6c
         +ZyzryqtpMJ5ZHt0smS7NyaESeXNlBpDJsz8vb2Hokf1GE/m8dttZA04i6TGIcRae8nD
         BMPw==
X-Forwarded-Encrypted: i=1; AJvYcCV1oahIs0inKF92p/xuXzm22BElW9BhvqhqDMJ09Hqq2DTSifPHw45AXsxBUbJwcrpl6mxciBqszmCcV2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8dz6T7SPPYWdbo6zjNrkPOFkhgXn28wC5Ty2zTngaYc8VPiar
	hcWLOv385t2CKgocjur6RlQDZG2klqL9LniP83GHvPDhMsJfSL3Z
X-Google-Smtp-Source: AGHT+IG3RsV6sa4NM7CAIihTVRijpKa1cwBMGuQh5KbbPYF2iRA63roXtnvfsp1r/U+bgLDArkFTSA==
X-Received: by 2002:a05:6a00:3e22:b0:71e:65ac:33aa with SMTP id d2e1a72fcca58-720b9ded7cbmr8291562b3a.28.1730457866216;
        Fri, 01 Nov 2024 03:44:26 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:469:ce01:3140:909e:43aa:4faf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2ebf38sm2494681b3a.171.2024.11.01.03.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 03:44:25 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	Victor Shih <victorshihgli@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V1] mmc: sd_uhs2: correction of incorrect type in assignment
Date: Fri,  1 Nov 2024 18:44:16 +0800
Message-Id: <20241101104416.4954-2-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241101104416.4954-1-victorshihgli@gmail.com>
References: <20241101104416.4954-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

There is a type issue in assignment in the sd_uhs2_dev_init(),
sd_uhs2_enum() and sd_uhs2_config_write() that will generate
a warnin when building the kernel.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410260423.15jvE6qc-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202410261827.7h8YK8u2-lkp@intel.com/
Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/core/sd_uhs2.c | 56 ++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/core/sd_uhs2.c b/drivers/mmc/core/sd_uhs2.c
index ddd2291ad7c4..0611db848c23 100644
--- a/drivers/mmc/core/sd_uhs2.c
+++ b/drivers/mmc/core/sd_uhs2.c
@@ -144,6 +144,7 @@ static int sd_uhs2_dev_init(struct mmc_host *host)
 	struct uhs2_command uhs2_cmd = {};
 	u32 cnt;
 	u32 dap, gap, resp_gap;
+	u32 payload0;
 	u8 gd = 0;
 	int err;
 
@@ -180,10 +181,11 @@ static int sd_uhs2_dev_init(struct mmc_host *host)
 	 * Let's retry the DEVICE_INIT command no more than 30 times.
 	 */
 	for (cnt = 0; cnt < 30; cnt++) {
-		uhs2_cmd.payload[0] = ((dap & 0xF) << 12) |
-				       UHS2_DEV_INIT_COMPLETE_FLAG |
-				       ((gd & 0xF) << 4) |
-				       (gap & 0xF);
+		payload0 = ((dap & 0xF) << 12) |
+			    UHS2_DEV_INIT_COMPLETE_FLAG |
+			    ((gd & 0xF) << 4) |
+			    (gap & 0xF);
+		uhs2_cmd.payload[0] = payload0;
 
 		sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, UHS2_DEV_INIT_PAYLOAD_LEN,
 				     UHS2_DEV_INIT_RESP_LEN);
@@ -229,6 +231,7 @@ static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
 {
 	struct mmc_command cmd = {0};
 	struct uhs2_command uhs2_cmd = {};
+	u32 payload0;
 	u8 id_f = 0xF, id_l = 0x0;
 	int err;
 
@@ -247,8 +250,8 @@ static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
 			UHS2_NATIVE_CMD_PLEN_4B |
 			(UHS2_DEV_CMD_ENUMERATE >> 8);
 
-	uhs2_cmd.payload[0] = (id_f << 4) | id_l;
-	uhs2_cmd.payload[0] = cpu_to_be32(uhs2_cmd.payload[0]);
+	payload0 = (id_f << 4) | id_l;
+	uhs2_cmd.payload[0] = cpu_to_be32(payload0);
 
 	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, UHS2_DEV_ENUM_PAYLOAD_LEN, UHS2_DEV_ENUM_RESP_LEN);
 
@@ -469,6 +472,7 @@ static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
 {
 	struct mmc_command cmd = {0};
 	struct uhs2_command uhs2_cmd = {};
+	u32 payload0, payload1;
 	u8 nMinDataGap;
 	int err;
 
@@ -491,10 +495,10 @@ static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
 	host->uhs2_caps.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
 	card->uhs2_config.n_lanes_set = UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD;
 
-	uhs2_cmd.payload[0] = card->uhs2_config.n_lanes_set << UHS2_DEV_CONFIG_N_LANES_POS;
-	uhs2_cmd.payload[1] = 0;
-	uhs2_cmd.payload[0] = cpu_to_be32(uhs2_cmd.payload[0]);
-	uhs2_cmd.payload[1] = cpu_to_be32(uhs2_cmd.payload[1]);
+	payload0 = card->uhs2_config.n_lanes_set << UHS2_DEV_CONFIG_N_LANES_POS;
+	payload1 = 0;
+	uhs2_cmd.payload[0] = cpu_to_be32(payload0);
+	uhs2_cmd.payload[1] = cpu_to_be32(payload1);
 
 	/*
 	 * There is no payload because per spec, there should be
@@ -549,8 +553,7 @@ static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
 		card->uhs2_config.speed_range_set = UHS2_DEV_CONFIG_PHY_SET_SPEED_A;
 	}
 
-	uhs2_cmd.payload[0] =
-			card->uhs2_config.speed_range_set << UHS2_DEV_CONFIG_PHY_SET_SPEED_POS;
+	payload0 = card->uhs2_config.speed_range_set << UHS2_DEV_CONFIG_PHY_SET_SPEED_POS;
 
 	card->uhs2_config.n_lss_sync_set = (max(card->uhs2_config.n_lss_sync,
 						host->uhs2_caps.n_lss_sync) >> 2) &
@@ -562,10 +565,10 @@ static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
 					  UHS2_DEV_CONFIG_N_LSS_DIR_MASK;
 	host->uhs2_caps.n_lss_dir_set = card->uhs2_config.n_lss_dir_set;
 
-	uhs2_cmd.payload[1] = (card->uhs2_config.n_lss_dir_set << UHS2_DEV_CONFIG_N_LSS_DIR_POS) |
-			      card->uhs2_config.n_lss_sync_set;
-	uhs2_cmd.payload[0] = cpu_to_be32(uhs2_cmd.payload[0]);
-	uhs2_cmd.payload[1] = cpu_to_be32(uhs2_cmd.payload[1]);
+	payload1 = (card->uhs2_config.n_lss_dir_set << UHS2_DEV_CONFIG_N_LSS_DIR_POS) |
+		   card->uhs2_config.n_lss_sync_set;
+	uhs2_cmd.payload[0] = cpu_to_be32(payload0);
+	uhs2_cmd.payload[1] = cpu_to_be32(payload1);
 
 	memset(uhs2_cmd.uhs2_resp, 0, sizeof(uhs2_cmd.uhs2_resp));
 
@@ -612,13 +615,12 @@ static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
 	host->uhs2_caps.max_retry_set = 3;
 	card->uhs2_config.max_retry_set = host->uhs2_caps.max_retry_set;
 
-	uhs2_cmd.payload[0] =
-			(card->uhs2_config.maxblk_len_set << UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) |
-			(card->uhs2_config.max_retry_set << UHS2_DEV_CONFIG_LT_SET_MAX_RETRY_POS) |
-			(card->uhs2_config.n_fcu_set << UHS2_DEV_CONFIG_N_FCU_POS);
-	uhs2_cmd.payload[1] = card->uhs2_config.n_data_gap_set;
-	uhs2_cmd.payload[0] = cpu_to_be32(uhs2_cmd.payload[0]);
-	uhs2_cmd.payload[1] = cpu_to_be32(uhs2_cmd.payload[1]);
+	payload0 = (card->uhs2_config.maxblk_len_set << UHS2_DEV_CONFIG_MAX_BLK_LEN_POS) |
+		   (card->uhs2_config.max_retry_set << UHS2_DEV_CONFIG_LT_SET_MAX_RETRY_POS) |
+		   (card->uhs2_config.n_fcu_set << UHS2_DEV_CONFIG_N_FCU_POS);
+	payload1 = card->uhs2_config.n_data_gap_set;
+	uhs2_cmd.payload[0] = cpu_to_be32(payload0);
+	uhs2_cmd.payload[1] = cpu_to_be32(payload1);
 
 	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, UHS2_CFG_WRITE_PAYLOAD_LEN, 0);
 
@@ -645,10 +647,10 @@ static int sd_uhs2_config_write(struct mmc_host *host, struct mmc_card *card)
 			UHS2_NATIVE_CMD_PLEN_8B |
 			(UHS2_DEV_CONFIG_GEN_SET >> 8);
 
-	uhs2_cmd.payload[0] = 0;
-	uhs2_cmd.payload[1] = UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE;
-	uhs2_cmd.payload[0] = cpu_to_be32(uhs2_cmd.payload[0]);
-	uhs2_cmd.payload[1] = cpu_to_be32(uhs2_cmd.payload[1]);
+	payload0 = 0;
+	payload1 = UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE;
+	uhs2_cmd.payload[0] = cpu_to_be32(payload0);
+	uhs2_cmd.payload[1] = cpu_to_be32(payload1);
 
 	memset(uhs2_cmd.uhs2_resp, 0, sizeof(uhs2_cmd.uhs2_resp));
 	sd_uhs2_cmd_assemble(&cmd, &uhs2_cmd, UHS2_CFG_WRITE_PAYLOAD_LEN,
-- 
2.25.1

