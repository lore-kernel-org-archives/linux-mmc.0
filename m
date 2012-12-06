From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [PATCH v4] mmc: fix async request mechanism for sequential read
 scenarios
Date: Thu, 06 Dec 2012 16:23:12 +0200
Message-ID: <50C0AA50.90707@codeaurora.org>
References: <n@samsung.com> <1354714708-17942-1-git-send-email-kdorfman@codeaurora.org> <001301cdd371$e7beaa90$b73bffb0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:53377 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321Ab2LFOXQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Dec 2012 09:23:16 -0500
In-Reply-To: <001301cdd371$e7beaa90$b73bffb0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, per.lkml@gmail.com

On 12/06/2012 07:24 AM, Seungwon Jeon wrote:
> Hi,
> 
> Doesn't it consider SD path?
> It have a problem with uninitialized 'context_info'.
> 'context_info' is moved into mmc_host struct in v4.
> Please, could you explain the reason in brief?
> 

The problem I'm trying to resolve with the v4 change is: there should be
no core/core.c API change from upper layers point of view.

There was such violation, when the synchronization mechanism of async
request for data commands was changed (from "completion" to "wait_event"
+ number of flags to pass event reason).

Before v4, the 'context_info' initialized by mmc_init_queue() function
and this is valid only for mmcblk. For example when running the mmc_test
module, the code for card/queue.c, card/block.c layers is not run at all
and the struct remains uninitialized.

In the current version the initialization was moved into
mmc_attach_mmc(), but now, I understand, that this initialization should
be moved even before mmc_attach_XXX() (XXX is sdio/sd/mmc...) - it may
be placed in  mmc_rescan_try_freq().

Will resend v4 after the testing.

'mmc_host' structure contains a host information for all sdio/sd/mmc, so
'context_info' may be accessed by any protocol willing to use
NEW_REQUEST notification (when async request mechanism is used).

-- 
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
