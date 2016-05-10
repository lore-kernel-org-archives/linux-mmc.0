From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: block: improve logging of handling emmc timeouts
Date: Tue, 10 May 2016 12:28:24 +0200
Message-ID: <CAPDyKFoFnE+cPi50tmNTCYneaZSNOTcwQQzBRORs3ttCNCanUQ@mail.gmail.com>
References: <1462872193-6213-1-git-send-email-amit.pundir@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35532 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbcEJK20 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2016 06:28:26 -0400
Received: by mail-wm0-f50.google.com with SMTP id e201so171518337wme.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 May 2016 03:28:25 -0700 (PDT)
In-Reply-To: <1462872193-6213-1-git-send-email-amit.pundir@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Amit Pundir <amit.pundir@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Ken Sumrall <ksumrall@android.com>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Jon Hunter <jonathanh@nvidia.com>, Grant Grundler <grundler@chromium.org>, "Luca Porzio (lporzio)" <lporzio@micron.com>, Android Kernel Team <kernel-team@android.com>, Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <john.stultz@linaro.org>

On 10 May 2016 at 11:23, Amit Pundir <amit.pundir@linaro.org> wrote:
> From: Ken Sumrall <ksumrall@android.com>
>
> Add some logging to make it clear just how the emmc timeout
> was handled.
>
> Signed-off-by: Ken Sumrall <ksumrall@android.com>
> [AmitP: cherry-picked this Android patch from aosp
>         common kernel android-4.4]
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
> v1...v2:
>   Removed CC list from the commit log and skipped one print statement.
>
>  drivers/mmc/card/block.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 9c69e21..ddc9620 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -948,16 +948,22 @@ static int mmc_blk_cmd_error(struct request *req, const char *name, int error,
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
>                 return ERR_ABORT;
> --
> 2.7.4
>
