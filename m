From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] MMC updates for mmc-next for 3.16, take 2
Date: Tue, 13 May 2014 10:54:35 +0200
Message-ID: <CAPDyKFpYPDXQcpPFt3PenRusp9jXfd_teF2aQVQpXmxrUxvYZQ@mail.gmail.com>
References: <CAPDyKFrCuL9HmQyOPZXex1WZT0LiJ6HCj6JiXoh-x+o-CHuhiA@mail.gmail.com>
	<861tvytz54.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:50920 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbaEMIyg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 May 2014 04:54:36 -0400
Received: by mail-qc0-f180.google.com with SMTP id i17so35785qcy.11
        for <linux-mmc@vger.kernel.org>; Tue, 13 May 2014 01:54:35 -0700 (PDT)
In-Reply-To: <861tvytz54.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 13 May 2014 00:23, Chris Ball <chris@printf.net> wrote:
> Hi Ulf,
>
> On Thu, May 08 2014, Ulf Hansson wrote:
>> Note 2)
>> I have not included the patch below; since I think it would be better
>> if you just drop the patch which this is reverting from your mmc next
>> branch.
>> [PATCH 1/2] mmc: rtsx: Revert "mmc: rtsx: modify error handle and
>> remove smatch warnings"
>
> Thanks for putting this together, I've dropped that patch and pulled
> in your patchset to mmc-next now.
>
> Something I'm curious about -- if I drop the above rtsx patch from
> (what used to be) origin/mmc-next and then pull your branch, I get:
>
> From git://git.linaro.org/people/ulf.hansson/mmc
>  * branch            mmc-next_for_chris_3.16_take2 -> FETCH_HEAD
> Auto-merging drivers/mmc/host/rtsx_usb_sdmmc.c
> CONFLICT (add/add): Merge conflict in drivers/mmc/host/rtsx_usb_sdmmc.c
> Auto-merging drivers/mmc/host/mxcmmc.c
> CONFLICT (content): Merge conflict in drivers/mmc/host/mxcmmc.c
> Auto-merging drivers/mmc/host/Makefile
> Auto-merging drivers/mmc/host/Kconfig
> Automatic merge failed; fix conflicts and then commit the result.
>
> The conflict in rtsx_usb_sdmmc.c is understandable, but I wonder why
> mxcmmc.c grew a conflict when it wasn't modified by the patch I
> dropped?  If you happen to know, would be great to understand it. :)
>

Huh, it seems like you re-based your branch while removing the rtsx
patch patch, but before pulling my branch. And since my branch were
based on yours, we screwed up. :-)

I tried doing the same operation locally, but I really can't tell what
happens. I would strongly suggest you to go back to the previous state
were the you still hold the rtsx patch on your branch and start over.
Then do things in the opposite order.

If you don't have access to your old version of your mmc-next branch,
you could just overwrite your mmc-next branch with the
mmc-next_for_chris_3.16_take2 branch from my git tree.

Kind regards
Uffe

> Thanks!
>
> - Chris.
> --
> Chris Ball   <http://printf.net/>
