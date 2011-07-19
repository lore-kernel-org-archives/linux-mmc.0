From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [RFC/RFT] MMC: CORE: eMMC in Sleep mode before suspend
Date: Tue, 19 Jul 2011 21:31:46 +0530
Message-ID: <CANfBPZ-dwv1e1JweRR5jFu2rLRxQCWd+ibuaN2RHv+gCZcQeOw@mail.gmail.com>
References: <1310567787-14697-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:60841 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751871Ab1GSQCH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 19 Jul 2011 12:02:07 -0400
Received: by mail-iy0-f182.google.com with SMTP id 11so5137291iyb.13
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jul 2011 09:02:06 -0700 (PDT)
In-Reply-To: <1310567787-14697-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org

On Wed, Jul 13, 2011 at 8:06 PM, Balaji T K <balajitk@ti.com> wrote:
> Put MMC to sleep if it supports SLEEP/AWAKE (CMD5)
> in the mmc suspend to minimize power consumption.
>
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
> =A0drivers/mmc/core/mmc.c | =A0 =A08 ++++++--
> =A01 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index afabdc3..e8dfcde 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -900,16 +900,20 @@ static void mmc_detect(struct mmc_host *host)
> =A0*/
> =A0static int mmc_suspend(struct mmc_host *host)
> =A0{
> + =A0 =A0 =A0 int err =3D 0;
> +
> =A0 =A0 =A0 =A0BUG_ON(!host);
> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>
> =A0 =A0 =A0 =A0mmc_claim_host(host);
> - =A0 =A0 =A0 if (!mmc_host_is_spi(host))
> + =A0 =A0 =A0 if (mmc_card_can_sleep(host))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_card_sleep(host);
> + =A0 =A0 =A0 else if (!mmc_host_is_spi(host))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_deselect_cards(host);
> =A0 =A0 =A0 =A0host->card->state &=3D ~MMC_STATE_HIGHSPEED;
> =A0 =A0 =A0 =A0mmc_release_host(host);
>
> - =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return err;
> =A0}
>
> =A0/*
> --
> 1.7.0.4
>

Balaji,
  Would you mind reposting the patch without the RFC and s/CORE/core
in subject line ?
You can add my
Acked-by: Venkatraman S <svenkatr@ti.com>
