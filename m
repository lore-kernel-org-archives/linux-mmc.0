From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V5 01/13] mmc: core: Add mmc_retune_hold_now()
Date: Tue, 22 Aug 2017 13:12:51 +0200
Message-ID: <CAPDyKFo9jM9ROe=KPBUfm7zU1M=1Lk59UHs_PQ9rEHHurr2S6g@mail.gmail.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com> <1502366898-23691-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f182.google.com ([209.85.216.182]:34467 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932350AbdHVLMx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Aug 2017 07:12:53 -0400
Received: by mail-qt0-f182.google.com with SMTP id p10so1169972qte.1
        for <linux-mmc@vger.kernel.org>; Tue, 22 Aug 2017 04:12:53 -0700 (PDT)
In-Reply-To: <1502366898-23691-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 10 August 2017 at 14:08, Adrian Hunter <adrian.hunter@intel.com> wrote:
> mmc_return_hold() / mmc_retune_release() are used around a group of
> commands to prevent re-tuning between the commands. Re-tuning can still
> happen before the first command. In some cases, re-tuning must be
> prevented entirely. Add mmc_retune_hold_now() for that purpose. It is
> added in preparation for CQE support where it will be used by CQE recovery.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

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
