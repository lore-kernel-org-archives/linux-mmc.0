From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: fix packed command header endianness
Date: Mon, 18 Jul 2016 13:19:55 +0200
Message-ID: <CAPDyKFqtDWzdGKa5i7uYk4VEOQy1vRW7bbPtmy6TjZzhqi=XUA@mail.gmail.com>
References: <1468447538-17973-1-git-send-email-takondra@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1468447538-17973-1-git-send-email-takondra@cisco.com>
Sender: stable-owner@vger.kernel.org
To: Taras Kondratiuk <takondra@cisco.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, xe-linux-external@cisco.com, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

+ stable

On 14 July 2016 at 00:05, Taras Kondratiuk <takondra@cisco.com> wrote:
> The code that fills packed command header assumes that CPU runs in
> little-endian mode. Hence the header is malformed in big-endian mode
> and causes MMC data transfer errors:
>
> [  563.200828] mmcblk0: error -110 transferring data, sector 2048, nr 8, cmd response 0x900, card status 0xc40
> [  563.219647] mmcblk0: packed cmd failed, nr 2, sectors 16, failure index: -1
>
> Convert header data to LE.
>
> Signed-off-by: Taras Kondratiuk <takondra@cisco.com>

Thanks, applied for fixes and added a stable+fixes tag.

Kind regards
Uffe

> ---
> The patch is based on v4.7-rc7.
> Tested on v4.4 kernel, but this code was not changed since then.
>
>  drivers/mmc/card/block.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index e62fde3ac431..3832234d9aef 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1786,8 +1786,8 @@ static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req *mqrq,
>
>         packed_cmd_hdr = packed->cmd_hdr;
>         memset(packed_cmd_hdr, 0, sizeof(packed->cmd_hdr));
> -       packed_cmd_hdr[0] = (packed->nr_entries << 16) |
> -               (PACKED_CMD_WR << 8) | PACKED_CMD_VER;
> +       packed_cmd_hdr[0] = cpu_to_le32((packed->nr_entries << 16) |
> +               (PACKED_CMD_WR << 8) | PACKED_CMD_VER);
>         hdr_blocks = mmc_large_sector(card) ? 8 : 1;
>
>         /*
> @@ -1801,14 +1801,14 @@ static void mmc_blk_packed_hdr_wrq_prep(struct mmc_queue_req *mqrq,
>                         ((brq->data.blocks * brq->data.blksz) >=
>                          card->ext_csd.data_tag_unit_size);
>                 /* Argument of CMD23 */
> -               packed_cmd_hdr[(i * 2)] =
> +               packed_cmd_hdr[(i * 2)] = cpu_to_le32(
>                         (do_rel_wr ? MMC_CMD23_ARG_REL_WR : 0) |
>                         (do_data_tag ? MMC_CMD23_ARG_TAG_REQ : 0) |
> -                       blk_rq_sectors(prq);
> +                       blk_rq_sectors(prq));
>                 /* Argument of CMD18 or CMD25 */
> -               packed_cmd_hdr[((i * 2)) + 1] =
> +               packed_cmd_hdr[((i * 2)) + 1] = cpu_to_le32(
>                         mmc_card_blockaddr(card) ?
> -                       blk_rq_pos(prq) : blk_rq_pos(prq) << 9;
> +                       blk_rq_pos(prq) : blk_rq_pos(prq) << 9);
>                 packed->blocks += blk_rq_sectors(prq);
>                 i++;
>         }
> --
> 2.5.0
>
