From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 04/11] mmc: core: Turn off CQE before sending commands
Date: Mon, 7 Aug 2017 15:59:03 +0200
Message-ID: <CAPDyKFq2X-k-qubjD5gadYb0RHcPJNbi6X1Lkz5SCLUzA-oWjw@mail.gmail.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com> <1500630584-22852-5-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:38715 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbdHGN7E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2017 09:59:04 -0400
Received: by mail-qt0-f174.google.com with SMTP id t37so2828529qtg.5
        for <linux-mmc@vger.kernel.org>; Mon, 07 Aug 2017 06:59:04 -0700 (PDT)
In-Reply-To: <1500630584-22852-5-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 21 July 2017 at 11:49, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Turn off the CQE before sending commands, and ensure it is off in any reset
> or power management paths, or re-tuning.

Please explain a bit why this is needed.

Also, it's not clear how it becomes re-enabled. Or it doesn't have to?

>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 26431267a3e2..b0af9db18eef 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -260,6 +260,9 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>
>         trace_mmc_request_start(host, mrq);
>
> +       if (host->cqe_on)
> +               host->cqe_ops->cqe_off(host);
> +

Why can't you use the ->cqe_disable() callback here instead?

I guess what puzzles me is that there is no corresponding ->cqe_on()
callback. When does cqe gets turned on again?

>         host->ops->request(host, mrq);
>  }
>
> @@ -982,6 +985,9 @@ int mmc_execute_tuning(struct mmc_card *card)
>         if (!host->ops->execute_tuning)
>                 return 0;
>
> +       if (host->cqe_on)
> +               host->cqe_ops->cqe_off(host);
> +
>         if (mmc_card_mmc(card))
>                 opcode = MMC_SEND_TUNING_BLOCK_HS200;
>         else
> @@ -1021,6 +1027,9 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
>   */
>  void mmc_set_initial_state(struct mmc_host *host)
>  {
> +       if (host->cqe_on)
> +               host->cqe_ops->cqe_off(host);
> +
>         mmc_retune_disable(host);
>
>         if (mmc_host_is_spi(host))
> --
> 1.9.1
>

Kind regards
Uffe
