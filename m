From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] mmc: core: do not retry CMD6 in __mmc_switch()
Date: Tue, 26 Feb 2019 09:18:16 +0100
Message-ID: <CAPDyKFq8FQLhbuDYsuV3nJ9pgLYFwaE3smPgkBO3VPsrAQF7cQ@mail.gmail.com>
References: <1550210375-32270-1-git-send-email-chaotian.jing@mediatek.com> <1550210375-32270-2-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550210375-32270-2-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, Simon Horman <horms+renesas@verge.net.au>, Avri Altman <avri.altman@wdc.com>, Kyle Roeschley <kyle.roeschley@ni.com>, Hongjie Fang <hongjiefang@asrmicro.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, srv_heupstream <srv_heupstream@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, 15 Feb 2019 at 06:59, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> the response type of CMD6 is R1B, when the first CMD6 gets response
> CRC error, do retry may get timeout error due to card may still in
> busy state, which cause this retry make no sense.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/mmc_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 9054329..c5208fb 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -562,7 +562,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>         if (index == EXT_CSD_SANITIZE_START)
>                 cmd.sanitize_busy = true;
>
> -       err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> +       err = mmc_wait_for_cmd(host, &cmd, 0);
>         if (err)
>                 goto out;
>
> --
> 1.8.1.1.dirty
>
