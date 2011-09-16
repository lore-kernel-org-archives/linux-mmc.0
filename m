From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH V2 RESEND] Power Class Selection Feature
Date: Fri, 16 Sep 2011 19:14:04 +0530
Message-ID: <1316180645-31060-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51062 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444Ab1IPNoH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Sep 2011 09:44:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>

This patch version removes some checkpatch error.
Earlier versions were checked with the older checkpatch.pl
which didnt give any checkpatch errors. This patch uses
the checkpatch.pl in the latest script folder.

Girish K S (1):
  mmc: core: eMMC 4.5 Power Class Selection Feature

 drivers/mmc/core/mmc.c  |   90 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/mmc.h |   13 +++++++
 2 files changed, 103 insertions(+), 0 deletions(-)

