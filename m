From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/10] add DMA support to tmio_mmc, using dmaengine API, use
 it on SH
Date: Wed, 19 May 2010 20:33:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005191750400.3099@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:59736 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753975Ab0ESSdt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 May 2010 14:33:49 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, dan.j.williams@intel.com, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, sameo@linux.intel.com, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

Mostly a resend, all patches have already been submitted to lists and 
maintainers, the only change in actual code is the preserved "host->data = 
NULL" line upon Ian's request, which pushed patch #6 version to v6. Apart 
from that acks have been added and numbering streamlined. All patches 
marked with their respective versions.

Andrew, please, apply.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
