Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E19C433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Mar 2022 11:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbiCALxu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Mar 2022 06:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiCALxs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2022 06:53:48 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D9B8AE74
        for <linux-mmc@vger.kernel.org>; Tue,  1 Mar 2022 03:53:07 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id f37so26370997lfv.8
        for <linux-mmc@vger.kernel.org>; Tue, 01 Mar 2022 03:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXthyKuVSmjIK882wlyq5sshJFYrq5Qsz7nD78CwzhY=;
        b=Two5H4sSOSzb5+mIBBKPmSRlk9b565laQsEBQyAJMnvbPKi/IpQ25SxGu34cvVoT/n
         57KNMLxKLYv3Hgq5CcTY/WfV4KCWsqfCL4ww77BiMwgCdK3udAltpIyiJxeW0OoDbBC2
         lwZHE+Vh6qCkbxPrAuz06jxqDFbqwwlrsSrDwjF5Pw4+ApU2hdH9b1FopdqXhX9bCGQZ
         P03cjVOswbXF8mcgU2eFJsxBup6mBEWblLxxe6JOVS2qSQmKuDcy2KIDS1NePQkq07B5
         e+Y2lvjc8QZxVlCSdgCH2N3zdvRJr+z/OLavgeUnQ0OVK2dsPhE3Z+KE9ok5+wHTIVhx
         MKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXthyKuVSmjIK882wlyq5sshJFYrq5Qsz7nD78CwzhY=;
        b=gy5/7P3xFKaD86sZ968e3DMcTDnJarzE/XByJhVsCzdKP8srmN5PNeA2R078LaV9Jy
         I2PsQU2+oAWYl0ouz2qdxfY7+DNCmwKYMKkU08CjMqHaHzmlp2nvMwKubWmjzmV+hE3x
         1bWFimlfRMZ5Sas21nipiVltMac2Qu0NBt+mnXitJ+L+FaBMwCu3lCHhekFCRt3LuG3Z
         is3Y3WyIMQfwxWb3tSBXdsx5vKWYCH0d+2PGxYpLi10m93l62tDmamf2C2QmrtW++t4k
         VdM2M+8dZyhOSLb1Nv2YBaov1qa1jVq+uRzVILO70OMOv6rHRcC1Logf9WOECyp1r2wN
         GW0w==
X-Gm-Message-State: AOAM530nAm9coP4JUShCZ9imRgweldAX6kVQPffTZ4mpu89WqAhsAFy+
        HNa08t0f9hrcoM+eN9XlSBdylg==
X-Google-Smtp-Source: ABdhPJyYnEN5oHtzfZA2MsTk80UR1tU02WFkEOdkGpS9wKwJM5My3AVt9J7bxlgIV7L2JcOn+6CLKg==
X-Received: by 2002:a05:6512:3296:b0:442:f695:ae75 with SMTP id p22-20020a056512329600b00442f695ae75mr15493028lfe.508.1646135586199;
        Tue, 01 Mar 2022 03:53:06 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-34.NA.cust.bahnhof.se. [155.4.129.34])
        by smtp.gmail.com with ESMTPSA id x20-20020ac25dd4000000b004415ddbc97esm1457578lfq.212.2022.03.01.03.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 03:53:05 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] mmc: rtsx: Fix build errors/warnings for unused variable
Date:   Tue,  1 Mar 2022 12:53:00 +0100
Message-Id: <20220301115300.64332-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The struct device *dev, is no longer needed at various functions, let's
therefore drop it to fix the build errors/warnings.

Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Fixes: 7570fb41e450 ("mmc: rtsx: Let MMC core handle runtime PM"
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 265b3889f9d7..f7c384db89bf 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -806,7 +806,6 @@ static void sd_request(struct work_struct *work)
 	struct mmc_request *mrq = host->mrq;
 	struct mmc_command *cmd = mrq->cmd;
 	struct mmc_data *data = mrq->data;
-	struct device *dev = &host->pdev->dev;
 
 	unsigned int data_size = 0;
 	int err;
@@ -1081,7 +1080,6 @@ static void sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
 	struct rtsx_pcr *pcr = host->pcr;
-	struct device *dev = &host->pdev->dev;
 
 	if (host->eject)
 		return;
@@ -1130,7 +1128,6 @@ static int sdmmc_get_ro(struct mmc_host *mmc)
 {
 	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
 	struct rtsx_pcr *pcr = host->pcr;
-	struct device *dev = &host->pdev->dev;
 	int ro = 0;
 	u32 val;
 
@@ -1156,7 +1153,6 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
 {
 	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
 	struct rtsx_pcr *pcr = host->pcr;
-	struct device *dev = &host->pdev->dev;
 	int cd = 0;
 	u32 val;
 
@@ -1255,7 +1251,6 @@ static int sdmmc_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
 	struct rtsx_pcr *pcr = host->pcr;
-	struct device *dev = &host->pdev->dev;
 	int err = 0;
 	u8 voltage;
 
@@ -1308,7 +1303,6 @@ static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
 	struct rtsx_pcr *pcr = host->pcr;
-	struct device *dev = &host->pdev->dev;
 	int err = 0;
 
 	if (host->eject)
-- 
2.25.1

