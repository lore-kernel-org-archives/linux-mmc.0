From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/7] mmc: mmci: clarify DDR timing mode between SD-UHS
 and eMMC
Date: Mon, 17 Feb 2014 15:08:54 +0100
Message-ID: <CAPDyKFq6=ysG2sg8PWkt2C0iwCWL=yn4oZRxYXhJiSEruzO90g@mail.gmail.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
	<006101cf2a57$77859c00$6690d400$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:62195 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbaBQOIy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Feb 2014 09:08:54 -0500
Received: by mail-qc0-f179.google.com with SMTP id e16so23534796qcx.38
        for <linux-mmc@vger.kernel.org>; Mon, 17 Feb 2014 06:08:54 -0800 (PST)
In-Reply-To: <006101cf2a57$77859c00$6690d400$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, Rickard Andersson <rickard.andersson@stericsson.com>

On 15 February 2014 15:08, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Added MMC_DDR52 as eMMC's DDR mode distinguished from SD-UHS.
>
> CC: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Do note, normally Russell takes patches for mmci.

In this case I think it's important that the complete set gets merged
together. Especially since patch 1, on it's own, actually breaks
support for MMC DDR mode for some host drivers.

Kind regards
Ulf Hansson

> ---
>  drivers/mmc/host/mmci.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index b931226..421d1fe 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -299,7 +299,8 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
>         if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_8)
>                 clk |= MCI_ST_8BIT_BUS;
>
> -       if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50)
> +       if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50 ||
> +           host->mmc->ios.timing == MMC_TIMING_MMC_DDR52)
>                 clk |= MCI_ST_UX500_NEG_EDGE;
>
>         mmci_write_clkreg(host, clk);
> @@ -784,7 +785,8 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
>                         mmci_write_clkreg(host, clk);
>                 }
>
> -       if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50)
> +       if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50 ||
> +           host->mmc->ios.timing == MMC_TIMING_MMC_DDR52)
>                 datactrl |= MCI_ST_DPSM_DDRMODE;
>
>         /*
> --
> 1.7.0.4
>
>
