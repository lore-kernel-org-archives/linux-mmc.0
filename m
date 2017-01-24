From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v3 3/13] mmc: sunxi: Always set signal delay to 0 for A64
Date: Tue, 24 Jan 2017 09:15:45 +0000
Message-ID: <b09f2ee5-77b3-eb2e-d749-d76a310bf1b0@arm.com>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
 <67fd7dad745b49bb8edb7391655eaddf6f35160e.1484585798.git-series.maxime.ripard@free-electrons.com>
 <CAPDyKFoatUWz0AwY6e73OCguDx70B1B5OAoPUYX-JDPsru+aZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750710AbdAXJO1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Jan 2017 04:14:27 -0500
In-Reply-To: <CAPDyKFoatUWz0AwY6e73OCguDx70B1B5OAoPUYX-JDPsru+aZw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Ulf,

On 24/01/17 08:16, Ulf Hansson wrote:
> On 16 January 2017 at 17:56, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> Experience have shown that the using the  autocalibration could severely
>> degrade the performances of the MMC bus.
>>
>> Allwinner is using in its BSP a delay set to 0 for all the modes but HS400.
>> Remove the calibration code for now, and add comments to document our
>> findings.
> 
> So doesn't this break some platforms using HS400? Or are you saying
> those are already broken?

This is a sunxi specific calibration routine, which was introduced
lately (e1b8dfd1b1c6) to be used by the Allwinner's enhanced MMC
controller. This is only used by devices using the sun50i-a64-mmc
compatible, of which this series introduces the first user.

So there is no way this can regress in any way, since the code wasn't
actually used before.

Cheers,
Andre.

> 
>>
>> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>  drivers/mmc/host/sunxi-mmc.c | 50 ++++++++++++-------------------------
>>  1 file changed, 17 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>> index 019f95e8e7c5..b9c8a62bc212 100644
>> --- a/drivers/mmc/host/sunxi-mmc.c
>> +++ b/drivers/mmc/host/sunxi-mmc.c
>> @@ -683,41 +683,19 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
>>
>>  static int sunxi_mmc_calibrate(struct sunxi_mmc_host *host, int reg_off)
>>  {
>> -       u32 reg = readl(host->reg_base + reg_off);
>> -       u32 delay;
>> -       unsigned long timeout;
>> -
>>         if (!host->cfg->can_calibrate)
>>                 return 0;
>>
>> -       reg &= ~(SDXC_CAL_DL_MASK << SDXC_CAL_DL_SW_SHIFT);
>> -       reg &= ~SDXC_CAL_DL_SW_EN;
>> -
>> -       writel(reg | SDXC_CAL_START, host->reg_base + reg_off);
>> -
>> -       dev_dbg(mmc_dev(host->mmc), "calibration started\n");
>> -
>> -       timeout = jiffies + HZ * SDXC_CAL_TIMEOUT;
>> -
>> -       while (!((reg = readl(host->reg_base + reg_off)) & SDXC_CAL_DONE)) {
>> -               if (time_before(jiffies, timeout))
>> -                       cpu_relax();
>> -               else {
>> -                       reg &= ~SDXC_CAL_START;
>> -                       writel(reg, host->reg_base + reg_off);
>> -
>> -                       return -ETIMEDOUT;
>> -               }
>> -       }
>> -
>> -       delay = (reg >> SDXC_CAL_DL_SHIFT) & SDXC_CAL_DL_MASK;
>> -
>> -       reg &= ~SDXC_CAL_START;
>> -       reg |= (delay << SDXC_CAL_DL_SW_SHIFT) | SDXC_CAL_DL_SW_EN;
>> -
>> -       writel(reg, host->reg_base + reg_off);
>> -
>> -       dev_dbg(mmc_dev(host->mmc), "calibration ended, reg is 0x%x\n", reg);
>> +       /*
>> +        * FIXME:
>> +        * This is not clear how the calibration is supposed to work
>> +        * yet. The best rate have been obtained by simply setting the
>> +        * delay to 0, as Allwinner does in its BSP.
>> +        *
>> +        * The only mode that doesn't have such a delay is HS400, that
>> +        * is in itself a TODO.
>> +        */
>> +       writel(SDXC_CAL_DL_SW_EN, host->reg_base + reg_off);
>>
>>         return 0;
>>  }
>> @@ -809,7 +787,13 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
>>         if (ret)
>>                 return ret;
>>
>> -       /* TODO: enable calibrate on sdc2 SDXC_REG_DS_DL_REG of A64 */
>> +       /*
>> +        * FIXME:
>> +        *
>> +        * In HS400 we'll also need to calibrate the data strobe
>> +        * signal. This should only happen on the MMC2 controller (at
>> +        * least on the A64).
>> +        */
>>
>>         return sunxi_mmc_oclk_onoff(host, 1);
>>  }
>> --
>> git-series 0.8.11
