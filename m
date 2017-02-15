From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-cadence: fix bit shift of read data from PHY port
Date: Wed, 15 Feb 2017 11:42:56 +0100
Message-ID: <CAPDyKFq3p0R0FH1Ppt6PdHt93W=eQWYZkwddC4kf8iog1KPWfA@mail.gmail.com>
References: <1487070340-8988-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:34903 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbdBOKm5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2017 05:42:57 -0500
Received: by mail-qt0-f169.google.com with SMTP id x49so133341706qtc.2
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2017 02:42:57 -0800 (PST)
In-Reply-To: <1487070340-8988-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 14 February 2017 at 12:05, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> This macro is currently unused, but it may be useful for debug use.
> Fix it just in case.
>
> Fixes: ff6af28faff5 ("mmc: sdhci-cadence: add Cadence SD4HC support")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  drivers/mmc/host/sdhci-cadence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 4b0ecb9..5ffa2e5 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -25,7 +25,7 @@
>  #define   SDHCI_CDNS_HRS04_ACK                 BIT(26)
>  #define   SDHCI_CDNS_HRS04_RD                  BIT(25)
>  #define   SDHCI_CDNS_HRS04_WR                  BIT(24)
> -#define   SDHCI_CDNS_HRS04_RDATA_SHIFT         12
> +#define   SDHCI_CDNS_HRS04_RDATA_SHIFT         16
>  #define   SDHCI_CDNS_HRS04_WDATA_SHIFT         8
>  #define   SDHCI_CDNS_HRS04_ADDR_SHIFT          0
>
> --
> 2.7.4
>

Thanks, applied for next!

Kind regards
Uffe
