From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: mmc: correct the logic for setting HS400ES signal voltage
Date: Tue, 8 Aug 2017 13:34:40 +0200
Message-ID: <CAPDyKFrTYZU2cpAhPU4rYcEmGrCSGqiYDLJ16FHT8+FSACtMtQ@mail.gmail.com>
References: <1502189641-29092-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1502189641-29092-1-git-send-email-haibo.chen@nxp.com>
Sender: stable-owner@vger.kernel.org
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, "# 4.0+" <stable@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 8 August 2017 at 12:54, Haibo Chen <haibo.chen@nxp.com> wrote:
> Change the default err value to -EINVAL, make sure the card only
> has type EXT_CSD_CARD_TYPE_HS400_1_8V also do the signal voltage
> setting when select hs400es mode.
>
> Fixes: commit 1720d3545b77 ("mmc: core: switch to 1V8 or 1V2 for hs400es mode")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 30a13f0..83d9468 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1289,7 +1289,7 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>  static int mmc_select_hs400es(struct mmc_card *card)
>  {
>         struct mmc_host *host = card->host;
> -       int err = 0;
> +       int err = -EINVAL;
>         u8 val;
>
>         if (!(host->caps & MMC_CAP_8_BIT_DATA)) {
> --
> 1.9.1
>
