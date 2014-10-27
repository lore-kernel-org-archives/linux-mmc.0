From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pci-o2micro: Fix Dell E5440 issue
Date: Mon, 27 Oct 2014 13:01:13 +0100
Message-ID: <CAPDyKFp1JZMxKkjjdwv-tfcouHKKn_Hkw3VrPhoQ=5yty2JU9g@mail.gmail.com>
References: <1411525744-4215-1-git-send-email-peter.guo@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:48561 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbaJ0MBO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Oct 2014 08:01:14 -0400
Received: by mail-qa0-f45.google.com with SMTP id dc16so3629405qab.32
        for <linux-mmc@vger.kernel.org>; Mon, 27 Oct 2014 05:01:13 -0700 (PDT)
In-Reply-To: <1411525744-4215-1-git-send-email-peter.guo@bayhubtech.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "peter.guo" <peter.guo@bayhubtech.com>
Cc: Chris Ball <chris@printf.net>, "adam.lee@canonical.com" <adam.lee@canonical.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Samuel Guan <samuel.guan@bayhubtech.com>

On 24 September 2014 04:29, peter.guo <peter.guo@bayhubtech.com> wrote:
> From: "peter guo" <peter.guo@bayhubtech.com>
>
> Fix Dell E5440 when reboot Linux, can't find o2micro sd host chip issue.
>
> Signed-off-by: peter guo <peter.guo@bayhubtech.com>

Thanks! Applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 5670e38..e2ec108d 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -127,8 +127,6 @@ void sdhci_pci_o2_fujin2_pci_init(struct sdhci_pci_chip *chip)
>                 return;
>         scratch_32 &= ~((1 << 21) | (1 << 30));
>
> -       /* Set RTD3 function disabled */
> -       scratch_32 |= ((1 << 29) | (1 << 28));
>         pci_write_config_dword(chip->pdev, O2_SD_FUNC_REG3, scratch_32);
>
>         /* Set L1 Entrance Timer */
> --
> 1.9.1
>
