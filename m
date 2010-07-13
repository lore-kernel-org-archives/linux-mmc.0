From: Madhav Chauhan <madhav.imsec@gmail.com>
Subject: Re: [PATCH FINAL] sdhci-clk-gating-support
Date: Tue, 13 Jul 2010 14:16:25 +0530
Message-ID: <AANLkTimBbnYut5Z1d6NjGXvSvoNvvOogJlFVNa5LinfS@mail.gmail.com>
References: <5005677.340441278667763470.JavaMail.weblogic@epml07>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52360 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab0GMIq0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jul 2010 04:46:26 -0400
Received: by qwh6 with SMTP id 6so1544194qwh.19
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jul 2010 01:46:26 -0700 (PDT)
In-Reply-To: <5005677.340441278667763470.JavaMail.weblogic@epml07>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: singh.madhav@samsung.com
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi,
Can any one comment on this patch??

Regards,
Madhav

> Hi Chris ,
> I have taken up you suggestion and coming with new patch.Also we have=
 done perfromance analysis
> using fileop/iozone and performance is not effected by this patch,reg=
arding the power consumption,
> after applying patch it saves 15 mA.
>
> From 3663ee85ce718c9607bc0968a5143e01d86919ed Mon Sep 17 00:00:00 200=
1
> From: Madhav Chauhan <singh.madhav@samsung.com>
> Date: Fri, 9 Jul 2010 20:02:06 +0530
> Subject: [PATCH] sdhci-clk-gating-support
>
> This patch implements clock gating support in sdhci layer. It will
> enable the clock when host controller start sending request
> to attached device and will disable it once it finish the command.
> Now this patch provides option so that some host controllers
> can be avoided using this functionality using mmc_host caps.
>
> Signed-off-by: Madhav Chauhan <singh.madhav@samsung.com>, Nitish Amba=
stha <nitish.a@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> =A0drivers/mmc/host/sdhci.c | =A0 35 ++++++++++++++++++++++++++++++++=
+++
> =A0drivers/mmc/host/sdhci.h | =A0 =A06 ++++++
> =A0include/linux/mmc/host.h | =A0 =A01 +
> =A03 files changed, 42 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c6d1bd8..5ed7c50 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1103,6 +1103,9 @@ static void sdhci_request(struct mmc_host *mmc,=
 struct mmc_request *mrq)
>
> =A0 =A0 =A0 =A0spin_lock_irqsave(&host->lock, flags);
>
> + =A0 =A0 =A0 if (host->mmc->caps & MMC_CAP_CLOCK_GATING)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_clk_enable(host); /*Enable clock =
as transfer starts now*/
> +
> =A0 =A0 =A0 =A0WARN_ON(host->mrq !=3D NULL);
>
> =A0#ifndef SDHCI_USE_LEDS_CLASS
> @@ -1310,6 +1313,10 @@ static void sdhci_tasklet_finish(unsigned long=
 param)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_reset(host, SDHCI_RESET_DATA);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (host->mmc->caps & MMC_CAP_CLOCK_GATING)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*Disable clock as command has been pro=
cessed*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_clk_disable(host);
> +
> =A0 =A0 =A0 =A0host->mrq =3D NULL;
> =A0 =A0 =A0 =A0host->cmd =3D NULL;
> =A0 =A0 =A0 =A0host->data =3D NULL;
> @@ -1597,6 +1604,9 @@ int sdhci_suspend_host(struct sdhci_host *host,=
 pm_message_t state)
>
> =A0 =A0 =A0 =A0sdhci_disable_card_detection(host);
>
> + =A0 =A0 =A0 if (host->mmc->caps & MMC_CAP_CLOCK_GATING)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_clk_enable(host); /* Enable clock=
 */
