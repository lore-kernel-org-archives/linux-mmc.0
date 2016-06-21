From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/5] mmc: sh_mmcif: Various minor improvements
Date: Tue, 21 Jun 2016 15:12:45 +0200
Message-ID: <1466514770-9462-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35837 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbcFUNVN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2016 09:21:13 -0400
Received: by mail-lf0-f51.google.com with SMTP id l188so23351859lfe.2
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2016 06:21:12 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Baolin Wang <baolin.wang@linaro.org>

When looking for mmc drivers that has special treatmeant of the ERASE command,
the sh_mmcif driver is one of them, I took the opportunity to improve some of
that related code.

This is not tested on HW, so I would appreciate if someone that still cares
about this driver can do a quick test of these changes.

Ulf Hansson (5):
  mmc: core: Allow hosts to specify non-support for SD commands
  mmc: sh_mmcif: Enable MMC_CAP2_NO_SD and MMC_CAP2_NO_SDIO
  mmc: sh_mmcif: Use response type to know when to enable busy detection
  mmc: sh_mmcif: Inform the mmc core about the max busy timeout
  mmc: sh_mmcif: Use a 10s timeout in the error recovery path

 drivers/mmc/core/core.c     |  9 +++++---
 drivers/mmc/host/sh_mmcif.c | 53 ++++++++++-----------------------------------
 include/linux/mmc/host.h    |  1 +
 3 files changed, 18 insertions(+), 45 deletions(-)

-- 
1.9.1

