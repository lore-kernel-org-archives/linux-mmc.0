From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 12/13] mmc: atmel-mci: use endian agnostic IO
Date: Wed, 25 Mar 2015 09:52:21 +0100
Message-ID: <CAPDyKFpwZA52zDQCt01xiuFrATu2As5Hm3uLmQQf9kk=hYKfzg@mail.gmail.com>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
	<1426693992-31163-13-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:35474 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbbCYIwW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Mar 2015 04:52:22 -0400
Received: by qgh3 with SMTP id 3so20227195qgh.2
        for <linux-mmc@vger.kernel.org>; Wed, 25 Mar 2015 01:52:21 -0700 (PDT)
In-Reply-To: <1426693992-31163-13-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ludovic Desroches <ludovic.desroches@atmel.com>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 18 March 2015 at 16:53, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Change the __raw IO functions to endian agnostic relaxed ones to allow
> the driver to function on big endian ARM systems.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Thanks! Applied.

Kind regards
Uffe


> --
> CC: Ludovic Desroches <ludovic.desroches@atmel.com>
> CC: Chris Ball <chris@printf.net>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: linux-mmc@vger.kernel.org
> ---
>  drivers/mmc/host/atmel-mci-regs.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/atmel-mci-regs.h b/drivers/mmc/host/atmel-mci-regs.h
> index c97001e..711bb53 100644
> --- a/drivers/mmc/host/atmel-mci-regs.h
> +++ b/drivers/mmc/host/atmel-mci-regs.h
> @@ -135,10 +135,17 @@
>  #define ATMCI_REGS_SIZE                0x100
>
>  /* Register access macros */
> -#define atmci_readl(port,reg)                          \
> +#ifdef CONFIG_AVR32
> +#define atmci_readl(port,reg)                  \
>         __raw_readl((port)->regs + reg)
>  #define atmci_writel(port,reg,value)                   \
>         __raw_writel((value), (port)->regs + reg)
> +#else
> +#define atmci_readl(port,reg)                  \
> +       readl_relaxed((port)->regs + reg)
> +#define atmci_writel(port,reg,value)                   \
> +       writel_relaxed((value), (port)->regs + reg)
> +#endif
>
>  /* On AVR chips the Peripheral DMA Controller is not connected to MCI. */
>  #ifdef CONFIG_AVR32
> --
> 2.1.4
>
