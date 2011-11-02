From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 0/2] mmc: core: Support packed command feature of eMMC4.5
Date: Wed,  2 Nov 2011 16:58:55 +0900
Message-ID: <1320220735-10330-1-git-send-email-tgih.jun@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:52243 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab1KBISm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Nov 2011 04:18:42 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com, Seungwon Jeon <tgih.jun@samsung.com>

This patch-set adds support of packed command feature
for eMMC4.5 devices.

Seungwon Jeon (2):
	mmc: core: Add packed command feature of eMMC4.5
	mmc: core: Support packed command for eMMC4.5 device

 drivers/mmc/card/block.c |  355 ++++++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/card/queue.c |   48 ++++++-
 drivers/mmc/card/queue.h |   12 ++
 drivers/mmc/core/mmc.c   |   22 ++++++++++++++++++++++
 include/linux/mmc/core.h |    3 +
 include/linux/mmc/card.h |    3 +++
 include/linux/mmc/host.h |    1 +
 include/linux/mmc/mmc.h  |   15 +++++++++++++++
 8 files changed, 445 insertions(+), 14 deletions(-)
--
1.7.2.3

