From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH V3 0/5] sdhci-esdhc-imx: use gpio for write protection and card detection
Date: Thu, 24 Feb 2011 12:40:10 +0100
Message-ID: <87k4gp3bl1.fsf@lebrac.rtp-net.org>
References: <1298469118-25282-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lebrac.rtp-net.org ([88.191.135.105]:44560 "EHLO
	lebrac.rtp-net.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756195Ab1BXLk2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Feb 2011 06:40:28 -0500
In-Reply-To: <1298469118-25282-1-git-send-email-w.sang@pengutronix.de>
	(Wolfram Sang's message of "Wed, 23 Feb 2011 14:51:53 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

Wolfram Sang <w.sang@pengutronix.de> writes:

Hi,

> Take #3, changes:
>
> * also intercept calls to SDHCI_SIGNAL_ENABLE (needed on mx25)
> * remove unconditional BROKEN_CARD_DETECTION (leftover)
> * improved kernel-doc about unused GPIO
> * added tags from Eric
>
> Tested now by me and Marc on mx35, Eric on mx25/35/51. Arnaud, did you have a
> chance to retest on mx51? What about the FSL guys? :)

I'm getting a hard freeze on my efika sb and mx once I remove the
unconditional BROKEN_CARD_DETECTION flag. I'm still investigating the
issue. I'll keep you informed if I find something.

Arnaud
