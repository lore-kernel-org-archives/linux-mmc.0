Return-Path: <SRS0=m4Hf=5K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08248C1975A
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Mar 2020 14:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7FF216FD
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Mar 2020 14:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="fIY3sQpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgCYOeh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:34:37 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40764 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727647AbgCYOeh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Mar 2020 10:34:37 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02PEY1aX016256;
        Wed, 25 Mar 2020 15:34:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=tWPRwxsxDdo/wbWf8QeAPGRCWogp00cXc4bZS5wiKi0=;
 b=fIY3sQpuisr+CDFy+qLNtaN831KCoi6wxf1GFWZPDnKJTlqGJNiBSU3Bk0LaWRLWC7ov
 X9Y6nStJXf1E5hJ8a7ziftEQYyixh7rWsEzY1e+tZhHCKXUTGReP8C31W7jOGiOj208a
 0HSJtjg5dqWA+33RAk8vblVAfbC6ucp4dGqiXK6Zte7yzI48W7sP4Zy3GknwYQaTK/M/
 S3WXk6kQFcwVNLMBilND7+du6G39ucrLOrOkkGYPiSqG/Tc35dt14yR4O86DMYNLXSGO
 waP/KzZrgZ16jZe+thcJT3y4CZY4qUMuEC8Jg4f6e4aStsF0c9VhncwvNvBeLF9Q3aWU pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ywapp61q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Mar 2020 15:34:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AA87510002A;
        Wed, 25 Mar 2020 15:34:18 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8AD7C2B2525;
        Wed, 25 Mar 2020 15:34:18 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Mar 2020 15:34:17
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
Subject: [PATCH V2 0/2] mmc: mmci_sdmmc: fixes and improvements
Date:   Wed, 25 Mar 2020 15:34:07 +0100
Message-ID: <20200325143409.13005-1-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_07:2020-03-24,2020-03-25 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch series fixes some problems:
-Clear busyd0end irq flag when a R1B busy is completed.
-Initialize pwr|clk|datactrl_reg with their hardware values at probe.

Ludovic Barre (2):
  mmc: mmci_sdmmc: fix clear busyd0end irq flag
  mmc: mmci: initialize pwr|clk|datactrl_reg with their hardware values

 drivers/mmc/host/mmci.c             | 4 ++++
 drivers/mmc/host/mmci_stm32_sdmmc.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.17.1

