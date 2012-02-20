From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix disableing DMA in Non-IDMAC
Date: Mon, 20 Feb 2012 14:59:22 +0900
Message-ID: <CAKYAXd-5iTe7CV4=qR+aQggUdubLHEZ3Bnx+y9_88w95k-U83Q@mail.gmail.com>
References: <001e01ccef73$97aee200$c70ca600$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:65396 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab2BTF7Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Feb 2012 00:59:24 -0500
Received: by bkcjm19 with SMTP id jm19so4268484bkc.19
        for <linux-mmc@vger.kernel.org>; Sun, 19 Feb 2012 21:59:23 -0800 (PST)
In-Reply-To: <001e01ccef73$97aee200$c70ca600$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, James Hogan <james@albanarts.com>, Will Newton <will.newton@imgtec.com>

2012/2/20 Seungwon Jeon <tgih.jun@samsung.com>:
> dw_mci_pre_dma_transfer() is valid only if internal DMA. In case of
> using other DMA it returns -ENOSYS. It prevents the DMA operations.
> This patch makes dw_mci_pre_dma_transfer() effective in all DMA case.
>
> Reported-by: James Hogan <james@albanarts.com>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Hi. Seungwon.
This patch make sense.
Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
> ---
> =C2=A0drivers/mmc/host/dw_mmc.c | =C2=A0 25 +++++++++----------------
> =C2=A01 files changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 692c3ba..bf3c9b4 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -429,6 +429,15 @@ static int dw_mci_idmac_init(struct dw_mci *host=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> +static struct dw_mci_dma_ops dw_mci_idmac_ops =3D {
> + =C2=A0 =C2=A0 =C2=A0 .init =3D dw_mci_idmac_init,
> + =C2=A0 =C2=A0 =C2=A0 .start =3D dw_mci_idmac_start_dma,
> + =C2=A0 =C2=A0 =C2=A0 .stop =3D dw_mci_idmac_stop_dma,
> + =C2=A0 =C2=A0 =C2=A0 .complete =3D dw_mci_idmac_complete_dma,
> + =C2=A0 =C2=A0 =C2=A0 .cleanup =3D dw_mci_dma_cleanup,
> +};
> +#endif /* CONFIG_MMC_DW_IDMAC */
> +
> =C2=A0static int dw_mci_pre_dma_transfer(struct dw_mci *host,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mmc_data *data=
,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bool next)
> @@ -468,22 +477,6 @@ static int dw_mci_pre_dma_transfer(struct dw_mci=
 *host,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return sg_len;
> =C2=A0}
>
> -static struct dw_mci_dma_ops dw_mci_idmac_ops =3D {
> - =C2=A0 =C2=A0 =C2=A0 .init =3D dw_mci_idmac_init,
> - =C2=A0 =C2=A0 =C2=A0 .start =3D dw_mci_idmac_start_dma,
> - =C2=A0 =C2=A0 =C2=A0 .stop =3D dw_mci_idmac_stop_dma,
> - =C2=A0 =C2=A0 =C2=A0 .complete =3D dw_mci_idmac_complete_dma,
> - =C2=A0 =C2=A0 =C2=A0 .cleanup =3D dw_mci_dma_cleanup,
> -};
> -#else
> -static int dw_mci_pre_dma_transfer(struct dw_mci *host,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_data *data,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool next)
> -{
> - =C2=A0 =C2=A0 =C2=A0 return -ENOSYS;
> -}
> -#endif /* CONFIG_MMC_DW_IDMAC */
> -
> =C2=A0static void dw_mci_pre_req(struct mmc_host *mmc,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 struct mmc_request *mrq,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 bool is_first_req)
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
