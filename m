From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: add support for ARM64
Date: Wed, 12 Nov 2014 15:11:09 +0100
Message-ID: <CAPDyKFp_XZ=93wisFScezHLqDWDz5XjqxHV1w13zmU3nzQrZww@mail.gmail.com>
References: <1409307891-16523-1-git-send-email-alim.akhtar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:55618 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbaKLOLK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Nov 2014 09:11:10 -0500
Received: by mail-qa0-f43.google.com with SMTP id j7so8551204qaq.16
        for <linux-mmc@vger.kernel.org>; Wed, 12 Nov 2014 06:11:09 -0800 (PST)
In-Reply-To: <1409307891-16523-1-git-send-email-alim.akhtar@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alim Akhtar <alim.akhtar@samsung.com>
Cc: Chris Ball <chris@printf.net>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Bresticker <abrestic@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

On 29 August 2014 12:24, Alim Akhtar <alim.akhtar@samsung.com> wrote:
> There are upcoming ARM64 SoCs with dw_mmc host controller.
>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index a43295c..72dd6c2 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -580,7 +580,7 @@ config SDH_BFIN_MISSING_CMD_PULLUP_WORKAROUND
>  config MMC_DW
>         tristate "Synopsys DesignWare Memory Card Interface"
>         depends on HAS_DMA
> -       depends on ARC || ARM || MIPS || COMPILE_TEST
> +       depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
>         help
>           This selects support for the Synopsys DesignWare Mobile Storage IP
>           block, this provides host support for SD and MMC interfaces, in both
> --
> 1.7.10.4
>
