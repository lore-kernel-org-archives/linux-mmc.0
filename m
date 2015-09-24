From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [linux-sunxi] Re: [PATCH] mmc: sunxi: Fix clk-delay settings
Date: Thu, 24 Sep 2015 11:52:36 +0200
Message-ID: <5603C7E4.5050806@redhat.com>
References: <1443038808-10965-1-git-send-email-hdegoede@redhat.com>
 <CAPDyKFpOFLgAAH5cVo-v+atfXYz=H7vxLH-BEzCA_i1Cu6wTFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51219 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036AbbIXJwk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 Sep 2015 05:52:40 -0400
In-Reply-To: <CAPDyKFpOFLgAAH5cVo-v+atfXYz=H7vxLH-BEzCA_i1Cu6wTFg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, Mike Turquette <mturquette@linaro.org>, Jelle van der Waa <jelle@vdwaa.nl>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-sunxi@googlegroups.com

Hi,

On 23-09-15 23:50, Ulf Hansson wrote:
> On 23 September 2015 at 22:06, Hans de Goede <hdegoede@redhat.com> wrote:
>> In recent allwinner kernel sources the mmc clk-delay settings have been
>> slightly tweaked, and for sun9i they are completely different then what
>> we are using.
>>
>> This commit brings us in sync with what allwinner does, fixing problems
>> accessing sdcards on some A33 devices (and likely others).
>>
>> For pre sun9i hardware this makes the following changes:
>> -At 400Khz change the sample delay from 7 to 0 (introduced in A31 sdk)
>> -At 50 Mhz change the sample delay from 5 to 4 (introduced in A23 sdk)
>>
>> This also drops the clk-delay calculation for clocks > 50 MHz, we do
>> not need this as we've: mmc->f_max = 50000000, and the delays in the
>> old code were not correct (at 100 MHz the delay must be a multiple of 60,
>> at 200 MHz a multiple of 120).
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> I assume you want me to take this as a fix?

With that you mean take it into 4.3-rcX ? Yes please.

> If so, can we point to what commit it fixes?

Erm, the clk-sample settings this adjusts have been there more or less
unchanged since the driver was introduced, and were taken directly from
the allwinner A10 kernel source / SDK.

This just syncs them with improvements done to the settings in later
allwinner SDK-s, improvements which I found when I could not get multiple
cards to work on certain A33 based tablets.

Regards,

Hans

>> ---
>>   drivers/mmc/host/sunxi-mmc.c | 53 ++++++++++++++++++++++++++++++++------------
>>   1 file changed, 39 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>> index e6226cd..83de82b 100644
>> --- a/drivers/mmc/host/sunxi-mmc.c
>> +++ b/drivers/mmc/host/sunxi-mmc.c
>> @@ -210,6 +210,16 @@
>>   #define SDXC_IDMAC_DES0_CES    BIT(30) /* card error summary */
>>   #define SDXC_IDMAC_DES0_OWN    BIT(31) /* 1-idma owns it, 0-host owns it */
>>
>> +#define SDXC_CLK_400K          0
>> +#define SDXC_CLK_25M           1
>> +#define SDXC_CLK_50M           2
>> +#define SDXC_CLK_50M_DDR       3
>> +
>> +struct sunxi_mmc_clk_delay {
>> +       u32 output;
>> +       u32 sample;
>> +};
>> +
>>   struct sunxi_idma_des {
>>          u32     config;
>>          u32     buf_size;
>> @@ -229,6 +239,7 @@ struct sunxi_mmc_host {
>>          struct clk      *clk_mmc;
>>          struct clk      *clk_sample;
>>          struct clk      *clk_output;
>> +       const struct sunxi_mmc_clk_delay *clk_delays;
>>
>>          /* irq */
>>          spinlock_t      lock;
>> @@ -654,25 +665,19 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>>
>>          /* determine delays */
>>          if (rate <= 400000) {
>> -               oclk_dly = 180;
>> -               sclk_dly = 42;
>> +               oclk_dly = host->clk_delays[SDXC_CLK_400K].output;
>> +               sclk_dly = host->clk_delays[SDXC_CLK_400K].sample;
>>          } else if (rate <= 25000000) {
>> -               oclk_dly = 180;
>> -               sclk_dly = 75;
>> +               oclk_dly = host->clk_delays[SDXC_CLK_25M].output;
>> +               sclk_dly = host->clk_delays[SDXC_CLK_25M].sample;
>>          } else if (rate <= 50000000) {
>>                  if (ios->timing == MMC_TIMING_UHS_DDR50) {
>> -                       oclk_dly = 60;
>> -                       sclk_dly = 120;
>> +                       oclk_dly = host->clk_delays[SDXC_CLK_50M_DDR].output;
>> +                       sclk_dly = host->clk_delays[SDXC_CLK_50M_DDR].sample;
>>                  } else {
>> -                       oclk_dly = 90;
>> -                       sclk_dly = 150;
>> +                       oclk_dly = host->clk_delays[SDXC_CLK_50M].output;
>> +                       sclk_dly = host->clk_delays[SDXC_CLK_50M].sample;
>>                  }
>> -       } else if (rate <= 100000000) {
>> -               oclk_dly = 6;
>> -               sclk_dly = 24;
>> -       } else if (rate <= 200000000) {
>> -               oclk_dly = 3;
>> -               sclk_dly = 12;
>>          } else {
>>                  return -EINVAL;
>>          }
>> @@ -878,6 +883,7 @@ static int sunxi_mmc_card_busy(struct mmc_host *mmc)
>>   static const struct of_device_id sunxi_mmc_of_match[] = {
>>          { .compatible = "allwinner,sun4i-a10-mmc", },
>>          { .compatible = "allwinner,sun5i-a13-mmc", },
>> +       { .compatible = "allwinner,sun9i-a80-mmc", },
>>          { /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
>> @@ -892,6 +898,20 @@ static struct mmc_host_ops sunxi_mmc_ops = {
>>          .card_busy       = sunxi_mmc_card_busy,
>>   };
>>
>> +static const struct sunxi_mmc_clk_delay sunxi_mmc_clk_delays[] = {
>> +       [SDXC_CLK_400K]         = { .output = 180, .sample = 180 },
>> +       [SDXC_CLK_25M]          = { .output = 180, .sample =  75 },
>> +       [SDXC_CLK_50M]          = { .output =  90, .sample = 120 },
>> +       [SDXC_CLK_50M_DDR]      = { .output =  60, .sample = 120 },
>> +};
>> +
>> +static const struct sunxi_mmc_clk_delay sun9i_mmc_clk_delays[] = {
>> +       [SDXC_CLK_400K]         = { .output = 180, .sample = 180 },
>> +       [SDXC_CLK_25M]          = { .output = 180, .sample =  75 },
>> +       [SDXC_CLK_50M]          = { .output = 150, .sample = 120 },
>> +       [SDXC_CLK_50M_DDR]      = { .output =  90, .sample = 120 },
>> +};
>> +
>>   static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>>                                        struct platform_device *pdev)
>>   {
>> @@ -903,6 +923,11 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>>          else
>>                  host->idma_des_size_bits = 16;
>>
>> +       if (of_device_is_compatible(np, "allwinner,sun9i-a80-mmc"))
>> +               host->clk_delays = sun9i_mmc_clk_delays;
>> +       else
>> +               host->clk_delays = sunxi_mmc_clk_delays;
>> +
>>          ret = mmc_regulator_get_supply(host->mmc);
>>          if (ret) {
>>                  if (ret != -EPROBE_DEFER)
>> --
>> 2.5.0
>>
