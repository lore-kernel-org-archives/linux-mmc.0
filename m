From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 0/3] mmc: block: Fix tuning (by avoiding it) for RPMB
Date: Tue, 10 May 2016 12:28:47 +0200
Message-ID: <CAPDyKFouAZyBKM0-5jAtE0AJ92jZ5Z-YM3_Jxtnmp+1vfPF1gQ@mail.gmail.com>
References: <1462361893-11897-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38568 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbcEJK2s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2016 06:28:48 -0400
Received: by mail-wm0-f45.google.com with SMTP id g17so19138549wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 May 2016 03:28:48 -0700 (PDT)
In-Reply-To: <1462361893-11897-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Tomas Winkler <tomas.winkler@intel.com>

On 4 May 2016 at 13:38, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Hi
>
> The RPMB partition only allows certain commands.  In particular,
> the tuning command (CMD21) is not allowed -  refer JEDEC eMMC
> standard v5.1 section 6.2.2 Command restrictions.
>
> That means commands will begin failing if re-tuning is needed
> while switched to the RPMB partition.
>
> As we discussed here:
>
>         http://marc.info/?l=linux-mmc&m=146218765801869
>
> this patch set takes a new approach which is:
>
>         Re-tune before switching to the RPMB partition
>         Don't allow re-tuning while switched to RPMB
>         Switch back from the RPMB partition immediately
>
> I gave it a brief test with a HS400 eMMC and using mmc utils
> to access RPMB.  Despite all the partition switches and
> re-tuning in between, all RPMB operations were successful.
>
>
> Changes in V2:
>
>         New approach entirely
>
>
> Adrian Hunter (3):
>       mmc: core: Add a facility to "pause" re-tuning
>       mmc: block: Always switch back to main area after RPMB access
>       mmc: block: Pause re-tuning while switched to the RPMB partition
>
>  drivers/mmc/card/block.c | 19 ++++++++++++++++++-
>  drivers/mmc/core/host.c  | 22 ++++++++++++++++++++++
>  include/linux/mmc/host.h |  4 ++++
>  3 files changed, 44 insertions(+), 1 deletion(-)
>
>
> Regards
> Adrian

Thanks, applied for next!

Kind regards
Uffe
