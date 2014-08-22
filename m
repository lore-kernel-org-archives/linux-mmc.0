From: Sonny Rao <sonnyrao@chromium.org>
Subject: Re: [PATCH V2 3/3] mmc: dw_mmc: Dont cut off vqmmc and vmmc
Date: Fri, 22 Aug 2014 11:27:38 -0700
Message-ID: <CAPz6YkXH1mMOTwcLkKdffdUHN+TaCAhpa8oG0h+rFn9i+GMoCw@mail.gmail.com>
References: <1408715272-13833-1-git-send-email-yuvaraj.cd@samsung.com>
 <1408715272-13833-4-git-send-email-yuvaraj.cd@samsung.com> <CAPDyKFqz8sGj2td=ihZXN4zvAqmu9FHZjWdCn-ZRcdHugNHe2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:47250 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932523AbaHVS17 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Aug 2014 14:27:59 -0400
Received: by mail-qc0-f170.google.com with SMTP id x3so11409252qcv.15
        for <linux-mmc@vger.kernel.org>; Fri, 22 Aug 2014 11:27:58 -0700 (PDT)
In-Reply-To: <CAPDyKFqz8sGj2td=ihZXN4zvAqmu9FHZjWdCn-ZRcdHugNHe2g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Doug Anderson <dianders@google.com>, Doug Anderson <dianders@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Tomasz Figa <t.figa@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, Prashanth G <prashanth.g@samsung.com>, ALIM AKHTAR <alim.akhtar@samsung.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, ABHILASH KESAVAN <a.kesavan@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

On Fri, Aug 22, 2014 at 8:31 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 22 August 2014 15:47, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com> wrote:
>> Exynos 5250 and 5420 based boards uses built-in CD# line for card
>> detection.But unfortunately CD# line is on the same voltage rails
>> as of I/O voltage rails. When we cut off vqmmc,the consequent card
>> detection will break in these boards.
>
> I am not sure I follow here.
>
> Is the card detect mechanism handled internally by the dw_mmc controller?

Yes

>
> I thought HW engineers long time ago realized that this should be done
> separately on a GPIO line to be able to save power while waiting for a
> card to be inserted. But that's not case then?

At least in my limited experience, this seems to be common among SoC
vendors who are using dw_mmc, as we've seen this elsewhere as well and
after seeing it here we know that we need to ignore the CD pin that's
routed to dw_mmc and use a separately powered GPIO on the board, but
still there are probably many SoCs/boards which are doing it this way.

>>
>> These hosts (obviously) need to keep vqmmc (and thus vmmc) on all the
>> time, even when the mmc core tells them to power off. However, one
>> problem is that these cards won't properly handle mmc_power_cycle().
>> That's needed to handle error cases when trying to switch voltages
>> (see 0797e5f mmc:core: Fixup signal voltage switch).
>>
>> This patch adds a new MMC_POWER_OFF_HARD mode when it's doing a power
>> cycle.  This mode differs from the normal MMC_POWER_OFF mode in that
>> the mmc core will promise to power the slot back on before it expects
>> the host to detect card insertion or removal.

This patch is based off of one that Doug wrote (sent privately to
Yuvaraj) which just modifies the MMC core, and should be split into
two patches.
One that modifies the mmc core and one that implements this in dw_mmc.

>>
>> Also if we let alone the vqmmc turned on when vmmc turned off, the
>> card could have half way powered and this can damage the card. So
>> this patch adds a check so that, if the board used the built-in
>> card detection mechanism i.e through CDETECT, it will not turned
>> down vqmmc and vmmc both.
>
> Why does vmmc needs to be enabled when there are no card inserted?
> That can't be right?

I think this is because we don't want to send power to a card over the
I/O pins but not the vcc pin, even for a little while. We also asked
some SD card manufacturers about whether it was okay to leave vqmmc on
and they recommended not doing this, because there's a risk of damage
to the card.

So, in this (broken) environment, we basically just keep both vmmc and
vqmmc on all the time unless mmc core is asking the driver to power
cycle the card through MMC_POWER_OFF and MMC_POWER_ON modes.

Does that help?

