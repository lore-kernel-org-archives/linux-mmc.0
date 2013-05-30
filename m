From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 0/8] cross-compiling, SEND_STATUS, pretty-printing and enhanced user area
Date: Thu, 30 May 2013 17:12:43 -0400
Message-ID: <cover.1369947867.git.bengardiner@nanometrics.ca>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33908 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821Ab3E3VNH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 May 2013 17:13:07 -0400
Received: by mail-ie0-f171.google.com with SMTP id s9so1918179iec.30
        for <linux-mmc@vger.kernel.org>; Thu, 30 May 2013 14:13:07 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org

This series builds on top of f74dfe23cd00894aa9f235374468e05acb793e17.

It introduces:
 * some Makefile changes to make cross-compiling easier
 * SEND_STATUS
 * 'pretty'-printing sizes of some fields in KiB
 * setting the OTP enhanced user area parameters

available also https://github.com/BenGardiner/mmc-utils/commits/features/enh-programming
if it helps.

Ben Gardiner (8):
  allow environment and command-line supplied make vars
  extract definitions for EXT_CSD register EXT_CSD_PARTITIONING_SUPPORT
  extract definitions for EXT_CSD register PARTITION_SETTING_COMPLETED
    and pretty-print
  Support SEND_STATUS command
  fix printing ENH_START_ADDR
  report if card is block-addressed and effect on ENH_START_ADDR
  print KiB sizes for some fields
  support setting the OTP enhanced user area parameters

 Makefile   |   10 +-
 mmc.c      |   10 ++
 mmc.h      |   20 ++++
 mmc_cmds.c |  307 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 mmc_cmds.h |    2 +
 5 files changed, 328 insertions(+), 21 deletions(-)

--
1.7.3.5

