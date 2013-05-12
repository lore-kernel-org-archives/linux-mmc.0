From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 19/22] mmc: sdhci-spear: remove unnecessary platform_set_drvdata()
Date: Sun, 12 May 2013 20:35:47 +0530
Message-ID: <CAOh2x=mXAEKa1w61fXd2OvTCdSS+Hn7s1+9EEt=t+qMd6dypNg@mail.gmail.com>
References: <005e01ce4a24$261f8100$725e8300$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:48959 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab3ELPFs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 12 May 2013 11:05:48 -0400
Received: by mail-vc0-f171.google.com with SMTP id m16so4929057vca.30
        for <linux-mmc@vger.kernel.org>; Sun, 12 May 2013 08:05:47 -0700 (PDT)
In-Reply-To: <005e01ce4a24$261f8100$725e8300$@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Mon, May 6, 2013 at 12:07 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata = NULL when no driver is bound).
> Thus, it is not needed to manually clear the device driver data to NULL.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/mmc/host/sdhci-spear.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
> index 7ae5b3a..2dba9f8 100644
> --- a/drivers/mmc/host/sdhci-spear.c
> +++ b/drivers/mmc/host/sdhci-spear.c
> @@ -258,7 +258,6 @@ static int sdhci_probe(struct platform_device *pdev)
>         return 0;
>
>  set_drvdata:
> -       platform_set_drvdata(pdev, NULL);
>         sdhci_remove_host(host, 1);
>  free_host:
>         sdhci_free_host(host);
> @@ -278,7 +277,6 @@ static int sdhci_remove(struct platform_device *pdev)
>         int dead = 0;
>         u32 scratch;
>
> -       platform_set_drvdata(pdev, NULL);
>         scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
>         if (scratch == (u32)-1)
>                 dead = 1;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
