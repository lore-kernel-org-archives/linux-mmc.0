From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Thu, 04 Nov 2010 13:15:43 +0000
Message-ID: <4CD2B1FF.6030708@csr.com>
References: <1288869390-20465-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:52283 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049Ab0KDNQg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Nov 2010 09:16:36 -0400
Received: from rly05d.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly05d.srv.mailcontrol.com (MailControl) with ESMTP id oA4DFo11025917
	for <linux-mmc@vger.kernel.org>; Thu, 4 Nov 2010 13:16:30 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly05d.srv.mailcontrol.com (MailControl) id oA4DFlsP024893
	for <linux-mmc@vger.kernel.org>; Thu, 4 Nov 2010 13:15:47 GMT
In-Reply-To: <1288869390-20465-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nico@fluxnic.net>, Adrian Hunter <adrian.hunter@nokia.com>, Kyungmin Park <kmpark@infradead.org>, jh80.chung@samsung.com

Linus Walleij wrote:
> 
> Switch to grouping this with the runtime PM stuff as Alan
> suggested. Is this looking better?
> [...]
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index af8dc6a..9064def 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -148,14 +148,19 @@ static int mmc_runtime_suspend(struct device *dev)
>  {
>  	struct mmc_card *card = mmc_dev_to_card(dev);
>  
> +	mmc_gate_clock(card->host);
>  	return mmc_power_save_host(card->host);
>  }

Haven't you tied the clock gating to the power on/off state of the
card/host?  This looks like the wrong thing to me.  Surely we want to
gate the clock even if the card (or SDIO functions) are active?

David--
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
