From: Per Forlin <per.forlin@stericsson.com>
Subject: Re: [PATCH 0/5] MMC: mmci: Provide bindings for Device Tree
Date: Thu, 15 Mar 2012 20:12:49 +0100
Message-ID: <CAFEEs1=TJaCYmaWd7zd28NsV8ubZBpBn7p=Mi7vGtmV_vpfh1w@mail.gmail.com>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
	<CAFEEs1kz+QT_4Yc6byS4se0EMZvqA5hp5CvLvvtNgC++AJboxA@mail.gmail.com>
	<4F6209DA.1080809@linaro.org>
	<201203151532.44363.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37092 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161069Ab2COTMt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 15:12:49 -0400
Received: by yhmm54 with SMTP id m54so3470008yhm.19
        for <linux-mmc@vger.kernel.org>; Thu, 15 Mar 2012 12:12:49 -0700 (PDT)
In-Reply-To: <201203151532.44363.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, niklas.hernaeus@linaro.org, linux-mmc@vger.kernel.org

On Thu, Mar 15, 2012 at 4:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 15 March 2012, Lee Jones wrote:
>> > I would like to see what the minimal required change is to support DT
>> > for mmci without factorization.
>> > 1. Minimal change in mmci.
>> > 2. Add mmci_dt.c which contains the DT-populate code.
>> >
>> > The factorization could be done as step 2 I think.
>> >
>> > What do you say?
>>
>> I'm wondering what the difference is as the work has already been done.
>>
>> It was Arnd's suggestion to separate out the two types of variants, and
>> I'm quite fond of the new (fully featured) layout.
>
> Right, I usually prefer cleanups or other refactoring to be done first, and
> then features added on top.
>
> You could in theory add have just patches 3/4/5 all applied without
> the refactoring, but that I would be worried that this causes dependencies
> between the mmci driver and ux500 specific functionality like the
> stedma40_filter function.
>
About DT
I think I need to catch up on the DT-design a bit. I will try to catch
up on the DT-implementation and maybe then the refactorization will
make sense to me :)

Board specific data in mmci-driver
The stedma40 filter function is not really specific for ux500. ux500
use stedma40 but it should be possible to replace this DMA.IP with
some other DMA-controller. This is board specific configuration. You
should not need to change the mmci-driver just because the dma-driver
has changed, right?
Or will the board-configuration now be placed in mmci-ux500?

Common DT populate code for all mmc host drivers
Some parts of the DT-population is common for all the host driver, for
instance setting the CAP and CAP2. This code should be moved to a
common place to be used by other host drivers as well.

About refactoring
There are numbers of patches stashed up for MMCI waiting for verdict
here http://git.kernel.org/?p=linux/kernel/git/linusw/linux-stericsson.git;a=shortlog;h=refs/heads/mmci.
If doing a refactorization please rebase it on top of these patches.
This needs to be done carefully, there may be more to considerations
than just DT. Maybe the timing is better to do this for 4.5, just
after 4.4 is closed. Then we can make sure that all new patches are
made on top of the refactorized base.

BR
Per
