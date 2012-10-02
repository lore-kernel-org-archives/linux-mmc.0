From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: [PATCH] mmc: fix async request mechanism for sequential read scenarios
Date: Tue,  2 Oct 2012 17:36:56 +0200
Message-ID: <1349192217-724-1-git-send-email-kdorfman@codeaurora.org>
References: <n>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:31816 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644Ab2JBPhb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Oct 2012 11:37:31 -0400
In-Reply-To: <n>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Konstantin Dorfman <kdorfman@codeaurora.org>

The main assumption of the async request design is that the file
system adds block requests to the block device queue asynchronously
without waiting for completion (see the Rationale section of
https://wiki.linaro.org/WorkingGroups/Kernel/Specs/StoragePerfMMC-async-req).

We found out that in case of sequential read operations this is not
the case, due to the read ahead mechanism.
When mmcqt reports on completion of a request there should be
a context switch to allow the insertion of the next read ahead BIOs
to the block layer. Since the mmcqd tries to fetch another request
immediately after the completion of the previous request it gets NULL
and starts waiting for the completion of the previous request.
This wait on completion gives the FS the opportunity to insert the next
request but the MMC layer is already blocked on the previous request
completion and is not aware of the new request waiting to be fetched.

This patch fixes the above behavior and allows the async request mechanism
to work in case of sequential read scenarios.
The main idea is to replace the blocking wait for a completion with an
event driven mechanism and add a new event of new_request.
When the block layer notifies the MMC layer on a new request, we check
for the above case where MMC layer is waiting on a previous request
completion and the current request is NULL.
In such a case the new_request event will be triggered to wakeup
the waiting thread. MMC layer will then fetch the new request
and after its preparation will go back to waiting on the completion.

Our tests showed that this fix improves the read sequential throughput
by 16%.

Konstantin Dorfman (1):
  mmc: fix async request mechanism for sequential read scenarios

 drivers/mmc/card/block.c |   30 ++++-----
 drivers/mmc/card/queue.c |   34 ++++++++-
 drivers/mmc/card/queue.h |    1 +
 drivers/mmc/core/core.c  |  165 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/card.h |   12 ++++
 include/linux/mmc/core.h |   21 ++++++
 6 files changed, 243 insertions(+), 20 deletions(-)

-- 
1.7.6

--
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation
