Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A75C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Jan 2022 12:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbiARMoR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Jan 2022 07:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbiARMoR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jan 2022 07:44:17 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BECC061574
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jan 2022 04:44:17 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o3so23194774pjs.1
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jan 2022 04:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jHdvJyYLqG4Cn517SGttmcCII1kWlh0ajHYNiJDKCx0=;
        b=U6emVYpXi8uVld16nBGFB1Kc54HHfibYaOU0rOXQiZmMkT6VqT5bYRWdkT2+QaQttG
         cioj29n3rfeh+BsBynlBxPown3dN9M4u2nnBaFMMGGbru+qKmMGQmw8Bn+31u1mbYvCC
         rS4qA/KsnBDY5u+yn7QFDPetPTWUJDJNetVFy0XzGKQZKkHFgjc8bRFLi+DBhqHndmY1
         pH9ztRJLc7CslT9gtnMqvDxFAjxBwkaAXgYUPD4GMfIsVTUOKpRnaGBI2/p2jqWvJZ7r
         XvpQ10tgPDXsxsksFDRhtem4JDrT1aZCfSnf7/poTVos4MMBgCjibKraltifixdcFSCe
         YaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jHdvJyYLqG4Cn517SGttmcCII1kWlh0ajHYNiJDKCx0=;
        b=V+aJe0SF3fVAiDduzfwVxKhFw/aFoY5mcXFaQiUFRp9CodRHk2ODv4CEZjZP3ZdnC6
         KEJImPqRzsKNUvTGt2Ks0Vbn2Q2BzUK8JO9h6L1rt/gHgwta0fwBBgYJMfGupTocIheM
         +YWpEI7rd19YLQDFnpRUlrxghfOVzwAwy9Uty0Nbkxvj4ylrE1lQYzWqE00N0HJtI8pB
         FcnbSZUga+936wCdHPzRon5hf+rGSQlyjYJXPeB4v4t1snnVYFIqJ4ono3DKZdpLsxkp
         6JmpB7PSb+4nQ6qB4qAYBTyKK3Cco3tpoji/HwPHOIrhafR1RKcIsmec6aswsyrKbtC+
         RHag==
X-Gm-Message-State: AOAM531ygXxJgel3kDdZxlhswHm7useKg8j89+EuGvyvXhYto92liCK4
        wpDNBCyEArFYh+lnp08Jsms=
X-Google-Smtp-Source: ABdhPJzc6AGiV4/91oXFw1v0gm8mY3rABRlPcH1r63RlDaXmsBfjCpAFuO15gQ7ii720fbJGsKUe9Q==
X-Received: by 2002:a17:902:a404:b0:148:b897:c658 with SMTP id p4-20020a170902a40400b00148b897c658mr27258771plq.71.1642509856792;
        Tue, 18 Jan 2022 04:44:16 -0800 (PST)
Received: from jason-z170xgaming7.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id n10sm362005pfj.120.2022.01.18.04.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 04:44:16 -0800 (PST)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        otis.wu@genesyslogic.com.tw,
        Jason Lai <jasonlai.genesyslogic@gmail.com>
Subject: [PATCH v2 5/7] mmc: add UHS-II related definitions in headers
Date:   Tue, 18 Jan 2022 20:43:53 +0800
Message-Id: <20220118124355.167552-6-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220118124355.167552-1-jasonlai.genesyslogic@gmail.com>
References: <20220118124355.167552-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jason Lai <jason.lai@genesyslogic.com.tw>

All LINK layer messages, registers and SD-TRAN command packet described in
'Part 1 UHS-II Addendum Ver 1.01' are defined in include/linux/mmc/sd_uhs2.h

drivers/mmc/core/sd_uhs2.h contains exported function prototype.

Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
---
 include/linux/mmc/card.h | 30 ++++++++++++++++++++++++++++-
 include/linux/mmc/core.h |  1 +
 include/linux/mmc/host.h | 41 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 82b07eac1..ee9fbeadb 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -212,7 +212,35 @@ struct sd_ext_reg {
 
 struct sd_uhs2_config {
 	u32			node_id;
-	/* TODO: Extend with more register configs. */
+
+	u32			dap;
+	u32			gap;
+	u32			n_fcu;
+	u32			maxblk_len;
+	u8			n_lanes;
+	u8			dadr_len;
+	u8			app_type;
+	u8			phy_minor_rev;
+	u8			phy_major_rev;
+	u8			can_hibernate;
+	u8			n_lss_sync;
+	u8			n_lss_dir;
+	u8			link_minor_rev;
+	u8			link_major_rev;
+	u8			dev_type;
+	u8			n_data_gap;
+
+	u32			n_fcu_set;
+	u32			maxblk_len_set;
+	u8			n_lanes_set;
+	u8			speed_range_set;
+	u8			n_lss_sync_set;
+	u8			n_lss_dir_set;
+	u8			n_data_gap_set;
+	u8			pwrctrl_mode_set;
+	u8			max_retry_set;
+
+	u8			cfg_complete;
 };
 
 struct sdio_cccr {
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index ab19245e9..c85d5aeb7 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -2,6 +2,7 @@
 /*
  *  linux/include/linux/mmc/core.h
  */
+
 #ifndef LINUX_MMC_CORE_H
 #define LINUX_MMC_CORE_H
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 69f8c8a8f..640c4bc81 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -96,7 +96,37 @@ struct mmc_clk_phase_map {
 };
 
 struct sd_uhs2_caps {
-	/* TODO: Add UHS-II capabilities for the host. */
+	int			flags;
+#define MMC_UHS2_SUPPORT	(1 << 0)
+#define MMC_UHS2_INITIALIZED	(1 << 1)
+#define MMC_UHS2_2L_HD		(1 << 2)
+#define MMC_UHS2_APP_CMD	(1 << 3)
+#define MMC_UHS2_SPEED_B	(1 << 4)
+#define MMC_SUPPORT_ADMA3	(1 << 5)
+
+	u32	dap;
+	u32	gap;
+	u32	maxblk_len;
+	u32	n_fcu;
+	u8	n_lanes;
+	u8	addr64;
+	u8	card_type;
+	u8	phy_rev;
+	u8	speed_range;
+	u8	can_hibernate;
+	u8	n_lss_sync;
+	u8	n_lss_dir;
+	u8	link_rev;
+	u8	host_type;
+	u8	n_data_gap;
+
+	u32	maxblk_len_set;
+	u32	n_fcu_set;
+	u8	n_lanes_set;
+	u8	n_lss_sync_set;
+	u8	n_lss_dir_set;
+	u8	n_data_gap_set;
+	u8	max_retry_set;
 };
 
 struct mmc_host;
@@ -145,7 +175,6 @@ struct mmc_host_ops {
 	 */
 	int	(*uhs2_set_ios)(struct mmc_host *host, struct mmc_ios *ios);
 
-
 	/*
 	 * Return values for the get_ro callback should be:
 	 *   0 for a read/write card
@@ -210,6 +239,14 @@ struct mmc_host_ops {
 
 	/* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP. */
 	int	(*init_sd_express)(struct mmc_host *host, struct mmc_ios *ios);
+
+	/* UHS2 interfaces */
+	/*
+	 * Every host controller can assign its own actions to set up their
+	 * controller.
+	 */
+	int	(*uhs2_host_operation)(struct mmc_host *host,
+				       enum uhs2_action act);
 };
 
 struct mmc_cqe_ops {
-- 
2.34.0

