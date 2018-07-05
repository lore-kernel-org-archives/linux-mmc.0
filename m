From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: disable clocks before changing
 frequency
Date: Thu, 05 Jul 2018 16:26:54 +0200
Message-ID: <7c2e40400de27f7887500f1ccf41db18@agner.ch>
References: <20180705121500.6256-1-stefan@agner.ch>
 <CAPDyKFrHH2Hm+Z1DgJiSunFwaC_yed_oVp82Y0dw7UMAhAq3+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrHH2Hm+Z1DgJiSunFwaC_yed_oVp82Y0dw7UMAhAq3+w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, marcel@ziswiler.com, linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 05.07.2018 15:09, Ulf Hansson wrote:
> On 5 July 2018 at 14:15, Stefan Agner <stefan@agner.ch> wrote:
>> In the uSDHC case (e.g. i.MX 6) clocks only get disabled if frequency
>> is set to 0. However, it could be that the stack asks for a frequency
>> change while clocks are on. In that case the function clears the
>> divider registers (by clearing ESDHC_CLOCK_MASK) while the clock is
>> enabled! This causes a short period of time where the clock is
>> undivided (on a i.MX 6DL a clock of 196MHz has been measured).
>>
>> For older IP variants the driver disables clock by clearing some bits
>> in ESDHC_SYSTEM_CONTROL.
>>
>> Make sure to disable card clock before chainging frequency for uSDHC
>> IP variants too. Also fix indent to make disable/enable clock look
>> alike.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> Thanks, applied for next!
> 
> Please tell if you want this for fixes and if I should add a stable tag.

I haven't seen any direct negative impact by that, so I don't think its
worth back-porting at this point.

--
Stefan

> 
> Kind regards
> Uffe
> 
>> ---
>>  drivers/mmc/host/sdhci-esdhc-imx.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index 85fd5a8b0b6d..aa48f4b2541a 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -708,14 +708,14 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>>         int div = 1;
>>         u32 temp, val;
>>
>> +       if (esdhc_is_usdhc(imx_data)) {
>> +               val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
>> +               writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
>> +                       host->ioaddr + ESDHC_VENDOR_SPEC);
>> +       }
>> +
>>         if (clock == 0) {
>>                 host->mmc->actual_clock = 0;
>> -
>> -               if (esdhc_is_usdhc(imx_data)) {
>> -                       val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
>> -                       writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
>> -                                       host->ioaddr + ESDHC_VENDOR_SPEC);
>> -               }
>>                 return;
>>         }
>>
>> @@ -761,7 +761,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>>         if (esdhc_is_usdhc(imx_data)) {
>>                 val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
>>                 writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
>> -               host->ioaddr + ESDHC_VENDOR_SPEC);
>> +                       host->ioaddr + ESDHC_VENDOR_SPEC);
>>         }
>>
>>         mdelay(1);
>> --
>> 2.18.0
>>
