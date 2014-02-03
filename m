From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH V2 2/2] mmc: core: Enable MMC_CAP2_CACHE_CTRL as default
Date: Sun, 2 Feb 2014 16:53:26 -0800
Message-ID: <CAGOxZ50eMD-nFSj8PWvx2fAbO+uHm2UZgR=MxtpjH1+TDrEp4g@mail.gmail.com>
References: <1387483461-6317-1-git-send-email-ulf.hansson@linaro.org> <1387483461-6317-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:34192 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbaBCAyH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 2 Feb 2014 19:54:07 -0500
Received: by mail-ve0-f175.google.com with SMTP id c14so4391757vea.6
        for <linux-mmc@vger.kernel.org>; Sun, 02 Feb 2014 16:54:06 -0800 (PST)
In-Reply-To: <1387483461-6317-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

Hi Ulf

On Thu, Dec 19, 2013 at 12:04 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> There are no reason to why the use of a non-volatile internal eMMC
> cache should be controlled by a host cap. Instead let's just enable it
> if the eMMC card supports it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/core/core.c  |    4 ----
>  drivers/mmc/core/mmc.c   |    3 +--
>  include/linux/mmc/host.h |    1 -
>  3 files changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index df591a9..1228a59 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2582,12 +2582,8 @@ EXPORT_SYMBOL(mmc_power_restore_host);
>   */
>  int mmc_flush_cache(struct mmc_card *card)
>  {
> -       struct mmc_host *host = card->host;
>         int err = 0;
>
> -       if (!(host->caps2 & MMC_CAP2_CACHE_CTRL))
> -               return err;
> -

I have back port this patch to a 3.8 based kernel and was  testing
cache_ctrl feature of emmc device.
It gives below kernel panic with a suspend/resume cycle.

========

26.084474] Unable to handle kernel NULL pointer dereference at virtual
 address 000001bc
 [   26.092203] pgd = eabb4000
 [   26.100593] [000001bc] *pgd=00000000
 [   26.104157] Internal error: Oops: 5 [#1] SMP ARM
 [   26.138663] CPU: 0    Tainted: G         C    (3.8.11 #164)
 [   26.144221] PC is at mmc_flush_cache+0x18/0xd4
 [   26.148640] LR is at mmc_suspend_host+0x34/0x188
 [   26.153238] pc : [<c03b2bd4>]    lr : [<c03b3e54>]    psr: 60000013
 [   26.153238] sp : edf73d60  ip : edf73d88  fp : edf73d84
 [   26.164687] r10: 00000002  r9 : c07d8b2c  r8 : c07a6bc8
 [   26.169892] r7 : ef2d5244  r6 : ede09818  r5 : ede09818  r4 :
 edddb400
 [   26.176399] r3 : 271ae517  r2 : 271ae517  r1 : 60000013  r0 :
 00000000
 [   26.182906] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
 Segment user
 [   26.190019] Control: 10c5387d  Table: 4abb406a  DAC: 00000015
 [   26.195744] Process cat (pid: 7087, stack limit = 0xedf72240)
 [   26.377050] Backtrace:
 [   26.379401] [<c03b2bd4>] (mmc_flush_cache+0x18/0xd4) from
 [<c03b3e54>] (mmc_suspend_host+0x34/0x188)
 [   26.388506] [<c03b3e54>] (mmc_suspend_host+0x34/0x188) from
 [<c03c7e24>] (dw_mci_suspend+0x40/0x88)
 [   26.397528] [<c03c7e24>] (dw_mci_suspend+0x40/0x88) from
 [<c03ca278>] (dw_mci_exynos_suspend+0x1c/0x20)
 [   26.406898] [<c03ca278>] (dw_mci_exynos_suspend+0x1c/0x20) from
 [<c02d0a04>] (platform_pm_suspend+0x3c/0x64)
 [   26.416701] [<c02d0a04>] (platform_pm_suspend+0x3c/0x64) from
 [<c02d594c>] (dpm_run_callback.isra.5+0x24/0x4c)
 [   26.426677] [<c02d594c>] (dpm_run_callback.isra.5+0x24/0x4c) from
 [<c02d6564>] (__device_suspend+0x188/0x214)
 [   26.436565] [<c02d6564>] (__device_suspend+0x188/0x214) from
 [<c02d6e44>] (dpm_suspend+0xbc/0x218)
 [   26.445501] [<c02d6e44>] (dpm_suspend+0xbc/0x218) from [<c02d7200>]
 (dpm_suspend_start+0x6c/0x74)
 [   26.454352] [<c02d7200>] (dpm_suspend_start+0x6c/0x74) from
 [<c006c944>] (suspend_devices_and_enter+0x8c/0x294)
 [   26.464414] [<c006c944>] (suspend_devices_and_enter+0x8c/0x294) from
 [<c006cbfc>] (pm_suspend+0xb0/0x19c)
 [   26.473955] [<c006cbfc>] (pm_suspend+0xb0/0x19c) from [<c006bd68>]
 (state_store+0xbc/0xd0)
 [   26.482197] [<c006bd68>] (state_store+0xbc/0xd0) from [<c020ea20>]
 (kobj_attr_store+0x1c/0x28)
 [   26.490787] [<c020ea20>] (kobj_attr_store+0x1c/0x28) from
 [<c015cfd0>] (sysfs_write_file+0x114/0x158)
 [   26.499980] [<c015cfd0>] (sysfs_write_file+0x114/0x158) from
 [<c00fff08>] (vfs_write+0xbc/0x14c)
 [   26.508741] [<c00fff08>] (vfs_write+0xbc/0x14c) from [<c0100098>]
 (sys_write+0x5c/0xa4)
 [   26.516723] [<c0100098>] (sys_write+0x5c/0xa4) from [<c000e2c0>]
 (ret_fast_syscall+0x0/0x30)
 [   26.525137] Code: e24cb004 e24dd00c e92d4000 e8bd4000 (e59011bc)
 [   26.531276] ---[ end trace 04c2942721bcd221 ]---
 [   26.537224] Kernel panic - not syncing: Fatal exception

========
Looks like mmc_flush_cache() is called for even SD cards,
and probably since SD cards does not have ext_csd register, and it is
trying to access the same below, its give kernel panic.
As my kernel is still 3.8, so I am not sure if I missed any other
patch which is/are needed and already taking care of such crashes.
By adding a check for card->type does make this crash goes away.

+ if (mmc_card_mmc(card) != MMC_TYPE_MMC)
+              return err;

Do you know if this is the right thing to do?

>         if (mmc_card_mmc(card) &&
>                         (card->ext_csd.cache_size > 0) &&
>                         (card->ext_csd.cache_ctrl & 1)) {
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index ef1cc73..7ab3e9c 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1287,8 +1287,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>          * If cache size is higher than 0, this indicates
>          * the existence of cache and it can be turned on.
>          */
> -       if ((host->caps2 & MMC_CAP2_CACHE_CTRL) &&
> -                       card->ext_csd.cache_size > 0) {
> +       if (card->ext_csd.cache_size > 0) {
>                 err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                                 EXT_CSD_CACHE_CTRL, 1,
>                                 card->ext_csd.generic_cmd6_time);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index f539bc7..8383e3f 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -264,7 +264,6 @@ struct mmc_host {
>         u32                     caps2;          /* More host capabilities */
>
>  #define MMC_CAP2_BOOTPART_NOACC        (1 << 0)        /* Boot partition no access */
> -#define MMC_CAP2_CACHE_CTRL    (1 << 1)        /* Allow cache control */
>  #define MMC_CAP2_FULL_PWR_CYCLE        (1 << 2)        /* Can do full power cycle */
>  #define MMC_CAP2_NO_MULTI_READ (1 << 3)        /* Multiblock reads don't work */
>  #define MMC_CAP2_NO_SLEEP_CMD  (1 << 4)        /* Don't allow sleep command */
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Regards,
Alim
