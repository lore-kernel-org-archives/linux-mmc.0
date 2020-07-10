Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F727C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29B272076A
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mStmS5OF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgGJLLc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJLLc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jul 2020 07:11:32 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEC0C08C5CE;
        Fri, 10 Jul 2020 04:11:32 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k27so2398071pgm.2;
        Fri, 10 Jul 2020 04:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hc0v8G3i487Ys5ZeJsDG4atE3X7Sxu4cwRpY1JcVqQw=;
        b=mStmS5OFyikPwV/iNnNUD8mZkeHhNxOpAFwn0mK2GxARssT4NT1EFEQfeP4Y5D/Ux7
         Hn3a+v7gK7IcF3LNAEIpvmqiYuyDaZD6vjXxHlH6ohW/GO9/CtnB9PgFg6Rfav0XvQpC
         JZDtr9OZOungHrdyivKVn1JzQWmeUUjSL/OpgPHv6lk/LJT7pBapSG06VgUWyt/iHhkl
         Q7WLeg7LCKiS3xijxcJgoWihuKpaM9NLW4VxX7RNPq4Gw0uod0Tk2RQCVLkqTFfN/smz
         q+3nXWTYotUqFlBZ7nyfcGsxNbAP/u31273Sx4RUWkjwJ/T35QRJSWZD0Ad5O7+zy61E
         Qmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hc0v8G3i487Ys5ZeJsDG4atE3X7Sxu4cwRpY1JcVqQw=;
        b=srr9cCDZhMD1i82qcrmC1gp0+Yg506WVfDQJ/injrYTK1ajZhY8W09Qg6jwlMeCRbO
         G4j1yT7Nvw7BiQo7C4PKEd6TS6mcTXFaQDDijZmdqWFIkN93E+jOidfE+PIKYfFUXwqY
         mytFqd8jbeFyF01CIFOz7oMTe1hpYJ28UnVo3Z/O8okSeQU9V/7t4CCV/7gCnStoAtuC
         +8f+VP2K9ieqscZ7Mr3fwdn9+I2igSloWqUtyr8AeUnXMBFBl2mb833UqtJ+phRsgga5
         AIaNzN3Rip0zk5YODEJMUWn98lTNyC1ZKBjnPRMZgdoZvhW2W2sa+ctdRmCdmbzuwCSw
         hOiw==
X-Gm-Message-State: AOAM5331sJa1ECwBRmc+ZRpNBJdN3vyduR5z86K6DureinoSRERXDViD
        l8oo9xPc112nLiGppyApNMIIuNTn
X-Google-Smtp-Source: ABdhPJxfvNnpYGcvdrC8pfXFBjVoF3hfv0P7R5oPXnVmvum3BhU7en/mFrhuGdSpbEpiqeTsGfxeZw==
X-Received: by 2002:a63:e018:: with SMTP id e24mr34282236pgh.175.1594379491736;
        Fri, 10 Jul 2020 04:11:31 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id i63sm5602434pfc.22.2020.07.10.04.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:11:31 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH V3 16/21] mmc: sdhci: UHS-II support, export helper functions to a module
Date:   Fri, 10 Jul 2020 19:12:15 +0800
Message-Id: <20200710111215.29779-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

Those exported functions will be utilized in the following commit
to implement UHS-II support as a kernel module.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci.c | 14 ++++++++------
 drivers/mmc/host/sdhci.h | 10 ++++++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ca3d4a506e01..5d84e61f6ad9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -57,8 +57,6 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_ops);
 static unsigned int debug_quirks = 0;
 static unsigned int debug_quirks2;
 
-static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
-
 static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
 
 void sdhci_dumpregs(struct sdhci_host *host)
@@ -225,13 +223,14 @@ static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
 	pm_runtime_get_noresume(host->mmc->parent);
 }
 
-static void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
+void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
 {
 	if (!host->bus_on)
 		return;
 	host->bus_on = false;
 	pm_runtime_put_noidle(host->mmc->parent);
 }
+EXPORT_SYMBOL_GPL(sdhci_runtime_pm_bus_off);
 
 void sdhci_reset(struct sdhci_host *host, u8 mask)
 {
@@ -1560,12 +1559,13 @@ static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 		sdhci_led_deactivate(host);
 }
 
-static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
+void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	__sdhci_finish_mrq(host, mrq);
 
 	queue_work(host->complete_wq, &host->complete_work);
 }
+EXPORT_SYMBOL_GPL(sdhci_finish_mrq);
 
 static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
 {
@@ -1644,10 +1644,11 @@ static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
 	}
 }
 
-static void sdhci_finish_data(struct sdhci_host *host)
+void sdhci_finish_data(struct sdhci_host *host)
 {
 	__sdhci_finish_data(host, false);
 }
+EXPORT_SYMBOL_GPL(sdhci_finish_data);
 
 static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 {
@@ -2991,7 +2992,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 }
 EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
 
-static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
+void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 {
 	/* Host Controller v3.00 defines preset value registers */
 	if (host->version < SDHCI_SPEC_300)
@@ -3019,6 +3020,7 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 		host->preset_enabled = enable;
 	}
 }
+EXPORT_SYMBOL_GPL(sdhci_enable_preset_value);
 
 static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 				int err)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f6732f33f29f..927aaba28932 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -893,4 +893,14 @@ void sdhci_switch_external_dma(struct sdhci_host *host, bool en);
 void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable);
 void __sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 
+/* sdhci_uhs2.c needed */
+void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
+void sdhci_finish_data(struct sdhci_host *host);
+void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
+		     unsigned short vdd, unsigned short vdd2);
+void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
+			   unsigned short vdd, unsigned short vdd2);
+void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
+void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
+
 #endif /* __SDHCI_HW_H */
-- 
2.27.0

