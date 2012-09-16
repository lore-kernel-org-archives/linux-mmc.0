From: Tatyana Brokhman <tlinder@codeaurora.org>
Subject: [RFC/PATCH 0/2] Adding support for urgent requests handling
Date: Sun, 16 Sep 2012 12:06:40 +0300
Message-ID: <1347786402-7339-1-git-send-email-tlinder@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:17574 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480Ab2IPJGu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Sep 2012 05:06:50 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: axboe@kernel.dk
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Tatyana Brokhman <tlinder@codeaurora.org>

This patch set adds support in block & elevator layers for handling
urgent requests.
Urgent request notification passed to underlying driver (eMMC for
example) and causes interruption of low priority current request in
order to execute the urgent one.
The interrupted request is inserted back to the scheduler's internal
data structures.

Tatyana Brokhman (2):
  block: Add support for reinsert a dispatched req
  block: Add API for urgent request handling

 block/blk-core.c         |   68 ++++++++++++++++++++++++++++++++++++++++++++-
 block/blk-settings.c     |   12 ++++++++
 block/blk.h              |   11 +++++++
 block/elevator.c         |   34 +++++++++++++++++++++++
 include/linux/blkdev.h   |    6 ++++
 include/linux/elevator.h |    8 +++++
 6 files changed, 137 insertions(+), 2 deletions(-)

-- 
1.7.6
--
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. 
Is a member of Code Aurora Forum, hosted by the Linux Foundation

