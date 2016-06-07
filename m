From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: moxart-mmc: Fix APP_CMD flag set on non-application commands
Date: Tue, 07 Jun 2016 10:59:01 +0200
Message-ID: <3845045.bnmKhmzSey@wuerfel>
References: <734d328a-56ec-34bb-30ab-0a502041af2d@spinet.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:53069 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754522AbcFGI6B (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2016 04:58:01 -0400
In-Reply-To: <734d328a-56ec-34bb-30ab-0a502041af2d@spinet.sk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michal Kadlic <michal.kadlic@spinet.sk>
Cc: linux-mmc@vger.kernel.org

On Tuesday, June 7, 2016 10:53:01 AM CEST Michal Kadlic wrote:
> Moxart MMC host controller has an APP_CMD flag, that's set when sending 
> an ACMD. This was set by checking command opcode instead of CMD55->ACMDx 
> sequence, which could lead to regular commands like CMD6,CMD13,CMD23 and 
> CMD42 flagged as application commands.
> 
> Patch is against kernel version 4.6
> 
> Signed-off-by: Michal Kadlic <michal.kadlic@spinet.sk>

Is this needed for backports to stable kernels as well?

>   static inline void moxart_init_sg(struct moxart_host *host,
> @@ -211,10 +213,11 @@ static void moxart_send_command(struct m
>          writel(cmd->arg, host->base + REG_ARGUMENT);
> 
>          cmdctrl = cmd->opcode & CMD_IDX_MASK;
> -       if (cmdctrl == SD_APP_SET_BUS_WIDTH    || cmdctrl == 
> SD_APP_OP_COND   ||
> -           cmdctrl == SD_APP_SEND_SCR         || cmdctrl == 
> SD_APP_SD_STATUS ||
> -           cmdctrl == SD_APP_SEND_NUM_WR_BLKS)
> +

You seem to have an incorrect word wrapping setting in your email
client, so the patch won't apply. I'd recommend using 'git send-email',
which tends to be easier than figuring out the right settings for your
mailer.

> +       // If previous command was CMD55 set APP_CMD flag, except for 
> CMD0(Reset)

Please use /* ... */ comments.

	Arnd
