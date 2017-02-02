From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/2] Auto BKOPS PM suspend
Date: Thu, 2 Feb 2017 12:38:33 +0100
Message-ID: <CAPDyKFqxenCvAeR4F5m_feQSFJM1_y31++Mm-GDenWfYbVJwVg@mail.gmail.com>
References: <1485076535-20572-1-git-send-email-uri.yanai@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35211 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbdBBLif (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Feb 2017 06:38:35 -0500
Received: by mail-wm0-f51.google.com with SMTP id b65so86163843wmf.0
        for <linux-mmc@vger.kernel.org>; Thu, 02 Feb 2017 03:38:35 -0800 (PST)
In-Reply-To: <1485076535-20572-1-git-send-email-uri.yanai@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Uri Yanai <uri.yanai@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>

Hi Uri,

Sorry for the delay.

On 22 January 2017 at 10:15, Uri Yanai <uri.yanai@sandisk.com> wrote:
> Resubmitting three patches for approval, originally submitted by Alex Lemberg <alex.lemberg@sandisk.com>

I can only see two patches in this series.

> [1/3] mmc: replacing hardcoded value for runtime PM suspend(removed)
> [2/3] mmc: Adding AUTO_BKOPS_EN bit set for Auto BKOPS support(changed)
> [3/3] mmc: Checking BKOPS status prior to Suspend(changed)

I think also Shawn Lin pointed out for the earlier submission, the
importance of the information in this cover letter.

First, I think this should give a nice summary of what the series
does, how and why. Neither of these questions are answered.

Second, for each new version, please provide a summary of what has changed.

>
> Uri Yanai (2):
>   mmc: Adding AUTO_BKOPS_EN bit set for Auto BKOPS support
>   mmc: Checking BKOPS status prior to Suspend
>
>  drivers/mmc/core/mmc.c   | 37 +++++++++++++++++++++++++++++++------
>  include/linux/mmc/card.h |  1 +
>  include/linux/mmc/mmc.h  |  1 +
>  3 files changed, 33 insertions(+), 6 deletions(-)
>
> --
> 1.9.1
>

Kind regards
Uffe
