From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 01/11] mmc: core: Add mmc_retune_hold_now()
Date: Mon, 7 Aug 2017 15:44:23 +0200
Message-ID: <CAPDyKFqMiP0QHu3DkK04D5=yt7ZCk2JiJUMzAcT=yEUK9C3+Sg@mail.gmail.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com> <1500630584-22852-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:35854 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbdHGNoY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2017 09:44:24 -0400
Received: by mail-qt0-f182.google.com with SMTP id v29so2658523qtv.3
        for <linux-mmc@vger.kernel.org>; Mon, 07 Aug 2017 06:44:24 -0700 (PDT)
In-Reply-To: <1500630584-22852-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 21 July 2017 at 11:49, Adrian Hunter <adrian.hunter@intel.com> wrote:
> In preparation for CQE support.

Can you please elaborate a bit on this. Perhaps explaining when/why a
host needs to call this new host API.

>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/host.c | 6 ++++++
>  drivers/mmc/core/host.h | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 1503412f826c..ad88deb2e8f3 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -111,6 +111,12 @@ void mmc_retune_hold(struct mmc_host *host)
>         host->hold_retune += 1;
>  }
>
> +void mmc_retune_hold_now(struct mmc_host *host)
> +{
> +       host->retune_now = 0;
> +       host->hold_retune += 1;
> +}
> +
>  void mmc_retune_release(struct mmc_host *host)
>  {
>         if (host->hold_retune)
> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
> index fb6a76a03833..77d6f60d1bf9 100644
> --- a/drivers/mmc/core/host.h
> +++ b/drivers/mmc/core/host.h
> @@ -19,6 +19,7 @@
>  void mmc_retune_enable(struct mmc_host *host);
>  void mmc_retune_disable(struct mmc_host *host);
>  void mmc_retune_hold(struct mmc_host *host);
> +void mmc_retune_hold_now(struct mmc_host *host);
>  void mmc_retune_release(struct mmc_host *host);
>  int mmc_retune(struct mmc_host *host);
>  void mmc_retune_pause(struct mmc_host *host);
> --
> 1.9.1
>

Kind regards
Uffe
