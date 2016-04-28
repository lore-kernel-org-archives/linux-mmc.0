From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Remove redundant rescan_disable flag
Date: Thu, 28 Apr 2016 16:07:37 +0200
Message-ID: <CAPDyKFpryTCQPXhHNQRZkAS1D3pBKwUJrndpC1Q0WrcqK096SQ@mail.gmail.com>
References: <1461840951-4401-1-git-send-email-ulf.hansson@linaro.org>
	<5722059F.5040703@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38632 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbcD1OHj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2016 10:07:39 -0400
Received: by mail-wm0-f44.google.com with SMTP id g17so43518564wme.1
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2016 07:07:38 -0700 (PDT)
In-Reply-To: <5722059F.5040703@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>

On 28 April 2016 at 14:44, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 28/04/16 13:55, Ulf Hansson wrote:
>> As cancel_delayed_work_sync() prevents an executing work for re-scheduling
>> itself, the rescan_disable flag is redundant.
>
> Are you sure rescan_disable is not needed for mmc_pm_notify()?

That's a good question!

Because we are using the system_freezable_wq for the detect works, the
works will be frozen when userspace is becomes frozen during system
PM.

New detect works that might get scheduled after that point will not be
scheduled to run until the queue becomes un-frozen.

Let's me re-spin the patch and update the changelog as that is of
course relevant information.

[...]

Kind regards
Uffe
