From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/2] mmc: tmio: minor SDIO updates
Date: Sun, 13 Nov 2016 15:29:10 +0100
Message-ID: <20161113142912.4041-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46118 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752603AbcKMO3Y (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 13 Nov 2016 09:29:24 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Here are two small fixes I found while evaluating SDIO with UHS.

Wolfram Sang (2):
  mmc: tmio: fix wrong bitmask for SDIO irqs
  mmc: tmio: remove SDIO from TODO list

 drivers/mmc/host/tmio_mmc_pio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.9.3

