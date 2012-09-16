From: Tatyana Brokhman <tlinder@codeaurora.org>
Subject: [RFC/PATCH 0/2] row: Adding support for urgent requests handling
Date: Sun, 16 Sep 2012 12:12:54 +0300
Message-ID: <1347786776-8327-1-git-send-email-tlinder@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:31670 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab2IPJNG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 16 Sep 2012 05:13:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: axboe@kernel.dk
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, Tatyana Brokhman <tlinder@codeaurora.org>

This patch set add support for handling urgent requests by the
ROW algorith. It depends on 2 previosly uploaded patch sets:
1.[RFC/PATCH/RESEND 0/2] ROW scheduling Algorithm
2.[RFC/PATCH 0/2] Adding support for urgent requests handling

Tatyana Brokhman (2):
  row: Adding support for reinsert already dispatched req
  row: Add support for urgent request handling

 block/row-iosched.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 77 insertions(+), 1 deletions(-)

-- 
1.7.6
--
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. 
Is a member of Code Aurora Forum, hosted by the Linux Foundation
