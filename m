Return-Path: <SRS0=NquR=6B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EC0C2BB1D
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 20:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978332223D
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 20:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgDQUoW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgDQUoV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 Apr 2020 16:44:21 -0400
Received: from ROU-LT-M43218B.mchp-main.com (amontpellier-556-1-155-96.w109-210.abo.wanadoo.fr [109.210.131.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F22DF20656;
        Fri, 17 Apr 2020 20:44:15 +0000 (UTC)
Date:   Fri, 17 Apr 2020 22:44:44 +0200
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
Subject: Re: [PATCH 03/19] mmc: atmel-mci: Respect the cmd->busy_timeout from
 the mmc core
Message-ID: <20200417204444.63ggl53sxztdyvln@ROU-LT-M43218B.mchp-main.com>
References: <20200414161413.3036-1-ulf.hansson@linaro.org>
 <20200414161413.3036-4-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414161413.3036-4-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Apr 14, 2020 at 06:13:57PM +0200, Ulf Hansson wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> Using a fixed 2s timeout for all commands is a bit problematic.
> 
> For some commands it means waiting longer than needed for the timer to
> expire, which may not a big issue, but still. For other commands, like for
> an erase (CMD38) that uses a R1B response, may require longer timeouts than
> 2s. In these cases, we may end up treating the command as it failed, while
> it just needed some more time to complete successfully.
> 
> Fix the problem by respecting the cmd->busy_timeout, which is provided by
> the mmc core.
> 
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Far better than a fixed timeout.

This driver covers many versions of the IP. I could test it with only one
version. As I didn't any regression and these three patches make sense

Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks

> ---
>  drivers/mmc/host/atmel-mci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 7292970065b6..5cb692687698 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -809,6 +809,9 @@ static u32 atmci_prepare_command(struct mmc_host *mmc,
>  static void atmci_send_command(struct atmel_mci *host,
>                 struct mmc_command *cmd, u32 cmd_flags)
>  {
> +       unsigned int timeout_ms = cmd->busy_timeout ? cmd->busy_timeout :
> +               ATMCI_CMD_TIMEOUT_MS;
> +
>         WARN_ON(host->cmd);
>         host->cmd = cmd;
> 
> @@ -819,8 +822,7 @@ static void atmci_send_command(struct atmel_mci *host,
>         atmci_writel(host, ATMCI_ARGR, cmd->arg);
>         atmci_writel(host, ATMCI_CMDR, cmd_flags);
> 
> -       mod_timer(&host->timer,
> -                 jiffies + msecs_to_jiffies(ATMCI_CMD_TIMEOUT_MS));
> +       mod_timer(&host->timer, jiffies + msecs_to_jiffies(timeout_ms));
>  }
> 
>  static void atmci_send_stop_cmd(struct atmel_mci *host, struct mmc_data *data)
> --
> 2.20.1
> 
