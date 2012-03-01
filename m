From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH V2 1/1] mmc: start removing enable / disable API
Date: Thu, 1 Mar 2012 18:10:40 +0530
Message-ID: <CANfBPZ-JLoMqq0ZfpbFTHDprkAPdqorTRyuyAJ=oLCbSwWhRjg@mail.gmail.com>
References: <1330499841-6879-1-git-send-email-adrian.hunter@intel.com> <1330499841-6879-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:60392 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759054Ab2CAMlD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 1 Mar 2012 07:41:03 -0500
Received: by bkwj4 with SMTP id j4so496182bkw.26
        for <linux-mmc@vger.kernel.org>; Thu, 01 Mar 2012 04:41:00 -0800 (PST)
In-Reply-To: <1330499841-6879-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>

On Wed, Feb 29, 2012 at 12:47 PM, Adrian Hunter <adrian.hunter@intel.co=
m> wrote:
> Most parts of the enable / disable API are no longer used and
> can be removed.
>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Venkatraman S <svenkatr@ti.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Tested on OMAP4 SDP Platform
Tested-by: Venkatraman S <svenkatr@ti.com>
> ---
> =A0arch/arm/mach-exynos/mach-nuri.c =A0 =A0 =A0 =A0 =A0 | =A0 =A05 +-
> =A0arch/arm/mach-exynos/mach-universal_c210.c | =A0 =A09 +-
> =A0drivers/mmc/core/core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
187 +++-------------------------
> =A0drivers/mmc/core/host.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A01 -
> =A0drivers/mmc/core/host.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A01 -
> =A0drivers/mmc/host/davinci_mmc.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04 =
-
> =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 15 =
+--
> =A0include/linux/mmc/core.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A01 -
> =A0include/linux/mmc/host.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 46 +------
> =A09 files changed, 27 insertions(+), 242 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/=
mach-nuri.c
> index 644af11..de68248 100644
> --- a/arch/arm/mach-exynos/mach-nuri.c
> +++ b/arch/arm/mach-exynos/mach-nuri.c
> @@ -109,7 +109,7 @@ static struct s3c_sdhci_platdata nuri_hsmmc0_data=
 __initdata =3D {
> =A0 =A0 =A0 =A0.max_width =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 8,
> =A0 =A0 =A0 =A0.host_caps =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D (MMC_CAP_8_B=
IT_DATA | MMC_CAP_4_BIT_DATA |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMC_CA=
P_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP=
_DISABLE | MMC_CAP_ERASE),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP=
_ERASE),
> =A0 =A0 =A0 =A0.cd_type =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D S3C_SDHCI_=
CD_PERMANENT,
> =A0};
>
> @@ -147,8 +147,7 @@ static struct platform_device emmc_fixed_voltage =
=3D {
> =A0static struct s3c_sdhci_platdata nuri_hsmmc2_data __initdata =3D {
> =A0 =A0 =A0 =A0.max_width =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4,
> =A0 =A0 =A0 =A0.host_caps =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D MMC_CAP_4_BI=
T_DATA |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP=
_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP=
_DISABLE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP=
_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
> =A0 =A0 =A0 =A0.ext_cd_gpio =A0 =A0 =A0 =A0 =A0 =A0=3D EXYNOS4_GPX3(3=
), =A0 =A0 =A0/* XEINT_27 */
> =A0 =A0 =A0 =A0.ext_cd_gpio_invert =A0 =A0 =3D 1,
> =A0 =A0 =A0 =A0.cd_type =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D S3C_SDHCI_=
CD_GPIO,
> diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/ma=
ch-exynos/mach-universal_c210.c
> index 9b3fbae..57cfe61 100644
> --- a/arch/arm/mach-exynos/mach-universal_c210.c
> +++ b/arch/arm/mach-exynos/mach-universal_c210.c
> @@ -734,8 +734,7 @@ static struct platform_device universal_gpio_keys=
 =3D {
> =A0static struct s3c_sdhci_platdata universal_hsmmc0_data __initdata =
=3D {
> =A0 =A0 =A0 =A0.max_width =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 8,
> =A0 =A0 =A0 =A0.host_caps =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D (MMC_CAP_8_B=
IT_DATA | MMC_CAP_4_BIT_DATA |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP=
_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP=
_DISABLE),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP=
_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
> =A0 =A0 =A0 =A0.cd_type =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D S3C_SDHCI_=
CD_PERMANENT,
> =A0};
>
> @@ -772,8 +771,7 @@ static struct platform_device mmc0_fixed_voltage =
=3D {
> =A0static struct s3c_sdhci_platdata universal_hsmmc2_data __initdata =
=3D {
> =A0 =A0 =A0 =A0.max_width =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4,
> =A0 =A0 =A0 =A0.host_caps =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D MMC_CAP_4_BI=
T_DATA |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP=
_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP=
_DISABLE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP=
_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
> =A0 =A0 =A0 =A0.ext_cd_gpio =A0 =A0 =A0 =A0 =A0 =A0=3D EXYNOS4_GPX3(4=
), =A0 =A0 =A0/* XEINT_28 */
> =A0 =A0 =A0 =A0.ext_cd_gpio_invert =A0 =A0 =3D 1,
> =A0 =A0 =A0 =A0.cd_type =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D S3C_SDHCI_=
CD_GPIO,
> @@ -783,8 +781,7 @@ static struct s3c_sdhci_platdata universal_hsmmc2=
_data __initdata =3D {
> =A0static struct s3c_sdhci_platdata universal_hsmmc3_data __initdata =
=3D {
> =A0 =A0 =A0 =A0.max_width =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4,
> =A0 =A0 =A0 =A0.host_caps =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D MMC_CAP_4_BI=
T_DATA |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP=
_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP=
_DISABLE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP=
_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
> =A0 =A0 =A0 =A0.cd_type =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D S3C_SDHCI_=
CD_EXTERNAL,
> =A0};
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 0b317f0..44dd013 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -605,105 +605,6 @@ unsigned int mmc_align_data_size(struct mmc_car=
d *card, unsigned int sz)
> =A0EXPORT_SYMBOL(mmc_align_data_size);
>
> =A0/**
> - * =A0 =A0 mmc_host_enable - enable a host.
> - * =A0 =A0 @host: mmc host to enable
> - *
> - * =A0 =A0 Hosts that support power saving can use the 'enable' and =
'disable'
> - * =A0 =A0 methods to exit and enter power saving states. For more i=
nformation
> - * =A0 =A0 see comments for struct mmc_host_ops.
> - */
> -int mmc_host_enable(struct mmc_host *host)
> -{
> - =A0 =A0 =A0 if (!(host->caps & MMC_CAP_DISABLE))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 if (host->en_dis_recurs)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 if (host->nesting_cnt++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 cancel_delayed_work_sync(&host->disable);
> -
> - =A0 =A0 =A0 if (host->enabled)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 if (host->ops->enable) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int err;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->en_dis_recurs =3D 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_clk_hold(host);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D host->ops->enable(host);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_clk_release(host);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->en_dis_recurs =3D 0;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: enable er=
ror %d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_=
hostname(host), err);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 host->enabled =3D 1;
> - =A0 =A0 =A0 return 0;
> -}
> -EXPORT_SYMBOL(mmc_host_enable);
> -
> -static int mmc_host_do_disable(struct mmc_host *host, int lazy)
> -{
> - =A0 =A0 =A0 if (host->ops->disable) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int err;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->en_dis_recurs =3D 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_clk_hold(host);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D host->ops->disable(host, lazy);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_clk_release(host);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->en_dis_recurs =3D 0;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: disable e=
rror %d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_=
hostname(host), err);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err > 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long delay =3D=
 msecs_to_jiffies(err);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_schedule_delayed_wo=
rk(&host->disable, delay);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 host->enabled =3D 0;
> - =A0 =A0 =A0 return 0;
> -}
> -
> -/**
> - * =A0 =A0 mmc_host_disable - disable a host.
> - * =A0 =A0 @host: mmc host to disable
> - *
> - * =A0 =A0 Hosts that support power saving can use the 'enable' and =
'disable'
> - * =A0 =A0 methods to exit and enter power saving states. For more i=
nformation
> - * =A0 =A0 see comments for struct mmc_host_ops.
> - */
> -int mmc_host_disable(struct mmc_host *host)
> -{
> - =A0 =A0 =A0 int err;
> -
> - =A0 =A0 =A0 if (!(host->caps & MMC_CAP_DISABLE))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 if (host->en_dis_recurs)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 if (--host->nesting_cnt)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 if (!host->enabled)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 err =3D mmc_host_do_disable(host, 0);
> - =A0 =A0 =A0 return err;
> -}
> -EXPORT_SYMBOL(mmc_host_disable);
> -
> -/**
> =A0* =A0 =A0 __mmc_claim_host - exclusively claim a host
> =A0* =A0 =A0 @host: mmc host to claim
> =A0* =A0 =A0 @abort: whether or not the operation should be aborted
> @@ -741,8 +642,8 @@ int __mmc_claim_host(struct mmc_host *host, atomi=
c_t *abort)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wake_up(&host->wq);
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->lock, flags);
> =A0 =A0 =A0 =A0remove_wait_queue(&host->wq, &wait);
> - =A0 =A0 =A0 if (!stop)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_enable(host);
> + =A0 =A0 =A0 if (host->ops->enable && !stop && host->claim_cnt =3D=3D=
 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->enable(host);
> =A0 =A0 =A0 =A0return stop;
> =A0}
>
> @@ -767,21 +668,28 @@ int mmc_try_claim_host(struct mmc_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0claimed_host =3D 1;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->lock, flags);
> + =A0 =A0 =A0 if (host->ops->enable && claimed_host && host->claim_cn=
t =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->enable(host);
> =A0 =A0 =A0 =A0return claimed_host;
> =A0}
> =A0EXPORT_SYMBOL(mmc_try_claim_host);
>
> =A0/**
> - * =A0 =A0 mmc_do_release_host - release a claimed host
> + * =A0 =A0 mmc_release_host - release a host
> =A0* =A0 =A0 @host: mmc host to release
> =A0*
> - * =A0 =A0 If you successfully claimed a host, this function will
> - * =A0 =A0 release it again.
> + * =A0 =A0 Release a MMC host, allowing others to claim the host
> + * =A0 =A0 for their operations.
> =A0*/
> -void mmc_do_release_host(struct mmc_host *host)
> +void mmc_release_host(struct mmc_host *host)
> =A0{
> =A0 =A0 =A0 =A0unsigned long flags;
>
> + =A0 =A0 =A0 WARN_ON(!host->claimed);
> +
> + =A0 =A0 =A0 if (host->ops->disable && host->claim_cnt =3D=3D 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->disable(host);
> +
> =A0 =A0 =A0 =A0spin_lock_irqsave(&host->lock, flags);
> =A0 =A0 =A0 =A0if (--host->claim_cnt) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Release for nested claim */
> @@ -793,67 +701,6 @@ void mmc_do_release_host(struct mmc_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wake_up(&host->wq);
> =A0 =A0 =A0 =A0}
> =A0}
> -EXPORT_SYMBOL(mmc_do_release_host);
> -
> -void mmc_host_deeper_disable(struct work_struct *work)
> -{
> - =A0 =A0 =A0 struct mmc_host *host =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 container_of(work, struct mmc_host, dis=
able.work);
> -
> - =A0 =A0 =A0 /* If the host is claimed then we do not want to disabl=
e it anymore */
> - =A0 =A0 =A0 if (!mmc_try_claim_host(host))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> - =A0 =A0 =A0 mmc_host_do_disable(host, 1);
> - =A0 =A0 =A0 mmc_do_release_host(host);
> -}
> -
> -/**
> - * =A0 =A0 mmc_host_lazy_disable - lazily disable a host.
> - * =A0 =A0 @host: mmc host to disable
> - *
> - * =A0 =A0 Hosts that support power saving can use the 'enable' and =
'disable'
> - * =A0 =A0 methods to exit and enter power saving states. For more i=
nformation
> - * =A0 =A0 see comments for struct mmc_host_ops.
> - */
> -int mmc_host_lazy_disable(struct mmc_host *host)
> -{
> - =A0 =A0 =A0 if (!(host->caps & MMC_CAP_DISABLE))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 if (host->en_dis_recurs)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 if (--host->nesting_cnt)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 if (!host->enabled)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> -
> - =A0 =A0 =A0 if (host->disable_delay) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_schedule_delayed_work(&host->disabl=
e,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msecs_t=
o_jiffies(host->disable_delay));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> - =A0 =A0 =A0 } else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mmc_host_do_disable(host, 1);
> -}
> -EXPORT_SYMBOL(mmc_host_lazy_disable);
> -
> -/**
> - * =A0 =A0 mmc_release_host - release a host
> - * =A0 =A0 @host: mmc host to release
> - *
> - * =A0 =A0 Release a MMC host, allowing others to claim the host
> - * =A0 =A0 for their operations.
> - */
> -void mmc_release_host(struct mmc_host *host)
> -{
> - =A0 =A0 =A0 WARN_ON(!host->claimed);
> -
> - =A0 =A0 =A0 mmc_host_lazy_disable(host);
> -
> - =A0 =A0 =A0 mmc_do_release_host(host);
> -}
> -
> =A0EXPORT_SYMBOL(mmc_release_host);
>
> =A0/*
> @@ -2206,8 +2053,6 @@ void mmc_stop_host(struct mmc_host *host)
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->lock, flags);
> =A0#endif
>
> - =A0 =A0 =A0 if (host->caps & MMC_CAP_DISABLE)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&host->disable);
> =A0 =A0 =A0 =A0cancel_delayed_work_sync(&host->detect);
> =A0 =A0 =A0 =A0mmc_flush_scheduled_work();
>
> @@ -2402,13 +2247,11 @@ int mmc_suspend_host(struct mmc_host *host)
> =A0{
> =A0 =A0 =A0 =A0int err =3D 0;
>
> - =A0 =A0 =A0 if (host->caps & MMC_CAP_DISABLE)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&host->disable);
> =A0 =A0 =A0 =A0cancel_delayed_work(&host->detect);
> =A0 =A0 =A0 =A0mmc_flush_scheduled_work();
> =A0 =A0 =A0 =A0if (mmc_try_claim_host(host)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_cache_ctrl(host, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_do_release_host(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_release_host(host);
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -EBUSY;
> =A0 =A0 =A0 =A0}
> @@ -2429,7 +2272,7 @@ int mmc_suspend_host(struct mmc_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->bus_ops->sus=
pend) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D=
 host->bus_ops->suspend(host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_do_release_host(hos=
t);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_release_host(host);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err =3D=3D -ENOSYS=
 || !host->bus_ops->resume) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index c3704e2..91c84c7 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -330,7 +330,6 @@ struct mmc_host *mmc_alloc_host(int extra, struct=
 device *dev)
> =A0 =A0 =A0 =A0spin_lock_init(&host->lock);
> =A0 =A0 =A0 =A0init_waitqueue_head(&host->wq);
> =A0 =A0 =A0 =A0INIT_DELAYED_WORK(&host->detect, mmc_rescan);
> - =A0 =A0 =A0 INIT_DELAYED_WORK_DEFERRABLE(&host->disable, mmc_host_d=
eeper_disable);
> =A0#ifdef CONFIG_PM
> =A0 =A0 =A0 =A0host->pm_notify.notifier_call =3D mmc_pm_notify;
> =A0#endif
> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
> index 08a7852..f2ab9e5 100644
> --- a/drivers/mmc/core/host.h
> +++ b/drivers/mmc/core/host.h
> @@ -14,7 +14,6 @@
>
> =A0int mmc_register_host_class(void);
> =A0void mmc_unregister_host_class(void);
> -void mmc_host_deeper_disable(struct work_struct *work);
>
> =A0#endif
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinc=
i_mmc.c
> index 64a8325..8de9c9b 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1418,17 +1418,14 @@ static int davinci_mmcsd_suspend(struct devic=
e *dev)
> =A0 =A0 =A0 =A0struct mmc_davinci_host *host =3D platform_get_drvdata=
(pdev);
> =A0 =A0 =A0 =A0int ret;
>
> - =A0 =A0 =A0 mmc_host_enable(host->mmc);
> =A0 =A0 =A0 =A0ret =3D mmc_suspend_host(host->mmc);
> =A0 =A0 =A0 =A0if (!ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writel(0, host->base + DAVINCI_MMCIM);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_davinci_reset_ctrl(host, 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_disable(host->mmc);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_disable(host->clk);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->suspended =3D 1;
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->suspended =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_disable(host->mmc);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return ret;
> @@ -1444,7 +1441,6 @@ static int davinci_mmcsd_resume(struct device *=
dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0clk_enable(host->clk);
> - =A0 =A0 =A0 mmc_host_enable(host->mmc);
>
> =A0 =A0 =A0 =A0mmc_davinci_reset_ctrl(host, 0);
> =A0 =A0 =A0 =A0ret =3D mmc_resume_host(host->mmc);
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 36e7f5b..fdb24cf 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -179,7 +179,6 @@ struct omap_hsmmc_host {
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 got_dbclk;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 response_b=
usy;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 context_lo=
ss;
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dpm_state;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vdd;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 protect_ca=
rd;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reqs_block=
ed;
> @@ -1748,7 +1747,7 @@ static int omap_hsmmc_enable_fclk(struct mmc_ho=
st *mmc)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int omap_hsmmc_disable_fclk(struct mmc_host *mmc, int lazy)
> +static int omap_hsmmc_disable_fclk(struct mmc_host *mmc)
> =A0{
> =A0 =A0 =A0 =A0struct omap_hsmmc_host *host =3D mmc_priv(mmc);
>
> @@ -1782,15 +1781,8 @@ static int omap_hsmmc_regs_show(struct seq_fil=
e *s, void *data)
> =A0 =A0 =A0 =A0if (host->pdata->get_context_loss_count)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0context_loss =3D host->pdata->get_cont=
ext_loss_count(host->dev);
>
> - =A0 =A0 =A0 seq_printf(s, "mmc%d:\n"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " enabled:\t%d\n"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " dpm_state:\t%d\n"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " nesting_cnt:\t%d\n"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " ctx_loss:\t%d:%d\n"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "\nregs:\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->index, mmc->enable=
d ? 1 : 0,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dpm_state, mmc->n=
esting_cnt,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->context_loss, con=
text_loss);
> + =A0 =A0 =A0 seq_printf(s, "mmc%d:\n ctx_loss:\t%d:%d\n\nregs:\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->index, host->conte=
xt_loss, context_loss);
>
> =A0 =A0 =A0 =A0if (host->suspended) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0seq_printf(s, "host suspended, can't r=
ead registers\n");
> @@ -1930,7 +1922,6 @@ static int __init omap_hsmmc_probe(struct platf=
orm_device *pdev)
>
> =A0 =A0 =A0 =A0omap_hsmmc_context_save(host);
>
> - =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_DISABLE;
> =A0 =A0 =A0 =A0if (host->pdata->controller_flags & OMAP_HSMMC_BROKEN_=
MULTIBLOCK_READ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_info(&pdev->dev, "multiblock reads=
 disabled due to 35xx erratum 2.1.1.128; MMC read performance may suffe=
r\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps2 |=3D MMC_CAP2_NO_MULTI_READ=
;
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 87a976c..2bfa589 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -175,7 +175,6 @@ extern unsigned int mmc_align_data_size(struct mm=
c_card *, unsigned int);
>
> =A0extern int __mmc_claim_host(struct mmc_host *host, atomic_t *abort=
);
> =A0extern void mmc_release_host(struct mmc_host *host);
> -extern void mmc_do_release_host(struct mmc_host *host);
> =A0extern int mmc_try_claim_host(struct mmc_host *host);
>
> =A0extern int mmc_flush_cache(struct mmc_card *);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 37147a4..4da98f7 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -80,34 +80,11 @@ struct mmc_ios {
>
> =A0struct mmc_host_ops {
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* Hosts that support power saving can use the 'enabl=
e' and 'disable'
> - =A0 =A0 =A0 =A0* methods to exit and enter power saving states. 'en=
able' is called
> - =A0 =A0 =A0 =A0* when the host is claimed and 'disable' is called (=
or scheduled with
> - =A0 =A0 =A0 =A0* a delay) when the host is released. The 'disable' =
is scheduled if
> - =A0 =A0 =A0 =A0* the disable delay set by 'mmc_set_disable_delay()'=
 is non-zero,
> - =A0 =A0 =A0 =A0* otherwise 'disable' is called immediately. 'disabl=
e' may be
> - =A0 =A0 =A0 =A0* scheduled repeatedly, to permit ever greater power=
 saving at the
> - =A0 =A0 =A0 =A0* expense of ever greater latency to re-enable. Resc=
heduling is
> - =A0 =A0 =A0 =A0* determined by the return value of the 'disable' me=
thod. A positive
> - =A0 =A0 =A0 =A0* value gives the delay in milliseconds.
> - =A0 =A0 =A0 =A0*
> - =A0 =A0 =A0 =A0* In the case where a host function (like set_ios) m=
ay be called
> - =A0 =A0 =A0 =A0* with or without the host claimed, enabling and dis=
abling can be
> - =A0 =A0 =A0 =A0* done directly and will nest correctly. Call 'mmc_h=
ost_enable()' and
> - =A0 =A0 =A0 =A0* 'mmc_host_lazy_disable()' for this purpose, but no=
te that these
> - =A0 =A0 =A0 =A0* functions must be paired.
> - =A0 =A0 =A0 =A0*
> - =A0 =A0 =A0 =A0* Alternatively, 'mmc_host_enable()' may be paired w=
ith
> - =A0 =A0 =A0 =A0* 'mmc_host_disable()' which calls 'disable' immedia=
tely. =A0In this
> - =A0 =A0 =A0 =A0* case the 'disable' method will be called with 'laz=
y' set to 0.
> - =A0 =A0 =A0 =A0* This is mainly useful for error paths.
> - =A0 =A0 =A0 =A0*
> - =A0 =A0 =A0 =A0* Because lazy disable may be called from a work que=
ue, the 'disable'
> - =A0 =A0 =A0 =A0* method must claim the host when 'lazy' !=3D 0, whi=
ch will work
> - =A0 =A0 =A0 =A0* correctly because recursion is detected and handle=
d.
> + =A0 =A0 =A0 =A0* 'enable' is called when the host is claimed and 'd=
isable' is called
> + =A0 =A0 =A0 =A0* when the host is released. 'enable' and 'disable' =
are deprecated.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0int (*enable)(struct mmc_host *host);
> - =A0 =A0 =A0 int (*disable)(struct mmc_host *host, int lazy);
> + =A0 =A0 =A0 int (*disable)(struct mmc_host *host);
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * It is optional for the host to implement pre_req an=
d post_req in
> =A0 =A0 =A0 =A0 * order to support double buffering of requests (prep=
are one
> @@ -218,7 +195,7 @@ struct mmc_host {
> =A0#define MMC_CAP_SPI =A0 =A0 =A0 =A0 =A0 =A0(1 << 4) =A0 =A0 =A0 =A0=
/* Talks only SPI protocols */
> =A0#define MMC_CAP_NEEDS_POLL =A0 =A0 (1 << 5) =A0 =A0 =A0 =A0/* Need=
s polling for card-detection */
> =A0#define MMC_CAP_8_BIT_DATA =A0 =A0 (1 << 6) =A0 =A0 =A0 =A0/* Can =
the host do 8 bit transfers */
> -#define MMC_CAP_DISABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 7) =A0 =
=A0 =A0 =A0/* Can the host be disabled */
> +
> =A0#define MMC_CAP_NONREMOVABLE =A0 (1 << 8) =A0 =A0 =A0 =A0/* Nonrem=
ovable e.g. eMMC */
> =A0#define MMC_CAP_WAIT_WHILE_BUSY =A0 =A0 =A0 =A0(1 << 9) =A0 =A0 =A0=
 =A0/* Waits while card is busy */
> =A0#define MMC_CAP_ERASE =A0 =A0 =A0 =A0 =A0(1 << 10) =A0 =A0 =A0 /* =
Allow erase/trim commands */
> @@ -301,13 +278,7 @@ struct mmc_host {
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0removed:1; =A0 =A0=
 =A0/* host is being removed */
> =A0#endif
>
> - =A0 =A0 =A0 /* Only used with MMC_CAP_DISABLE */
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enabled; =A0=
 =A0 =A0 =A0/* host is enabled */
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rescan_dis=
able; /* disable card detection */
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nesting_cnt=
; =A0 =A0/* "enable" nesting count */
> - =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 en_dis_recu=
rs; =A0/* detect recursion */
> - =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0disable_delay; =A0/=
* disable delay in msecs */
> - =A0 =A0 =A0 struct delayed_work =A0 =A0 disable; =A0 =A0 =A0 =A0/* =
disabling work */
>
> =A0 =A0 =A0 =A0struct mmc_card =A0 =A0 =A0 =A0 *card; =A0 =A0 =A0 =A0=
 =A0/* device attached to this host */
>
> @@ -407,17 +378,8 @@ int mmc_card_awake(struct mmc_host *host);
> =A0int mmc_card_sleep(struct mmc_host *host);
> =A0int mmc_card_can_sleep(struct mmc_host *host);
>
> -int mmc_host_enable(struct mmc_host *host);
> -int mmc_host_disable(struct mmc_host *host);
> -int mmc_host_lazy_disable(struct mmc_host *host);
> =A0int mmc_pm_notify(struct notifier_block *notify_block, unsigned lo=
ng, void *);
>
> -static inline void mmc_set_disable_delay(struct mmc_host *host,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0unsigned int disable_delay)
> -{
> - =A0 =A0 =A0 host->disable_delay =3D disable_delay;
> -}
> -
> =A0/* Module parameter */
> =A0extern bool mmc_assume_removable;
>
> --
> 1.7.6.4
>
