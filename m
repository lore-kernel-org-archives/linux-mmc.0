From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2] mmc mxcmmc: fix falling back to PIO
Date: Thu, 25 Aug 2011 11:39:05 +0200
Message-ID: <20110825093905.GB7526@pengutronix.de>
References: <1314264785-19224-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60897 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508Ab1HYJjH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Aug 2011 05:39:07 -0400
Content-Disposition: inline
In-Reply-To: <1314264785-19224-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Thu, Aug 25, 2011 at 11:33:05AM +0200, Sascha Hauer wrote:
> When we can't configure the dma channel we want to fall
> back to PIO. We do this by setting host->do_dma to zero.
> This does not work as do_dma is used to see whether dma
> can be used for the current transfer. Instead, we have
> to set host->dma to NULL.

Argh. Still wrong. I stop sending patches for today.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
