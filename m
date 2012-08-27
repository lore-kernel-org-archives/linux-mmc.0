From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 06/10] mmc: omap_hsmmc: remove access to SYSCONFIG register
Date: Mon, 27 Aug 2012 16:34:58 +0530
Message-ID: <CANfBPZ_dgPBQye4MZYCUd1GG9mmYZO22t2MCDZtRn7_4a9=szw@mail.gmail.com>
References: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
 <1345229550-8672-7-git-send-email-svenkatr@ti.com> <CAM=Q2cv=YmZpXOVwzJt6qXGYkL9DpHbhv4CRNEkhWL8Mn+EOeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CAM=Q2cv=YmZpXOVwzJt6qXGYkL9DpHbhv4CRNEkhWL8Mn+EOeg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, balajitk@ti.com, vishp@ti.com
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 21, 2012 at 9:08 PM, Shubhrajyoti Datta
<omaplinuxkernel@gmail.com> wrote:
> Hi Venkat,
> Some doubts below.
>
> On Sat, Aug 18, 2012 at 12:22 AM, Venkatraman S <svenkatr@ti.com> wrote:
>> SYSCONFIG register of HSMMC IP is managed by the omap hwmod
>> abstraction layer.
>
> At init only right?
Yes.
>
>
>> Resetting the IP and configuring the correct
>> SYSCONFIG mode is centrally managed by hwmod.
>>
>> Remove code which manipulates IP reset and SYSCONFIG directly in the
>> driver.
>
> I am not sure if mmc needs a reset.
>
Actually it doesn't, as far as I know. That's why I propose it to be removed.

> However IMHO
> In case it needs a reset
>
> the hwmod way could be to use  omap_hwmod_reset
> However I  fear it may be an issue with dt.
> or
> may be sysc could be restored something like [1]
>
>
>
> if it doesnt need reset even the check for the SYSSTATUS could be
> considered for removal.
>
> [1] http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg12041.html
>
>
>
>>
>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>> ---
>>  drivers/mmc/host/omap_hsmmc.c | 24 ++----------------------
>>  1 file changed, 2 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index da4f5a7..4bc55ac 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -44,7 +44,6 @@
>>  #include <plat/cpu.h>
>>
>>  /* OMAP HSMMC Host Controller Registers */
>> -#define OMAP_HSMMC_SYSCONFIG   0x0010
>>  #define OMAP_HSMMC_SYSSTATUS   0x0014
>>  #define OMAP_HSMMC_CON         0x002C
>>  #define OMAP_HSMMC_BLK         0x0104
>> @@ -576,21 +575,8 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
>>         if (host->context_loss == context_loss)
>>                 return 1;
>>
>> -       /* Wait for hardware reset */
>> -       timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
>> -       while ((OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE) != RESETDONE
>> -               && time_before(jiffies, timeout))
>> -               ;
>> -
>> -       /* Do software reset */
>> -       OMAP_HSMMC_WRITE(host->base, SYSCONFIG, SOFTRESET);
>> -       timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
>> -       while ((OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE) != RESETDONE
>> -               && time_before(jiffies, timeout))
>> -               ;
>> -
>> -       OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
>> -                       OMAP_HSMMC_READ(host->base, SYSCONFIG) | AUTOIDLE);
>> +       if (!OMAP_HSMMC_READ(host->base, SYSSTATUS) & RESETDONE)
>> +               return 1;
> Should this check be removed.
>
No - it's still needed to check that the IP is ready for use.

>>
>>         if (host->pdata->controller_flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT) {
>>                 if (host->power_mode != MMC_POWER_OFF &&
>> @@ -1593,10 +1579,6 @@ static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
>>         value = OMAP_HSMMC_READ(host->base, CAPA);
>>         OMAP_HSMMC_WRITE(host->base, CAPA, value | capa);
>>
>> -       /* Set the controller to AUTO IDLE mode */
>> -       value = OMAP_HSMMC_READ(host->base, SYSCONFIG);
>> -       OMAP_HSMMC_WRITE(host->base, SYSCONFIG, value | AUTOIDLE);
>> -
>>         /* Set SD bus power bit */
>>         set_sd_bus_power(host);
>>  }
>> @@ -1654,8 +1636,6 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
>>
>>         pm_runtime_get_sync(host->dev);
>>
>> -       seq_printf(s, "SYSCONFIG:\t0x%08x\n",
>> -                       OMAP_HSMMC_READ(host->base, SYSCONFIG));
>>         seq_printf(s, "CON:\t\t0x%08x\n",
>>                         OMAP_HSMMC_READ(host->base, CON));
>>         seq_printf(s, "HCTL:\t\t0x%08x\n",
>> --
>> 1.7.11.1.25.g0e18bef
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
