From: Zoran Markovic <zoran.markovic@linaro.org>
Subject: Re: [RFC PATCH] mmc: Enable wakeup_sources for mmc core
Date: Fri, 14 Jun 2013 11:42:33 -0700
Message-ID: <CAME+o4mM-YmcZ4pcdWo7mzrDUi2R2LhihgcnbYixOm8KnGfnBA@mail.gmail.com>
References: <1371146190-16786-1-git-send-email-zoran.markovic@linaro.org>
	<CAPDyKFrD=q4hOQps5ENJdmAPJyKG1cj7+P6MtXdQ8KQ1cPjnpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:62720 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035Ab3FNSme (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Jun 2013 14:42:34 -0400
Received: by mail-oa0-f44.google.com with SMTP id l10so1118971oag.31
        for <linux-mmc@vger.kernel.org>; Fri, 14 Jun 2013 11:42:33 -0700 (PDT)
In-Reply-To: <CAPDyKFrD=q4hOQps5ENJdmAPJyKG1cj7+P6MtXdQ8KQ1cPjnpQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, San Mehat <san@google.com>, Colin Cross <ccross@android.com>, John Stultz <john.stultz@linaro.org>, Chris Ball <cjb@laptop.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Jaehoon Chung <jh80.chung@samsung.com>, Konstantin Dorfman <kdorfman@codeaurora.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>

> I am not sure I understand why this patch is needed. When a new card
> is inserted/removed and the upper levels gets notification about the
> new card, triggering the mounting/un-mounting of the file system, why
> should it be the lowest layer (mmc) that prevents the platform from
> enter suspend/sleep? Why do we need to prevent it at all?
>
> Note that notifier handling in mmc_pm_notify, was if I remember
> correctly, not completely developed when the original version of this
> patch was being discussed. mmc_pm_notify prevents cards from being
> inserted/removed in the middle of suspend->resume sequence, is that
> not enough?

I will try to speak on behalf of the original implementers in a hope
they would provide the original motivation for the patch.

My understanding is that any preemption in the procedure could be an
opportunity to suspend, as there may be a suspend request racing with
this code. This is why the calls to __pm_stay_awake() and
queue_delayed_work() are so tightly coupled. It would be up to the
delayed work procedure (mmc_rescan()) to decide whether or not it is
safe to suspend. If there are no changes in the MMC state or all
changes can be handled by mmc_rescan(), it is safe to call
__pm_relax(). Otherwise, userland may take over processing of this
event, and this is why the awake state needs to be extended by 1/2
second.

Regards, Zoran
