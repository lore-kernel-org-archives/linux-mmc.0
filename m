From: tlinder <tlinder@codeaurora.org>
Subject: [RFC/PATCH v2 0/2] Adding support for urgent requests handling
Date: Thu,  1 Nov 2012 14:21:15 +0200
Message-ID: <1351772475-10298-1-git-send-email-tlinder@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:21305 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933620Ab2KAMVX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Nov 2012 08:21:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, philippedeswert@gmail.com, jengelh@inai.de, jh80.chung@samsung.com, tgih.jun@samsung.com, arnd.bergmann@linaro.org, tlinder <tlinder@codeaurora.org>

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
 block/elevator.c         |   35 +++++++++++++++++++++++
 include/linux/blkdev.h   |    6 ++++
 include/linux/elevator.h |    8 +++++
 6 files changed, 138 insertions(+), 2 deletions(-)

-- 
1.7.6
--
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. 
Is a member of Code Aurora Forum, hosted by the Linux Foundation

