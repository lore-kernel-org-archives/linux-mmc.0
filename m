From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V6 04/12] mmc: core: Turn off CQE before sending commands
Date: Wed, 30 Aug 2017 15:14:37 +0200
Message-ID: <CAPDyKFqUbEDKzGHypo=GmMyL4Og4z19PGxO2Wf05nEJhPhAX0g@mail.gmail.com>
References: <1503665035-16231-1-git-send-email-adrian.hunter@intel.com> <1503665035-16231-5-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:38618 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbdH3NOi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Aug 2017 09:14:38 -0400
Received: by mail-it0-f52.google.com with SMTP id 77so7391700itj.1
        for <linux-mmc@vger.kernel.org>; Wed, 30 Aug 2017 06:14:38 -0700 (PDT)
In-Reply-To: <1503665035-16231-5-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 25 August 2017 at 14:43, Adrian Hunter <adrian.hunter@intel.com> wrote:
> CQE needs to be off for the host controller to accept non-CQ commands. Turn
> off the CQE before sending commands, and ensure it is off in any reset or
> power management paths, or re-tuning.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

This one was already applied.

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 5dd1c00d95f5..66c9cf49ad2f 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -260,6 +260,9 @@ static void __mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>
>         trace_mmc_request_start(host, mrq);
>
> +       if (host->cqe_on)
> +               host->cqe_ops->cqe_off(host);
> +
>         host->ops->request(host, mrq);
>  }
>
> @@ -979,6 +982,9 @@ int mmc_execute_tuning(struct mmc_card *card)
>         if (!host->ops->execute_tuning)
>                 return 0;
>
> +       if (host->cqe_on)
> +               host->cqe_ops->cqe_off(host);
> +
>         if (mmc_card_mmc(card))
>                 opcode = MMC_SEND_TUNING_BLOCK_HS200;
>         else
> @@ -1018,6 +1024,9 @@ void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
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
