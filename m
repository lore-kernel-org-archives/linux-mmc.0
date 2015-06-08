From: Scott Wood <scottwood@freescale.com>
Subject: Re: powerpc/corenet: enable eSDHC
Date: Mon, 8 Jun 2015 15:30:33 -0500
Message-ID: <1433795433.2477.62.camel@freescale.com>
References: <1430893748-38821-1-git-send-email-yangbo.lu@freescale.com>
	 <20150530000331.GA9143@home.buserror.net>
	 <BY1PR0301MB119286F6B8EBD6EED07C8B15F2BF0@BY1PR0301MB1192.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bn0105.outbound.protection.outlook.com ([157.56.110.105]:9500
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753325AbbFHUan (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 8 Jun 2015 16:30:43 -0400
In-Reply-To: <BY1PR0301MB119286F6B8EBD6EED07C8B15F2BF0@BY1PR0301MB1192.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lu Yangbo-B47093 <yangbo.lu@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, 2015-06-08 at 05:12 -0500, Lu Yangbo-B47093 wrote:
> Thanks a lot, Scott.
> And now a patch was merged on 
> git://git.linaro.org/people/ulf.hansson/mmc.git next branch to fix 
> this issue.
> It should be no problem.

Assuming that patch fixes it and gets pulled for 4.2, this config 
patch can go in for 4.3.

That said, it would be nice if, apart from fixing the problem itself, 
the MMC code failed more gracefully instead of endlessly repeating and 
filling up the log/console.

-Scott

