From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Remove unneeded code
Date: Fri, 8 May 2015 10:24:14 +0800
Message-ID: <20150508022412.GP3162@dragon>
References: <1431021609-6932-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36853 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbbEHCYe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 May 2015 22:24:34 -0400
Received: by pabsx10 with SMTP id sx10so56188414pab.3
        for <linux-mmc@vger.kernel.org>; Thu, 07 May 2015 19:24:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1431021609-6932-1-git-send-email-fabio.estevam@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: ulf.hansson@linaro.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org

On Thu, May 07, 2015 at 03:00:09PM -0300, Fabio Estevam wrote:
> Since commit 8d86e4fcccf61 ("mmc: sdhci-esdhc-imx: Call mmc_of_parse()")
> the 'non-removable' and 'cd-gpios' properties are handled by
> mmc_of_parse(), so we can safely remove the pieces of code that still
> handles them.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

It looks like a left-over of commit 8d86e4fcccf61.

Acked-by: Shawn Guo <shawn.guo@linaro.org>
