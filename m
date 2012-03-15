From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/5] MMC: mmci: Provide bindings for Device Tree
Date: Thu, 15 Mar 2012 20:36:27 +0000
Message-ID: <20120315203627.GB2311@n2100.arm.linux.org.uk>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org> <CAFEEs1kz+QT_4Yc6byS4se0EMZvqA5hp5CvLvvtNgC++AJboxA@mail.gmail.com> <4F6209DA.1080809@linaro.org> <201203151532.44363.arnd@arndb.de> <CAFEEs1=TJaCYmaWd7zd28NsV8ubZBpBn7p=Mi7vGtmV_vpfh1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:32947 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031833Ab2COUgi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 16:36:38 -0400
Content-Disposition: inline
In-Reply-To: <CAFEEs1=TJaCYmaWd7zd28NsV8ubZBpBn7p=Mi7vGtmV_vpfh1w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@stericsson.com>
Cc: Arnd Bergmann <arnd@arndb.de>, niklas.hernaeus@linaro.org, linux-mmc@vger.kernel.org, cjb@laptop.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

On Thu, Mar 15, 2012 at 08:12:49PM +0100, Per Forlin wrote:
> About refactoring
> There are numbers of patches stashed up for MMCI waiting for verdict
> here http://git.kernel.org/?p=linux/kernel/git/linusw/linux-stericsson.git;a=shortlog;h=refs/heads/mmci.
> If doing a refactorization please rebase it on top of these patches.

Quite a number of these are in linux-next via my tree:

http://ftp.arm.linux.org.uk/git/?p=linux-next.git;a=shortlog;h=7437cfa532842ce75189826742bddf1ba137f58e

There's 10 there, out of the 17 in Linus' tree.  See my previous replies
on why that's the case.
