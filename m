From: Alexander Tarasikov <alexander.tarasikov@gmail.com>
Subject: Fixes for the MSM SDCC driver on msm7200a
Date: Sun, 21 Aug 2011 15:52:42 +0400
Message-ID: <1313927564-10355-1-git-send-email-alexander.tarasikov@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56197 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305Ab1HULxO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Aug 2011 07:53:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davidb@codeaurora.org, dwalker@fifo99.com, bryanh@codeaurora.org, cjb@laptop.org
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org

These two patches fix issues that prevent the MSM SDCC driver from
being used on msm7200a boards. First one fixes a NULL pointer when
the board does not supply gpio config. Second one adds the init_card
operation instead of the declared but unimplemented embedded_sdio_data
feature.

