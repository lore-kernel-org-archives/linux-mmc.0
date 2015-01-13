From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 12/13] mmc: sdhci: Always init buf_ready_int
Date: Tue, 13 Jan 2015 12:21:22 +0100
Message-ID: <CAPDyKFqULTHuGdzNO2N+fouBDushniw=WHRDKtRn5c2C58Lo0w@mail.gmail.com>
References: <1417801271-15575-1-git-send-email-adrian.hunter@intel.com>
	<1417801271-15575-13-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:61545 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbbAMLVX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jan 2015 06:21:23 -0500
Received: by mail-qg0-f46.google.com with SMTP id q107so1596782qgd.5
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jan 2015 03:21:23 -0800 (PST)
In-Reply-To: <1417801271-15575-13-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lu@intel.com>, Philip Rakity <prakity@nvidia.com>, Girish K S <girish.shivananjappa@linaro.org>, Al Cooper <alcooperx@gmail.com>, Arend van Spriel <arend@broadcom.com>

On 5 December 2014 at 18:41, Adrian Hunter <adrian.hunter@intel.com> wrote:
> There is no point making the initialization
> of buf_ready_int conditional on host version.
> Simplify by just doing it always. Note that
> the other conditional initializations will be
> removed when the new way of doing re-tuning
> is taken into use.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index bfde165..dd4cc4c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3331,9 +3331,9 @@ int sdhci_add_host(struct sdhci_host *host)
>
>         setup_timer(&host->timer, sdhci_timeout_timer, (unsigned long)host);
>
> -       if (host->version >= SDHCI_SPEC_300) {
> -               init_waitqueue_head(&host->buf_ready_int);
> +       init_waitqueue_head(&host->buf_ready_int);
>
> +       if (host->version >= SDHCI_SPEC_300) {
>                 /* Initialize re-tuning timer */
>                 init_timer(&host->tuning_timer);
>                 host->tuning_timer.data = (unsigned long)host;
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
