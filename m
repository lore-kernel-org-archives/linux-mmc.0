From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [patch v2 1/1]sdhci support 10 bit divided clock Mode for spec
 3.0
Date: Mon, 16 Aug 2010 17:07:15 +0100
Message-ID: <4C696233.6000408@csr.com>
References: <AANLkTimBQA+-RLAv-DRb3cv10LH84B=7Rzo92igwyo4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:59953 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab0HPQIH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2010 12:08:07 -0400
Received: from rly21d.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly21d.srv.mailcontrol.com (MailControl) with ESMTP id o7GG7nUW020983
	for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2010 17:08:05 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly21d.srv.mailcontrol.com (MailControl) id o7GG7I5G015027
	for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2010 17:07:18 +0100
In-Reply-To: <AANLkTimBQA+-RLAv-DRb3cv10LH84B=7Rzo92igwyo4A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Matt Fleming <matt@console-pimps.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

zhangfei gao wrote:
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 913555e..32dcac9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
[...]
> @@ -1001,13 +1001,23 @@ static void sdhci_set_clock(struct sdhci_host
> *host, unsigned int clock)
>  	if (clock == 0)
>  		goto out;
> 
> -	for (div = 1;div < 256;div *= 2) {
> -		if ((host->max_clk / div) <= clock)
> -			break;
> +	if (host->version >= SDHCI_SPEC_300)
> +		max_div = 2046;
> +	else
> +		max_div = 256;
> +
> +	if(host->max_clk <= clock)
> +		div = 1;
> +	else {
> +		for (div = 2; div < max_div; div += 2) {
> +			if ((host->max_clk / div) <= clock)
> +				break;
> +		}

This isn't correct.  The divisor must be a power of two for 2.00
controllers.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
