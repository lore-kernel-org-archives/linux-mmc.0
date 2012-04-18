From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH 4/8] mmc: mmci: Use ios_handler to save power
Date: Wed, 18 Apr 2012 13:57:27 +0200
Message-ID: <CAMJBoFOBVXQHpjNyy7LDpXuNUbEyRosOVvuVt_MYeOrWbQutnw@mail.gmail.com>
References: <1326810867-5346-1-git-send-email-ulf.hansson@stericsson.com>
	<1326810867-5346-5-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48594 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574Ab2DRL51 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Apr 2012 07:57:27 -0400
Received: by obbta14 with SMTP id ta14so6508522obb.19
        for <linux-mmc@vger.kernel.org>; Wed, 18 Apr 2012 04:57:27 -0700 (PDT)
In-Reply-To: <1326810867-5346-5-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Lee Jones <lee.jones@linaro.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

Hi Ulf,

On Tue, Jan 17, 2012 at 3:34 PM, Ulf Hansson <ulf.hansson@stericsson.co=
m> wrote:
> To disable a levelshifter when we are in an idle state will
> decrease current consumption. We make use of the ios_handler
> at runtime suspend and at regular suspend to accomplish this.
>
> Of course depending on the used levelshifter the decrease of
> current differs. For ST6G3244ME the value is up to ~200 uA.
>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> =A0drivers/mmc/host/mmci.c | =A0 19 ++++++++++++++++++-
> =A01 files changed, 18 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index a7c8f8f..76ce2cd 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1505,10 +1505,22 @@ static int mmci_save(struct amba_device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct mmc_host *mmc =3D amba_get_drvdata(dev);
> =A0 =A0 =A0 =A0unsigned long flags;
> + =A0 =A0 =A0 struct mmc_ios ios;
> + =A0 =A0 =A0 int ret =3D 0;
>
> =A0 =A0 =A0 =A0if (mmc) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mmci_host *host =3D mmc_priv(mm=
c);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Let the ios_handler act on a POWER_O=
=46F to save power. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->plat->ios_handler) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(&ios, &mmc->ios,=
 sizeof(struct mmc_ios));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ios.power_mode =3D MMC_=
POWER_OFF;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D host->plat->ios=
_handler(mmc_dev(mmc),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &ios);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(&host->lock, flags);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> @@ -1527,7 +1539,7 @@ static int mmci_save(struct amba_device *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0amba_vcore_disable(dev);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return ret;
> =A0}
>
> =A0static int mmci_restore(struct amba_device *dev)
> @@ -1550,6 +1562,11 @@ static int mmci_restore(struct amba_device *de=
v)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writel(MCI_IRQENABLE, host->base + MMC=
IMASK0);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->lock, fl=
ags);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Restore settings done by the ios_han=
dler. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->plat->ios_handler)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->plat->ios_handler=
(mmc_dev(mmc),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 &mmc->ios);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return 0;

this patch is a disaster because it cuts off the chip's power on
suspend regardless of whether MMC_PM_KEEP_POWER flag has been set or
not. Simply put: it breaks everything This patch therefore gets a
strongest *NACK* from me.

Thanks,
   Vitaly
