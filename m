From: Alan Cooper <alcooperx@gmail.com>
Subject: Re: [PATCH 1/4] mmc: Add quirk to disable SDR50 mode
Date: Fri, 6 Nov 2015 09:07:49 -0500
Message-ID: <CAOGqxeU8QN6ntmyFbOFPN8jAYLThQeyD6mxLBb_JgshfTwvJMg@mail.gmail.com>
References: <1446763200-10234-1-git-send-email-alcooperx@gmail.com>
	<CAPDyKFrhtoDwe82Zg4YP4eU=xO6zE1pZTcRSnzSeHGRCzgu+5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34632 "EHLO
	mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161339AbbKFOHu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Nov 2015 09:07:50 -0500
Received: by qkdg3 with SMTP id g3so399977qkd.1
        for <linux-mmc@vger.kernel.org>; Fri, 06 Nov 2015 06:07:49 -0800 (PST)
In-Reply-To: <CAPDyKFrhtoDwe82Zg4YP4eU=xO6zE1pZTcRSnzSeHGRCzgu+5w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com

On Fri, Nov 6, 2015 at 3:14 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> No thanks! No more quirks please!

OK, I'll move this functionality into the sdhci-brcmstb driver and
re-submit the patch set.

Thanks
Al
