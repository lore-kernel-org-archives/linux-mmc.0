From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/2] tmio: Support board-specified voltages
Date: Wed, 19 May 2010 20:37:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005191825160.3099@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:45844 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753006Ab0ESSg6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 May 2010 14:36:58 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Andrew Morton <akpm@linux-foundation.org>

Just re-sending with Ian's ack added. This used to be a series of 3 
patches, patch 3 is ARM specific and will be merged via the architecture 
tree.

Applies on top of

"[PATCH 0/10] add DMA support to tmio_mmc, using dmaengine API, use it on SH"
and
"[PATCH 0/3] tmio: let platforms decide upon write-protection availability"

patch series.

Andrew, please, apply.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
