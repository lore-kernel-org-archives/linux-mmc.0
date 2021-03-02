Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC82C28CFA
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3A564E62
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243066AbhCCBsB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Mar 2021 20:48:01 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:49452 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1572986AbhCBOIV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Mar 2021 09:08:21 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122E0rVV003184;
        Tue, 2 Mar 2021 15:06:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=B/YQiWDteqAy1if94IzoLqwuQ5Yxhjv54jSJ587Pt5c=;
 b=rrwW2S2e16/v+wy9LH7QS1EXJ13aPTwEtUvid3GPu7UE8T3l+XY3bZ7FTCM8Tb9C/cb/
 IRQj/0PYDIeNsHQQ4o2Q4ZvqMToglbxMcx6HsmLTjyPtloykSXXAiMRas3VfDkpraHHc
 bDvHWvlFnRfORTs9DoXmmYXlBu18LK7lznof/puoH31Q5L26DNBFYyIO18mySRcQQBZ8
 pc8PBN7wZ9cAKb9kB3a923dq2U/58tknSBofszH3jUq9VH7GjI/0SAtRYGy6xsyIHLtg
 oGOxmkyquZ8ijP+CAL7kra09+0wO7iHS8fYZeeNHWD7/6YRfLhK/ldLu79GeHkEikofh yA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 370xehqcv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 15:06:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BAB51100034;
        Tue,  2 Mar 2021 15:06:51 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9512923A2E1;
        Tue,  2 Mar 2021 15:06:51 +0100 (CET)
Received: from lmecxl0504.lme.st.com (10.75.127.49) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Mar
 2021 15:06:50 +0100
Subject: Re: [PATCH v2] mmc: mmci: manage MMC_CAP_NEED_RSP_BUSY for stm32
 variant
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        =?UTF-8?Q?Marek_Va=c5=a1ut?= <marex@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20210225145454.12780-1-yann.gautier@foss.st.com>
 <CAPDyKFo-98OWNg4QJ1cgY2QwYFB9d-6tVrMs0RYt6-=cU3-73w@mail.gmail.com>
From:   Yann Gautier <yann.gautier@foss.st.com>
Message-ID: <3c1f963c-e3bf-cedf-307c-dfbc96260e9c@foss.st.com>
Date:   Tue, 2 Mar 2021 15:06:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFo-98OWNg4QJ1cgY2QwYFB9d-6tVrMs0RYt6-=cU3-73w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_06:2021-03-01,2021-03-02 signatures=0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 3/2/21 11:40 AM, Ulf Hansson wrote:
> On Thu, 25 Feb 2021 at 15:55, Yann Gautier <yann.gautier@foss.st.com> wrote:
>>
>> To properly manage commands awaiting R1B responses, the capability
>> MMC_CAP_NEED_RSP_BUSY is enabled in mmci driver, for stm32 variant.
>> The issue was seen on STM32MP157C-EV1 board, with an erase command,
>> with secure erase argument, letting the card stuck, possibly waiting
>> for 4 hours before timeout.
>>
>> Fixes: 94fe2580a2f3 ("mmc: core: Enable erase/discard/trim support for all mmc hosts")
>>
>> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>
>> ---
>> This is somehow a v2 for patch [1].
>> Changes:
>> - Only apply MMC_CAP_NEED_RSP_BUSY to stm32 variant
>> - Cap the used timeout written to MMCIDATATIMER (when using
>> MMC_CAP_NEED_RSP_BUSY, cmd->busy_timeout may be greater than
>> host->max_busy_timeout)
>>
>>   [1] https://patchwork.kernel.org/project/linux-mmc/patch/20210204120547.15381-2-yann.gautier@foss.st.com/
>>
>>   drivers/mmc/host/mmci.c             | 8 +++++++-
>>   drivers/mmc/host/mmci_stm32_sdmmc.c | 1 +
>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
>> index 17dbc81c221e..89e0e9ccfb71 100644
>> --- a/drivers/mmc/host/mmci.c
>> +++ b/drivers/mmc/host/mmci.c
>> @@ -1242,7 +1242,13 @@ mmci_start_command(struct mmci_host *host, struct mmc_command *cmd, u32 c)
>>                  if (!cmd->busy_timeout)
>>                          cmd->busy_timeout = 10 * MSEC_PER_SEC;
>>
>> -               clks = (unsigned long long)cmd->busy_timeout * host->cclk;
>> +               if (host->mmc->caps & MMC_CAP_NEED_RSP_BUSY &&
>> +                   host->mmc->max_busy_timeout &&
>> +                   cmd->busy_timeout > host->mmc->max_busy_timeout)
> 
> We are already within "if (host->variant->busy_timeout ....", a few
> lines above, which means this can be simplified into:
> 
> if (cmd->busy_timeout > host->mmc->max_busy_timeout)
> 
>> +                       clks = (unsigned long long)host->mmc->max_busy_timeout * host->cclk;
>> +               else
>> +                       clks = (unsigned long long)cmd->busy_timeout * host->cclk;
>> +
>>                  do_div(clks, MSEC_PER_SEC);
>>                  writel_relaxed(clks, host->base + MMCIDATATIMER);
>>          }
>> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
>> index 51db30acf4dc..2ad577618324 100644
>> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
>> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
>> @@ -522,6 +522,7 @@ void sdmmc_variant_init(struct mmci_host *host)
>>
>>          host->ops = &sdmmc_variant_ops;
>>          host->pwr_reg = readl_relaxed(host->base + MMCIPOWER);
>> +       host->mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
> 
> To make it more clear that this is for variants having the
> ->busy_timeout flag set, I suggest to move this into mmci_probe().
> 
>>
>>          base_dlyb = devm_of_iomap(mmc_dev(host->mmc), np, 1, NULL);
>>          if (IS_ERR(base_dlyb))
>> --
>> 2.17.1
>>
> 
> Well, I decided to help out a bit. I have amend the patch according to
> the above and extended the commit message with some valuable
> information, based upon our earlier discussions.
> 
> Patch is applied at my fixes branch with a stable tag, please have a
> look, test and shout at me if there is something that looks wrong!
> 
> Thanks and kind regards
> Uffe
> 

Hi Ulf,

Thanks a lot for the updated patch.
I've tested it on STM32MP157C-EV1. The MMC_TEST full campaigns for both 
SD-card and eMMC run OK.


Best regards,
Yann
