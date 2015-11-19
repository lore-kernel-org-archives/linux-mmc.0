From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Fix strings broken across multiple lines
Date: Thu, 19 Nov 2015 13:05:15 +0100
Message-ID: <CAPDyKFoQxCj01khj4pLitDa=UEA-gmE0rMXx1+RBWHTSpNCwyQ@mail.gmail.com>
References: <1447840022-8262-1-git-send-email-marex@denx.de>
	<CAPDyKFq6XcKczr+QrJ_-XodxLZZxLiyG+EMpGBzDyR3pe5=oBw@mail.gmail.com>
	<201511191258.45847.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33092 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbbKSMFP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Nov 2015 07:05:15 -0500
Received: by ykdv3 with SMTP id v3so104943022ykd.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2015 04:05:15 -0800 (PST)
In-Reply-To: <201511191258.45847.marex@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 19 November 2015 at 12:58, Marek Vasut <marex@denx.de> wrote:
> On Thursday, November 19, 2015 at 12:52:06 PM, Ulf Hansson wrote:
>> On 18 November 2015 at 10:47, Marek Vasut <marex@denx.de> wrote:
>> > This is a trivial patch which fixes printed strings split across two
>> > or more lines in the source. I tried to grep for some error output*,
>> > but I couldn't find it easily because it was broken across multiple
>> > lines. This patch makes my life easier.
>> >
>> > * in particular "Timeout waiting for hardware interrupt."
>> >
>> > Signed-off-by: Marek Vasut <marex@denx.de>
>> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
>
> Hi!
>
>> Future wise, no need to add a Cc tag here. You should send the patch
>> to me anyway.
>
> Are CC tags now frowned upon? In case I have multiple distinct patches
> (which go to distinct lists/recipients) in a queue, I use these CC tags
> to track who to keep in a loop. Is there some better way to do this?

As this was a separate patch I didn't quite understand the Cc.
If the patch is a part of a patchset, it makes more sense if it
involves different subsystems/maintainers.

Anyway, no big deal for me! If I don't like the Cc tag, I can easily
remove it when applying.

Kind regards
Uffe
