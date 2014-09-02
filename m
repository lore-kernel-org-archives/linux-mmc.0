From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: pxamci: prepare and unprepare the clocks
Date: Tue, 2 Sep 2014 12:53:20 +0200
Message-ID: <CAPDyKFrxLue+XTROXbOvC+G0=AQ8-jMNYjQ3n7mMk=Ce-iLtKw@mail.gmail.com>
References: <1409649835-13778-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:64035 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753707AbaIBKxV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Sep 2014 06:53:21 -0400
Received: by mail-la0-f48.google.com with SMTP id gl10so7605074lab.35
        for <linux-mmc@vger.kernel.org>; Tue, 02 Sep 2014 03:53:20 -0700 (PDT)
In-Reply-To: <1409649835-13778-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 2 September 2014 11:23, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Add the clock prepare and unprepare call to the driver set_ios calls
> phase. This will remove a warning once the PXA architecture is migrated
> to the clock infrastructure.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/pxamci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 32fe113..96406e8 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -474,7 +474,7 @@ static void pxamci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 unsigned int clk = rate / ios->clock;
>
>                 if (host->clkrt == CLKRT_OFF)
> -                       clk_enable(host->clk);
> +                       clk_prepare_enable(host->clk);
>
>                 if (ios->clock == 26000000) {
>                         /* to support 26MHz */
> @@ -501,7 +501,7 @@ static void pxamci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 pxamci_stop_clock(host);
>                 if (host->clkrt != CLKRT_OFF) {
>                         host->clkrt = CLKRT_OFF;
> -                       clk_disable(host->clk);
> +                       clk_disable_unprepare(host->clk);
>                 }
>         }
>
> --
> 1.9.1
>
