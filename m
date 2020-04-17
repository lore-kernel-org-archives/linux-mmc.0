Return-Path: <SRS0=NquR=6B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BDCC2BB1D
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 20:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85B0221E9
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 20:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgDQUkF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgDQUkF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 Apr 2020 16:40:05 -0400
Received: from ROU-LT-M43218B.mchp-main.com (amontpellier-556-1-155-96.w109-210.abo.wanadoo.fr [109.210.131.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC52420656;
        Fri, 17 Apr 2020 20:40:00 +0000 (UTC)
Date:   Fri, 17 Apr 2020 22:40:28 +0200
From:   ludovic.desroches@microchip.com
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        Alex Dubov <oakad@yahoo.com>,
        Sascha Sommer <saschasommer@freenet.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mirq-linux@rere.qmqm.pl, Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH 02/19] mmc: atmel-mci: Set the timer per command rather
 than per request
Message-ID: <20200417204028.qapr4anx7wfppxev@ROU-LT-M43218B.mchp-main.com>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
 <20200414161413.3036-3-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414161413.3036-3-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Apr 14, 2020 at 06:13:56PM +0200, Ulf Hansson wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Setting the timer on a per request basis, is rather limiting as the timer
> really depends on what commands that is to be sent as part of the request.
> 
> Therefore improve the behaviour by programming the timer per command basis
> instead.
> 
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Makes sense.

Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks

> ---
>  drivers/mmc/host/atmel-mci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 0472df8391b5..7292970065b6 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -169,6 +169,7 @@
>  #define        atmci_writel(port, reg, value)                  \
>         __raw_writel((value), (port)->regs + reg)
> 
> +#define ATMCI_CMD_TIMEOUT_MS   2000
>  #define AUTOSUSPEND_DELAY      50
> 
>  #define ATMCI_DATA_ERROR_FLAGS (ATMCI_DCRCE | ATMCI_DTOE | ATMCI_OVRE | ATMCI_UNRE)
> @@ -817,6 +818,9 @@ static void atmci_send_command(struct atmel_mci *host,
> 
>         atmci_writel(host, ATMCI_ARGR, cmd->arg);
>         atmci_writel(host, ATMCI_CMDR, cmd_flags);
> +
> +       mod_timer(&host->timer,
> +                 jiffies + msecs_to_jiffies(ATMCI_CMD_TIMEOUT_MS));
>  }
> 
>  static void atmci_send_stop_cmd(struct atmel_mci *host, struct mmc_data *data)
> @@ -1314,8 +1318,6 @@ static void atmci_start_request(struct atmel_mci *host,
>          * prepared yet.)
>          */
>         atmci_writel(host, ATMCI_IER, iflags);
> -
> -       mod_timer(&host->timer, jiffies +  msecs_to_jiffies(2000));
>  }
> 
>  static void atmci_queue_request(struct atmel_mci *host,
> --
> 2.20.1
> 
