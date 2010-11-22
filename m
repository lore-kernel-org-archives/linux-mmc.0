From: Philip Rakity <prakity@marvell.com>
Subject: Re: [RFC] sdhci: 8 bit bus width changes
Date: Mon, 22 Nov 2010 08:13:06 -0800
Message-ID: <C1554C82-70D9-4CE6-BFC3-469CF037B8D3@marvell.com>
References: <B76798A1-FA3F-4D7D-A22A-52289A4062FB@marvell.com>
 <20101119214002.GA19272@void.printf.net>
 <20101119215333.GB19272@void.printf.net>
 <20101120123553.GA11936@pengutronix.de>
 <20101120182423.GA31030@void.printf.net>
 <06A44983-1A70-4715-86AF-66C08DD381C0@marvell.com>
 <AANLkTimP8oRK_ALTbEXzL7Pp2VtJFef7eKGEA00Ers-7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:53733 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756093Ab0KVQPh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Nov 2010 11:15:37 -0500
In-Reply-To: <AANLkTimP8oRK_ALTbEXzL7Pp2VtJFef7eKGEA00Ers-7@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


On Nov 22, 2010, at 2:36 AM, zhangfei gao wrote:

> On Mon, Nov 22, 2010 at 3:17 AM, Philip Rakity <prakity@marvell.com> wrote:
>> From d52213a33a71142134555793583b726501827827 Mon Sep 17 00:00:00 2001
>> From: Philip Rakity <prakity@marvell.com>
>> Date: Sun, 21 Nov 2010 11:08:21 -0800
>> Subject: [PATCH] [PATCH] sdhci: resubmit 8 bit support based on feedback from list
>> 
>> a) QUIRK removed for 8 bit support since platform issue - not quirk
>> b) platform Flag defined for sdhci-pxa.c and plat-pxa
>> c) comments added to sdhci.c on usage
>> 
>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>> 
>> comments from previous submission
>> 
>> We now:
>> * check for a v3 controller before setting 8-bit bus width
>> * offer a callback for platform code to switch to 8-bit mode, which
>>  allows non-v3 controllers to support it
>> * introduce a quirk to specify that the board designers have indeed
>>  brought out all the pins for 8-bit to the slot.
>> 
>> We were previously relying only on whether the controller supported
>> 8-bit, which doesn't tell us anything about the pin configuration in
>> the board design.
>> 
>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>> Tested-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>> Signed-off-by: Chris Ball <cjb@laptop.org>
>> ---
>>  arch/arm/plat-pxa/include/plat/sdhci.h |    3 ++
>>  drivers/mmc/host/sdhci-pxa.c           |    4 ++
>>  drivers/mmc/host/sdhci.c               |   49 ++++++++++++++++++++++++--------
>>  drivers/mmc/host/sdhci.h               |    4 ++-
>>  4 files changed, 47 insertions(+), 13 deletions(-)
>> 
>> diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h b/arch/arm/plat-pxa/include/plat/sdhci.h
>> index e49c5b6..e85b58f 100644
>> --- a/arch/arm/plat-pxa/include/plat/sdhci.h
>> +++ b/arch/arm/plat-pxa/include/plat/sdhci.h
>> @@ -17,6 +17,9 @@
>>  /* Require clock free running */
>>  #define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
>> 
>> +/* board design supports 8 bit data on SD/SDIO BUS */
>> +#define PXA_FLAG_SD_8_BIT_CAPABLE_SLOT (1<<2)
>> +
>>  /*
>>  * struct pxa_sdhci_platdata() - Platform device data for PXA SDHCI
>>  * @max_speed: the maximum speed supported
>> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
>> index fc406ac..f609f4a 100644
>> --- a/drivers/mmc/host/sdhci-pxa.c
>> +++ b/drivers/mmc/host/sdhci-pxa.c
>> @@ -141,6 +141,10 @@ static int __devinit sdhci_pxa_probe(struct platform_device *pdev)
>>        if (pdata->quirks)
>>                host->quirks |= pdata->quirks;
>> 
>> +       /* if slot design supports 8 bit data - indicate this */
>> +       if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
>> +               host->mmc->caps |= MMC_CAP_8_BIT_DATA;
>> +
>>        ret = sdhci_add_host(host);
> 
> how about
>      /* if BOARD NOT support 8 BIT */
>       if (pdata->flags & PXA_FLAG_SD_CANT_8_BIT)
>               host->mmc->caps &= ~MMC_CAP_8_BIT_DATA;


A number of folks have found that enabling 8 bit by default breaks existing drivers.
Having it enabled by default is not a good idea.  New features should enabled by the 
platform code and not enabled by default.

