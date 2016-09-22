From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/5] mmc: core: don't try to switch block size for dual
 rate mode
Date: Thu, 22 Sep 2016 11:40:57 +0200
Message-ID: <CAPDyKFqEGz3_UmeemsK4dEzqFX5woxqsKTOAyqpmEPh=HDXMPQ@mail.gmail.com>
References: <1474422233-29355-1-git-send-email-shawn.lin@rock-chips.com> <1474422233-29355-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474422233-29355-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Ziyuan Xu <xzy.xu@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

On 21 September 2016 at 03:43, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> From: Ziyuan Xu <xzy.xu@rock-chips.com>
>
> Per spec, block size should always be 512 bytes for dual rate mode,
> so any attempts to switch the block size under dual rate mode should
> be neglected.
>
> Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

>
> ---
>
>  drivers/mmc/core/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index f0ed0af..2553d90 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2576,7 +2576,8 @@ int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
>  {
>         struct mmc_command cmd = {0};
>
> -       if (mmc_card_blockaddr(card) || mmc_card_ddr52(card))
> +       if (mmc_card_blockaddr(card) || mmc_card_ddr52(card) ||
> +           mmc_card_hs400(card) || mmc_card_hs400es(card))
>                 return 0;
>
>         cmd.opcode = MMC_SET_BLOCKLEN;
> --
> 2.3.7
>
>
