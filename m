From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH] mmc: mmc_oops: support mmc_oops feature
Date: Fri, 27 Feb 2015 12:36:34 +0100
Message-ID: <3372849.Dqaz8KMKAB@wuerfel>
References: <1425015219-19849-1-git-send-email-jh80.chung@samsung.com> <41342138.MjUK31a4Mt@wuerfel> <54F03C05.7040009@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:60307 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbbB0Lgv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Feb 2015 06:36:51 -0500
In-Reply-To: <54F03C05.7040009@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

On Friday 27 February 2015 18:42:29 Jaehoon Chung wrote:
> Dear, Arnd.
> 
> On 02/27/2015 05:31 PM, Arnd Bergmann wrote:
> > On Friday 27 February 2015 14:33:39 Jaehoon Chung wrote:
> >> --- a/drivers/mmc/card/Kconfig
> >> +++ b/drivers/mmc/card/Kconfig
> >> @@ -68,3 +68,11 @@ config MMC_TEST
> >>  
> >>           This driver is only of interest to those developing or
> >>           testing a host driver. Most people should say N here.
> >> +
> >> +config MMC_OOPS
> >> +       tristate "Log panic/oops to a MMC buffer"
> >> +       depends on OF
> >> +       help
> >> +         This enables panic and oops messages to be logged to a circular
> >> +         buffer in a MMC sectors where it can be read back at some
> >> +         later point.
> >>
> > 
> > This sounds a lot like the implementation should be using
> > the fs/pstore infrastructure like we do for ramoops, chromeos
> > and the EFI runtime services logger.
> 
> I refer to it, so you can sound so. It's my wrong.
> I will rewrite the comment for MMC_OOPS config.
> Thanks for point out.

I don't exactly understand what you mean here, but I meant rewriting
the patch, not just the comment.

	Arnd
