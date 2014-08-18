From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] sdhci : handle busy timeout irq
Date: Mon, 18 Aug 2014 13:13:11 +0200
Message-ID: <CAPDyKFpLNa+WiqdrdFT9AC34i29_XiafXgThK2gofkNwZx8ztg@mail.gmail.com>
References: <1408024998-4097-1-git-send-email-matthieu.castet@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:49108 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbaHRLNM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Aug 2014 07:13:12 -0400
Received: by mail-qg0-f48.google.com with SMTP id i50so4463682qgf.35
        for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2014 04:13:11 -0700 (PDT)
In-Reply-To: <1408024998-4097-1-git-send-email-matthieu.castet@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

On 14 August 2014 16:03, Matthieu CASTET <matthieu.castet@parrot.com> wrote:
> When we wait for busy after sending a command, if there is
> a timeout, we got SDHCI_INT_DATA_TIMEOUT flags.
> Before this commit we got the message :
> "Got data interrupt 0x00100000 even though no data  operation was in progress."
> and we need to wait 10s that sdhci_timeout_timer expires.
>
> Signed-off-by: Matthieu CASTET <matthieu.castet@parrot.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 47055f3..9df59a4 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2301,6 +2301,11 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>                  * above in sdhci_cmd_irq().
>                  */
>                 if (host->cmd && (host->cmd->flags & MMC_RSP_BUSY)) {
> +                       if (intmask & SDHCI_INT_DATA_TIMEOUT) {
> +                               host->cmd->error = -ETIMEDOUT;
> +                               tasklet_schedule(&host->finish_tasklet);
> +                               return;
> +                       }
>                         if (intmask & SDHCI_INT_DATA_END) {
>                                 sdhci_finish_command(host);
>                                 return;
> --
> 2.1.0.rc1
>
