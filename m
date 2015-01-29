From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: moxart: fix probe logic
Date: Thu, 29 Jan 2015 23:04:46 +0100
Message-ID: <4063267.WLHfiFCJT7@wuerfel>
References: <8340872.32GezMfzR1@wuerfel> <20150129170104.GD26493@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:56924 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757873AbbA2WEy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jan 2015 17:04:54 -0500
In-Reply-To: <20150129170104.GD26493@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, Jonas Jensen <jonas.jensen@gmail.com>

On Thursday 29 January 2015 17:01:04 Russell King - ARM Linux wrote:
> On Thu, Jan 29, 2015 at 05:15:31PM +0100, Arnd Bergmann wrote:
> > @@ -586,10 +586,10 @@ static int moxart_probe(struct platform_device *pdev)
> >               goto out;
> >       }
> >  
> > -     clk = of_clk_get(node, 0);
> > -     if (IS_ERR(clk)) {
> > +     host->clk = of_clk_get(node, 0);
> > +     if (IS_ERR(host->clk)) {
> >               dev_err(dev, "of_clk_get failed\n");
> > -             ret = PTR_ERR(clk);
> > +             ret = PTR_ERR(host->clk);
> >               goto out;
> >       }
> >  
> ...
> > @@ -677,6 +679,8 @@ static int moxart_probe(struct platform_device *pdev)
> >       return 0;
> >  
> >  out:
> > +     if (host->clk)
> > +             clk_put(host->clk);
> 
> Are you sure?
> 

Oops, sorry about that.

Thanks for the review! Fixed patch follows.

	Arnd
