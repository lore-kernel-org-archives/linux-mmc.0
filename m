From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [patch] mmc: fix init f_min
Date: Mon, 20 Sep 2010 15:34:12 +0100
Message-ID: <4C9770E4.7000801@csr.com>
References: <AANLkTi=8ScP4Lm-an7bjXhj8doUVu+nM0KnVTa3WK4p3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-g.mailcontrol.com ([208.87.233.190]:41816 "EHLO
	cluster-g.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844Ab0ITOep (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2010 10:34:45 -0400
Received: from rly25g.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly25g.srv.mailcontrol.com (MailControl) with ESMTP id o8KEYQ7l011180
	for <linux-mmc@vger.kernel.org>; Mon, 20 Sep 2010 15:34:44 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly25g.srv.mailcontrol.com (MailControl) id o8KEYGPU009019
	for <linux-mmc@vger.kernel.org>; Mon, 20 Sep 2010 15:34:16 +0100
In-Reply-To: <AANLkTi=8ScP4Lm-an7bjXhj8doUVu+nM0KnVTa3WK4p3@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>

zhangfei gao wrote:
> From fa357144df43e6c1a9e5e36af497c53437cd41e1 Mon Sep 17 00:00:00 2001
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Mon, 20 Sep 2010 15:12:26 -0400
> Subject: [PATCH 3/4] mmc: fix init f_min
> 
> Change-Id: I7fab1a1a162d9f26fc92c497078f26912c04a3fc

What's this line in the description for?

> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
>  drivers/mmc/core/core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 5db49b1..9114c87 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -910,9 +910,9 @@ static void mmc_power_up(struct mmc_host *host)
>  	if (host->f_min > 400000) {
>  		pr_warning("%s: Minimum clock frequency too high for "
>  				"identification mode\n", mmc_hostname(host));
> -		host->ios.clock = host->f_min;
> -	} else
>  		host->ios.clock = 400000;
> +	} else
> +		host->ios.clock = host->f_min;

NAK.

The code is already correctly requesting 400 kHz (unless the controller
can't go that slow).

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
