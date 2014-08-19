From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5] mmc: implement Driver Stage Register handling
Date: Tue, 19 Aug 2014 13:00:51 +0200
Message-ID: <CAPDyKFqf0Ci1C+1_qCpAMEtpH4dmVoxBZv=GHW-CFMpMEt=vog@mail.gmail.com>
References: <1408437951-31477-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:60752 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbaHSLA4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Aug 2014 07:00:56 -0400
Received: by mail-qa0-f50.google.com with SMTP id s7so5396426qap.37
        for <linux-mmc@vger.kernel.org>; Tue, 19 Aug 2014 04:00:55 -0700 (PDT)
In-Reply-To: <1408437951-31477-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Markus Niebel <Markus.Niebel@tq-group.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>

On 19 August 2014 10:45, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
>
> Some eMMC and SD cards implement a DSR register that allows to tune
> raise/fall times and drive strength of the CMD and DATA outputs.
> The values to use depend on the card in use and the host.
> It might be needed to reduce the drive strength to prevent voltage pe=
aks
> above the host's specification.
>
> Implement a 'dsr' devicetree property that allows to specify the valu=
e
> to set the DSR to. For non-dt setups the new members of mmc_host can =
be
> set by board code.
>
> This patch was initially authored by Sascha Hauer. It contains
> improvements authored by Markus Niebel and Uwe Kleine-K=C3=B6nig.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Markus Niebel <Markus.Niebel@tq-group.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Thanks! Applied for next.

