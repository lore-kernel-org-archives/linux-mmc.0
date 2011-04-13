From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: Fix use of uninitialized data in mmc_cmd_app.
Date: Wed, 13 Apr 2011 16:24:07 -0400
Message-ID: <m3aaftvr14.fsf@pullcord.laptop.org>
References: <1302726792-4733-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42714 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756889Ab1DMUTY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 13 Apr 2011 16:19:24 -0400
In-Reply-To: <1302726792-4733-1-git-send-email-andreiw@motorola.com> (Andrei
	Warkentin's message of "Wed, 13 Apr 2011 15:33:12 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

Hi Andrei,

On Wed, Apr 13 2011, Andrei Warkentin wrote:
> mmc_cmd_app did not zero out mmc_command on stack.
>
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
> ---
>  drivers/mmc/core/sd_ops.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index 76af349..71fdb07 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -29,6 +29,8 @@ static int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
>  	BUG_ON(!host);
>  	BUG_ON(card && (card->host != host));
>  
> +	memset(&cmd, 0, sizeof(struct mmc_command));
> +
>  	cmd.opcode = MMC_APP_CMD;
>  
>  	if (card) {

Thanks, pushed to mmc-next for .40.  I found a few more which I'm about
to post.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
