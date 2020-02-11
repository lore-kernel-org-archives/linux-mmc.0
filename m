Return-Path: <SRS0=tDgF=37=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E48C3B186
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Feb 2020 14:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B85208C3
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Feb 2020 14:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="GtWzjgWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbgBKOol (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:44:41 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:31254 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727728AbgBKOol (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Feb 2020 09:44:41 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BEiRXu032757;
        Tue, 11 Feb 2020 15:44:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=zMrqEZqOCVnlA3/9d0Rc7Rgo4RLOby/Y5h96V1K6k5k=;
 b=GtWzjgWpZQmghAi169LU0uuY4j7UF/y4Gxjub5zSHljucQ9SciIS1fLFx8NgjERgpEqd
 wD2ePTUv/IS4QpFL9ashW1yofY0nK/2ZRkTrwnh5vpa39jIgJSyf0bP0MsxLWB3JnPwC
 c1nSsQxR/ELJ1NNAZiSh6qB5VMdSGOdzJw/piJ0VJCKihyErlkdRkV9gaiGiZggHXRb3
 JKG1oAfc3Pk3dP48IbxrRU1u7fZArbuL1j1hAOco7JtMhjlz4ZZv7pVn4VOAXp9fdizr
 uotji9CPN2DDHDLLtx4hKF92yFf7FnBzwHslCu1jX0mj3fq8XgNV6R/j+ka/1TtPFeHt PA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1ufh5xf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Feb 2020 15:44:28 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6748F100046;
        Tue, 11 Feb 2020 15:44:18 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 535752BD3FC;
        Tue, 11 Feb 2020 15:44:18 +0100 (CET)
Received: from lmecxl0923.lme.st.com (10.75.127.48) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Feb
 2020 15:44:17 +0100
Subject: Re: [PATCH V2 9/9] mmc: mmci: add sdmmc variant revision 2.0
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200128090636.13689-1-ludovic.barre@st.com>
 <20200128090636.13689-10-ludovic.barre@st.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <853f4b14-a188-f329-34e5-8e88fcafa775@st.com>
Date:   Tue, 11 Feb 2020 15:44:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200128090636.13689-10-ludovic.barre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_04:2020-02-10,2020-02-11 signatures=0
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

hi Ulf

Le 1/28/20 à 10:06 AM, Ludovic Barre a écrit :
> This patch adds a sdmmc variant revision 2.0.
> This revision is backward compatible with 1.1, and adds dma
> link list support.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>   drivers/mmc/host/mmci.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 24e630183ed4..a774c329c212 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -275,6 +275,31 @@ static struct variant_data variant_stm32_sdmmc = {
>   	.init			= sdmmc_variant_init,
>   };
>   
> +static struct variant_data variant_stm32_sdmmcv2 = {
> +	.fifosize		= 16 * 4,
> +	.fifohalfsize		= 8 * 4,
> +	.f_max			= 208000000,
> +	.stm32_clkdiv		= true,
> +	.cmdreg_cpsm_enable	= MCI_CPSM_STM32_ENABLE,
> +	.cmdreg_lrsp_crc	= MCI_CPSM_STM32_LRSP_CRC,
> +	.cmdreg_srsp_crc	= MCI_CPSM_STM32_SRSP_CRC,
> +	.cmdreg_srsp		= MCI_CPSM_STM32_SRSP,
> +	.cmdreg_stop		= MCI_CPSM_STM32_CMDSTOP,
> +	.data_cmd_enable	= MCI_CPSM_STM32_CMDTRANS,
> +	.irq_pio_mask		= MCI_IRQ_PIO_STM32_MASK,
> +	.datactrl_first		= true,
> +	.datacnt_useless	= true,
> +	.datalength_bits	= 25,
> +	.datactrl_blocksz	= 14,
> +	.datactrl_any_blocksz	= true,
> +	.stm32_idmabsize_mask	= GENMASK(16, 5),
> +	.dma_lli		= true,
> +	.busy_timeout		= true,

I forget "busy_detect		= true," property
I add this in next patch set

> +	.busy_detect_flag	= MCI_STM32_BUSYD0,
> +	.busy_detect_mask	= MCI_STM32_BUSYD0ENDMASK,
> +	.init			= sdmmc_variant_init,
> +};
> +
>   static struct variant_data variant_qcom = {
>   	.fifosize		= 16 * 4,
>   	.fifohalfsize		= 8 * 4,
> @@ -2343,6 +2368,11 @@ static const struct amba_id mmci_ids[] = {
>   		.mask	= 0xf0ffffff,
>   		.data	= &variant_stm32_sdmmc,
>   	},
> +	{
> +		.id     = 0x00253180,
> +		.mask	= 0xf0ffffff,
> +		.data	= &variant_stm32_sdmmcv2,
> +	},
>   	/* Qualcomm variants */
>   	{
>   		.id     = 0x00051180,
> 
