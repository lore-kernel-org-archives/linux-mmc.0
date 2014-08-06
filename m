From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: Re: [PATCH v14 0/6] mmc: omap_hsmmc: Enable SDIO IRQ
Date: Wed, 06 Aug 2014 09:18:39 +0300
Message-ID: <53E1C8BF.8020209@compulab.co.il>
References: <1401352085-22781-1-git-send-email-afenkart@gmail.com> <CAPDyKFrFoDabt=2eC_p7SsDB1x+DNKdAY4V9xTTJ4XNnAaQ4oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrFoDabt=2eC_p7SsDB1x+DNKdAY4V9xTTJ4XNnAaQ4oA@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>, Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, Sebastian Reichel <sre@kernel.org>, Daniel Mack <zonque@gmail.com>, Kumar Gala <galak@codeaurora.org>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

I did not find this patch set in Chris MMC tree.
I did succeed to locate it in Linaro repo only.

When it will be merged in the mainline?

We are using SDIO IRQ patch with OMAP5 board and it is really useful.

Andreas, thank you.

Regards,

Dmitry


On 06/16/2014 12:26 PM, Ulf Hansson wrote:
> On 29 May 2014 10:27, Andreas Fenkart <afenkart@gmail.com> wrote:
>> Hi Balaji, Tony, Ulf, all
>>
>> v14
>> - drop all ifdef/endif introduced by v13
>> -- rely on pinctrl_lookup_state to prevent ifdef CONFIG_PM
>> -- benefit: all code is compile tested no matter the configuration
>> -- drawback: require wake_irq/pinctrl configuration even when
>>     runtime suspend is not configured
>> - drop runtime state from debugfs output
>> - rebased onto current mmc-next 06732b84b4cf
>
> Thanks! Applied for next.
>
> Kind regards
> Ulf Hansson
>
>>
>> v13
>> - fix compile breaks if !CONFIG_PM
>> - additional patch: install dummy pm runtime hooks if !CONFIG_PM_RUN=
TIME
>>
>> v12
>> - drop !CONFIG_OF compile break only exists when
>>    #undef CONFIG_OF after include headers 1/7(Sebastian Reichel)
>> - do not emit "falling back to polling" if wake_irq not specified
>>    since MMC does not need it, and it might confuse users
>>    only emit if pinmux default/idle is not present or claiming
>>    the irq failed 2/7(Balaji)
>> - dropped out-of-tree patches 6/7(Balaji)
>> - mention "ti,am33xx-hsmmc" compatible section in bindings
>>    documentation 1/5
>>
>> v11
>> - split !CONFIG_OF compile break into separate patch
>> - enable IWE/CLKEXTFREE in CON/HCTL register needed for omap4
>> - '&' vs '&&' in omap_hsmmc_resume, 1/5 (Andreas M=C3=BCller)
>> - #define DLEV_DAT instead of BIT(21) 2/5 (Balaji)
>> - pinctrl_pm_select_default_state() removed, 4/5 (Balaji)
>> - drop _irqsave/_irqrestore from omap_hsmmc_wake_irq handler since i=
t
>>    can't be preempted by same priority omap_hsmmc_irq handler 1/5(Jo=
el Fernandes)
>> - replace devres_open_group by explicit devm_free calls 1/5 (Balaji)
>> - disable_irq_nosync wake_irq since we handle it thread safe 1/5 (Ba=
laji)
>> - drop 'gpio_dat1' pinctrl states and rework documentation 5/5 (Bala=
ji)
>>
>> v10
>> - bug fix on multi-core, untested
>> - incorporated changes from Balaji
>> - use devres / RAII mechanism to configure wake_up /
>>    sdio irq capabilities
>> - drop pinctrl state 'active'
>>    rely on driver-model states 'default', 'idle'
>> - add specific 'gpio_dat1' state for am335x SWAKEUP hack
>> - reorganized patches; +1 patch multi-core bugfix / +1 for pinctrl
>> - rebased 455c6fdbd21916 / cherry-picks from mmc-next
>>
>> v9
>> - extended comment about why wake-irq is needed
>> - drop double '(' ')' around card_detect_irq
>> - drop final '.' in in subject line of patch
>>
>> v8
>> - rebased on top of Tony Lindgren<tony@atomide.com> changes
>>    - improved changelog describing the earlier work
>>    - improved wakeup irq setup
>>    - works for am3730 es platform now
>> - my changes on top:
>>    - compile tested with #undef CONFIG_OF
>>    - disable wake_irq in handler to prevent infinite loop
>>    - fixed typo and added comment about wake-irq
>>
>> v7
>> - rebase on 3.14.0-rc3-49726-g77e15ec
>> - split omap_hsmmc_pin_init due to regression on omap-3730 platform
>>
>> v6
>> - rebase on Linux 3.13-rc3
>> - reformatting debugfs
>>
>> v5
>> - fix compile error introduced by last minute one line fix
>>
>> v4:
>> - switch to interrupts-extended format
>> - drop ti,swakeup-missing flag convert to comaptible section
>>
>> v3:
>> - removed gpio_irq from platform_data
>>
>> v2:
>> - incorparated changes as suggested by reviewers
>> - simplified workaround for am335x, gpio will now only wake
>>    the module from runtime suspend, not handle the sdio irq
>>    itself
>>
>> Andreas Fenkart (6):
>>    mmc: omap_hsmmc: Enable SDIO interrupt
>>    mmc: omap_hsmmc: Extend debugfs by SDIO IRQ handling, runtime sta=
te
>>    mmc: omap_hsmmc: enable wakeup event for sdio OMAP4
>>    mmc: omap_hsmmc: abort runtime suspend if pending sdio irq detect=
ed
>>    mmc: omap_hsmmc: switch default/idle pinctrl states in runtime ho=
oks
>>    mmc: omap_hsmmc: Pin remux workaround to support SDIO interrupt o=
n
>>      AM335x
>>
>>   .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   54 ++++
>>   drivers/mmc/host/omap_hsmmc.c                      |  283 ++++++++=
++++++++++--
>>   include/linux/platform_data/mmc-omap.h             |    1 +
>>   3 files changed, 317 insertions(+), 21 deletions(-)
>>
>> --
>> 1.7.10.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

