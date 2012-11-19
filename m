From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 2/4 v4] MMC/SD: Add callback function to detect card
Date: Sun, 18 Nov 2012 19:05:41 -0800
Message-ID: <20121119030541.GA6603@lizard>
References: <1351584769-16662-1-git-send-email-r66093@freescale.com>
 <1351584769-16662-2-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:38638 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab2KSDIw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Nov 2012 22:08:52 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so111975pad.19
        for <linux-mmc@vger.kernel.org>; Sun, 18 Nov 2012 19:08:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1351584769-16662-2-git-send-email-r66093@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: r66093@freescale.com
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chris Ball <cjb@laptop.org>

On Tue, Oct 30, 2012 at 04:12:47PM +0800, r66093@freescale.com wrote:
[..]
> If the card is present, 1 will return, if the card is absent, 0 will return.
> If the controller will not support this feature, -ENOSYS will return.
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Anton Vorontsov <cbouatmailru@gmail.com>
> CC: Chris Ball <cjb@laptop.org>
> ---
[...]
>  int _mmc_detect_card_removed(struct mmc_host *host)
>  {
> -	int ret;
> +	int ret = -ENOSYS;
>  
>  	if ((host->caps & MMC_CAP_NONREMOVABLE) || !host->bus_ops->alive)
>  		return 0;
> @@ -2081,7 +2081,13 @@ int _mmc_detect_card_removed(struct mmc_host *host)
>  	if (!host->card || mmc_card_removed(host->card))
>  		return 1;
>  
> -	ret = host->bus_ops->alive(host);
> +	if (host->ops->get_cd) {
> +		ret = host->ops->get_cd(host);
> +		if (ret >= 0)
> +			ret = !ret;

o_O

Oh, I see...

Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>

(But I must confess I didn't follow the whole discussion about
get_cd()-via-gpio being unreliable. I'm assuming you fixed this?)

> +	}
> +	if (ret < 0)
> +		ret = host->bus_ops->alive(host);
>  	if (ret) {
>  		mmc_card_set_removed(host->card);
>  		pr_debug("%s: card remove detected\n", mmc_hostname(host));
> -- 
> 1.7.9.5
