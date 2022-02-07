Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCECC433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Feb 2022 12:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbiBGLso (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Feb 2022 06:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378330AbiBGLPt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Feb 2022 06:15:49 -0500
X-Greylist: delayed 2163 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 03:15:28 PST
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17E6C03FEE0
        for <linux-mmc@vger.kernel.org>; Mon,  7 Feb 2022 03:15:28 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2177wqw4017916;
        Mon, 7 Feb 2022 11:39:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=5fT7c4Mvgn2+ok+STLBdSgiGaFIlSdUaQbBwjLUOJH0=;
 b=i67U6qLJURxlIpLy7BYqlneYLOC7BdWvvYXtnza2KQDmRrcTbYml/pKJc443HWlff3RN
 znakVb4TkS8kPn3g+v49D34loNf2M+X9zzV6th7oqe2eRL4YZQpDgi8616hvuBPGFUK0
 JXY+LqnKaH9bGnw6VuWI9cJnvPynwDiq7K0qaqt92fLzNtiYN25P1fQylixxZuBeSqtq
 T6Yi4MBXokPTOIYgzaVkFKwbcq2zIpVbC6RB/vWgRoQWBnd5oRW69vexYBYaSckmESAS
 ziGP1HcQsDJd7Dv6uIXTP2ewNa7zQDCtOkEtHLBUdGxwgjFiQgRkj6CbgG2RYXFu+uL4 Mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3e2nfyaveu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 11:39:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 86CCF100034;
        Mon,  7 Feb 2022 11:39:16 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7D6EB215157;
        Mon,  7 Feb 2022 11:39:16 +0100 (CET)
Received: from [10.48.0.252] (10.75.127.47) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 7 Feb
 2022 11:39:15 +0100
Message-ID: <b35ab20d-479f-a5ae-0e43-2b3c03f087e1@foss.st.com>
Date:   Mon, 7 Feb 2022 11:39:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/10] ARM: dts: stm32: update sdmmc nodes
Content-Language: en-US
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
References: <20220112163226.25384-1-yann.gautier@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220112163226.25384-1-yann.gautier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_03,2022-02-07_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Yann

On 1/12/22 17:32, Yann Gautier wrote:
> This patches series brings updates for SDMMC nodes on STM32MP13
> (max frequency, pins slew-rates, sleep pins, and controller version).
> The sdmmc2 node is also added as STM32MP13 embeds 2 SDMMC controllers.
> 
> The compatible for sdmmc nodes is also updated for both STM32MP13
> and STM32MP15, to align with bootloaders DT, and after arm,pl18x.yaml
> has been updated [1].
> 
> [1] commit 552bc46484b3 ("dt-bindings: mmc: mmci: Add st,stm32-sdmmc2
>      compatible")
> 
> Gerald Baeza (1):
>    ARM: dts: stm32: update sdmmc slew-rate in stm32mp13 pinctrl
> 
> Yann Gautier (9):
>    ARM: dts: stm32: add st,stm32-sdmmc2 compatible on stm32mp151
>    ARM: dts: stm32: add st,stm32-sdmmc2 compatible on stm32mp131
>    ARM: dts: stm32: increase SDMMC max-frequency for STM32MP13
>    ARM: dts: stm32: update SDMMC clock slew-rate on STM32MP135F-DK board
>    ARM: dts: stm32: add sdmmc sleep pins for STM32MP13
>    ARM: dts: stm32: add sdmmc sleep config for STM32MP135F-DK
>    ARM: dts: stm32: update SDMMC version for STM32MP13
>    ARM: dts: stm32: add SDMMC2 in STM32MP13 DT
>    ARM: dts: stm32: add sdmmc2 pins for STM32MP13
> 
>   arch/arm/boot/dts/stm32mp13-pinctrl.dtsi | 81 ++++++++++++++++++++----
>   arch/arm/boot/dts/stm32mp131.dtsi        | 20 +++++-
>   arch/arm/boot/dts/stm32mp135f-dk.dts     |  7 +-
>   arch/arm/boot/dts/stm32mp151.dtsi        |  6 +-
>   4 files changed, 94 insertions(+), 20 deletions(-)
> 

Series applied on stm32-next.

Thanks
alex
