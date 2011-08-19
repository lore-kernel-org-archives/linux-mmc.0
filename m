From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 0/4 v6] mmc: tmio, sdhi: provide multiple irq handlers
Date: Fri, 19 Aug 2011 10:10:17 +0900
Message-ID: <1313716221-20136-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55968 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004Ab1HSBKe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Aug 2011 21:10:34 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

The SDHI driver already supports making use of up to three interrupt
sources.

This series breaks up the existing interrupt handler into three handlers,
one for card access, one for card detect interrupts, and one for SDIO
interrupts.  A cover-all handler, which makes use of these new broken-out
handlers is provided for for the case where there is only one interrupt
source.

This series also wires up the broken-out irq handlers in the SDHI driver


