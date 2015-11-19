From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] mmc: sdhci: Fix strings broken across multiple lines
Date: Thu, 19 Nov 2015 16:16:04 +0100
Message-ID: <201511191616.04636.marex@denx.de>
References: <1447840022-8262-1-git-send-email-marex@denx.de> <201511191258.45847.marex@denx.de> <CAPDyKFoQxCj01khj4pLitDa=UEA-gmE0rMXx1+RBWHTSpNCwyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:34000 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066AbbKSPQG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Nov 2015 10:16:06 -0500
In-Reply-To: <CAPDyKFoQxCj01khj4pLitDa=UEA-gmE0rMXx1+RBWHTSpNCwyQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On Thursday, November 19, 2015 at 01:05:15 PM, Ulf Hansson wrote:
> On 19 November 2015 at 12:58, Marek Vasut <marex@denx.de> wrote:
> > On Thursday, November 19, 2015 at 12:52:06 PM, Ulf Hansson wrote:
> >> On 18 November 2015 at 10:47, Marek Vasut <marex@denx.de> wrote:
> >> > This is a trivial patch which fixes printed strings split across two
> >> > or more lines in the source. I tried to grep for some error output*,
> >> > but I couldn't find it easily because it was broken across multiple
> >> > lines. This patch makes my life easier.
> >> > 
> >> > * in particular "Timeout waiting for hardware interrupt."
> >> > 
> >> > Signed-off-by: Marek Vasut <marex@denx.de>
> >> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > 
> > Hi!
> > 
> >> Future wise, no need to add a Cc tag here. You should send the patch
> >> to me anyway.
> > 
> > Are CC tags now frowned upon? In case I have multiple distinct patches
> > (which go to distinct lists/recipients) in a queue, I use these CC tags
> > to track who to keep in a loop. Is there some better way to do this?
> 
> As this was a separate patch I didn't quite understand the Cc.
> If the patch is a part of a patchset, it makes more sense if it
> involves different subsystems/maintainers.

It does, but the patches are orthogonal in my case, so I am sending them
using git send-email -1 or such.

> Anyway, no big deal for me! If I don't like the Cc tag, I can easily
> remove it when applying.

Thanks :-)

Best regards,
Marek Vasut
