From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [RFC/PATCH 4/4] block: Add URGENT request notification support
 to CFQ scheduler
Date: Sun, 04 Aug 2013 16:45:59 +0300
Message-ID: <51FE5B17.3060608@codeaurora.org>
References: <1373547671-2779-1-git-send-email-tlinder@codeaurora.org> <x49oba9ndls.fsf@segfault.boston.devel.redhat.com> <51E020C2.4040504@codeaurora.org> <CAB+TZU_hyC4WJ6UuyMupih29iRRwutoUX+U+c28qo8AGEnvRmw@mail.gmail.com> <51E02B7D.6020505@codeaurora.org> <CAB+TZU9T_pE66y=-BrLf1PZ7osFnni81VDQBNsFNFzqOtqrrCg@mail.gmail.com> <51E053B8.5030602@codeaurora.org> <51F539AB.5090601@codeaurora.org> <CAB+TZU_PZTY696t0eEZ8i8qJueq8xMm2CrM1DFxtBW4XEoySpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:47206 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab3HDNqG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Aug 2013 09:46:06 -0400
In-Reply-To: <CAB+TZU_PZTY696t0eEZ8i8qJueq8xMm2CrM1DFxtBW4XEoySpw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: mani <manishrma@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Tanya Brokhman <tlinder@codeaurora.org>

Hello Manish,

On 08/03/2013 10:28 PM, mani wrote:
> 
> Yes, the patch does the same but then why to modify the CFQ ?
CFQ currently not supports URGENT request notification/reinsert - so you
can't use it with urgent data request implementation in mmc layer.

> Instead I think u should only move the urgent requests in front of the
> queue ?

This is not good enough, because still the urgent requests are stacked
after long write requests in the MMC layer and because of asynch request
mechanism it may be 2 very long write requests (eMMC4.5 packed request
feature can pack up to ~60 write requests into single packed request).

> Also may be someone has to do the decision making for the urgent request
> either it is application, VFS or Filesystem
According to my understanding there is clear separation of functionality
between block layer and block device driver:  Block layer implements
policy of reordering/merging requests based on many parameters, while
block device driver mainly purpose to fill underlying data bus with
maximum efficiency (data rate/power/memory/etc. resource wise).

VFS/Filesystem uses block plug list to consolidate its bios and to give
a chance to merge them into single request in the block layer. For
ordering enforcement there is FLUSH/FUA mechanism. CFQ uses iopriority
as classification parameter to differentiate bios into different
priority queues.

> and that is the main concern. As per my understanding "*Every read may not
> be urgent and every write must not stall*.
Not every read is urgent in CFQ, request is considered urgent under the
following conditions:
1. The currently served queue has lower priority than the incoming
request queue (iopriority)
2. This is read request.

MMC layer re-inserts interrupted write request and original timestamp is
not changed, so it will be scheduled according to its deadline.

In case you need special requirements for say "low priority read" it
should be implemented within block layer scheduler (existing one or new).

Thanks,
-- 
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
