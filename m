Return-Path: <SRS0=M0wQ=4O=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8D8C4BA0B
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Feb 2020 08:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CD42465D
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Feb 2020 08:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Bp6LWZeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgBZIkk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:40:40 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:48523 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727267AbgBZIkk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Feb 2020 03:40:40 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01Q8ckpw015436;
        Wed, 26 Feb 2020 09:40:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=qYNCz7bGkBTTaNO03CNPss3EnrpQ6PC4YPTkV05TJOM=;
 b=Bp6LWZeUbDd9/bjJiGIWsKryeSmrlLTP2fafPjXcT7aN+tjxBggpXGZGWspFxamZ6RfQ
 m27AcW+IxkOOZNtVkOxrSAuEwpLT6MWfMYq1by0Bjz8lsFhnki+xSCo6LuruVekSUH42
 jpjl/360ynLmkp9m92Xesb9v45xZuFmosJsM+NniCidYkvAWY/6deH4Z8I6ja0xPJchg
 mqPV+6TrHaepw9Z5b+qBOT6NdoGugev5i+KaNUbgG48d8FXTxnhCeS7irPHGrlIFrVOq
 6AZBi1THuUtTsi9XwSEo4dviPrq9OxZJ9rNXucFl60kOXXebHWegQEHpYrS147GajNkD ig== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ydcnj2h2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Feb 2020 09:40:23 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 02F9910003B;
        Wed, 26 Feb 2020 09:40:17 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E67DB2AC906;
        Wed, 26 Feb 2020 09:40:16 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 26 Feb 2020 09:40:16
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
Subject: [PATCH 0/4] mmc: mmci_sdmmc: fixes and improvements
Date:   Wed, 26 Feb 2020 09:40:10 +0100
Message-ID: <20200226084014.5242-1-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_02:2020-02-25,2020-02-26 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch series fixes some problems:
-dma api debug warning to segment size check.
-dma_unmap_sg missing on not prepared request.
-Clear busyd0end irq flag when a R1B busy is completed.
-Initialize pwr|clk|datactrl_reg with their hardware values at probe.

Ludovic Barre (4):
  mmc: mmci_sdmmc: fix DMA API warning max segment size
  mmc: mmci_sdmmc: fix DMA API warning overlapping mappings
  mmc: mmci_sdmmc: fix clear busyd0end irq flag
  mmc: mmci: initialize pwr|clk|datactrl_reg with their hardware values

 drivers/mmc/host/mmci.c             |  4 ++++
 drivers/mmc/host/mmci_stm32_sdmmc.c | 21 +++++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.17.1

