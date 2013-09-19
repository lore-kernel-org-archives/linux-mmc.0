From: Ben Gardiner <ben.l.gardiner@gmail.com>
Subject: [PATCH 0/3] Write-reliability settings support
Date: Thu, 19 Sep 2013 11:14:26 -0400
Message-ID: <cover.1379602866.git.ben.l.gardiner@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:58836 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab3ISPOi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Sep 2013 11:14:38 -0400
Received: by mail-qc0-f175.google.com with SMTP id v2so5526101qcr.34
        for <linux-mmc@vger.kernel.org>; Thu, 19 Sep 2013 08:14:37 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org

This series builds on top of 
d91d3698c6464a83b7c301eb84da109f9f94b54c

It introduces
 * an extracted function for setting the PARTITION_SETTING_COMPLETE bit
 * a command for setting the write-reliability bits
 * pretty-printing the write-reliability bits from EXTCSD registers

available also https://github.com/BenGardiner/mmc-utils/tree/features/reliable-write
if it helps.

Ben Gardiner (3):
  extract PARTITION_SETTING_COMPLETE function
  pretty print write reliability settings
  support setting the OTP write reliability settings

 mmc.c      |   5 +++
 mmc.h      |   1 +
 mmc_cmds.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 mmc_cmds.h |   1 +
 4 files changed, 129 insertions(+), 21 deletions(-)

-- 
1.8.1.2

