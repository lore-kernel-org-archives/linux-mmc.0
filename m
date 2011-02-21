From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-tegra: free irq on error and remove
Date: Mon, 21 Feb 2011 21:44:51 +0000
Message-ID: <20110221214451.GA29206@void.printf.net>
References: <1297357650-14245-1-git-send-email-w.sang@pengutronix.de> <20110221072120.GA13424@pengutronix.de> <AANLkTi=LQfWjeGYf4sLbjif9nO20yjKtEN+dzq5Qdjtp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37195 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095Ab1BUVoz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 21 Feb 2011 16:44:55 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=LQfWjeGYf4sLbjif9nO20yjKtEN+dzq5Qdjtp@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org

Hi,

On Mon, Feb 21, 2011 at 01:35:36PM -0800, Olof Johansson wrote:
> >> Found the leak while working on the esdhc-imx driver. Not even compile tested,
> >> please check.
> >
> > Olof, do you have a minute for this one?
> 
> Yeah, my bad -- I thought I had already acked it.
> 
> Acked-by: Olof Johansson <olof@lixom.net>

Thanks, pushed to mmc-next for .39.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
