Return-Path: <SRS0=bXXM=3N=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF03C2D0DB
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 12:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AA020708
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jan 2020 12:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="aqxG94s1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387396AbgAXMzh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Jan 2020 07:55:37 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:26578 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387393AbgAXMzh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jan 2020 07:55:37 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00OCsTCw012368;
        Fri, 24 Jan 2020 13:55:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=HsT5XOh0k0Oip5e4q1QwfFV3XVw3YKpi81ECZxj8y6Q=;
 b=aqxG94s1vaUPEi7oDUwgOsYy3ksvsgGOaWryEalFEw+6Zgdpn66PA45Wk9YnaG06YC0O
 aBklNAsLyjk63X/6JayBKfFWnPoajK64SDY5dhXmGZ5SYJXnDEuGIwkrxaDGKW7Lqoxu
 5imLP6Ba6rd3VLxeGfE5eELqunxfwIp/TEo6qOT1oIRrHt8ADdzIe97YYl01EGefCZ68
 8tbO7EMpd0mYn/mc8D923WscSRyQv2abfuiZbik1+S7JawA9NuI1C8Ct9ZKLLcp5B7N1
 ApvOKGuEbrfLmwvcTx3KpafV0loMaKPLNCmf9fnU1DQyWTdhTUdaAVSVhzPPor7hJXBG Cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkrc5g12e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jan 2020 13:55:24 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CE8E310002A;
        Fri, 24 Jan 2020 13:55:23 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B75A72A847D;
        Fri, 24 Jan 2020 13:55:23 +0100 (CET)
Received: from lmecxl0923.lme.st.com (10.75.127.48) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Jan
 2020 13:55:23 +0100
Subject: Re: [PATCH 0/9] mmc: mmci: sdmmc: add sdr104 support
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200110134823.14882-1-ludovic.barre@st.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <6d859def-351e-abd7-0d5f-962ad935dff2@st.com>
Date:   Fri, 24 Jan 2020 13:55:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200110134823.14882-1-ludovic.barre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-24_03:2020-01-24,2020-01-24 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

hi Ulf

Just a "gentleman ping" on this series
https://lkml.org/lkml/2020/1/10/392

Regards
Ludo

Le 1/10/20 à 2:48 PM, Ludovic Barre a écrit :
> To support the sdr104 mode, sdmmc variant needs:
> -Hardware delay block support for sdmmc variant
>   with tuning procedure
> -Voltage switch callbacks
> -sdmmc revision 2.0
> 
> Ludovic Barre (9):
>    mmc: mmci: sdmmc: replace sg_dma_xxx macros
>    mmc: mmci: sdmmc: rename sdmmc_priv struct to sdmmc_idma
>    mmc: mmci: add a reference at mmc_host_ops in mmci struct
>    mmc: mmci: add private pointer for variant
>    dt-bindings: mmc: mmci: add delay block base register for sdmmc
>    mmc: mmci: sdmmc: add execute tuning with delay block
>    mmc: mmci: add volt_switch callbacks
>    mmc: mmci: sdmmc: add voltage switch functions
>    mmc: mmci: add sdmmc variant revision 2.0
> 
>   .../devicetree/bindings/mmc/mmci.txt          |   2 +
>   drivers/mmc/host/mmci.c                       |  39 ++++
>   drivers/mmc/host/mmci.h                       |   8 +
>   drivers/mmc/host/mmci_stm32_sdmmc.c           | 199 +++++++++++++++++-
>   4 files changed, 241 insertions(+), 7 deletions(-)
> 
