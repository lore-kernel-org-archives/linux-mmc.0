From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: don't use CMD23 with very old MMC cards
Date: Wed, 31 Aug 2016 10:25:35 +0200
Message-ID: <CAPDyKFpp2xT91e1UNXECWiBZA7Nue0qseynggt+1SdhkVvsAvg@mail.gmail.com>
References: <1472559450-19840-1-git-send-email-dg@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1472559450-19840-1-git-send-email-dg@emlix.com>
Sender: stable-owner@vger.kernel.org
To: =?UTF-8?Q?Daniel_Gl=C3=B6ckner?= <dg@emlix.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

+ stable

On 30 August 2016 at 14:17, Daniel Gl=C3=B6ckner <dg@emlix.com> wrote:
> CMD23 aka SET_BLOCK_COUNT was introduced with MMC v3.1.
> Older versions of the specification allowed to terminate
> multi-block transfers only with CMD12.
>
> The patch fixes the following problem:
>
>   mmc0: new MMC card at address 0001
>   mmcblk0: mmc0:0001 SDMB-16 15.3 MiB
>   mmcblk0: timed out sending SET_BLOCK_COUNT command, card status 0x40090=
0
>   ...
>   blk_update_request: I/O error, dev mmcblk0, sector 0
>   Buffer I/O error on dev mmcblk0, logical block 0, async page read
>    mmcblk0: unable to read partition table
>
> Signed-off-by: Daniel Gl=C3=B6ckner <dg@emlix.com>

This was an old problem you found, nice! I should remove the dust from
my old MMC cards and give them a go with this change.
I assume it could be worth to send this to stable as well, so I will
add a stable tag to it.

Applied for next! Thanks and kind regards!

Uffe

> ---
>  drivers/mmc/card/block.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 2206d44..0fec40d 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2303,7 +2303,8 @@ again:
>         set_capacity(md->disk, size);
>
>         if (mmc_host_cmd23(card->host)) {
> -               if (mmc_card_mmc(card) ||
> +               if ((mmc_card_mmc(card) &&
> +                    card->csd.mmca_vsn >=3D CSD_SPEC_VER_3)||
>                     (mmc_card_sd(card) &&
>                      card->scr.cmds & SD_SCR_CMD23_SUPPORT))
>                         md->flags |=3D MMC_BLK_CMD23;
> --
> 2.1.2
>
