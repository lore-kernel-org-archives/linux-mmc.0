From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 0/3] mmc: sh_mmcif: Clock Tweaks
Date: Wed, 28 Mar 2012 18:01:08 +0900
Message-ID: <1332925271-23860-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:50921 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757369Ab2C1JBU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Mar 2012 05:01:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Cao Minh Hiep <hiepcm@gmail.com>, Simon Horman <horms@verge.net.au>

Hi,

this series of three small patches cleans up the handling
of clocks in the MMCIF driver a little.

Simon Horman (3):
      mmc: sh_mmcif: double clock speed
      mmc: sh_mmcif: mmc->f_max should be half of the bus clock
      mmc: sh_mmcif: Simplify calculation of mmc->f_min

 drivers/mmc/host/sh_mmcif.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)
