From: James Hogan <james@albanarts.com>
Subject: Re: mmc: dw_mmc: Add more capabilities field
Date: Fri, 9 Dec 2011 10:41:06 +0000
Message-ID: <CAAG0J99SSLm6r0NoqXCMmEvdpVnW-zwHdFhA-n=zEiagyGHuTQ@mail.gmail.com>
References: <00a801ccb636$5bbe2920$133a7b60$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <00a801ccb636$5bbe2920$133a7b60$%jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 9 December 2011 05:49, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

A commit message would be useful.

> ---
> =A0drivers/mmc/host/dw_mmc.c =A0| =A0 =A06 ++++++
> =A0include/linux/mmc/dw_mmc.h | =A0 =A01 +
> =A02 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 3aaeb08..366df6b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1681,6 +1681,12 @@ static int __init dw_mci_init_slot(struct dw_m=
ci *host, unsigned int id)
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps =3D 0;
>
> + =A0 =A0 =A0 if (host->pdata->caps2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps2 =3D host->pdata->caps2;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps2 =3D 0;
> +
> +

There's really no need to check the value here, just copy it over.
Same with the other caps field really.

> =A0 =A0 =A0 =A0if (host->pdata->get_bus_wd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->pdata->get_bus_wd(slot->id) =
>=3D 4)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP=
_4_BIT_DATA;
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 6dc9b80..e8779c6 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -214,6 +214,7 @@ struct dw_mci_board {
> =A0 =A0 =A0 =A0unsigned int bus_hz; /* Bus speed */
>
> =A0 =A0 =A0 =A0unsigned int caps; =A0 =A0 =A0/* Capabilities */
> + =A0 =A0 =A0 unsigned int caps2; =A0 =A0 /* More capabilities */
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Override fifo depth. If 0, autodetect it from the F=
IFOTH register,
> =A0 =A0 =A0 =A0 * but note that this may not be reliable after a boot=
loader has used
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

other than that it looks fine to me.

--=20
James Hogan
