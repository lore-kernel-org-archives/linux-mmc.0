From: Tanya Brokhman <tlinder@codeaurora.org>
Subject: [PATCH v3 0/2] block:row: Adding support for urgent requests handling
Date: Tue, 11 Dec 2012 15:43:18 +0200
Message-ID: <1355233400-26269-1-git-send-email-tlinder@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:44290 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711Ab2LKNnb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Dec 2012 08:43:31 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jaxboe@fusionio.com
Cc: linux-arm-msm@vger.kernel.org, philippedeswert@gmail.com, jengelh@inai.de, jh80.chung@samsung.com, tgih.jun@samsung.com, arnd.bergmann@linaro.org, venkat@linaro.org, linux-mmc@vger.kernel.org, Tanya Brokhman <tlinder@codeaurora.org>

This patch set add support for handling urgent requests by the
ROW algorith. It depends on 2 previosly uploaded patch sets:
1. ROW scheduling Algorithm
2. Adding support for urgent requests handling (in block layer)

Tanya Brokhman (2):
  row: Adding support for reinsert already dispatched req
  row: Add support for urgent request handling

 block/row-iosched.c |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 75 insertions(+), 1 deletions(-)

-- 
1.7.6
--
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. 
Is a member of Code Aurora Forum, hosted by the Linux Foundation

