From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-of-esdhc: add workaround for pre divider
 initial value
Date: Tue, 25 Aug 2015 14:05:44 +0200
Message-ID: <CAPDyKFpxcDWARoHhWejg69LxukjctB2iFdECYdSj23-cFjwMhQ@mail.gmail.com>
References: <1439261614-38605-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38888 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755711AbbHYMFp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 08:05:45 -0400
Received: by igfj19 with SMTP id j19so9156438igf.1
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2015 05:05:45 -0700 (PDT)
In-Reply-To: <1439261614-38605-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Joakim Tjernlund <joakim.tjernlund@transmode.se>

On 11 August 2015 at 04:53, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> For eSDHC(version < 2.3), the pre divider only could divide base clock
> by 2 at least. Add workaround for this to avoid unexpected issue.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 797be75..653f335 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -208,6 +208,12 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>         if (clock == 0)
>                 return;
>
> +       /* Workaround to start pre_div at 2 for VNN < VENDOR_V_23 */
> +       temp = esdhc_readw(host, SDHCI_HOST_VERSION);
> +       temp = (temp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
> +       if (temp < VENDOR_V_23)
> +               pre_div = 2;
> +
>         /* Workaround to reduce the clock frequency for p1010 esdhc */
>         if (of_find_compatible_node(NULL, NULL, "fsl,p1010-esdhc")) {
>                 if (clock > 20000000)
> --
> 2.1.0.27.g96db324
>
