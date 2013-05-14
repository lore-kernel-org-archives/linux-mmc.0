From: Gerhard Sittig <gsi@denx.de>
Subject: [PATCH v1 0/1] mmc: mxcmmc: completion of MPC512x support
Date: Tue, 14 May 2013 17:00:08 +0200
Message-ID: <1368543609-11372-1-git-send-email-gsi@denx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:56400 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377Ab3ENPAk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 May 2013 11:00:40 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Anatolij Gustschin <agust@denx.de>, Gerhard Sittig <gsi@denx.de>

the mxcmmc(4) driver is shared across the i.MX and the MPC512x platforms

the driver's initialization did setup the i.MX related clocks but did
not setup the MPC512x related clock, this change fixes the omission and
thus makes SDHC/MMC fully operational on both platforms


Gerhard Sittig (1):
  mmc: mxcmmc: setup mpc512x related clocks

 drivers/mmc/host/mxcmmc.c |   41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

-- 
1.7.10.4

