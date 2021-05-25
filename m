Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF51C4707F
	for <linux-mmc@archiver.kernel.org>; Tue, 25 May 2021 19:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F2C6141B
	for <linux-mmc@archiver.kernel.org>; Tue, 25 May 2021 19:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhEYTda (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 May 2021 15:33:30 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:35546 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhEYTd3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 May 2021 15:33:29 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d64 with ME
        id 97Xv2500221Fzsu037Xvxk; Tue, 25 May 2021 21:31:58 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 25 May 2021 21:31:58 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] mmc: mxs-mmc: Disable the 'reg_vmmc' regulator when
 needed
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Doug Anderson <dianders@chromium.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Chris Ball <cjb@laptop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <d05074c11962a046ff9c2f457c240432ca8a7194.1621600443.git.christophe.jaillet@wanadoo.fr>
 <CAPDyKFrS3wdYs3AQtjZEOsLzNvxgy1n3EfxZ+a8w8J8rH8kQ-w@mail.gmail.com>
Message-ID: <7c973bfd-8fc3-026d-351c-dc00e92c8b01@wanadoo.fr>
Date:   Tue, 25 May 2021 21:31:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrS3wdYs3AQtjZEOsLzNvxgy1n3EfxZ+a8w8J8rH8kQ-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Le 24/05/2021 à 15:59, Ulf Hansson a écrit :
> On Fri, 21 May 2021 at 14:36, Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> The 'reg_vmmc' regulator is never disabled. Neither in the error handling
>> of the probe, nor in the remove function.
>>
>> Add a managed action to do the required clean-up before a 'regulator_put()'
>> call.
>>
>> Fixes: 4dc5a79f1350 ("mmc: mxs-mmc: enable regulator for mmc slot")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/mmc/host/mxs-mmc.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
>> index 947581de7860..b043d53dd728 100644
>> --- a/drivers/mmc/host/mxs-mmc.c
>> +++ b/drivers/mmc/host/mxs-mmc.c
>> @@ -552,6 +552,13 @@ static const struct of_device_id mxs_mmc_dt_ids[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, mxs_mmc_dt_ids);
>>
>> +static void regulator_disable_action(void *_data)
>> +{
>> +       struct regulator *regulator = _data;
>> +
>> +       regulator_disable(regulator);
>> +}
>> +
>>   static int mxs_mmc_probe(struct platform_device *pdev)
>>   {
>>          struct device_node *np = pdev->dev.of_node;
>> @@ -591,6 +598,10 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>>                                  "Failed to enable vmmc regulator: %d\n", ret);
>>                          goto out_mmc_free;
>>                  }
>> +               ret = devm_add_action_or_reset(&pdev->dev,
>> +                                       regulator_disable_action, reg_vmmc);
>> +               if (ret)
>> +                       goto out_mmc_free;
> 
> Even if this improves the behaviour, there is a standardized way for
> how we deal with regulators for mmc.
> 
> 1. Call mmc_regulator_get_supply() during probe to fetch the optional
> regulator. If a regulator is found a corresponding OCR mask, in
> host->ocr_avail is assigned.
> 
> 2. In the ->set_ios() callback, invoke mmc_regulator_set_ocr(). This
> will also set the correct voltage-level and turn on/off the regulator,
> depending on the requested OCR/voltage-level.

Hi,
I don't know this API.
I've tried to look at a few drivers to see how it was used, but it 
didn't help me either.

So, I won't be able to provide any other proposal on this. It would only 
be trial/error.
It is yours if something needs to be fixed here.

Anyway, thanks for your time for answering and trying to show the right 
direction.

CJ

> 
>>          }
>>
>>          ssp->clk = devm_clk_get(&pdev->dev, NULL);
>> --
>> 2.30.2
>>
> 
> Kind regards
> Uffe
> 

