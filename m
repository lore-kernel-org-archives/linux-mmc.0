From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: hsmmc: add max_freq field
Date: Fri, 23 Dec 2011 00:02:39 +0100
Message-ID: <4EF3B70F.5080604@gmail.com>
References: <1323868927-3738-1-git-send-email-zonque@gmail.com> <CAF=Qhp3UjugPL8eDzbJ9=-Yw0gxxpCFw7p13GS5LQEWrzHxLfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:32965 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab1LVXCo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Dec 2011 18:02:44 -0500
In-Reply-To: <CAF=Qhp3UjugPL8eDzbJ9=-Yw0gxxpCFw7p13GS5LQEWrzHxLfQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On 12/22/2011 08:37 PM, Kishore Kadiyala wrote:
> On Wed, Dec 14, 2011 at 6:52 PM, Daniel Mack <zonque@gmail.com> wrote:
>> External circuitry like level shifters may limit the maximum operation
>> speed of the hsmmc controller. Add a field to struct omap2_hsmmc_info
>> so boards can adjust the setting on demand.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> ---
>>  arch/arm/mach-omap2/hsmmc.c   |    1 +
>>  arch/arm/mach-omap2/hsmmc.h   |    2 ++
>>  drivers/mmc/host/omap_hsmmc.c |    8 ++++++--
>>  3 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
>> index f4a1020..4c7bc36 100644
>> --- a/arch/arm/mach-omap2/hsmmc.c
>> +++ b/arch/arm/mach-omap2/hsmmc.c
>> @@ -298,6 +298,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
>>        mmc->slots[0].caps = c->caps;
>>        mmc->slots[0].internal_clock = !c->ext_clock;
>>        mmc->dma_mask = 0xffffffff;
>> +       mmc->max_freq = c->max_freq;
>>        if (cpu_is_omap44xx())
>>                mmc->reg_offset = OMAP4_MMC_REG_OFFSET;
>>        else
>> diff --git a/arch/arm/mach-omap2/hsmmc.h b/arch/arm/mach-omap2/hsmmc.h
>> index f757e78..65a8c12 100644
>> --- a/arch/arm/mach-omap2/hsmmc.h
>> +++ b/arch/arm/mach-omap2/hsmmc.h
>> @@ -25,6 +25,8 @@ struct omap2_hsmmc_info {
>>        char    *name;          /* or NULL for default */
>>        struct device *dev;     /* returned: pointer to mmc adapter */
>>        int     ocr_mask;       /* temporary HACK */
>> +       int     max_freq;       /* maximum clock, if constrained by external
>> +                                * circuitry, or 0 for default */
>>        /* Remux (pad configuration) when powering on/off */
>>        void (*remux)(struct device *dev, int slot, int power_on);
>>        /* init some special card */
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 101cd31..8215ef9 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -1927,8 +1927,12 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
>>        if (mmc_slot(host).vcc_aux_disable_is_sleep)
>>                mmc_slot(host).no_off = 1;
>>
>> -       mmc->f_min      = OMAP_MMC_MIN_CLOCK;
>> -       mmc->f_max      = OMAP_MMC_MAX_CLOCK;
>> +       mmc->f_min = OMAP_MMC_MIN_CLOCK;
>> +
>> +       if (pdata->max_freq > 0)
> 
> What about having check as below:
> if (pdata->max_freq > 0 && pdata->max_freq < OMAP_MMC_MAX_CLOCK)

I can quickly do that if Tony agrees on it. Any opinions?

Thanks,
Daniel
