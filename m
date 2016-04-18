From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: drop unnecessary bit checking
Date: Mon, 18 Apr 2016 13:21:22 +0200
Message-ID: <CAPDyKFruAoqRA=fdNNjoW1atD8-yFFuCJ9q3R-8iQDwHh8TD3g@mail.gmail.com>
References: <1460718972-17306-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460718972-17306-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

On 15 April 2016 at 13:16, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> This if-block is going to call mmc_card_set_blockaddr(), so
> mmc_card_blockaddr() right before it is redundant.
>
> I am fixing the block comment style while I am here.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/core/mmc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 4dbe3df..c96bc81 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1483,12 +1483,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                 if (err)
>                         goto free_card;
>
> -               /* If doing byte addressing, check if required to do sector
> +               /*
> +                * If doing byte addressing, check if required to do sector
>                  * addressing.  Handle the case of <2GB cards needing sector
>                  * addressing.  See section 8.1 JEDEC Standard JED84-A441;
>                  * ocr register has bit 30 set for sector addressing.
>                  */
> -               if (!(mmc_card_blockaddr(card)) && (rocr & (1<<30)))
> +               if (rocr & BIT(30))
>                         mmc_card_set_blockaddr(card);
>
>                 /* Erase size depends on CSD and Extended CSD */
> --
> 1.9.1
>
