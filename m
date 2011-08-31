From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH v3 1/2] mmc: sdio add regulator vsdio
Date: Wed, 31 Aug 2011 22:06:15 +0800
Message-ID: <CAMPhdO9r8wyyU9uW7NTyOR2e2kOJG0rqgUow3krg9GpiZmab_g@mail.gmail.com>
References: <1314253575-2602-1-git-send-email-zhangfei.gao@marvell.com> <1314253575-2602-2-git-send-email-zhangfei.gao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44491 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab1HaOGg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Aug 2011 10:06:36 -0400
Received: by vws1 with SMTP id 1so561416vws.19
        for <linux-mmc@vger.kernel.org>; Wed, 31 Aug 2011 07:06:35 -0700 (PDT)
In-Reply-To: <1314253575-2602-2-git-send-email-zhangfei.gao@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@marvell.com>
Cc: Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>, Daniel Drake <dsd@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Bing Zhao <bzhao@marvell.com>

Zhangfei,

My understanding is that the card in the slot would be either MMC _or_
SDIO and why do we need another regulator for the power on/off?

On Thu, Aug 25, 2011 at 2:26 PM, Zhangfei Gao <zhangfei.gao@marvell.com=
> wrote:
> sdio client may be required power on/off dynamically.
> With regulator vsdio, sdio client power on/off could be executed by m=
mc_power_up/down
>
> CC: Ohad Ben-Cohen <ohad@wizery.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
> =C2=A0drivers/mmc/host/sdhci.c =C2=A0| =C2=A0 22 , > =C2=A0include/li=
nux/mmc/sdhci.h | =C2=A0 =C2=A02 ++
> =C2=A02 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0e02cc1..e0ef7d3 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1424,6 +1424,18 @@ static void sdhci_set_ios(struct mmc_host *mmc=
, struct mmc_ios *ios)
> =C2=A0out:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmiowb();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&host->lock, flags)=
;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (host->vsdio) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ios->power_mod=
e !=3D host->power_mode_old) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (ios->power_mode =3D=3D MMC_POWER_OFF)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regulator_disable(host->vsdio);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (ios->power_mode =3D=3D MMC_POWER_UP)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regulator_enable(host->vsdio);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->power_mode_o=
ld =3D ios->power_mode;
> + =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0}
>
> =C2=A0static int check_ro(struct sdhci_host *host)
> @@ -2748,6 +2760,13 @@ int sdhci_add_host(struct sdhci_host *host)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regulator_enab=
le(host->vmmc);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> + =C2=A0 =C2=A0 =C2=A0 host->vsdio =3D regulator_get(mmc_dev(mmc), "v=
sdio");
> + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(host->vsdio))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->vsdio =3D NU=
LL;
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_INFO "=
%s: vsdio regulator found\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 mmc_hostname(mmc));
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sdhci_init(host, 0);
>
> =C2=A0#ifdef CONFIG_MMC_DEBUG
> @@ -2839,6 +2858,9 @@ void sdhci_remove_host(struct sdhci_host *host,=
 int dead)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0regulator_put(=
host->vmmc);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> + =C2=A0 =C2=A0 =C2=A0 if (host->vsdio)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regulator_put(host=
->vsdio);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(host->adma_desc);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(host->align_buffer);
>
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index 5666f3a..201207a 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -94,6 +94,8 @@ struct sdhci_host {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct sdhci_ops *ops; =C2=A0 =C2=A0=
/* Low level hw interface */
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct regulator *vmmc; /* Power regulator=
 */
> + =C2=A0 =C2=A0 =C2=A0 struct regulator *vsdio; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/* sdio Power regulator */
> + =C2=A0 =C2=A0 =C2=A0 unsigned char power_mode_old; =C2=A0 /* power =
supply mode */
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Internal data */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_host *mmc; =C2=A0 /* MMC struct=
ure */
> --
> 1.7.0.4
>
>
