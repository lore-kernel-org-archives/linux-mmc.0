From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: mmc: fix switch timeout issue caused by jiffies precision
Date: Tue, 21 Jun 2016 15:15:58 +0200
Message-ID: <CAPDyKFqVW0sdwwvYoJcwZh=WKq1QzJREvt2y+rNWyA324J7p4A@mail.gmail.com>
References: <1463647662-27426-1-git-send-email-chaotian.jing@mediatek.com> <1463647662-27426-4-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463647662-27426-4-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, srv_heupstream <srv_heupstream@mediatek.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

On 19 May 2016 at 10:47, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> with CONFIG_HZ=100, the precision of jiffies is 10ms, and the
> generic_cmd6_time of some card is also 10ms. then, may be current
> time is only 5ms, but already timed out caused by jiffies precision.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 32de144..ad6e979 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -534,7 +534,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>                 timeout_ms = MMC_OPS_TIMEOUT_MS;
>
>         /* Must check status to be sure of no errors. */
> -       timeout = jiffies + msecs_to_jiffies(timeout_ms);
> +       timeout = jiffies + msecs_to_jiffies(timeout_ms) + 1;
>         do {
>                 /*
>                  * Due to the possibility of being preempted after
> --
> 1.8.1.1.dirty
>
