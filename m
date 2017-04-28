From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: limit SD clock for ls1012a/ls1046a
Date: Fri, 28 Apr 2017 12:37:02 +0200
Message-ID: <CAPDyKFqVm=tkOL+jo_V+m=z+wqM+XT-gOGCpRO8QfzrE3=AV2A@mail.gmail.com>
References: <1492671509-22044-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:34553 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2992703AbdD1KhD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Apr 2017 06:37:03 -0400
Received: by mail-qt0-f176.google.com with SMTP id c45so46642522qtb.1
        for <linux-mmc@vger.kernel.org>; Fri, 28 Apr 2017 03:37:03 -0700 (PDT)
In-Reply-To: <1492671509-22044-1-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Xiaobo Xie <xiaobo.xie@nxp.com>

On 20 April 2017 at 08:58, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> The ls1046a datasheet specified that the max SD clock frequency
> for eSDHC SDR104/HS200 was 167MHz, and the ls1012a datasheet
> specified it's 125MHz for ls1012a. So this patch is to add the
> limitation.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 49ac197..57966ef 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -456,6 +456,20 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>         if (esdhc->vendor_ver < VENDOR_V_23)
>                 pre_div = 2;
>
> +       /*
> +        * Limit SD clock to 167MHz for ls1046a according to its datasheet
> +        */
> +       if (clock > 167000000 &&
> +           of_find_compatible_node(NULL, NULL, "fsl,ls1046a-esdhc"))
> +               clock = 167000000;
> +
> +       /*
> +        * Limit SD clock to 125MHz for ls1012a according to its datasheet
> +        */
> +       if (clock > 125000000 &&
> +           of_find_compatible_node(NULL, NULL, "fsl,ls1012a-esdhc"))
> +               clock = 125000000;
> +
>         /* Workaround to reduce the clock frequency for p1010 esdhc */
>         if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
>                 if (clock > 20000000)
> --
> 2.1.0.27.g96db324
>
