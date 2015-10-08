From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: core: Fix init_card in 52Mhz
Date: Thu, 8 Oct 2015 12:59:12 +0200
Message-ID: <CAPDyKFqrjP3-y+ucm5ybwXefsDLOYcPF9XqMciwhRkjD5NXLBg@mail.gmail.com>
References: <1444288147-24013-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444288147-24013-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@freescale.com>, Johan Rudholm <johan.rudholm@axis.com>, Gwendal Grignou <gwendal@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, srv_heupstream <srv_heupstream@mediatek.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

On 8 October 2015 at 09:09, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> Suppose that we got a data crc error, and it triggers the mmc_reset.
> mmc_reset will call mmc_send_status to see if HW reset was supported.
> before issue CMD13, it will do retune, and if EMMC was in HS400 mode,
> it will reduce frequency to 52Mhz firstly, then results in card init
> was doing at 52Mhz.
> The mmc_send_status was originally only done for mmc_test, so if retune
> needed, do not call mmc_send_status.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/card/mmc_test.c | 6 ++++++
>  drivers/mmc/core/mmc.c      | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
> index b78cf5d..2f78bfb 100644
> --- a/drivers/mmc/card/mmc_test.c
> +++ b/drivers/mmc/card/mmc_test.c
> @@ -2272,6 +2272,12 @@ static int mmc_test_hw_reset(struct mmc_test_card *test)
>         if (!mmc_card_mmc(card) || !mmc_can_reset(card))
>                 return RESULT_UNSUP_CARD;
>
> +       if (host->need_retune) {
> +               pr_info("%s: cannot test hw reset because retune needed\n",
> +                       mmc_hostname(test->card->host));
> +               return RESULT_FAIL;
> +       }
> +
>         err = mmc_hw_reset(host);
>         if (!err)
>                 return RESULT_OK;
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index e726903..647c96d 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1938,7 +1938,7 @@ static int mmc_reset(struct mmc_host *host)
>         host->ops->hw_reset(host);
>
>         /* If the reset has happened, then a status command will fail */
> -       if (!mmc_send_status(card, &status)) {
> +       if (!host->need_retune && !mmc_send_status(card, &status)) {

No, this seem like the wrong solution! The main purpose of mmc_reset()
is to try to reset and re-initiate the card, to make it operational
again.

I can't find a good reason to why we want to do a mmc_send_status() at
this point, as even if it succeeds it will only tell us that the card
has not been "hw-reset". No matter what, we should still try to make
it fully operational again and thus give mmc_init_card() a try.

>From this reasoning, I suggest we remove the call to mmc_send_status()
from this path, as that will also address your issue with CRC errors
in combination with re-tune.

>                 mmc_host_clk_release(host);
>                 return -ENOSYS;
>         }
> --
> 1.8.1.1.dirty
>

Kind regards
Uffe
