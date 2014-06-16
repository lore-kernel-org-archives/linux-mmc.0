From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: implement driver stage register handling
Date: Mon, 16 Jun 2014 13:36:38 +0200
Message-ID: <CAPDyKFotJr1UkKFs8vqaeh+=VqZvbxY6KmzDQ0HQKFkkr=07ug@mail.gmail.com>
References: <1400852087-32442-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:63889 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbaFPLgj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 07:36:39 -0400
Received: by mail-qc0-f172.google.com with SMTP id o8so7636775qcw.31
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jun 2014 04:36:38 -0700 (PDT)
In-Reply-To: <1400852087-32442-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, Markus Niebel <Markus.Niebel@tqs.de>

On 23 May 2014 15:34, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> The eMMC and the SD-Card specifications describe the optional SET_DSR command.
> During measurements at our lab we found that some cards implementing this feature
> having really strong driver strengts per default. This can lead to voltage peaks
> above the specification of the host on signal edges for data sent from a card to
> the host.
>
> Since availability of a given card type may be shorter than the time a certain
> hardware will be produced it is useful to have support for this command (Alternative
> would be changing termination resistors and adapting the driver strength of the
> host to the used card.)
>
> As the value of the dsr register is board specific this adds a 'dsr' devicetree
> property which is handled in mmc_of_parse.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt |  3 +++
>  drivers/mmc/core/host.c                       |  3 +++
>  drivers/mmc/core/mmc.c                        |  4 ++++
>  drivers/mmc/core/mmc_ops.c                    | 17 +++++++++++++++++
>  drivers/mmc/core/mmc_ops.h                    |  1 +
>  include/linux/mmc/card.h                      |  3 ++-
>  include/linux/mmc/host.h                      |  2 ++
>  7 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 9dce540..737203e 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -38,6 +38,9 @@ Optional properties:
>  - mmc-highspeed-ddr-1_2v: eMMC high-speed DDR mode(1.2V I/O) is supported
>  - mmc-hs200-1_8v: eMMC HS200 mode(1.8V I/O) is supported
>  - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
> +- dsr: Content of the optional driver stage register (DSR) as described
> +  in JEDEC Standard No. 84-A44, 12.4: Programmable card output driver. Not
> +  all MMC cards implement this register and the actual value is card specific.

I get the impression of that this is (e)MMC specific, but this is
relevant for SD cards as well, right!?

I don't find the part's that should be implemented for sd/sdio, could
we add that in this patch as well?

>
>  *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
>  polarity properties, we have to fix the meaning of the "normal" and "inverted"
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index fdea825..eea272e 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -447,6 +447,7 @@ int mmc_of_parse(struct mmc_host *host)
>                 host->caps2 |= MMC_CAP2_HS200_1_8V_SDR;
>         if (of_find_property(np, "mmc-hs200-1_2v", &len))
>                 host->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
> +       of_property_read_u32(np, "dsr", &host->dsr);
>
>         return 0;
>
> @@ -515,6 +516,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>         host->max_blk_size = 512;
>         host->max_blk_count = PAGE_CACHE_SIZE / 512;
>
> +       host->dsr = 0xffffffff;
> +

Why is this needed?

>         return host;
>
>  free:
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 1ab5f3a..0ab1c44 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -162,6 +162,7 @@ static int mmc_decode_csd(struct mmc_card *card)
>         csd->read_partial = UNSTUFF_BITS(resp, 79, 1);
>         csd->write_misalign = UNSTUFF_BITS(resp, 78, 1);
>         csd->read_misalign = UNSTUFF_BITS(resp, 77, 1);
> +       csd->dsr_imp = UNSTUFF_BITS(resp, 76, 1);
>         csd->r2w_factor = UNSTUFF_BITS(resp, 26, 3);
>         csd->write_blkbits = UNSTUFF_BITS(resp, 22, 4);
>         csd->write_partial = UNSTUFF_BITS(resp, 21, 1);
> @@ -970,6 +971,9 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                         goto free_card;
>         }
>
> +       if (card->csd.dsr_imp && (host->dsr & 0xffff) == host->dsr)

To clarify, maybe add an extra pair of parentheses around the above expression?

Additionally I don't quite understand the comparison? Couldn't we just
use a "u16" to simplify this?

> +               mmc_set_dsr(host);
> +
>         /*
>          * Select card, as all following commands rely on that.
>          */
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index f51b5ba..f8af72a 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -93,6 +93,23 @@ int mmc_deselect_cards(struct mmc_host *host)
>         return _mmc_select_card(host, NULL);
>  }
>
> +int mmc_set_dsr(struct mmc_host *host)
> +{
> +       int err;
> +       struct mmc_command cmd = {0};
> +
> +       cmd.opcode = MMC_SET_DSR;
> +
> +       cmd.arg = (host->dsr << 16) | 0xffff;
> +       cmd.flags = MMC_RSP_NONE | MMC_CMD_AC;

I think it should be MMC_CMD_BC instead of MMC_CMD_AC.

> +
> +       err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> +       if (err)
> +               return err;
> +
> +       return 0;
> +}
> +
>  int mmc_go_idle(struct mmc_host *host)
>  {
>         int err;
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 80ae9f4..390dac6 100644
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
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index b730272..ced116f 100644
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
> index cb61ea4..d8d9d68 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -358,6 +358,8 @@ struct mmc_host {
>
>         unsigned int            slotno; /* used for sdio acpi binding */
>
> +       u32                     dsr;    /* optional driver stage register (dsr) value */

Again, the DSR register is 16 bits. Couldn't we use u16 instead?

Moreover, feel free to to move this further up in the struct. I would
put it between ocr_avail and f_init, since it's more related to these.

Kind regards
Uffe

> +
>         unsigned long           private[0] ____cacheline_aligned;
>  };
>
> --
> 2.0.0.rc0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
