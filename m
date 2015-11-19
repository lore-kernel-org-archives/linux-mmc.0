From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] mmc: sdhci: Fix strings broken across multiple lines
Date: Thu, 19 Nov 2015 12:58:45 +0100
Message-ID: <201511191258.45847.marex@denx.de>
References: <1447840022-8262-1-git-send-email-marex@denx.de> <CAPDyKFq6XcKczr+QrJ_-XodxLZZxLiyG+EMpGBzDyR3pe5=oBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:48066 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756164AbbKSL6r (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Nov 2015 06:58:47 -0500
In-Reply-To: <CAPDyKFq6XcKczr+QrJ_-XodxLZZxLiyG+EMpGBzDyR3pe5=oBw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On Thursday, November 19, 2015 at 12:52:06 PM, Ulf Hansson wrote:
> On 18 November 2015 at 10:47, Marek Vasut <marex@denx.de> wrote:
> > This is a trivial patch which fixes printed strings split across two
> > or more lines in the source. I tried to grep for some error output*,
> > but I couldn't find it easily because it was broken across multiple
> > lines. This patch makes my life easier.
> > 
> > * in particular "Timeout waiting for hardware interrupt."
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>

Hi!

> Future wise, no need to add a Cc tag here. You should send the patch
> to me anyway.

Are CC tags now frowned upon? In case I have multiple distinct patches
(which go to distinct lists/recipients) in a queue, I use these CC tags
to track who to keep in a loop. Is there some better way to do this?

> Thanks, applied for next!

Thanks.

> FYI: There were some check patch warnings, but I decided to ignore
> them as those are related to the use of the DBG macro.

Oh yeah, the DBG() macro struck me as slightly odd. We should probably
use dev_err() or pr_err() where applicable.

> Kind regards
> Uffe

[..]

Best regards,
Marek Vasut
