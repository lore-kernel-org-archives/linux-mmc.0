Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EB7C6377D
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9D1608FC
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhGVDWA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhGVDVo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:21:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A485C061575;
        Wed, 21 Jul 2021 21:02:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gx2so4343514pjb.5;
        Wed, 21 Jul 2021 21:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p64ymEfbWIOXlBU2XpyW8YH+kA6dtacSu0XJepOqP6o=;
        b=o36SZHRyhDW8cRhM8Kb/a2tz61RRancNXporAGJjhwLEnOvRF/4dYJZZyE8KoT4qrI
         BkDM2eT+QOXHswKseFyID6tPjcDhHFEOogh6VBRHaj63Xg/5H5oQu8F47C/9nKaqE3Lm
         bXfqz2TlEp/JHOYHqLCDTqxWY5iMDeo4cgJPGXjI45Q/9lO7yHm9LuE/yLKYf/TcDbU4
         Kc3ePo1lUgmjnI5itPw9Je2ipZ1agayVH1PR4mCcXxibP/mS5ysf3A/UcyBgsq7OgY61
         CqtmylDwaQCGBbhzXxEXIOqxpKB04zb5XJjvzn4Z96vReDbi5kJmL0loPextW4nup9w8
         5KQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p64ymEfbWIOXlBU2XpyW8YH+kA6dtacSu0XJepOqP6o=;
        b=bpPFjq33jJQgLHlmUPJA+rF/jtE3GnQzJQdO9XGJDZbdJtFjqa9xAM9iPzZAVCMWj9
         HYzMUIUPtClOwvDndmaScqjWJBYJMcuRs+g+hx61Y3Tppgnp0Vh7MSlLsNhvGe+b894S
         VMmwpoA6akzE6a9xK3eceMF8MC7dFeoRKp1klUkx7CuT+Ra8IB+P3+Wc+EcjzRIjjMOg
         GWvRCrejoyDLEQtekIBPA/KX7bHo+d0sGmfOuu/1bYrjIFhTz62I2+EVgdtouofg4Fo+
         1EAHTHUs41UZLRDoPNnA9IbB0bPilqP5ulLu8GaiAxury9pXrTMsxyYCUc8leSUyyF9c
         TjhQ==
X-Gm-Message-State: AOAM533UwrjkTPstc9l/dSsddmpM1b1VuMR3RwyuMg+1qCbhN3k71WXZ
        fItTpBURY8EOk8RtTX9cfaA=
X-Google-Smtp-Source: ABdhPJysyTXxFH//02lY03MLSMoI5M1YP/Pc54A3QNv3ZGjmC0Sja2Gc9rjf/cgboqftYxDM5yeXug==
X-Received: by 2002:a62:3344:0:b029:25e:a0a8:1c51 with SMTP id z65-20020a6233440000b029025ea0a81c51mr39851727pfz.58.1626926539031;
        Wed, 21 Jul 2021 21:02:19 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:02:18 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 14/29] mmc: sdhci-uhs2: skip signal_voltage_switch()
Date:   Thu, 22 Jul 2021 12:01:09 +0800
Message-Id: <20210722040124.7573-14-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For UHS2, the signal voltage is supplied by vdd2 which is already 1.8v,
so no voltage switch required.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci-uhs2.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 2bf78cc4e9ed..1eca89359351 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -178,6 +178,29 @@ void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);

+/*****************************************************************************\
+ *                                                                           *
+ * MMC callbacks                                                             *
+ *                                                                           *
+\*****************************************************************************/
+
+static int sdhci_uhs2_start_signal_voltage_switch(struct mmc_host *mmc,
+						  struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	/*
+	 * For UHS2, the signal voltage is supplied by vdd2 which is
+	 * already 1.8v so no voltage switch required.
+	 */
+        if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
+             host->version >= SDHCI_SPEC_400 &&
+             host->mmc->flags & MMC_UHS2_SUPPORT)
+                return 0;
+
+	return sdhci_start_signal_voltage_switch(mmc, ios);
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
@@ -186,6 +209,9 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);

 static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 {
+	host->mmc_host_ops.start_signal_voltage_switch =
+		sdhci_uhs2_start_signal_voltage_switch;
+
 	return 0;
 }

--
2.32.0

