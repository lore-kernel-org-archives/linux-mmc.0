From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-cadence: add parsing sdhci properties
Date: Wed, 12 Apr 2017 16:11:43 +0200
Message-ID: <CAPDyKFrFRJseQdqT9JJd9-XW=RzSLB0=m_pjc8Qk-92ZFXafKQ@mail.gmail.com>
References: <1491909218-7300-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:34948 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbdDLOLp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Apr 2017 10:11:45 -0400
Received: by mail-ua0-f181.google.com with SMTP id 49so16849806uau.2
        for <linux-mmc@vger.kernel.org>; Wed, 12 Apr 2017 07:11:44 -0700 (PDT)
In-Reply-To: <1491909218-7300-1-git-send-email-piotrs@cadence.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>

On 11 April 2017 at 13:13, Piotr Sroka <piotrs@cadence.com> wrote:
> Add calling sdhci_get_of_property function to parse sdhci properties.
>
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-cadence.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 7797e98..19d5698 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -330,6 +330,8 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         host->mmc_host_ops.hs400_enhanced_strobe =
>                                 sdhci_cdns_hs400_enhanced_strobe;
>
> +       sdhci_get_of_property(pdev);
> +
>         ret = mmc_of_parse(host->mmc);
>         if (ret)
>                 goto free;
> --
> 2.2.2
>
