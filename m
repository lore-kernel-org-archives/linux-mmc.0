From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH RFC 05/15] mmc: sunxi: Support MMC_DDR52 timing modes
Date: Thu, 21 Jan 2016 19:55:01 +0800
Message-ID: <CAGb2v640b6tygtu1TkBEYM6Uf6JqpytzqUQ-Y1uxKf9PUwpQaA@mail.gmail.com>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
 <1453354002-28366-6-git-send-email-wens@csie.org> <56A0BD8F.2000805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:56980 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbcAULz1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2016 06:55:27 -0500
In-Reply-To: <56A0BD8F.2000805@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>

On Thu, Jan 21, 2016 at 7:14 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 21-01-16 06:26, Chen-Yu Tsai wrote:
>>
>> DDR transfer modes include UHS-1 DDR50 and MMC HS-DDR (or MMC_DDR52).
>> Consider MMC_DDR52 when setting clock delays.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>   drivers/mmc/host/sunxi-mmc.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>> index 4bec87458317..b403a2433eec 100644
>> --- a/drivers/mmc/host/sunxi-mmc.c
>> +++ b/drivers/mmc/host/sunxi-mmc.c
>> @@ -687,7 +687,8 @@ static int sunxi_mmc_clk_set_rate(struct
>> sunxi_mmc_host *host,
>>                 oclk_dly = host->clk_delays[SDXC_CLK_25M].output;
>>                 sclk_dly = host->clk_delays[SDXC_CLK_25M].sample;
>>         } else if (rate <= 50000000) {
>
>
> Shouldn't this be <= 52000000 then, considering that we may at one point get
> some PLL setup where we may actually be able to do 52000000 for
> MMC_TIMING_MMC_DDR52 ?

Given that mmc->f_max = 50000000, the core will never try any clock rate higher
than 50 MHz, and iirc clk_round_rate always rounds down. We could increase both
numbers at the same time when we actually encounter such hardware.

Or we could increase both now, which I actually did in an earlier version, but
it really made no difference with current hardware.


Regards
ChenYu

>
>> -               if (ios->timing == MMC_TIMING_UHS_DDR50) {
>> +               if (ios->timing == MMC_TIMING_UHS_DDR50 ||
>> +                   ios->timing == MMC_TIMING_MMC_DDR52) {
>>                         oclk_dly =
>> host->clk_delays[SDXC_CLK_50M_DDR].output;
>>                         sclk_dly =
>> host->clk_delays[SDXC_CLK_50M_DDR].sample;
>>                 } else {
>> @@ -762,7 +763,8 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc,
>> struct mmc_ios *ios)
>>
>>         /* set ddr mode */
>>         rval = mmc_readl(host, REG_GCTRL);
>> -       if (ios->timing == MMC_TIMING_UHS_DDR50)
>> +       if (ios->timing == MMC_TIMING_UHS_DDR50 ||
>> +           ios->timing == MMC_TIMING_MMC_DDR52)
>>                 rval |= SDXC_DDR_MODE;
>>         else
>>                 rval &= ~SDXC_DDR_MODE;
>>
>
> Regards,
>
> Hans
