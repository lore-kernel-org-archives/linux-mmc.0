From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] sdhci: rtsx: fix 64 BIT DMA quirks
Date: Wed, 8 Apr 2015 12:07:43 +0200
Message-ID: <CAPDyKFpLZzum7KdXFBWeurmL00f6Q4=8vPJ7OROYmDYXSy0ZqA@mail.gmail.com>
References: <1428377521-16619-1-git-send-email-micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vn0-f52.google.com ([209.85.216.52]:40244 "EHLO
	mail-vn0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018AbbDHKHn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Apr 2015 06:07:43 -0400
Received: by vnbg62 with SMTP id g62so14075052vnb.7
        for <linux-mmc@vger.kernel.org>; Wed, 08 Apr 2015 03:07:43 -0700 (PDT)
In-Reply-To: <1428377521-16619-1-git-send-email-micky_ching@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: micky <micky_ching@realsil.com.cn>
Cc: Chris Ball <chris@printf.net>, Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, "driverdev-devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Roger <rogerable@realtek.com>, Wei WANG <wei_wang@realsil.com.cn>

On 7 April 2015 at 05:32,  <micky_ching@realsil.com.cn> wrote:
> From: Micky Ching <micky_ching@realsil.com.cn>
>
> rts5250 chip failed handle 64 bit ADMA for address below 4G.
> Add 64 BIT quirks to disable this feature.
>
> Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>

Thanks! Applied, with a minor updated commit message header.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index 0342775..ae8e450 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -650,6 +650,7 @@ static int rtsx_probe_slot(struct sdhci_pci_slot *slot)
>
>  static const struct sdhci_pci_fixes sdhci_rtsx = {
>         .quirks2        = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +                       SDHCI_QUIRK2_BROKEN_64_BIT_DMA |
>                         SDHCI_QUIRK2_BROKEN_DDR50,
>         .probe_slot     = rtsx_probe_slot,
>  };
> --
> 1.9.1
>
