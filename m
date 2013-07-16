From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 2/7] mmc: atmel-mci: prepare clk before calling
	enable
Date: Tue, 16 Jul 2013 18:13:24 +0100
Message-ID: <20130716171324.GF24642@n2100.arm.linux.org.uk>
References: <1373986995-23899-1-git-send-email-b.brezillon@overkiz.com> <1373987208-24120-1-git-send-email-b.brezillon@overkiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37137 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932381Ab3GPRNn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jul 2013 13:13:43 -0400
Content-Disposition: inline
In-Reply-To: <1373987208-24120-1-git-send-email-b.brezillon@overkiz.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Boris BREZILLON <b.brezillon@overkiz.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jul 16, 2013 at 05:06:48PM +0200, Boris BREZILLON wrote:
> @@ -389,9 +391,13 @@ static int atmci_regs_show(struct seq_file *s, void *v)
>  	 * consistent.
>  	 */
>  	spin_lock_bh(&host->lock);
> -	clk_enable(host->mck);
> +	ret = clk_prepare_enable(host->mck);
> +	if (ret) {
> +		spin_unlock_bh(&host->lock);
> +		goto out;
> +	}

NAK.  This is buggy.  clk_prepare() can sleep.  Calling clk_prepare()
even via clk_prepare_enable() is a blatent bug.

>  	memcpy_fromio(buf, host->regs, ATMCI_REGS_SIZE);
> -	clk_disable(host->mck);
> +	clk_disable_unprepare(host->mck);
>  	spin_unlock_bh(&host->lock);

Now, given that the CLK API counts enables/disables, having the spin lock
around the clk API calls is utterly pointless.  This should be:

	ret = clk_prepare_enable(host->mck);
	if (ret)
		goto out;

	spin_lock_bh(&host->lock);
	memcpy_fromio(buf, host->regs, ATMCI_REGS_SIZE);
	spin_unlock_bh(&host->lock);

	clk_disable_unprepare(host->mclk);

or, if you really need to have the clock enabled/disabled within the
spinlock (very very very unlikely):

	ret = clk_prepare(host->mck);
	if (ret)
		goto out;

	spin_lock_bh(&host->lock);
	ret = clk_enable(host->mck);
	if (ret == 0) {
		memcpy_fromio(buf, host->regs, ATMCI_REGS_SIZE);
		clk_disable(host->mck);
	}
	spin_unlock_bh(&host->lock);

	clk_unprepare(host->mclk);
	if (ret)
		goto out;

> @@ -1279,7 +1286,7 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  
>  		spin_lock_bh(&host->lock);
>  		if (!host->mode_reg) {
> -			clk_enable(host->mck);
> +			clk_prepare_enable(host->mck);

Again, buggy - calling clk_prepare beneath a spinlock is illegal.
