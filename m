Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC56C433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 19:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B1BB22A84
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 19:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388988AbhAZFz4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:55:56 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:2666 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729382AbhAYOUt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jan 2021 09:20:49 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10PEGlfg032259;
        Mon, 25 Jan 2021 15:19:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=oMdkZm40ACOSf8auj1kXawbXsXZ+gWEYe1elBBMLiag=;
 b=j8cgtIVdYfjqPMV3wigODycdPHCm2aHPbf/+HQ4Uyt0mz+CEozez1LIPnx/D9++Hhmbh
 nr8UZ1mfDwqsorBbgn2y+mHZSky6TzAbyrQLzLCUvyuQ0BYxHAbE6NvQMoqR5tt5b+kW
 5Tr8jP/GJWpc5KmglXnXgD9V1QavGJoNB4oHsaAIkxMPJp2BORCddxvaUV4X9bV3/QfM
 to4MtZZd5JvKyyPGDN3QnStlIL5didXmPUnPf7Be0+CEM2ILe2ZZDGrfbP8ZddAXQ7DT
 ehjVEK/eiyUhVZ0oxgAe8x9i0lkJHBSezFsJwWhLD2L+GfyxSXfPjCS10jXFcHhWzL0f PA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3689tdkmvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jan 2021 15:19:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9D07110002A;
        Mon, 25 Jan 2021 15:19:52 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8974B2AD9F7;
        Mon, 25 Jan 2021 15:19:52 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.49) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Jan
 2021 15:19:52 +0100
Subject: Re: [PATCH V2 4/4] ARM: dts: stm32: Enable voltage translator
 auto-detection on DHCOM
To:     Marek Vasut <marex@denx.de>, <linux-mmc@vger.kernel.org>
CC:     Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20210124170258.32862-1-marex@denx.de>
 <20210124170258.32862-4-marex@denx.de>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <6d8a1479-e9e7-27ad-6d41-d6d0e586c543@foss.st.com>
Date:   Mon, 25 Jan 2021 15:19:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210124170258.32862-4-marex@denx.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-25_04:2021-01-25,2021-01-25 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Marek

On 1/24/21 6:02 PM, Marek Vasut wrote:
> The DHCOM SoM uSD slot has an optional voltage level translator, add
> DT bindings which permit the MMCI driver to detect the translator
> automatically.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Ludovic Barre <ludovic.barre@st.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-stm32@st-md-mailman.stormreply.com
> ---
> V2: Rebase on next-20210122
> ---
>   arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
> index ff70bd03a017..661d8d071296 100644
> --- a/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
> @@ -408,14 +408,19 @@ &rtc {
>   };
>   
>   &sdmmc1 {
> -	pinctrl-names = "default", "opendrain", "sleep";
> +	pinctrl-names = "default", "opendrain", "sleep", "init";
>   	pinctrl-0 = <&sdmmc1_b4_pins_a &sdmmc1_dir_pins_a>;
>   	pinctrl-1 = <&sdmmc1_b4_od_pins_a &sdmmc1_dir_pins_a>;
>   	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a &sdmmc1_dir_sleep_pins_a>;
> +	pinctrl-3 = <&sdmmc1_b4_init_pins_a &sdmmc1_dir_init_pins_a>;
>   	cd-gpios = <&gpiog 1 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
>   	disable-wp;
>   	st,sig-dir;
>   	st,neg-edge;
> +	st,use-ckin;
> +	st,cmd-gpios = <&gpiod 2 0>;
> +	st,ck-gpios = <&gpioc 12 0>;
> +	st,ckin-gpios = <&gpioe 4 0>;
>   	bus-width = <4>;
>   	vmmc-supply = <&vdd_sd>;
>   	status = "okay";
> 

DT patches applied on stm32-next.

Thanks
Alex
