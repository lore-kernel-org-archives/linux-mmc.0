From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: improve logging of handling emmc timeouts
Date: Tue, 10 May 2016 08:58:21 +0200
Message-ID: <CAPDyKFqRXS8rn8_e356o2ujKm-eZxQY2WwaxkP+cZ9D0TVmLYg@mail.gmail.com>
References: <1462353220-5196-1-git-send-email-amit.pundir@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34234 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbcEJG6X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2016 02:58:23 -0400
Received: by mail-wm0-f45.google.com with SMTP id v200so25325189wmv.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 May 2016 23:58:22 -0700 (PDT)
In-Reply-To: <1462353220-5196-1-git-send-email-amit.pundir@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Amit Pundir <amit.pundir@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Ken Sumrall <ksumrall@android.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jon Hunter <jonathanh@nvidia.com>, Grant Grundler <grundler@chromium.org>, Luca Porzio <lporzio@micron.com>, Android Kernel Team <kernel-team@android.com>, Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <john.stultz@linaro.org>

On 4 May 2016 at 11:13, Amit Pundir <amit.pundir@linaro.org> wrote:
> From: Ken Sumrall <ksumrall@android.com>
>
> Add some logging to make it clear just how the emmc timeout
> was handled.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Cc: Grant Grundler <grundler@chromium.org>
> Cc: Luca Porzio <lporzio@micron.com>
> Cc: Android Kernel Team <kernel-team@android.com>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: John Stultz <john.stultz@linaro.org>

I would prefer if you could remove the above cc:s, as I don't think
it's of relevance to have all these people here.

> Signed-off-by: Ken Sumrall <ksumrall@android.com>
> [AmitP: cherry-picked this Android patch from aosp common kernel android-4.4]
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
>  drivers/mmc/card/block.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 9c69e21..e737c81 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -948,18 +948,25 @@ static int mmc_blk_cmd_error(struct request *req, const char *name, int error,
>                         req->rq_disk->disk_name, "timed out", name, status);
>
>                 /* If the status cmd initially failed, retry the r/w cmd */
> -               if (!status_valid)
> +               if (!status_valid) {
> +                       pr_err("%s: status not valid, retrying timeout\n",
> +                               req->rq_disk->disk_name);
>                         return ERR_RETRY;
> +               }
>
>                 /*
>                  * If it was a r/w cmd crc error, or illegal command
>                  * (eg, issued in wrong state) then retry - we should
>                  * have corrected the state problem above.
>                  */
> -               if (status & (R1_COM_CRC_ERROR | R1_ILLEGAL_COMMAND))
> +               if (status & (R1_COM_CRC_ERROR | R1_ILLEGAL_COMMAND)) {
> +                       pr_err("%s: command error, retrying timeout\n",
> +                               req->rq_disk->disk_name);
>                         return ERR_RETRY;
> +               }
>
>                 /* Otherwise abort the command */
> +               pr_err("%s: not retrying timeout\n", req->rq_disk->disk_name);

There's already a print done a couple of lines above. Even if it's not
telling about the "re-try" it becomes implicit, as nothing else gets
printed in this path.

Would you mind removing this?

>                 return ERR_ABORT;
>
>         default:
> --
> 2.7.4
>

Kind regards
Uffe
