From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/3] fix TMIO DMA regression
Date: Fri, 27 May 2011 12:44:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105271235230.25265@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

A recent commit a197b59a

Author: David Rientjes <rientjes@google.com>

    mm: fail GFP_DMA allocations when ZONE_DMA is not configured

has broken TMIO DMA on SH and ARM. This patch series fixes the regression.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
