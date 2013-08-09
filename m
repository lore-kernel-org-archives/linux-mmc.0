From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: my outstanding patches for 3.12
Date: Fri, 9 Aug 2013 15:30:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1308091507450.937@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:49289 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966148Ab3HINaw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Aug 2013 09:30:52 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi Chris

There are still a number of MMC patches from me for 3.12, that still 
aren't in next. Unless I'm missing anything, here's the list of patches 
with their respective patchwork IDs:

mmc: SDHI: add DT compatibility strings for further SoCs
pw ID: 2828382

mmc: sh_mmcif: move header include from header into .c
pw ID: 2837887

mmc: sh_mmcif: add support for Device Tree DMA bindings
pw ID: 2770781

mmc: sh_mmcif: revision-specific Command Completion Signal handling
pw ID: 2825876

mmc: sh_mmcif: revision-specific CLK_CTRL2 handling
pw ID: 2825870

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
