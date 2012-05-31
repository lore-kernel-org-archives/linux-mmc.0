From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] MMC: core: cap MMC card timeouts at 2 seconds.
Date: Thu, 31 May 2012 18:00:44 +0800
Message-ID: <CAPDyKFrpXc7cODie9g-QK_ZhVpmVZPQ36TDF9CWJcVPL_-EU2Q@mail.gmail.com>
References: <CAEV-rjeEKMNs2N8KEatCi+guFKihgFok4k4nDnd=vTQ5x7iStg@mail.gmail.com>
	<1338282140-11106-1-git-send-email-torne@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1338282140-11106-1-git-send-email-torne@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Torne (Richard Coles)" <torne@google.com>
Cc: cjb@laptop.org, linus.walleij@linaro.org, jh80.chung@samsung.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, ben@decadent.org.uk
List-Id: linux-mmc@vger.kernel.org

Hi Richard,

On 29 May 2012 17:02, Torne (Richard Coles) <torne@google.com> wrote:
> From: "Torne (Richard Coles)" <torne@google.com>
>
> MMC CSD info can specify very large, ridiculous timeouts, big enough =
to
> overflow timeout_ns on 32-bit machines. This can result in the card
> timing out on every operation because the wrapped timeout value is fa=
r
> too small.
>
> Fix the overflow by capping the result at 2 seconds. =A0Cards specify=
ing
> longer timeouts are almost certainly insane, and host controllers
> generally cannot support timeouts that long in any case.
>
> 2 seconds should be plenty of time for any card to actually function;
> the timeout calculation code is already using 1 second as a "worst ca=
se"
> timeout for cards running in SPI mode.
>
> Signed-off-by: Torne (Richard Coles) <torne@google.com>
> ---
> =A0drivers/mmc/core/core.c | =A0 11 ++++++++++-
> =A01 files changed, 10 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 0b6141d..3b4a9fc 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -512,7 +512,16 @@ void mmc_set_data_timeout(struct mmc_data *data,=
 const struct mmc_card *card)
> =A0 =A0 =A0 =A0if (data->flags & MMC_DATA_WRITE)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mult <<=3D card->csd.r2w_factor;
>
> - =A0 =A0 =A0 data->timeout_ns =3D card->csd.tacc_ns * mult;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* The timeout in nanoseconds may overflow with some =
cards. Cap it at
> + =A0 =A0 =A0 =A0* two seconds both to avoid the overflow and also be=
cause host
> + =A0 =A0 =A0 =A0* controllers cannot generally generate timeouts tha=
t long anyway.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (card->csd.tacc_ns <=3D (2 * NSEC_PER_SEC) / mult)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->timeout_ns =3D card->csd.tacc_ns =
* mult;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->timeout_ns =3D 2 * NSEC_PER_SEC;
> +

The above looks OK to me, although if doing this for tacc_ns we might
want to do this for tacc_clks as well. Could we include that is this
patch as well?

> =A0 =A0 =A0 =A0data->timeout_clks =3D card->csd.tacc_clks * mult;
>
> =A0 =A0 =A0 =A0/*
> --
> 1.7.7.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

Kind regards
Ulf Hansson
