Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858DCC64E7C
	for <linux-mmc@archiver.kernel.org>; Sun, 29 Nov 2020 20:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C46320757
	for <linux-mmc@archiver.kernel.org>; Sun, 29 Nov 2020 20:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iq6NmnY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgK2UcU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 29 Nov 2020 15:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgK2UcU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Nov 2020 15:32:20 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12ABC0613D2;
        Sun, 29 Nov 2020 12:31:33 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so12562321wrb.9;
        Sun, 29 Nov 2020 12:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a+61rl8Elaa09l9GcyZ+z+uAZtLyVMaEf7GEyD6Ddls=;
        b=Iq6NmnY2+bJcgQs4s22WQevUkqs94k6ha4EgdnN2wO7QUi+6ScpCTtlyRaPiRSicq3
         peARZHQIulf7FXYahwM6YncDsk+K5cOxOyHcP1t1/K3gq0aU7qJ6LRyoFaboW+4+jZ7W
         PMUveGqAbGgp6rdrmU/ycgCVr/m3YIso+nWWVkJkjjJPVINRi7oGMP/N2PYcBSSdAPMm
         eJmFIKit8kfY2rU5TOfEdUSktnxwvLhRbqJxrgJXT1Z8yM4ZyBePOInAjX17olV8GShc
         uk6l+7xffcRB4j1YuXKfHhsk5QpFClnMhxJWdpsZlFZg5jQSdTsl2UpK0bWRKvpGOK+2
         h+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a+61rl8Elaa09l9GcyZ+z+uAZtLyVMaEf7GEyD6Ddls=;
        b=H5ooKlO5aoW6YThBte0J1XTw4uGgBe/qAP2R/4PNA/Jbz4T4RS/SDF5iR3bpJKncUr
         PYAFFph5cnHCPpbq+QgV3YKOny1QYGm8cSRNhD4H2Nuxr1O0QBOtOH+VfAJfT34Njscw
         MJEwQ3JpbQ5/5DHjZQqWu6UlyrosQkFwiw9dB9/gcNmuGrZR5xv20LbfPikW0Q0u3y4Q
         Q4FMS18Mi373lnPRDo1rImuvjCWo9YOIcRBWq3EwW5g25Yy2KTm4CBD/Xm3VlrmCCTOE
         y/Cmjzs5BcIoBZriooMh9uzrw1T1JB2KxKDLaJgDnhoFdC5WxifvhPtCb175gmgKqYf5
         KoYQ==
X-Gm-Message-State: AOAM531ZN6kdbpCrbZtrif0zPrKEGO5DdktxFhFAa2y11x96AWASDlWa
        oL7o9En1f8cwmObtJaV45xY=
X-Google-Smtp-Source: ABdhPJxTD0hHt5TLDJRkdINbsSpLmPvHo9EMfYVe2OzvP1ZTzI/eQqoDsS53zE2JU1MP8gnZ1qVzNQ==
X-Received: by 2002:adf:e681:: with SMTP id r1mr25070757wrm.348.1606681892631;
        Sun, 29 Nov 2020 12:31:32 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id a144sm22997876wmd.47.2020.11.29.12.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 12:31:32 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 2/2] mmc: sdhci-esdhc-imx: allow to disable HS400 support
Date:   Sun, 29 Nov 2020 21:31:16 +0100
Message-Id: <20201129203116.11987-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201129203116.11987-1-adrien.grassein@gmail.com>
References: <20201129203116.11987-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch adds the posibility to remove the HS400
support directly from the devicetree.

This is useful for example for the sdcard slot of the
Nitrogen8M mini that doesn't support the HS400 standard.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index fce8fa7e6b30..6fbd4bcca7a1 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -294,6 +294,7 @@ struct pltfm_imx_data {
 	} multiblock_status;
 	u32 is_ddr;
 	struct pm_qos_request pm_qos_req;
+	u32 disable_caps;
 };
 
 static const struct platform_device_id imx_esdhc_devtype[] = {
@@ -454,6 +455,8 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 			    IS_ERR_OR_NULL(imx_data->pins_200mhz))
 				val &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50
 					 | SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_HS400);
+
+			val &= ~imx_data->disable_caps;
 		}
 	}
 
@@ -1502,6 +1505,9 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
 		boarddata->delay_line = 0;
 
+	if (of_find_property(np, "fsl,no-mmc-hs400", NULL))
+		imx_data->disable_caps |= SDHCI_SUPPORT_HS400;
+
 	mmc_of_parse_voltage(np, &host->ocr_mask);
 
 	if (esdhc_is_usdhc(imx_data)) {
-- 
2.20.1

