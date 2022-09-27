Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F137C54EE9
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Sep 2022 08:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiI0Ipy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Sep 2022 04:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiI0Ipx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2022 04:45:53 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB6443E47;
        Tue, 27 Sep 2022 01:45:51 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R61EEc011790;
        Tue, 27 Sep 2022 10:45:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Dyznb/HDuNwOefV0uJggIqu+fF7WsNix9IVaqdVthls=;
 b=KibQCYQoc6G6DQbxAArpZi7N+/JZRmPGy347Orel25+TXOjFsLlL6i0xrdudJpQ3gfdC
 1yIldoSVwlukkVRyuR+DypIqMzQ1g8kYOZeTrsvlck5NoD5D14nFoyVBcu2JhkPHWs4q
 Yet/A0kWiRmndB8Jar9Kt0lGq76OrveL/K5lnPpr47eIJmu0nPrqcRCWF2gYUUOCNHjY
 qQSkTKMGV11W2Qh+amAGUo8qX1hvvadHMKpunoG8YR9oF9GgEqJSrurRaswI+3BnhimF
 Fc6vdOKrpI8eGMpLp8Vw8H5kCb05l3QljhMPYILlBE5x+pE3VFeq/1fXnNgaQ7ciwpZQ 7Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jss82827j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 10:45:35 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 55F3F100034;
        Tue, 27 Sep 2022 10:45:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 504A7216EF0;
        Tue, 27 Sep 2022 10:45:35 +0200 (CEST)
Received: from [10.201.20.201] (10.75.127.123) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 10:45:32 +0200
Message-ID: <3f21cc73-c190-7855-b1c6-722098b5fa22@foss.st.com>
Date:   Tue, 27 Sep 2022 10:45:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] dt-bindings: mmc: arm,pl18x: Document interrupt-names
 property
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, <linux-arm-kernel@lists.infradead.org>
CC:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20220926204708.381741-1-marex@denx.de>
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <20220926204708.381741-1-marex@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.123]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_02,2022-09-22_02,2022-06-22_01
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 9/26/22 22:47, Marek Vasut wrote:

Hi Marek,

> Document interrupt-names property with "event" and "error" interrupt names.
Minor: this looks like a wrong copy/paste, the interrupt name is cmd_irq 
here.

Other than that, you can add my:
Reviewed-by: Yann Gautier <yann.gautier@foss.st.com>


Best regards,
Yann

> This fixes dtbs_check warnings when building current Linux DTs:
> 
> "
> arch/arm/boot/dts/stm32mp153c-dhcom-drc02.dtb: mmc@58007000: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
> "
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Yann Gautier <yann.gautier@foss.st.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> To: linux-arm-kernel@lists.infradead.org
> ---
>   Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> index 1e69a5a42439b..5f7eae8d57ab9 100644
> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> @@ -99,6 +99,9 @@ properties:
>       minItems: 1
>       maxItems: 2
>   
> +  interrupt-names:
> +    const: cmd_irq
> +
>     st,sig-dir-dat0:
>       $ref: /schemas/types.yaml#/definitions/flag
>       description: ST Micro-specific property, bus signal direction pins used for

