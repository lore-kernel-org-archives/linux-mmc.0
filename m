Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1092C4167B
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Dec 2022 02:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiLPCCP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Dec 2022 21:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiLPCCP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Dec 2022 21:02:15 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE71389E3;
        Thu, 15 Dec 2022 18:02:09 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1AD9E24E00A;
        Fri, 16 Dec 2022 10:02:06 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 16 Dec
 2022 10:02:06 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 16 Dec
 2022 10:02:05 +0800
Message-ID: <420d067c-665b-b247-b0cd-8ac242c19924@starfivetech.com>
Date:   Fri, 16 Dec 2022 10:02:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v1 0/3] StarFive's SDIO/eMMC driver support
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <20221207131731.1291517-1-william.qiu@starfivetech.com>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <20221207131731.1291517-1-william.qiu@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS063.cuchost.com (172.16.6.23) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 2022/12/7 21:17, William Qiu wrote:
> Hi,
> 
> This patchset adds initial rudimentary support for the StarFive
> designware mobile storage host controller driver. And this driver will
> be used in StarFive's visionfive-v2 board. The main purpose of adding
> this driver is to accommodate the ultra-high speed mode of eMMC.
> 
> The patch series is based on v6.1-rc5.
> 
> -- William
> 
> William Qiu (3):
>   dt-bindings: mmc: Add bindings for StarFive
>   mmc: starfive: Add sdio/emmc driver support
>   riscv: dts: starfive: Add mmc node
> 
>  .../bindings/mmc/starfive,jh7110-sdio.yaml    |  71 +++++++
>  MAINTAINERS                                   |   6 +
>  .../jh7110-starfive-visionfive-v2.dts         |  25 +++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  38 ++++
>  drivers/mmc/host/Kconfig                      |  10 +
>  drivers/mmc/host/Makefile                     |   1 +
>  drivers/mmc/host/dw_mmc-starfive.c            | 197 ++++++++++++++++++
>  7 files changed, 348 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-sdio.yaml
>  create mode 100644 drivers/mmc/host/dw_mmc-starfive.c
> 
> --
> 2.34.1
> 

Hi Jaehoon/Ulf,

Could you please help to review and provide comments on this patch series?
Thank you in advance.

Best regards,
William Qiu
