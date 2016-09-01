From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] mmc: Check BKOPS Level On Runtime Suspend
Date: Thu, 1 Sep 2016 09:45:04 +0200
Message-ID: <CAPDyKFrLAAeLPuEJGCA1EzS2Xmfpo9puJN4G3BZCMZJRAXq7yA@mail.gmail.com>
References: <1472706697-853-1-git-send-email-alex.lemberg@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35007 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754325AbcIAHpH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Sep 2016 03:45:07 -0400
Received: by mail-wm0-f47.google.com with SMTP id w2so62601666wmd.0
        for <linux-mmc@vger.kernel.org>; Thu, 01 Sep 2016 00:45:06 -0700 (PDT)
In-Reply-To: <1472706697-853-1-git-send-email-alex.lemberg@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "alex.lemberg" <alex.lemberg@sandisk.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Avi Shchislowski <avi.shchislowski@sandisk.com>

On 1 September 2016 at 07:11, alex.lemberg <alex.lemberg@sandisk.com> wrote:
> Flash based storage devices might need to perform the internal
> Background Operations (BKOPS) in order to insure better performance
> for the next coming IO.
> Following the discussion in the mmc thread:
> www.spinics.net/lists/linux-mmc/msg37779.html
> To let the device complete its BKOPS during Runtime Suspend,
> we suggest to check the BKOPS level.
> In case the device need to complete its BKOPS, reschedule the Runtime
> Suspend.
>
> alex.lemberg (3):
>   mmc: replacing hardcoded value for runtime PM suspend
>   mmc: Adding AUTO_BKOPS_EN bit set for Auto BKOPS support
>   mmc: Checking BKOPS status prior to Suspend
>
>  drivers/mmc/card/block.c |  3 ++-
>  drivers/mmc/core/mmc.c   | 36 +++++++++++++++++++++++++++++-------
>  include/linux/mmc/card.h |  1 +
>  include/linux/mmc/host.h |  2 ++
>  include/linux/mmc/mmc.h  |  2 ++
>  5 files changed, 36 insertions(+), 8 deletions(-)
>
> --
> 1.9.1
>

Alex, this didn't help either. So I could of course pick the patches
just from my inbox, as those are correctly formatted, but...  I then
realized that your emails isn't accepted in either spinics' or marc's
mail-archive.

I was looking into the raw email and the headers gets *really*
obfuscated by your Microsoft exchange server. We can't review this
until you fixed this, you emails at least needs to be accepted by the
mail-archives.

http://marc.info/?l=linux-mmc
http://www.spinics.net/lists/linux-mmc/

Kind regards
Uffe
