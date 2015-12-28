From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/9] mmc: sdhci-pci: use to_pci_dev()
Date: Mon, 28 Dec 2015 14:29:42 +0100
Message-ID: <CAPDyKFrSGZTacQeqS-41q5Y_wvJfAr+5JkgWZeV3dd+wZbL1Tw@mail.gmail.com>
References: <baf4e17c993f197cc31f8a0e5736ee8a558ba44c.1451211133.git.geliangtang@163.com>
	<7ec8850ded7ef24fa8e68d2482ac1046f1a9dc1b.1451211133.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36661 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbbL1N3n (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Dec 2015 08:29:43 -0500
Received: by mail-yk0-f176.google.com with SMTP id v14so10131903ykd.3
        for <linux-mmc@vger.kernel.org>; Mon, 28 Dec 2015 05:29:43 -0800 (PST)
In-Reply-To: <7ec8850ded7ef24fa8e68d2482ac1046f1a9dc1b.1451211133.git.geliangtang@163.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geliang Tang <geliangtang@163.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Peter Guo <peter.guo@bayhubtech.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 27 December 2015 at 11:46, Geliang Tang <geliangtang@163.com> wrote:
> Use to_pci_dev() instead of open-coding it.
>
> Signed-off-by: Geliang Tang <geliangtang@163.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 08f4a9f..cc851b0 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1464,7 +1464,7 @@ static int sdhci_pci_resume(struct device *dev)
>
>  static int sdhci_pci_runtime_suspend(struct device *dev)
>  {
> -       struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> +       struct pci_dev *pdev = to_pci_dev(dev);
>         struct sdhci_pci_chip *chip;
>         struct sdhci_pci_slot *slot;
>         int i, ret;
> @@ -1500,7 +1500,7 @@ err_pci_runtime_suspend:
>
>  static int sdhci_pci_runtime_resume(struct device *dev)
>  {
> -       struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
> +       struct pci_dev *pdev = to_pci_dev(dev);
>         struct sdhci_pci_chip *chip;
>         struct sdhci_pci_slot *slot;
>         int i, ret;
> --
> 2.5.0
>
>
