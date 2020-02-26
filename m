Return-Path: <SRS0=M0wQ=4O=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAD9C4BA0F
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Feb 2020 08:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C0924656
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Feb 2020 08:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="fqUdeqGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgBZIkm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:40:42 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:55832 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726425AbgBZIkl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Feb 2020 03:40:41 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01Q8crEg027973;
        Wed, 26 Feb 2020 09:40:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=UTNAbP13GzjPHqEdVThO2cR89yJ3a5MfyLKzDHxgcvU=;
 b=fqUdeqGfpujOuJ5oG07BCO06VytcD3iFDMOqKGVbRyskAC6UTHv1Mx2mpZXQc6FLnEjT
 xxyqXNo5Y0LOEEwoFK6JQSAxwP1rKDyBjcQibV86Ehx5riqHYdBxFNql1gl9aXBu1Crd
 5QXCQPvLQHzcjxEVvL0NS2CWK/9GjG6eFuxaz8l+rvl0QMpuRfg9syvyDI/LN3vqICLR
 ZlM5teH5joaqQsi8fQHqQTSeWrEGq8nmAJwWXQB9x+orAh064a/dV1AZ6Qn2a6LTg8oY
 XaOckX9s+fH7yV/SMNC8TE3GozA8gsl1HG3emwfXeEnZ92vcL4TxV7WkONl7GGy+EISA ZA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ydcpgagsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Feb 2020 09:40:23 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 33994100038;
        Wed, 26 Feb 2020 09:40:19 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 26AB02AC906;
        Wed, 26 Feb 2020 09:40:19 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 26 Feb 2020 09:40:18
 +0100
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
Subject: [PATCH 2/4] mmc: mmci_sdmmc: fix DMA API warning overlapping mappings
Date:   Wed, 26 Feb 2020 09:40:12 +0100
Message-ID: <20200226084014.5242-3-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226084014.5242-1-ludovic.barre@st.com>
References: <20200226084014.5242-1-ludovic.barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_02:2020-02-25,2020-02-26 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Turning on CONFIG_DMA_API_DEBUG_SG results in the following warning:
WARNING: CPU: 1 PID: 20 at kernel/dma/debug.c:500 add_dma_entry+0x16c/0x17c
DMA-API: exceeded 7 overlapping mappings of cacheline 0x031d2645
Modules linked in:
CPU: 1 PID: 20 Comm: kworker/1:1 Not tainted 5.5.0-rc2-00021-gdeda30999c2b-dirty #49
Hardware name: STM32 (Device Tree Support)
Workqueue: events_freezable mmc_rescan
[<c03138c0>] (unwind_backtrace) from [<c030d760>] (show_stack+0x10/0x14)
[<c030d760>] (show_stack) from [<c0f2eb28>] (dump_stack+0xc0/0xd4)
[<c0f2eb28>] (dump_stack) from [<c034a14c>] (__warn+0xd0/0xf8)
[<c034a14c>] (__warn) from [<c034a530>] (warn_slowpath_fmt+0x94/0xb8)
[<c034a530>] (warn_slowpath_fmt) from [<c03bca0c>] (add_dma_entry+0x16c/0x17c)
[<c03bca0c>] (add_dma_entry) from [<c03bdf54>] (debug_dma_map_sg+0xe4/0x3d4)
[<c03bdf54>] (debug_dma_map_sg) from [<c0d09244>] (sdmmc_idma_prep_data+0x94/0xf8)
[<c0d09244>] (sdmmc_idma_prep_data) from [<c0d05a2c>] (mmci_prep_data+0x2c/0xb0)
[<c0d05a2c>] (mmci_prep_data) from [<c0d073ec>] (mmci_start_data+0x134/0x2f0)
[<c0d073ec>] (mmci_start_data) from [<c0d078d0>] (mmci_request+0xe8/0x154)
[<c0d078d0>] (mmci_request) from [<c0cecb44>] (mmc_start_request+0x94/0xbc)

DMA api debug brings to light leaking dma-mappings, dma_map_sg and
dma_unmap_sg are not correctly balanced.

If a request is prepared, the dma_map/unmap are done in asynchronous
call pre_req (prep_data) and post_req (unprep_data). In this case
the dma-mapping is right balanced.

But if the request was not prepared, the data->host_cookie is
define to zero and the dma_map/unmap must be done in the request.
The dma_map is called by mmci_dma_start (prep_data), but there is
no dma_unmap in this case.

This patch adds dma_unmap_sg when the dma is finalized and
the data cookie is zero (request not prepared).

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci_stm32_sdmmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 56d9ad7f523e..7b781c897346 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -190,6 +190,9 @@ static int sdmmc_idma_start(struct mmci_host *host, unsigned int *datactrl)
 static void sdmmc_idma_finalize(struct mmci_host *host, struct mmc_data *data)
 {
 	writel_relaxed(0, host->base + MMCI_STM32_IDMACTRLR);
+
+	if (!data->host_cookie)
+		sdmmc_idma_unprep_data(host, data, 0);
 }
 
 static void mmci_sdmmc_set_clkreg(struct mmci_host *host, unsigned int desired)
-- 
2.17.1

