From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: fix mmc card disappearence on resume on ricoh
	mmc controllers
Date: Mon, 7 Jun 2010 00:23:13 +0100
Message-ID: <20100606232313.GA5444@void.printf.net>
References: <1275859475.3151.4.camel@maxim-laptop> <1275859731-2898-2-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55050 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752014Ab0FFXXO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 6 Jun 2010 19:23:14 -0400
Content-Disposition: inline
In-Reply-To: <1275859731-2898-2-git-send-email-maximlevitsky@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Philip Langdale <philipl@overt.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hi,

On Mon, Jun 07, 2010 at 12:28:51AM +0300, Maxim Levitsky wrote:
> +	/* Some controllers (especialy the ricoh mmc controller) delay
> +		card detection on resume (probably since the controller
> +		has to poke the card to determine if its MMC or not */
> +
> +	if (host->mmc->bus_ops && (host->quirks &
> +			SDHCI_QUIRK_WAIT_CARD_ON_RESUME)) {
> +
> +		unsigned long timeout = jiffies + msecs_to_jiffies(2000);
> +
> +		while (!time_after(jiffies, timeout))
> +			if (sdhci_readl(host, SDHCI_PRESENT_STATE)
> +							& SDHCI_CARD_PRESENT) {
> +				break;

It looks like your editor is set to four-space instead of eight-space
tab characters, else you wouldn't be using so many tabs here. 

-- 
Chris Ball   <cjb@laptop.org>
One Laptop Per Child
