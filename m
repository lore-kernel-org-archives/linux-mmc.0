From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] mmc: Check BKOPS Level On Runtime Suspend
Date: Wed, 31 Aug 2016 15:51:36 +0200
Message-ID: <CAPDyKFpYSZwQSoeA-aMh9P7gDuSDa6gzouusWpBOOidf3jw=Fg@mail.gmail.com>
References: <1472491952-395-1-git-send-email-alex.lemberg@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35847 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934432AbcHaNvj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Aug 2016 09:51:39 -0400
Received: by mail-wm0-f41.google.com with SMTP id c133so33678694wmd.1
        for <linux-mmc@vger.kernel.org>; Wed, 31 Aug 2016 06:51:38 -0700 (PDT)
In-Reply-To: <1472491952-395-1-git-send-email-alex.lemberg@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "alex.lemberg" <alex.lemberg@sandisk.com>
Cc: Avi Shchislowski <avi.shchislowski@sandisk.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 29 August 2016 at 19:32, alex.lemberg <alex.lemberg@sandisk.com> wrote:
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

Alex, thanks for posting this. Although, the patches doesn't show up
in the https://patchwork.kernel.org/project/linux-mmc/list/. I guess
it's because you must have linux-mmc on the to list. Could you please
resend?

Kind regards
Uffe
