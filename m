Return-Path: <SRS0=uOye=6E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54745C3815B
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 16:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E2CC2074F
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 16:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="TqeR1ZUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgDTQTC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:19:02 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39176 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726036AbgDTQTC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Apr 2020 12:19:02 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KGCBKL029130;
        Mon, 20 Apr 2020 18:18:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=GQbTc6KNDxMl8YSg798Cux50zZhwrXkX/dFcXXvNJ6Q=;
 b=TqeR1ZUjHaQNCqR1KQDULMvtxVFF85RXV2MogrDVDAHrZD/et2D7nz6qTKcwwppMIrw7
 abk6DWiG+BS0lKq7o0OPec7V2NOfU/VHcwNxTT8P3uv7qQeRMx07cNgFeJ0lKEPZF7kA
 UZpHJcK0MhKaooEDP3R2uOn2pfDsiA97RxUBKuFJU/Yd4V1uFn56MFqmlhUq7NEfBRAQ
 /Wdw9iDFC70tBL3wAny8mfmBI/JlXz7ohVCfWTMcyGhEkr3Cu0bNlRdxZ9evLWtkAG+I
 s77Y6vRMJRum/CJmcokfdHvet2o2P8Xvsaiu4k7D6fRMiGkwanqoziqxjMLXtUzZqLIT Gw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fregb2ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 18:18:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 80A9F100034;
        Mon, 20 Apr 2020 18:18:45 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6C9062AA2A3;
        Mon, 20 Apr 2020 18:18:45 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Apr 2020 18:18:44
 +0200
From:   Ludovic Barre <ludovic.barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH] mmc: mmci_sdmmc: fix power on issue due to pwr_reg initialization
Date:   Mon, 20 Apr 2020 18:18:31 +0200
Message-ID: <20200420161831.5043-1-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_05:2020-04-20,2020-04-20 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch fix a power-on issue, and avoid to retry the power sequence.

In power off sequence: sdmmc must set pwr_reg in "power-cycle" state
(value 0x2), to prevent the card from being supplied through the signal
lines (all the lines are driven low).

In power on sequence: when the power is stable, sdmmc must set pwr_reg
in "power-off" state (value 0x0) to drive all signal to high before to
set "power-on".

To avoid writing the same value to the power register several times, this
register is cached by the pwr_reg variable. At probe pwr_reg is initialized
to 0 by kzalloc of mmc_alloc_host.

Like pwr_reg value is 0 at probing, the power on sequence fail because
the "power-off" state is not writes (value 0x0) and the lines
remain drive to low.

This patch initializes "pwr_reg" variable with power register value.
This it done in sdmmc variant init to not disturb default mmci behavior.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---

This patch is the proposal from:
https://patchwork.kernel.org/patch/11457987/

---
 drivers/mmc/host/mmci_stm32_sdmmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index d33e62bd6153..14f99d8aa3f0 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -519,6 +519,7 @@ void sdmmc_variant_init(struct mmci_host *host)
 	struct sdmmc_dlyb *dlyb;
 
 	host->ops = &sdmmc_variant_ops;
+	host->pwr_reg = readl_relaxed(host->base + MMCIPOWER);
 
 	base_dlyb = devm_of_iomap(mmc_dev(host->mmc), np, 1, NULL);
 	if (IS_ERR(base_dlyb))
-- 
2.17.1

