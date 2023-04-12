Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7CAC77B6E
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Apr 2023 07:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjDLHsz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Apr 2023 03:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDLHsx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Apr 2023 03:48:53 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD69BE59
        for <linux-mmc@vger.kernel.org>; Wed, 12 Apr 2023 00:48:51 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C5PtDL001785;
        Wed, 12 Apr 2023 09:48:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=MVBSuZmwmGl3CD1mpnNXSbvcquP54D2COle1slnBb6g=;
 b=ppaJScPs+R32qcu2GXQlBuWVAyYliJ7r+61SVqtcupi8Vy0S7nUkDAfl6EEXBV2NYlU/
 92LdqsbEOzkeJowJw+YEb/LHSOEAkSS/lbDB6vdNq9twyS1+QtPvdfoAODAbqbALuFVW
 M2Wb3P33x+kAFEDsVlZQBEJYAuPv6zrj6zyV3qdzCMJkXvdn6ZKwZm752Ms6DBFvmc7f
 IGVw5qfHeVO9FQLBOXat5kGfNYS/P1Sc/jKpkM4Opjp6Go0uIyYPqCYuoOLGNfKi75IX
 1QxNYgvErFv0XpDkx4nP8Q/Q34iEune0Nip+WM8YmQPai5VEouNzaFJXnBHngW/LmbJI sg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pw8b0n145-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 09:48:47 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 73ED110002A;
        Wed, 12 Apr 2023 09:48:46 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5CBC920FA32;
        Wed, 12 Apr 2023 09:48:46 +0200 (CEST)
Received: from [10.252.13.119] (10.252.13.119) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 12 Apr
 2023 09:48:45 +0200
Message-ID: <04180e5c-71ec-2f0f-c63b-185523110f1c@foss.st.com>
Date:   Wed, 12 Apr 2023 09:48:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 00/12] Fix busydetect on Ux500 PL180/MMCI
To:     Linus Walleij <linus.walleij@linaro.org>,
        Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org>
Content-Language: en-US
From:   Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.13.119]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_02,2023-04-11_02,2023-02-09_01
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/9/23 00:00, Linus Walleij wrote:
> This series fixes a pretty serious problem in the MMCI
> busy detect handling, discovered only after going up and
> down a ladder of refactorings.
> 
> The code is written expecting the Ux500 busy detect
> to fire two interrupts: one at the start of the busy
> signalling and one at the end of the busy signalling.
> 
> The root cause of the problem seen on some devices
> is that only the first IRQ arrives, and then the device
> hangs, waiting perpetually for the next IRQ to arrive.
> 
> This is eventually solved by adding a timeout using
> a delayed work that fire after 10 ms if the busy detect
> has not stopped at this point. (Other delay spans can
> be suggested.) This is the last patch in the series.
> 
> I included the rewrite of the entire busy detect logic
> to use a state machine as this makes it way easier to
> debug and will print messages about other error
> conditions as well.
> 
> The problem affects especially the Skomer
> (Samsung GT-I9070) and Kyle (Samsung SGH-I407).
> 
> It is fine to just apply this for the -next kernel,
> despite it fixes the busy detect that has been broken
> for these devices for a while, we can think about
> backporting a simpler version of the timeout for
> stable kernels if we want.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v2:
> - Drop pointless patch nr 1
> - Unconditionally intialize some state variables
> - Use a less fragile method to look for busy status when
>    using busy detect, should fix Yann's problem

Hi Linus,

Thanks for the update, it is now OK on STM32MP1.
For the series, you can add my:
Reviewed-by: Yann Gautier <yann.gautier@foss.st.com>


Best regards,
Yann

> - Link to v1: https://lore.kernel.org/r/20230405-pl180-busydetect-fix-v1-0-28ac19a74e5e@linaro.org
> 
> ---
> Linus Walleij (12):
>        mmc: mmci: Clear busy_status when starting command
>        mmc: mmci: Unwind big if() clause
>        mmc: mmci: Stash status while waiting for busy
>        mmc: mmci: Break out error check in busy detect
>        mmc: mmci: Make busy complete state machine explicit
>        mmc: mmci: Retry the busy start condition
>        mmc: mmci: Use state machine state as exit condition
>        mmc: mmci: Use a switch statement machine
>        mmc: mmci: Break out a helper function
>        mmc: mmci: mmci_card_busy() from state machine
>        mmc: mmci: Drop end IRQ from Ux500 busydetect
>        mmc: mmci: Add busydetect timeout
> 
>   drivers/mmc/host/mmci.c             | 166 ++++++++++++++++++++++++++++--------
>   drivers/mmc/host/mmci.h             |  17 ++++
>   drivers/mmc/host/mmci_stm32_sdmmc.c |   6 +-
>   3 files changed, 151 insertions(+), 38 deletions(-)
> ---
> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
> change-id: 20230405-pl180-busydetect-fix-66a0360d398a
> 
> Best regards,

