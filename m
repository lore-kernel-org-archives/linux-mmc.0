From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [patch 1/1]sdhci: sdhc spec 3.0 add some modification
Date: Tue, 10 Aug 2010 17:32:44 +0100
Message-ID: <20100810163244.GA12837@console-pimps.org>
References: <AANLkTin=8qej=hh3sJQkyjHcp17Wh4j8wngqyuRz=+1C@mail.gmail.com> <AANLkTimx_-+wvrnoe22ZDtrhfc0Ds873KSzW04zuppBH@mail.gmail.com> <AANLkTinn+Af7kE34kjLEf3XLe2YTbpkJ4MtePFK0vMS8@mail.gmail.com> <20100809101042.GA8293@console-pimps.org> <AANLkTinqToYc6bizV7AcKuk-4XiNA08qhqfCPN1WLo8S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:40151 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932212Ab0HJQcp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 12:32:45 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinqToYc6bizV7AcKuk-4XiNA08qhqfCPN1WLo8S@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>

On Mon, Aug 09, 2010 at 08:33:16PM +0800, zhangfei gao wrote:
> 
> Thanks for your careful review, in our platform, we use max/min for
> the max_div, so miss this modification :(
> Update the patch, help review again.

What do you mean? Where does max/min come from? It would definitely
be best if everybody uses the same code to calculate max_div. Have
you tested the max_div changes? Are you now using this patch on
your platform or are you still maintaining a patch to do it a
different way?

If you've got a separate patch and it does this things better
than the way we currently do them, get it upstream! :-)
