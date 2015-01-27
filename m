From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Enable Ricoh MMC quirk by default
Date: Tue, 27 Jan 2015 14:56:53 +0100
Message-ID: <CAPDyKFpKN85kg-bCkt9PxSS-oH4KdvgErX9Oy5Js53OfoteZ0Q@mail.gmail.com>
References: <20150126114415.00369e32@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:63906 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbbA0N4x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jan 2015 08:56:53 -0500
Received: by mail-qg0-f45.google.com with SMTP id q107so11708810qgd.4
        for <linux-mmc@vger.kernel.org>; Tue, 27 Jan 2015 05:56:53 -0800 (PST)
In-Reply-To: <20150126114415.00369e32@endymion.delvare>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Philipl Langdale <philipl@overt.org>

On 26 January 2015 at 11:44, Jean Delvare <jdelvare@suse.de> wrote:
> Config option MMC_RICOH_MMC's help text reads:
>
>           If unsure, say Y.
>
> However the option defaults to N. Set the default to Y to match the
> recommendation in the help text.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Chris Ball <chris@printf.net>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Philipl Langdale <philipl@overt.org>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-3.19-rc6.orig/drivers/mmc/host/Kconfig        2015-01-26 11:39:05.048048277 +0100
> +++ linux-3.19-rc6/drivers/mmc/host/Kconfig     2015-01-26 11:39:27.121513084 +0100
> @@ -83,6 +83,7 @@ config MMC_SDHCI_PCI
>  config MMC_RICOH_MMC
>         bool "Ricoh MMC Controller Disabler"
>         depends on MMC_SDHCI_PCI
> +       default y
>         help
>           This adds a pci quirk to disable Ricoh MMC Controller. This
>           proprietary controller is unnecessary because the SDHCI driver
>
>
> --
> Jean Delvare
> SUSE L3 Support
