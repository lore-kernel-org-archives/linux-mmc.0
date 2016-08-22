From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PACTH v4] mmc: sdhci: Do not allow tuning procedure to be interrupted
Date: Mon, 22 Aug 2016 15:40:26 +0200
Message-ID: <CAPDyKFrdAivj0ZSZwjNEtBUzM87f36QwAG1nmtPR9iBrOQgoBw@mail.gmail.com>
References: <1471455267-8352-1-git-send-email-robert.foss@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471455267-8352-1-git-send-email-robert.foss@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robert.foss@collabora.com
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Bresticker <abrestic@chromium.org>, Kevin Cernekee <cernekee@chromium.org>, Benson Leung <bleung@chromium.org>, Christopher Freeman <cfreeman@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

On 17 August 2016 at 19:34,  <robert.foss@collabora.com> wrote:
> From: Christopher Freeman <cfreeman@nvidia.com>
>
> wait_event_interruptible_timeout() will return early if the blocked
> process receives a signal, causing the driver to abort the tuning
> procedure and possibly leaving the controller in a bad state.  Since the
> tuning command is expected to complete quickly (<50ms) and we've set a
> timeout, use wait_event_timeout() instead.
>
> Signed-off-by: Christopher Freeman <cfreeman@nvidia.com>
> Tested-by: Robert Foss <robert.foss@collabora.com>
> Signed-off-by: Robert Foss <robert.foss@collabora.com>
> Reviewed-by: Benson Leung <bleung@chromium.org>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
> Changes since v1:
> - Added proper metadata tags to series.
>
> Changes since v2:
> - Added "Reviewed-by: Benson Leung <bleung@chromium.org>"
>
> Changes since v3:
> - Added "Acked-by: Adrian Hunter <adrian.hunter@intel.com>"
>
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0e3d7c0..9e80203 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1960,7 +1960,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>
>                 spin_unlock_irqrestore(&host->lock, flags);
>                 /* Wait for Buffer Read Ready interrupt */
> -               wait_event_interruptible_timeout(host->buf_ready_int,
> +               wait_event_timeout(host->buf_ready_int,
>                                         (host->tuning_done == 1),
>                                         msecs_to_jiffies(50));
>                 spin_lock_irqsave(&host->lock, flags);
> --
> 2.7.4
>
