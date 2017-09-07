From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: host: fix typo after MMC_DEBUG move
Date: Thu, 7 Sep 2017 14:06:46 +0200
Message-ID: <CAPDyKFoYZqm9b90Nmudzgf7ApN0-hCCKocX38Dw7i_Zb7ZW3iQ@mail.gmail.com>
References: <20170905182750.4343-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:38459 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754796AbdIGMGr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Sep 2017 08:06:47 -0400
Received: by mail-io0-f180.google.com with SMTP id q64so3627153iod.5
        for <linux-mmc@vger.kernel.org>; Thu, 07 Sep 2017 05:06:47 -0700 (PDT)
In-Reply-To: <20170905182750.4343-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 5 September 2017 at 20:27, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> MMC_DEBUG was moved and one letter got strangely capitalized.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>
> based on mmc/next
>
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 02179ed2a40d7a..8c15637178ff3c 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -5,7 +5,7 @@
>  comment "MMC/SD/SDIO Host Controller Drivers"
>
>  config MMC_DEBUG
> -       bool "MMC host drivers debugginG"
> +       bool "MMC host drivers debugging"
>         depends on MMC != n
>         help
>           This is an option for use by developers; most people should
> --
> 2.11.0
>
