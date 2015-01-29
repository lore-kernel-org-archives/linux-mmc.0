From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: wait until card ready if tuning fails
Date: Thu, 29 Jan 2015 09:45:15 +0100
Message-ID: <CAPDyKFo+zLXnFjJTWpufCRvtJ_y2YEWT42sMHFTMD9psL-vd+Q@mail.gmail.com>
References: <1422271175-19445-1-git-send-email-addy.ke@rock-chips.com>
	<1422271175-19445-3-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:65398 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbbA2IpQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jan 2015 03:45:16 -0500
Received: by mail-qg0-f50.google.com with SMTP id f51so25249814qge.9
        for <linux-mmc@vger.kernel.org>; Thu, 29 Jan 2015 00:45:16 -0800 (PST)
In-Reply-To: <1422271175-19445-3-git-send-email-addy.ke@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Addy Ke <addy.ke@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Dinh Nguyen <dinguyen@altera.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Olof Johansson <olof@lixom.net>, Doug Anderson <dianders@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, Alexandru Stan <amstan@chromium.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infrad>

On 26 January 2015 at 12:19, Addy Ke <addy.ke@rock-chips.com> wrote:
> This patch based on Alex's patch:
> https://patchwork.kernel.org/patch/5516411/

This above patch was rejected, since it doesn't use mmc_send_tuning().
Please base you work on my latest next branch.

If you need other patches which has been posted recently, which hasn=E2=
=80=99t
been reviewed nor merged you can just included them in your patchset
as well.

Kind regards
Uffe

>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
>  drivers/mmc/core/mmc_ops.h |  1 -
>  drivers/mmc/host/dw_mmc.c  | 48 ++++++++++++++++++++++++++++++++++++=
++++------
>  include/linux/mmc/card.h   |  2 ++
>  3 files changed, 44 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 6f4b00e..c5be9ce 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -20,7 +20,6 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr=
, u32 *rocr);
>  int mmc_all_send_cid(struct mmc_host *host, u32 *cid);
>  int mmc_set_relative_addr(struct mmc_card *card);
>  int mmc_send_csd(struct mmc_card *card, u32 *csd);
> -int mmc_send_status(struct mmc_card *card, u32 *status);
>  int mmc_send_cid(struct mmc_host *host, u32 *cid);
>  int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
>  int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index e54e656..4a31a5e 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1317,10 +1317,38 @@ static void dw_mci_enable_sdio_irq(struct mmc=
_host *mmc, int enb)
>         spin_unlock_irqrestore(&host->irq_lock, irqflags);
>  }
>
> -static int dw_mci_tuning_test(struct dw_mci_slot *slot, u32 opcode,
> -                              struct dw_mci_tuning_data *tuning_data=
,
> -                              u8 *blk_test)
> +static int dw_mci_card_busy(u32 status)
>  {
> +       return !(status & R1_READY_FOR_DATA) ||
> +               (R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG);
> +}
> +
> +static int dw_mci_wait_for_card_ready(struct mmc_card *card)
> +{
> +       struct mmc_host *mmc =3D card->host;
> +       struct dw_mci_slot *slot =3D mmc_priv(mmc);
> +       struct dw_mci *host =3D slot->host;
> +       int err =3D 0;
> +       u32 status;
> +
> +       do {
> +               err =3D mmc_send_status(card, &status);
> +               if (err) {
> +                       dev_err(host->dev,
> +                               "Get card status fail in tuning state=
\n");
> +                       break;
> +               }
> +       } while (dw_mci_card_busy(status));
> +
> +       return err;
> +}
> +
> +static int dw_mci_tuning_test(struct mmc_card *card, u32 opcode,
> +                             struct dw_mci_tuning_data *tuning_data,
> +                             u8 *blk_test)
> +{
> +       struct mmc_host *mmc =3D card->host;
> +       struct dw_mci_slot *slot =3D mmc_priv(mmc);
>         struct dw_mci *host =3D slot->host;
>         struct mmc_host *mmc =3D slot->mmc;
>         const u8 *blk_pattern =3D tuning_data->blk_pattern;
> @@ -1330,6 +1358,7 @@ static int dw_mci_tuning_test(struct dw_mci_slo=
t *slot, u32 opcode,
>         struct mmc_command stop =3D {0};
>         struct mmc_data data =3D {0};
>         struct scatterlist sg;
> +       int err;
>
>         memset(blk_test, 0, blksz);
>
> @@ -1365,6 +1394,11 @@ static int dw_mci_tuning_test(struct dw_mci_sl=
ot *slot, u32 opcode,
>                 dev_dbg(host->dev,
>                         "Tuning error: cmd.error:%d, data.error:%d\n"=
,
>                         cmd.error, data.error);
> +
> +               err =3D dw_mci_wait_for_card_ready(card);
> +               if (err)
> +                       return err;
> +
>                 if (cmd.error)
>                         return cmd.error;
>                 else
> @@ -1372,9 +1406,11 @@ static int dw_mci_tuning_test(struct dw_mci_sl=
ot *slot, u32 opcode,
>         }
>  }
>
> -static int dw_mci_execute_generic_tuning(struct dw_mci_slot *slot, u=
32 opcode,
> +static int dw_mci_execute_generic_tuning(struct mmc_card *card, u32 =
opcode,
>                                          struct dw_mci_tuning_data *t=
uning_data)
>  {
> +       struct mmc_host *mmc =3D card->host;
> +       struct dw_mci_slot *slot =3D mmc_priv(mmc);
>         struct dw_mci *host =3D slot->host;
>         unsigned int blksz =3D tuning_data->blksz;
>         u8 *blk_test;
> @@ -1412,7 +1448,7 @@ static int dw_mci_execute_generic_tuning(struct=
 dw_mci_slot *slot, u32 opcode,
>         for (i =3D 0; i < NUM_PHASES; i++) {
>                 clk_set_phase(host->sample_clk, i * PHASE_INCREMENT);
>
> -               v =3D !dw_mci_tuning_test(slot, opcode, tuning_data, =
blk_test);
> +               v =3D !dw_mci_tuning_test(card, opcode, tuning_data, =
blk_test);
>
>                 if ((!prev_v) && v) {
>                         range_count++;
> @@ -1496,7 +1532,7 @@ static int dw_mci_execute_tuning(struct mmc_car=
d *card, u32 opcode)
>         if (drv_data && drv_data->execute_tuning)
>                 err =3D drv_data->execute_tuning(slot, opcode, &tunin=
g_data);
>         else
> -               err =3D dw_mci_execute_generic_tuning(slot, opcode, &=
tuning_data);
> +               err =3D dw_mci_execute_generic_tuning(card, opcode, &=
tuning_data);
>         return err;
>  }
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 4d69c00..40d90ae 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -518,4 +518,6 @@ extern void mmc_unregister_driver(struct device_d=
river *);
>  extern void mmc_fixup_device(struct mmc_card *card,
>                              const struct mmc_fixup *table);
>
> +int mmc_send_status(struct mmc_card *card, u32 *status);
> +
>  #endif /* LINUX_MMC_CARD_H */
> --
> 1.8.3.2
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
