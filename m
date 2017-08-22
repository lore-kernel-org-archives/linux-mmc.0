From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V5 05/13] mmc: core: Add support for handling CQE requests
Date: Tue, 22 Aug 2017 10:06:41 +0200
Message-ID: <CAPDyKFo9T0_-7veFa+5vE_HqDjaG31moEGdFThqXi4z6uVSJ_w@mail.gmail.com>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com> <1502366898-23691-6-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:33714 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbdHVIGn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Aug 2017 04:06:43 -0400
Received: by mail-qt0-f178.google.com with SMTP id d15so23042499qta.0
        for <linux-mmc@vger.kernel.org>; Tue, 22 Aug 2017 01:06:42 -0700 (PDT)
In-Reply-To: <1502366898-23691-6-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

[...]

> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index bf1788a224e6..1974fcfd4284 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -174,6 +174,11 @@ struct mmc_async_req *mmc_start_areq(struct mmc_host *host,
>  int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
>                 int retries);
>
> +int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq);
> +void mmc_cqe_request_done(struct mmc_host *host, struct mmc_request *mrq);
> +void mmc_cqe_post_req(struct mmc_host *host, struct mmc_request *mrq);
> +int mmc_cqe_recovery(struct mmc_host *host);
> +

Please move mmc_cqe_start_req(), mmc_cqe_post_req(),
mmc_cqe_recovery() to drivers/mmc/core/core.h. This makes sure they
don't become abused.

Also, please move mmc_cqe_request_done() to include/linux/mmc/host.h.
Then it becomes consistent with where mmc_request_done() is declared.

Feel free to also fold in a patch moving the existing mmc_start_areq()
to drivers/mmc/core/core.h. Unfortunate the others closely related to
these functions, are being abused by SDIO func drivers and needs more
work before they can be moved.

>  int mmc_hw_reset(struct mmc_host *host);
>  void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card);
>
> --
> 1.9.1
>

Sorry for not noticing this in v4.

Kind regards
Uffe
