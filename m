From: tlinder <tlinder@codeaurora.org>
Subject: [RFC/PATCH v2 0/2] block:row: Adding support for urgent requests handling
Date: Thu,  1 Nov 2012 14:40:44 +0200
Message-ID: <1351773644-19525-1-git-send-email-tlinder@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, philippedeswert@gmail.com, jengelh@inai.de, jh80.chung@samsung.com, tgih.jun@samsung.com, arnd.bergmann@linaro.org, tlinder <tlinder@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

This patch set add support for handling urgent requests by the
ROW algorith. It depends on 2 previosly uploaded patch sets:
1. ROW scheduling Algorithm
2. Adding support for urgent requests handling

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
