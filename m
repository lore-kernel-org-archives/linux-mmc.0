Return-Path: <SRS0=IAZs=3R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566DEC35246
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jan 2020 09:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9FF24687
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Jan 2020 09:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="nMdIWhzp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgA1JGx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:06:53 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55728 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgA1JGx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2020 04:06:53 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00S92kWS021535;
        Tue, 28 Jan 2020 10:06:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=dM4EBFGBDxEbKJ3rgoXqLG+/SBlJ9gkuXeRvPF/9krE=;
 b=nMdIWhzp+SqKhb3FySeBN89jovlV4Q/x1JwFEEwrgv+3cy6ssAqH+0H6NsD2ne8AtCj4
 Ln5lX3LBrfaIsjlMfJjazhItRY8/UbmCL2Sg19FstvtIcZZMpiYvvlMDIf7URiGKIEp1
 Dn0jSO0kf02NMdJi89lywq/Ch4VaWk1OaaCUjQZZHjtGDz3ftv5c7zZxcbiJnJJRXSpn
 Cot4u5++wXTHxmRAnMUOdPHM8BZM86JqMosORJUrRLP7QLW75BrBFef7xK+lNcyE5Tq3
 5wSUAZBezsgnEj+RRbbGxS9dZnaAu4DG6LFr6GP5ND5X1/zlATJvHEPGnXpUPfunpafI KA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrdekcugb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 10:06:40 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9D790100034;
        Tue, 28 Jan 2020 10:06:39 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8B6CB212A35;
        Tue, 28 Jan 2020 10:06:39 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG6NODE1.st.com (10.75.127.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jan 2020 10:06:38
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
Subject: [PATCH V2 0/9] mmc: mmci: sdmmc: add sdr104 support
Date:   Tue, 28 Jan 2020 10:06:27 +0100
Message-ID: <20200128090636.13689-1-ludovic.barre@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_02:2020-01-24,2020-01-28 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To support the sdr104 mode, sdmmc variant needs:
-Hardware delay block support for sdmmc variant
 with tuning procedure
-Voltage switch callbacks
-sdmmc revision 2.0

V2:
-regroup host->mmc_ops & mmc->ops assignment
-add timeout define
-rename prep_volt_switch to pre_sig_volt_switch
-rename volt_switch to post_sig_volt_switch
-add 'why' comment for "mmc: mmci: add volt_switch callbacks"

Ludovic Barre (9):
  mmc: mmci: sdmmc: replace sg_dma_xxx macros
  mmc: mmci: sdmmc: rename sdmmc_priv struct to sdmmc_idma
  mmc: mmci: add a reference at mmc_host_ops in mmci struct
  mmc: mmci: add private pointer for variant
  dt-bindings: mmc: mmci: add delay block base register for sdmmc
  mmc: mmci: sdmmc: add execute tuning with delay block
  mmc: mmci: add volt_switch callbacks
  mmc: mmci: sdmmc: add voltage switch functions
  mmc: mmci: add sdmmc variant revision 2.0

 .../devicetree/bindings/mmc/mmci.txt          |   2 +
 drivers/mmc/host/mmci.c                       |  42 +++-
 drivers/mmc/host/mmci.h                       |   8 +
 drivers/mmc/host/mmci_stm32_sdmmc.c           | 204 +++++++++++++++++-
 4 files changed, 248 insertions(+), 8 deletions(-)

-- 
2.17.1

