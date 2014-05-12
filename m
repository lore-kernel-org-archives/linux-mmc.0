From: Chris Ball <chris@printf.net>
Subject: Re: [GIT PULL] MMC updates for mmc-next for 3.16, take 2
Date: Mon, 12 May 2014 23:23:19 +0100
Message-ID: <861tvytz54.fsf@void.printf.net>
References: <CAPDyKFrCuL9HmQyOPZXex1WZT0LiJ6HCj6JiXoh-x+o-CHuhiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35803 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491AbaELWXV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 May 2014 18:23:21 -0400
In-Reply-To: <CAPDyKFrCuL9HmQyOPZXex1WZT0LiJ6HCj6JiXoh-x+o-CHuhiA@mail.gmail.com>
	(Ulf Hansson's message of "Thu, 8 May 2014 14:57:07 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi Ulf,

On Thu, May 08 2014, Ulf Hansson wrote:
> Note 2)
> I have not included the patch below; since I think it would be better
> if you just drop the patch which this is reverting from your mmc next
> branch.
> [PATCH 1/2] mmc: rtsx: Revert "mmc: rtsx: modify error handle and
> remove smatch warnings"

Thanks for putting this together, I've dropped that patch and pulled
in your patchset to mmc-next now.

Something I'm curious about -- if I drop the above rtsx patch from
(what used to be) origin/mmc-next and then pull your branch, I get:

>From git://git.linaro.org/people/ulf.hansson/mmc
 * branch            mmc-next_for_chris_3.16_take2 -> FETCH_HEAD
Auto-merging drivers/mmc/host/rtsx_usb_sdmmc.c
CONFLICT (add/add): Merge conflict in drivers/mmc/host/rtsx_usb_sdmmc.c
Auto-merging drivers/mmc/host/mxcmmc.c
CONFLICT (content): Merge conflict in drivers/mmc/host/mxcmmc.c
Auto-merging drivers/mmc/host/Makefile
Auto-merging drivers/mmc/host/Kconfig
Automatic merge failed; fix conflicts and then commit the result.

The conflict in rtsx_usb_sdmmc.c is understandable, but I wonder why
mxcmmc.c grew a conflict when it wasn't modified by the patch I
dropped?  If you happen to know, would be great to understand it. :)

Thanks!

- Chris.
-- 
Chris Ball   <http://printf.net/>
