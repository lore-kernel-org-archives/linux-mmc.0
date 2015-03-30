From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] Update codes relevant to dw-mmc controller
Date: Mon, 30 Mar 2015 11:25:31 +0200
Message-ID: <CAPDyKFo9PeKaa+R32098F-9B71rXxZsznAJMUPVOjpgZGMbN2A@mail.gmail.com>
References: <55189C7C.50201@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:34429 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbbC3JZc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Mar 2015 05:25:32 -0400
Received: by qgep97 with SMTP id p97so182243953qge.1
        for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2015 02:25:32 -0700 (PDT)
In-Reply-To: <55189C7C.50201@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Chris Ball <chris@printf.net>

On 30 March 2015 at 02:44, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear, Ulf.
>
> Sorry for updating too late..
> ASAP, I will request pull for patches of dw-mmc controller at next time.
> If needs anything, let me know, plz.

Thanks Jaehoon! Pulled into my next branch.

Kind regards
Uffe

>
> The following changes since commit 40de191e55585db80793e1c01d051fb539042d15:
>
>   mmc: core: Enable runtime PM management of host devices (2015-03-27 14:57:50 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jh80chung/dw-mmc.git tags/dw_mmc-for-ulf
>
> for you to fetch changes up to 21db9218155ad2cb75cf0111b07da6cce7452d30:
>
>   mmc: dw_mmc: Don't try to enable the CD until we're sure we're not deferring (2015-03-30 01:29:23 +0900)
>
> ----------------------------------------------------------------
> Main update:
> - Add the cmd11 timer to detect a timeout.
> - Fixes: bcafaf5470f0 ("mmc: dw_mmc: Only enable CD after setup and only if needed"
>
> ----------------------------------------------------------------
> Doug Anderson (2):
>       mmc: dw_mmc: Add a timeout for sending CMD11
>       mmc: dw_mmc: Don't try to enable the CD until we're sure we're not deferring
>
> Jaehoon Chung (1):
>       mmc: dw_mmc: enable card read threshold when mode is HS400
>
>  drivers/mmc/host/dw_mmc.c  |   33 ++++++++++++++++++++++++++++++---
>  include/linux/mmc/dw_mmc.h |    2 ++
>  2 files changed, 32 insertions(+), 3 deletions(-)