> ---
>
> Notes:
>     Changes since v4, Message-Id: 1408091882-32123-1-git-send-email-u=
=2Ekleine-koenig@pengutronix.de:
>
>      - fix logic to set dsr_req
>      - make dsr_req an int as requested by Ulf Hansson and put it nea=
r dsr in the
>        struct
>
>  Documentation/devicetree/bindings/mmc/mmc.txt |  2 ++
>  drivers/mmc/core/host.c                       |  8 ++++++++
>  drivers/mmc/core/mmc.c                        |  8 ++++++++
>  drivers/mmc/core/mmc_ops.c                    | 20 +++++++++++++++++=
+++
>  drivers/mmc/core/mmc_ops.h                    |  1 +
>  drivers/mmc/core/sd.c                         |  8 ++++++++
>  include/linux/mmc/card.h                      |  3 ++-
>  include/linux/mmc/host.h                      |  4 ++++
>  8 files changed, 53 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Document=
ation/devicetree/bindings/mmc/mmc.txt
> index 3c18001dfd5d..a3fe21f2b709 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -40,6 +40,8 @@ Optional properties:
>  - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
>  - mmc-hs400-1_8v: eMMC HS400 mode(1.8V I/O) is supported
>  - mmc-hs400-1_2v: eMMC HS400 mode(1.2V I/O) is supported
> +- dsr: Value the card's (optional) Driver Stage Register (DSR) shoul=
d be
> +  programmed with. Valid range: [0 .. 0xffff].
>
>  *NOTE* on CD and WP polarity. To use common for all SD/MMC host cont=
rollers line
>  polarity properties, we have to fix the meaning of the "normal" and =
"inverted"
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 95cceae96944..d572b2beb65a 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -452,6 +452,14 @@ int mmc_of_parse(struct mmc_host *host)
>         if (of_find_property(np, "mmc-hs400-1_2v", &len))
>                 host->caps2 |=3D MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200=
_1_2V_SDR;
>
> +       host->dsr_req =3D !of_property_read_u32(np, "dsr", &host->dsr=
);
> +       if (host->dsr_req && (host->dsr & ~0xffff)) {
> +               dev_err(host->parent,
> +                       "device tree specified broken value for DSR: =
0x%x, ignoring\n",
> +                       host->dsr);
> +               host->dsr_req =3D 0;
> +       }
> +
>         return 0;
>
>  out:
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 793c6f7ddb04..fdc1ac1360c4 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -162,6 +162,7 @@ static int mmc_decode_csd(struct mmc_card *card)
>         csd->read_partial =3D UNSTUFF_BITS(resp, 79, 1);
>         csd->write_misalign =3D UNSTUFF_BITS(resp, 78, 1);
>         csd->read_misalign =3D UNSTUFF_BITS(resp, 77, 1);
> +       csd->dsr_imp =3D UNSTUFF_BITS(resp, 76, 1);
>         csd->r2w_factor =3D UNSTUFF_BITS(resp, 26, 3);
>         csd->write_blkbits =3D UNSTUFF_BITS(resp, 22, 4);
>         csd->write_partial =3D UNSTUFF_BITS(resp, 21, 1);
> @@ -1273,6 +1274,13 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
>         }
>
>         /*
> +        * handling only for cards supporting DSR and hosts requestin=
g
> +        * DSR configuration
> +        */
> +       if (card->csd.dsr_imp && host->dsr_req)
> +               mmc_set_dsr(host);
> +
> +       /*
>          * Select card, as all following commands rely on that.
>          */
>         if (!mmc_host_is_spi(host)) {
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index f51b5ba3bbea..ba0275e90617 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -93,6 +93,26 @@ int mmc_deselect_cards(struct mmc_host *host)
>         return _mmc_select_card(host, NULL);
>  }
>
> +/*
> + * Write the value specified in the device tree or board code into t=
he optional
> + * 16 bit Driver Stage Register. This can be used to tune raise/fall=
 times and
> + * drive strength of the DAT and CMD outputs. The actual meaning of =
a given
> + * value is hardware dependant.
> + * The presence of the DSR register can be determined from the CSD r=
egister,
> + * bit 76.
> + */
> +int mmc_set_dsr(struct mmc_host *host)
> +{
> +       struct mmc_command cmd =3D {0};
> +
> +       cmd.opcode =3D MMC_SET_DSR;
> +
> +       cmd.arg =3D (host->dsr << 16) | 0xffff;
> +       cmd.flags =3D MMC_RSP_NONE | MMC_CMD_AC;
> +
> +       return mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> +}
> +
>  int mmc_go_idle(struct mmc_host *host)
>  {
>         int err;
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 80ae9f4e0293..390dac665b2a 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -14,6 +14,7 @@
>
>  int mmc_select_card(struct mmc_card *card);
>  int mmc_deselect_cards(struct mmc_host *host);
> +int mmc_set_dsr(struct mmc_host *host);
>  int mmc_go_idle(struct mmc_host *host);
>  int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
>  int mmc_all_send_cid(struct mmc_host *host, u32 *cid);
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 0c44510bf717..25913889cbaa 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -127,6 +127,7 @@ static int mmc_decode_csd(struct mmc_card *card)
>                 csd->read_partial =3D UNSTUFF_BITS(resp, 79, 1);
>                 csd->write_misalign =3D UNSTUFF_BITS(resp, 78, 1);
>                 csd->read_misalign =3D UNSTUFF_BITS(resp, 77, 1);
> +               csd->dsr_imp =3D UNSTUFF_BITS(resp, 76, 1);
>                 csd->r2w_factor =3D UNSTUFF_BITS(resp, 26, 3);
>                 csd->write_blkbits =3D UNSTUFF_BITS(resp, 22, 4);
>                 csd->write_partial =3D UNSTUFF_BITS(resp, 21, 1);
> @@ -954,6 +955,13 @@ static int mmc_sd_init_card(struct mmc_host *hos=
t, u32 ocr,
>         }
>
>         /*
> +        * handling only for cards supporting DSR and hosts requestin=
g
> +        * DSR configuration
> +        */
> +       if (card->csd.dsr_imp && host->dsr_req)
> +               mmc_set_dsr(host);
> +
> +       /*
>          * Select card, as all following commands rely on that.
>          */
>         if (!mmc_host_is_spi(host)) {
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index d424b9de3aff..680a7f0188bb 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -42,7 +42,8 @@ struct mmc_csd {
>         unsigned int            read_partial:1,
>                                 read_misalign:1,
>                                 write_partial:1,
> -                               write_misalign:1;
> +                               write_misalign:1,
> +                               dsr_imp:1;
>  };
>
>  struct mmc_ext_csd {
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 7960424d0bc0..fd3d81e3fd8e 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -365,6 +365,10 @@ struct mmc_host {
>
>         unsigned int            slotno; /* used for sdio acpi binding=
 */
>
> +       int                     dsr_req;        /* DSR value is valid=
 */
> +

I took the liberty to remove this empty line.

> +       u32                     dsr;    /* optional driver stage (DSR=
) value */
> +
>         unsigned long           private[0] ____cacheline_aligned;
>  };
>
> --
> 2.1.0.rc1
>

Kind regards
Uffe