>
> Kind regards
> Uffe
>
>>
>> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> ---
>> changes from v1:
>>         1.added a new MMC_POWER_OFF_HARD mode as per Doug Anderson's suggestion.
>>         2.added dw_mci_exynos_post_init() to perform the host specific post
>>           initialisation.
>>         3.added a new flag MMC_CAP2_CD_NEEDS_POWER for host->caps2.
>>
>>  drivers/mmc/core/core.c          |   16 ++++++++++++++--
>>  drivers/mmc/core/debugfs.c       |    3 +++
>>  drivers/mmc/host/dw_mmc-exynos.c |   12 ++++++++++++
>>  drivers/mmc/host/dw_mmc.c        |   25 +++++++++++++++++++++++++
>>  drivers/mmc/host/dw_mmc.h        |    2 ++
>>  include/linux/mmc/host.h         |    2 ++
>>  6 files changed, 58 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 68f5f4b..79ced36 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1564,9 +1564,9 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
>>         mmc_host_clk_release(host);
>>  }
>>
>> -void mmc_power_off(struct mmc_host *host)
>> +void _mmc_power_off(struct mmc_host *host, unsigned char power_mode)
>>  {
>> -       if (host->ios.power_mode == MMC_POWER_OFF)
>> +       if (host->ios.power_mode == power_mode)
>>                 return;
>>
>>         mmc_host_clk_hold(host);
>> @@ -1579,6 +1579,7 @@ void mmc_power_off(struct mmc_host *host)
>>                 host->ios.chip_select = MMC_CS_DONTCARE;
>>         }
>>         host->ios.power_mode = MMC_POWER_OFF;
>> +       host->ios.power_mode = power_mode;
>>         host->ios.bus_width = MMC_BUS_WIDTH_1;
>>         host->ios.timing = MMC_TIMING_LEGACY;
>>         mmc_set_ios(host);
>> @@ -1593,9 +1594,20 @@ void mmc_power_off(struct mmc_host *host)
>>         mmc_host_clk_release(host);
>>  }
>>
>> +void mmc_power_off(struct mmc_host *host)
>> +{
>> +       _mmc_power_off(host, MMC_POWER_OFF);
>> +}
>> +
>>  void mmc_power_cycle(struct mmc_host *host, u32 ocr)
>>  {
>>         mmc_power_off(host);
>> +       /* If host normally ignores MMC_POWER_OFF, tell it to pay attention */
>> +       if (host->caps2 & MMC_CAP2_CD_NEEDS_POWER)
>> +               _mmc_power_off(host, MMC_POWER_OFF_HARD);
>> +       else
>> +               _mmc_power_off(host, MMC_POWER_OFF);
>> +
>>         /* Wait at least 1 ms according to SD spec */
>>         mmc_delay(1);
>>         mmc_power_up(host, ocr);
>> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
>> index 91eb162..3d9c5a3 100644
>> --- a/drivers/mmc/core/debugfs.c
>> +++ b/drivers/mmc/core/debugfs.c
>> @@ -108,6 +108,9 @@ static int mmc_ios_show(struct seq_file *s, void *data)
>>         case MMC_POWER_ON:
>>                 str = "on";
>>                 break;
>> +       case MMC_POWER_OFF_HARD:
>> +               str = "hard off";
>> +               break;
>>         default:
>>                 str = "invalid";
>>                 break;
>> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
>> index 0fbc53a..4e26049 100644
>> --- a/drivers/mmc/host/dw_mmc-exynos.c
>> +++ b/drivers/mmc/host/dw_mmc-exynos.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/mmc/mmc.h>
>>  #include <linux/of.h>
>>  #include <linux/of_gpio.h>
>> +#include <linux/mmc/slot-gpio.h>
>>  #include <linux/slab.h>
>>
>>  #include "dw_mmc.h"
>> @@ -217,6 +218,16 @@ static void dw_mci_exynos_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>>         }
>>  }
>>
>> +static void dw_mci_exynos_post_init(struct dw_mci_slot *slot)
>> +{
>> +       struct dw_mci_board *brd = slot->host->pdata;
>> +       struct mmc_host *mmc = slot->mmc;
>> +
>> +       if (!(brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION) &&
>> +                       IS_ERR_VALUE(mmc_gpio_get_cd(mmc)))
>> +               mmc->caps2 |= MMC_CAP2_CD_NEEDS_POWER;
>> +}
>> +
>>  static int dw_mci_exynos_parse_dt(struct dw_mci *host)
>>  {
>>         struct dw_mci_exynos_priv_data *priv;
>> @@ -399,6 +410,7 @@ static const struct dw_mci_drv_data exynos_drv_data = {
>>         .prepare_command        = dw_mci_exynos_prepare_command,
>>         .set_ios                = dw_mci_exynos_set_ios,
>>         .parse_dt               = dw_mci_exynos_parse_dt,
>> +       .post_init              = dw_mci_exynos_post_init,
>>         .execute_tuning         = dw_mci_exynos_execute_tuning,
>>  };
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index f20b4b8..6f2c681 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -972,6 +972,22 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>         spin_unlock_bh(&host->lock);
>>  }
>>
>> +/*
>> + * some of the boards use controller CD line for card detection.Unfortunately
>> + * CD line is bind to the same volatge domain as of the IO lines.If we turn off
>> + * IO voltage domain, CD line wont work.
>> + * Return true when controller CD line is used for card detection or return
>> + * false.
>> + */
>> +static bool dw_mci_builtin_cd(struct dw_mci_slot *slot)
>> +{
>> +       struct dw_mci_board *brd = slot->host->pdata;
>> +       struct mmc_host *mmc = slot->mmc;
>> +
>> +       return  (!(brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION) &&
>> +                       IS_ERR_VALUE(mmc_gpio_get_cd(mmc))) ? 1 : 0;
>> +}
>> +
>>  static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>  {
>>         struct dw_mci_slot *slot = mmc_priv(mmc);
>> @@ -1043,6 +1059,10 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>                 mci_writel(slot->host, PWREN, regs);
>>                 break;
>>         case MMC_POWER_OFF:
>> +               if (dw_mci_builtin_cd(slot) &&
>> +                               !test_bit(DW_MMC_CARD_PRESENT, &slot->flags))
>> +                       return;
>> +
>>                 if (!IS_ERR(mmc->supply.vmmc))
>>                         mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>>
>> @@ -1055,6 +1075,8 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>                 regs &= ~(1 << slot->id);
>>                 mci_writel(slot->host, PWREN, regs);
>>                 break;
>> +       case MMC_POWER_OFF_HARD:
>> +               break;
>>         default:
>>                 break;
>>         }
>> @@ -2310,6 +2332,9 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>         else
>>                 clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
>>
>> +       if (drv_data && drv_data->post_init)
>> +               drv_data->post_init(slot);
>> +
>>         ret = mmc_add_host(mmc);
>>         if (ret)
>>                 goto err_setup_bus;
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index 01b99e8..a3c2628 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -250,6 +250,7 @@ struct dw_mci_tuning_data {
>>   * @prepare_command: handle CMD register extensions.
>>   * @set_ios: handle bus specific extensions.
>>   * @parse_dt: parse implementation specific device tree properties.
>> + * @post_init: implementation specific post initialization.
>>   * @execute_tuning: implementation specific tuning procedure.
>>   *
>>   * Provide controller implementation specific extensions. The usage of this
>> @@ -263,6 +264,7 @@ struct dw_mci_drv_data {
>>         void            (*prepare_command)(struct dw_mci *host, u32 *cmdr);
>>         void            (*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
>>         int             (*parse_dt)(struct dw_mci *host);
>> +       void            (*post_init)(struct dw_mci_slot *slot);
>>         int             (*execute_tuning)(struct dw_mci_slot *slot, u32 opcode,
>>                                         struct dw_mci_tuning_data *tuning_data);
>>  };
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 4cbf614..5eb24ff 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -42,6 +42,7 @@ struct mmc_ios {
>>  #define MMC_POWER_OFF          0
>>  #define MMC_POWER_UP           1
>>  #define MMC_POWER_ON           2
>> +#define MMC_POWER_OFF_HARD     3
>>
>>         unsigned char   bus_width;              /* data bus width */
>>
>> @@ -283,6 +284,7 @@ struct mmc_host {
>>  #define MMC_CAP2_HS400         (MMC_CAP2_HS400_1_8V | \
>>                                  MMC_CAP2_HS400_1_2V)
>>  #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
>> +#define MMC_CAP2_CD_NEEDS_POWER (1 << 18)      /* Card detect needs power */
>>
>>         mmc_pm_flag_t           pm_caps;        /* supported pm features */
>>
>> --
>> 1.7.10.4
>>
