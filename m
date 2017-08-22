From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V5 04/13] mmc: core: Turn off CQE before sending commands
Date: Tue, 22 Aug 2017 13:13:21 +0200
Message-ID: <CAPDyKFqZxZ4kNHEdSiFwRLKu5x3kzfreQHJBkWwGKAC9tHfkGA@mail.gmail.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com> <1502366898-23691-5-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:34597 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932484AbdHVLNW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Aug 2017 07:13:22 -0400
Received: by mail-qt0-f174.google.com with SMTP id p10so1174900qte.1
        for <linux-mmc@vger.kernel.org>; Tue, 22 Aug 2017 04:13:22 -0700 (PDT)
In-Reply-To: <1502366898-23691-5-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 10 August 2017 at 14:08, Adrian Hunter <adrian.hunter@intel.com> wrote:
> CQE needs to be off for the host controller to accept non-CQ commands. Turn
> off the CQE before sending commands, and ensure it is off in any reset or
> power management paths, or re-tuning.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 6177eb09bf1b..29544aa2824a 100644
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