> 
> 
>>        if (ret) {
>>                dev_err(&pdev->dev, "failed to add host\n");
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 154cbf8..03c801b 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1185,17 +1185,31 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>        if (host->ops->platform_send_init_74_clocks)
>>                host->ops->platform_send_init_74_clocks(host, ios->power_mode);
>> 
>> -       ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>> -
>> -       if (ios->bus_width == MMC_BUS_WIDTH_8)
>> -               ctrl |= SDHCI_CTRL_8BITBUS;
>> -       else
>> -               ctrl &= ~SDHCI_CTRL_8BITBUS;
>> +       /*
>> +        * If your platform has 8-bit width support but is not a v3 controller,
>> +        * or if it requires special setup code, you should implement that in
>> +        * platform_8bit_width().
>> +        */
>> +       if (host->ops->platform_8bit_width)
>> +               host->ops->platform_8bit_width(host, ios->bus_width);
>> +       else {
>> +               ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>> +               if (ios->bus_width == MMC_BUS_WIDTH_8) {
>> +                       ctrl &= ~SDHCI_CTRL_4BITBUS;
>> +                       if (host->version >= SDHCI_SPEC_300)
>> +                               ctrl |= SDHCI_CTRL_8BITBUS;
>> +               } else {
>> +                       if (host->version >= SDHCI_SPEC_300)
>> +                               ctrl &= ~SDHCI_CTRL_8BITBUS;
>> +                       if (ios->bus_width == MMC_BUS_WIDTH_4)
>> +                               ctrl |= SDHCI_CTRL_4BITBUS;
>> +                       else
>> +                               ctrl &= ~SDHCI_CTRL_4BITBUS;
>> +               }
>> +               sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>> +       }
>> 
>> -       if (ios->bus_width == MMC_BUS_WIDTH_4)
>> -               ctrl |= SDHCI_CTRL_4BITBUS;
>> -       else
>> -               ctrl &= ~SDHCI_CTRL_4BITBUS;
>> +       ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>> 
>>        if ((ios->timing == MMC_TIMING_SD_HS ||
>>             ios->timing == MMC_TIMING_MMC_HS)
>> @@ -1855,11 +1869,22 @@ int sdhci_add_host(struct sdhci_host *host)
>>                mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
>>        else
>>                mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
>> +
>>        mmc->f_max = host->max_clk;
>>        mmc->caps |= MMC_CAP_SDIO_IRQ;
>> 
>> -       if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
>> -               mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
>> +       /*
>> +        * A controller may support 8-bit width, but the board itself
>> +        * might not have the pins brought out.  So, boards that support
>> +        * 8-bit width should set the MMC_CAP_8_BIT_DATA and we won't assume
>> +        * that devices without the quirk can use 8-bit width.
>> +        *
>> +        * set mmc->caps |= MMC_CAP_8_BIT_DATA in platfrom code
>> +        * before call for_add_host to enable 8 bit support
>> +        */
>> +       if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA)) {
>> +               mmc->caps |= MMC_CAP_4_BIT_DATA;
>> +       }
> 
> i am afraid this will impact all platform supporting 8 bit emmc, if
> this logic is correct, why assume board could support 4-bit width.
> i think sdhci.c should describe controller behavior, instead of board
> specific behavior.


Concur about 4 bit support and said this on the mailing list earlier.  The original code by Pierre
assumes 4 bit bus width is always available.  

sdhci.c should only assume 1 bit mode works and the platform code should enable 4 and 8 bit support. 
Did not want to change the original assumptions as it impacts lots of platform code.  If the list thinks this
is a good idea I am open to preparing the patch to do this.

8 bit support is new -- I have not seen the impact that you are referring too.  


> 
>> 
>>        if (caps & SDHCI_CAN_DO_HISPD)
>>                mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index d52a716..ff18eaa 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -76,7 +76,7 @@
>>  #define   SDHCI_CTRL_ADMA1     0x08
>>  #define   SDHCI_CTRL_ADMA32    0x10
>>  #define   SDHCI_CTRL_ADMA64    0x18
>> -#define  SDHCI_CTRL_8BITBUS    0x20
>> +#define   SDHCI_CTRL_8BITBUS   0x20
>> 
>>  #define SDHCI_POWER_CONTROL    0x29
>>  #define  SDHCI_POWER_ON                0x01
>> @@ -215,6 +215,8 @@ struct sdhci_ops {
>>        unsigned int    (*get_max_clock)(struct sdhci_host *host);
>>        unsigned int    (*get_min_clock)(struct sdhci_host *host);
>>        unsigned int    (*get_timeout_clock)(struct sdhci_host *host);
>> +       int     (*platform_8bit_width)(struct sdhci_host *host,
>> +                               int width);
>>        void (*platform_send_init_74_clocks)(struct sdhci_host *host,
>>                                             u8 power_mode);
>>        unsigned int    (*get_ro)(struct sdhci_host *host);
>> --
>> 1.6.0.4
>> 
>> On Nov 20, 2010, at 10:24 AM, Chris Ball wrote:
>> 
>>> Hi,
>>> 
>>> On Sat, Nov 20, 2010 at 01:35:53PM +0100, Wolfram Sang wrote:
>>>> I know it's too late, but...
>>> 
>>> It's late, but it's not too late.  I'd like to send a fix for MMC cards
>>> to Linus within the next week.  If we decide to make some small changes
>>> here and can do it quickly, that should be fine.
>>> 
>>>> What does the platform_-prefix of the callback indicate?
>>> 
>>> That it's a hook for code (whether that's a -pltfm driver or an SDHCI
>>> driver) that knows more about the board-level setup to implement.
>>> 
>>>>> * introduce a quirk to specify that the board designers have indeed
>>>>>   brought out all the pins for 8-bit to the slot.
>>>> 
>>>> This is not a quirk, this is platform_data, no?
>>> 
>>> Yes, I agree that platform code would be more correct than the quirk.
>>> 
>>> Thanks,
>>> 
>>> --
>>> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
>>> One Laptop Per Child
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 

