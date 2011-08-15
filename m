From: Simon Horman <horms@verge.net.au>
Subject: [RFC 0/4] mmc: tmio, sdhi: provide multiple irq handlers
Date: Mon, 15 Aug 2011 14:51:24 +0900
Message-ID: <1313387488-28175-1-git-send-email-horms@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:43002 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab1HOFvi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2011 01:51:38 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

The SDHI driver already supports making use of up to three interrupt
sources.

This series breaks up the existing interrupt handler into three handlers,
one for card access, one for card detect interrupts, and one for SDIO
interrupts.  A cover-all handler, which makes use of these new broken-out
handlers is provided for for the case where there is only one interrupt
source.

This series also wires up the broken-out irq handlers in the SDHI driver

* Card portion tested on AP4/Mackerel
* SDIO portion yet to be tested. I intend to schedule access to hardware
  to test this if the review of these patches is positive.

