From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: Fix tag condition with packed writes
Date: Wed, 22 Jun 2016 17:23:29 +0200
Message-ID: <CAPDyKFoim1q-7-6x9sXSyQJfDd6hxTyTku5F77=DuKA8cOEbTA@mail.gmail.com>
References: <575ABF08.4010102@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37958 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbcFVPXc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2016 11:23:32 -0400
Received: by mail-wm0-f49.google.com with SMTP id r201so11134065wme.1
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jun 2016 08:23:31 -0700 (PDT)
In-Reply-To: <575ABF08.4010102@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 10 June 2016 at 15:22, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Apparently a cut-and-paste error, 'do_data_tag' is using 'brq' for data
> size even though 'brq' has not been set up. Instead use blk_rq_sectors().
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>
> Hi
>
> I don't know if anyone is actually using packed writes, but this is
> something I noticed.
>
> Regards
> Adrian
>
>
>  drivers/mmc/card/block.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index b954516739be..aa5cfaf1fdf0 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1834,8 +1834,7 @@ static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req *mqrq,
>                 do_data_tag = (card->ext_csd.data_tag_unit_size) &&
>                         (prq->cmd_flags & REQ_META) &&
>                         (rq_data_dir(prq) == WRITE) &&
> -                       ((brq->data.blocks * brq->data.blksz) >=
> -                        card->ext_csd.data_tag_unit_size);
> +                       blk_rq_bytes(prq) >= card->ext_csd.data_tag_unit_size;
>                 /* Argument of CMD23 */
>                 packed_cmd_hdr[(i * 2)] =
>                         (do_rel_wr ? MMC_CMD23_ARG_REL_WR : 0) |
> --
> 1.9.1
>
