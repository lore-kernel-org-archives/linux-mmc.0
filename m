From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/2] mmc: add generic hotplug handler and a GPIO implementation
Date: Sat, 24 Dec 2011 00:00:11 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1112232346180.1911@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:62781 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757965Ab1LWXAW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Dec 2011 18:00:22 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

The following two patches add an ability to implement pluggable card 
hotplug handlers and a simple implementation for GPIO hotplug IRQs.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
