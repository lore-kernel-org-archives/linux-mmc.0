From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v2 0/2] mmc: core: Fix cache control for eMMC4.5
Date: Fri, 09 Dec 2011 17:46:43 +0900
Message-ID: <000001ccb64f$13e3a760$3baaf620$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:50131 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab1LIIqp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Dec 2011 03:46:45 -0500
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org

This patch-set fixed the cache control for eMMC4.5

Changes in v2:
    - clear the cache_ctrl flag for a failure(enabling cache)

Seungwon Jeon (2):
      mmc: core: Separate the timeout value for cache-ctrl
      mmc: core: Add claiming a host during mmc_cache_ctrl

 drivers/mmc/core/core.c |   29 +++++++++++++++++++----------
 drivers/mmc/core/mmc.c  |   13 +++++++++++--
 2 files changed, 30 insertions(+), 12 deletions(-)

Best regards,
Seungwon Jeon.
--
1.7.2.3


