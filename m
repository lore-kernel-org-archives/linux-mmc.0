From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: core: Fix init_card in 52Mhz
Date: Fri, 16 Oct 2015 10:25:52 +0200
Message-ID: <CAPDyKFrATv2=ywT2-tCLCTgTuFeOr1odWQgsCk8-XpKjY0GnjA@mail.gmail.com>
References: <1444641743-15614-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444641743-15614-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@freescale.com>, Johan Rudholm <johan.rudholm@axis.com>, Gwendal Grignou <gwendal@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, srv_heupstream <srv_heupstream@mediatek.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

On 12 October 2015 at 11:22, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> Suppose that we got a data crc error, and it triggers the mmc_reset.
> mmc_reset will call mmc_send_status to see if HW reset was supported.
> before issue CMD13, it will do retune, and if EMMC was in HS400 mode,
> it will reduce frequency to 52Mhz firstly, then results in card init
> was doing at 52Mhz.
> The mmc_send_status was originally only done for mmc_test, should drop
> it. And, rename the "eMMC hardware reset" to "Reset test", as we would
> also be able to use the test for SD-cards.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/card/mmc_test.c | 9 +++------
>  drivers/mmc/core/mmc.c      | 7 -------
>  2 files changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
> index b78cf5d..7fc9174 100644
> --- a/drivers/mmc/card/mmc_test.c
> +++ b/drivers/mmc/card/mmc_test.c
> @@ -2263,15 +2263,12 @@ static int mmc_test_profile_sglen_r_nonblock_perf(struct mmc_test_card *test)
>  /*
>   * eMMC hardware reset.
>   */
> -static int mmc_test_hw_reset(struct mmc_test_card *test)
> +static int mmc_test_reset(struct mmc_test_card *test)
>  {
>         struct mmc_card *card = test->card;
>         struct mmc_host *host = card->host;
>         int err;
>
> -       if (!mmc_card_mmc(card) || !mmc_can_reset(card))
> -               return RESULT_UNSUP_CARD;
> -
>         err = mmc_hw_reset(host);
>         if (!err)
>                 return RESULT_OK;
> @@ -2605,8 +2602,8 @@ static const struct mmc_test_case mmc_test_cases[] = {
>         },
>
>         {
> -               .name = "eMMC hardware reset",
> -               .run = mmc_test_hw_reset,
> +               .name = "Reset test",
> +               .run = mmc_test_reset,
>         },
>  };
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index e726903..f6cd995 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1924,7 +1924,6 @@ EXPORT_SYMBOL(mmc_can_reset);
>  static int mmc_reset(struct mmc_host *host)
>  {
>         struct mmc_card *card = host->card;
> -       u32 status;
>
>         if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
>                 return -EOPNOTSUPP;
> @@ -1937,12 +1936,6 @@ static int mmc_reset(struct mmc_host *host)
>
>         host->ops->hw_reset(host);
>
> -       /* If the reset has happened, then a status command will fail */
> -       if (!mmc_send_status(card, &status)) {
> -               mmc_host_clk_release(host);
> -               return -ENOSYS;
> -       }
> -
>         /* Set initial state and call mmc_set_ios */
>         mmc_set_initial_state(host);
>         mmc_host_clk_release(host);
> --
> 1.8.1.1.dirty
>
