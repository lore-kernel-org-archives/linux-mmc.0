From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v3 2/7] mmc: atmel-mci: prepare clk before calling
 enable
Date: Tue, 16 Jul 2013 17:13:24 +0200
Message-ID: <20130716171324.7d483ada@skate>
References: <1373986995-23899-1-git-send-email-b.brezillon@overkiz.com>
	<1373987208-24120-1-git-send-email-b.brezillon@overkiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:36488 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932469Ab3GPPN3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jul 2013 11:13:29 -0400
In-Reply-To: <1373987208-24120-1-git-send-email-b.brezillon@overkiz.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Boris BREZILLON <b.brezillon@overkiz.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Dear Boris BREZILLON,

On Tue, 16 Jul 2013 17:06:48 +0200, Boris BREZILLON wrote:

>  	buf = kmalloc(ATMCI_REGS_SIZE, GFP_KERNEL);
>  	if (!buf)
> @@ -389,9 +391,13 @@ static int atmci_regs_show(struct seq_file *s, void *v)
>  	 * consistent.
>  	 */
>  	spin_lock_bh(&host->lock);
> -	clk_enable(host->mck);
> +	ret = clk_prepare_enable(host->mck);

I am not very familiar with the spin_lock_bh() variant, but are you
sure we are allowed to sleep within a spin_lock_bh()-protected critical
section?

Remember that clk_prepare_enable() calls both ->prepare() and
->enable() for the clock, and ->prepare() is allowed to sleep, while
->enable() is guaranteed not to sleep.

Therefore, clk_prepare() is usually called at probe time, while
clk_enable() is called whenever enabling/disabling the clock is really
needed. So not all clk_enable() can transparently be converted into a
clk_prepare_enable().

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
