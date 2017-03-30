From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v5 4/4] mmc: sdhci-cadence: refactor probe function
Date: Thu, 30 Mar 2017 21:30:53 +0200
Message-ID: <CAPDyKFo1VHQq3Vt=MgisMEH0vHVrsmUGUBqiKVBYha8oKS_deQ@mail.gmail.com>
References: <1490106736-2242-1-git-send-email-piotrs@cadence.com> <1490106806-3936-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34726 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934667AbdC3TbA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Mar 2017 15:31:00 -0400
Received: by mail-vk0-f51.google.com with SMTP id z204so67236103vkd.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Mar 2017 12:30:59 -0700 (PDT)
In-Reply-To: <1490106806-3936-1-git-send-email-piotrs@cadence.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Piotr Sroka <piotrs@cadence.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>

On 21 March 2017 at 15:33, Piotr Sroka <piotrs@cadence.com> wrote:
> Use added dev variable for devm_clk_get.
>
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>


Thanks, applied for next!

Kind regards
Uffe


> ---
> Changes for v5:
> - patch created in v5
> ---
>  drivers/mmc/host/sdhci-cadence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index c3c7090..5aa238d 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -305,7 +305,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
>         int ret;
>         struct device *dev = &pdev->dev;
>
> -       clk = devm_clk_get(&pdev->dev, NULL);
> +       clk = devm_clk_get(dev, NULL);
>         if (IS_ERR(clk))
>                 return PTR_ERR(clk);
>
> --
> 2.2.2
>
