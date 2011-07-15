From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/2] use both-edge GPIO interrupt for SDHI0 on mackerel
Date: Fri, 15 Jul 2011 12:58:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1107151254300.22613@axis700.grange>
References: <Pine.LNX.4.64.1107140123070.30737@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:54406 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964787Ab1GOK6p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jul 2011 06:58:45 -0400
In-Reply-To: <Pine.LNX.4.64.1107140123070.30737@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>

As correctly pointed out by Magnus, IRQ-capable GPIOs on sh7372 can 
produce interrupts on both edges. These patches extend the intc driver and 
use this for SDHI0 hotplug detection on mackerel.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
