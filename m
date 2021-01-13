Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FE8C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C28DF233CE
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbhAMLfK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbhAMLfJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 06:35:09 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C446C061575
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:34:29 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DG52B1D9cz1s8vL;
        Wed, 13 Jan 2021 12:34:26 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DG52B0R34z1qqkw;
        Wed, 13 Jan 2021 12:34:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id sYKn3FNqEKDq; Wed, 13 Jan 2021 12:34:22 +0100 (CET)
X-Auth-Info: 8NKgG4WI1id14ec42vtqdyNS4AXM0ddjBFlmNIJJ5Hg=
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 13 Jan 2021 12:34:22 +0100 (CET)
Subject: Re: [PATCH] [RFC] mmc: mmci: Add support for probing bus voltage
 level translator
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>
References: <20210105140718.122752-1-marex@denx.de>
 <CAPDyKFoQfm2ZtPdsZSZtOCDH-FJqNzihYqZny-vUdK4Q4tWTzQ@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <b83c1112-010b-a40f-319f-84c755424b0f@denx.de>
Date:   Wed, 13 Jan 2021 12:34:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoQfm2ZtPdsZSZtOCDH-FJqNzihYqZny-vUdK4Q4tWTzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 1/13/21 11:44 AM, Ulf Hansson wrote:

[...]

>> NOTE: I would prefer this solution over having a custom DT per SoM,
>>        since it reduces the amount of DT combinations.
>> ---
>>   arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi | 32 ++++++++-
>>   drivers/mmc/host/mmci.c                      | 70 ++++++++++++++++++--
> 
> Please avoid mixing DTS changes with changes to code in drivers.

With RFC patch you likely want to see the whole picture, so I kept it in 
one patch.

>>   2 files changed, 96 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
>> index dc70ddd09e9d..a69cae19d92d 100644
>> --- a/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
>> +++ b/arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi
>> @@ -401,15 +401,45 @@ &rtc {
>>          status = "okay";
>>   };
>>
>> +&pinctrl {
>> +       sdmmc1_b4_init_pins_a: sdmmc1-init-b4-0 {
>> +               pins1 {
>> +                       pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
>> +                                <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
>> +                                <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
>> +                                <STM32_PINMUX('C', 11, AF12)>; /* SDMMC1_D3 */
>> +                       slew-rate = <1>;
>> +                       drive-push-pull;
>> +                       bias-disable;
>> +               };
>> +       };
>> +
>> +       sdmmc1_dir_init_pins_a: sdmmc1-init-dir-0 {
>> +               pins1 {
>> +                       pinmux = <STM32_PINMUX('F', 2, AF11)>, /* SDMMC1_D0DIR */
>> +                                <STM32_PINMUX('C', 7, AF8)>, /* SDMMC1_D123DIR */
>> +                                <STM32_PINMUX('B', 9, AF11)>; /* SDMMC1_CDIR */
>> +                       slew-rate = <1>;
>> +                       drive-push-pull;
>> +                       bias-pull-up;
>> +               };
>> +       };
>> +};
>> +
>>   &sdmmc1 {
>> -       pinctrl-names = "default", "opendrain", "sleep";
>> +       pinctrl-names = "default", "opendrain", "sleep", "init";
> 
> Apologize for my ignorance, but my understanding of "init" vs
> "default" is that "init" should be treated as the legacy name for the
> pinstate. I would appreciate Linus' opinion on this.

My understanding is that "init" is the way pins are configured before 
the driver reconfigures them to whatever the driver needs to configure 
them to. The "default" state is the normal operational state of the 
hardware, which often is the same as "init".

[...]

>>   static int mmci_of_parse(struct device_node *np, struct mmc_host *mmc)
>>   {
>>          struct mmci_host *host = mmc_priv(mmc);
>> @@ -1913,7 +1973,7 @@ static int mmci_of_parse(struct device_node *np, struct mmc_host *mmc)
>>          if (of_get_property(np, "st,neg-edge", NULL))
>>                  host->clk_reg_add |= MCI_STM32_CLK_NEGEDGE;
>>          if (of_get_property(np, "st,use-ckin", NULL))
>> -               host->clk_reg_add |= MCI_STM32_CLK_SELCKIN;
>> +               mmci_probe_level_translator(mmc);
> 
> I think you can make this change bit less invasive. Rather than having
> to shuffle code around in ->probe(), I suggest you call
> mmci_probe_level_translator() outside and after mmci_of_parse() has
> been called.
> 
> In this way, you can also provide mmci_probe_level_translator() with a
> struct mmci_host *, rather than having to pick it up from
> mmc_priv(mmc), if you see what I mean.
> 
> Of course, this also means in mmci_probe_level_translator() you will
> have to check if MCI_STM32_CLK_SELCKIN has been set, and if not then
> do an early return.

Testing the translator presence when checking whether its enabled in DT 
seems like the right place, but that's really just an implementation detail.

I am more interested in knowing whether adding 
mmci_probe_level_translator() is even acceptable in the first place. Is it ?
