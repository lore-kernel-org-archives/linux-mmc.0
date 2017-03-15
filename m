From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: fix incorrect timeout clock
Date: Wed, 15 Mar 2017 10:42:31 +0200
Message-ID: <531c1247-e2eb-9d78-c798-1f510b3c841a@intel.com>
References: <20170213120610.1385-1-anssi.hannula@bitwise.fi>
 <CAPDyKFooBAwUvQ4L6TZLAP0nyu5WtBRoLjzO4ak9czmnJ92DRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:50408 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752040AbdCOIsC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Mar 2017 04:48:02 -0400
In-Reply-To: <CAPDyKFooBAwUvQ4L6TZLAP0nyu5WtBRoLjzO4ak9czmnJ92DRA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Anssi Hannula <anssi.hannula@bitwise.fi>, Shawn Lin <shawn.lin@rock-chips.com>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 14/03/17 18:20, Ulf Hansson wrote:
> On 13 February 2017 at 13:06, Anssi Hannula <anssi.hannula@bitwise.fi> wrote:
>> sdhci_arasan_get_timeout_clock() divides the frequency it has with (1 <<
>> (13 + divisor)).
>>
>> However, the divisor is not some Arasan-specific value, but instead is
>> just the Data Timeout Counter Value from the SDHCI Timeout Control
>> Register.
>>
>> Applying it here like this is wrong as the sdhci driver already takes
>> that value into account when calculating timeouts, and in fact it *sets*
>> that register value based on how long a timeout is wanted.
>>
>> Additionally, sdhci core interprets the .get_timeout_clock callback
>> return value as if it were read from hardware registers, i.e. the unit
>> should be kHz or MHz depending on SDHCI_TIMEOUT_CLK_UNIT capability bit.
>> This bit is set at least on the tested Zynq-7000 SoC.
>>
>> With the tested hardware (SDHCI_TIMEOUT_CLK_UNIT set) this results in
>> too high a timeout clock rate being reported, causing the core to use
>> longer-than-needed timeouts. Additionally, on a partitioned MMC
>> (therefore having erase_group_def bit set) mmc_calc_max_discard()
>> disables discard support as it looks like controller does not support
>> the long timeouts needed for that.
>>
>> Do not apply the extra divisor and return the timeout clock in the
>> expected unit.
>>
>> Tested with a Zynq-7000 SoC and a partitioned Toshiba THGBMAG5A1JBAWR
>> eMMC card.
>>
>> Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
>> Fixes: e3ec3a3d11ad ("mmc: arasan: Add driver for Arasan SDHCI")
>> Cc: <stable@vger.kernel.org>
> 
> Since this seems to fix the problem, I have applied this for fixes. Thanks!
> 
> If additional changes are needed, let's do those on top.

I agree.

Shawn, you will have to change your patch accordingly.

> 
> Kind regards
> Uffe
> 
>> ---
>>
>> The .get_timeout_clock situation seems rather messy altogether, but I
>> wasn't sure which direction to take it to and it is probably best to
>> have that separate from this bugfix, anyway, so I kept the scope
>> limited.
>>
>>
>>  drivers/mmc/host/sdhci-of-arasan.c | 14 +++++---------
>>  1 file changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>> index 410a55b..1cfd7f9 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -28,13 +28,9 @@
>>  #include "sdhci-pltfm.h"
>>  #include <linux/of.h>
>>
>> -#define SDHCI_ARASAN_CLK_CTRL_OFFSET   0x2c
>>  #define SDHCI_ARASAN_VENDOR_REGISTER   0x78
>>
>>  #define VENDOR_ENHANCED_STROBE         BIT(0)
>> -#define CLK_CTRL_TIMEOUT_SHIFT         16
>> -#define CLK_CTRL_TIMEOUT_MASK          (0xf << CLK_CTRL_TIMEOUT_SHIFT)
>> -#define CLK_CTRL_TIMEOUT_MIN_EXP       13
>>
>>  #define PHY_CLK_TOO_SLOW_HZ            400000
>>
>> @@ -163,15 +159,15 @@ static int sdhci_arasan_syscon_write(struct sdhci_host *host,
>>
>>  static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
>>  {
>> -       u32 div;
>>         unsigned long freq;
>>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>
>> -       div = readl(host->ioaddr + SDHCI_ARASAN_CLK_CTRL_OFFSET);
>> -       div = (div & CLK_CTRL_TIMEOUT_MASK) >> CLK_CTRL_TIMEOUT_SHIFT;
>> +       /* SDHCI timeout clock is in kHz */
>> +       freq = DIV_ROUND_UP(clk_get_rate(pltfm_host->clk), 1000);
>>
>> -       freq = clk_get_rate(pltfm_host->clk);
>> -       freq /= 1 << (CLK_CTRL_TIMEOUT_MIN_EXP + div);
>> +       /* or in MHz */
>> +       if (host->caps & SDHCI_TIMEOUT_CLK_UNIT)
>> +               freq = DIV_ROUND_UP(freq, 1000);
>>
>>         return freq;
>>  }
>> --
>> 2.8.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