> +
> =A0 =A0 =A0 =A0ret =3D mmc_suspend_host(host->mmc);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> @@ -1626,6 +1636,11 @@ int sdhci_resume_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0mmiowb();
>
> =A0 =A0 =A0 =A0ret =3D mmc_resume_host(host->mmc);
> +
> + =A0 =A0 =A0 if (host->mmc->caps & MMC_CAP_CLOCK_GATING)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*Now device has wake up disable it*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_clk_disable(host);
> +
> =A0 =A0 =A0 =A0sdhci_enable_card_detection(host);
>
> =A0 =A0 =A0 =A0return ret;
> @@ -1654,6 +1669,9 @@ struct sdhci_host *sdhci_alloc_host(struct devi=
ce *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_PTR(-ENOMEM);
>
> =A0 =A0 =A0 =A0host =3D mmc_priv(mmc);
> +
> + =A0 =A0 =A0 host->clk_restore =3D 0; =A0/* For clock gating */
> +
> =A0 =A0 =A0 =A0host->mmc =3D mmc;
>
> =A0 =A0 =A0 =A0return host;
> @@ -1984,6 +2002,23 @@ void sdhci_free_host(struct sdhci_host *host)
>
> =A0EXPORT_SYMBOL_GPL(sdhci_free_host);
>
> +void sdhci_clk_enable(struct sdhci_host *host)
> +{
> + =A0 =A0 =A0 if (host->clk_restore && host->clock =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_set_clock(host, host->clk_restore=
);
> +}
> +EXPORT_SYMBOL_GPL(sdhci_clk_enable);
> +
> +void sdhci_clk_disable(struct sdhci_host *host)
> +{
> + =A0 =A0 =A0 if (host->clock !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->clk_restore =3D host->clock;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_set_clock(host, 0);
> + =A0 =A0 =A0 }
> +}
> +EXPORT_SYMBOL_GPL(sdhci_clk_disable);
> +
> +
> =A0/*****************************************************************=
************\
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *
> =A0* Driver init/exit =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index c846813..5031d33 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -292,6 +292,8 @@ struct sdhci_host {
>
> =A0 =A0 =A0 =A0struct timer_list =A0 =A0 =A0 timer; =A0 =A0 =A0 =A0 =A0=
/* Timer for timeouts */
>
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0clk_restore; =A0 =A0=
/* For Clock Gating */
> +
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 private[0] ____cache=
line_aligned;
> =A0};
>
> @@ -410,6 +412,10 @@ static inline void *sdhci_priv(struct sdhci_host=
 *host)
> =A0extern int sdhci_add_host(struct sdhci_host *host);
> =A0extern void sdhci_remove_host(struct sdhci_host *host, int dead);
>
> +/*For Clock Gating*/
> +extern void sdhci_clk_enable(struct sdhci_host *host);
> +extern void sdhci_clk_disable(struct sdhci_host *host);
> +
> =A0#ifdef CONFIG_PM
> =A0extern int sdhci_suspend_host(struct sdhci_host *host, pm_message_=
t state);
> =A0extern int sdhci_resume_host(struct sdhci_host *host);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index f65913c..b5c3563 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -155,6 +155,7 @@ struct mmc_host {
> =A0#define MMC_CAP_DISABLE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 7) =A0=
 =A0 =A0 =A0/* Can the host be disabled */
> =A0#define MMC_CAP_NONREMOVABLE =A0 (1 << 8) =A0 =A0 =A0 =A0/* Nonrem=
ovable e.g. eMMC */
> =A0#define MMC_CAP_WAIT_WHILE_BUSY =A0 =A0 =A0 =A0(1 << 9) =A0 =A0 =A0=
 =A0/* Waits while card is busy */
> +#define MMC_CAP_CLOCK_GATING =A0 (1 << 10) =A0 =A0 =A0 /* Clock Gati=
ng feature */
>
> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
>
> --
> 1.7.0.4
>
>
>
>
>> + =A0 =A0 =A0 host->user =3D 0; =A0 =A0 =A0 =A0 /*For Clock gating*/
>> + =A0 =A0 =A0 host->clk_restore =3D 0;
>
> Also, it's not obvious to me why two variables are necessary. =A0What=
's
> wrong with just setting host->clk_restore when disabling clock, and
> testing whether it's non-zero instead of testing host->user?
> (host->user would need a more descriptive name, too.)
>
> Thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org>
> One Laptop Per Child
>
>
>
>
>
>
>
>
