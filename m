Return-Path: <SRS0=LLi2=7I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892B3C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 26 May 2020 15:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 517B3206F1
	for <linux-mmc@archiver.kernel.org>; Tue, 26 May 2020 15:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="GKxwNZLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgEZPvY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 May 2020 11:51:24 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45272 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgEZPvY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 May 2020 11:51:24 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QFlFqb028014;
        Tue, 26 May 2020 17:51:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=awNzOZtUgwnfFeZ/Tz9VhjThCwN8TwzoQKI0+2aZH60=;
 b=GKxwNZLxyFZkMA8x/3+/Czi4YCWZDs2yEPTjTAZjydeLI6qJFeG5uz7cap84Ev8fhBKj
 OZy4VncmxfQl5Ld3Yg4Yz8KuaCq/pOMCNg5DtmBJn4thF5hx+9ezej3+t91OCMMgSfoB
 7lE8bHoWa4BOioysdbtnqBGCig9OYt9AkS3MHIbuNf67jxwyK6XIdoO9w5cfTQneT5j8
 ph02hv58mCV/iE10YCv8cwFxKCuO+wXune2zb5RBucojIiaEQf44sfviF8DhgZlAIaUk
 TSeHWgKs81sAI2RwBjMrjiy5vJSvl4iUla5P0fgfxgc2xb6mnYgJhR/NaRXE86GmLEMn PA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 316tqh09kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 17:51:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AD68B10002A;
        Tue, 26 May 2020 17:51:11 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 98B582C4B36;
        Tue, 26 May 2020 17:51:11 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 May 2020 17:51:11
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
Subject: [PATCH 0/2] mmc: mmci_sdmmc: fix dma api warnings
Date:   Tue, 26 May 2020 17:51:01 +0200
Message-ID: <20200526155103.12514-1-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch series fixes warnings see with DMA_API_DEBUG_SG=y

Ludovic Barre (2):
  mmc: mmci_sdmmc: fix DMA API warning overlapping mappings
  mmc: mmci_sdmmc: fix DMA API warning max segment size

 drivers/mmc/host/mmci_stm32_sdmmc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
2.17.1

