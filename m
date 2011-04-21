From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/2] MMC TMIO: power management, locking
Date: Thu, 21 Apr 2011 09:20:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1104210911040.6893@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

This patch-series adds locking to the TMIO MMC driver to protect against 
theoretical races between IO-requests and configuration and implements 
power-management, based on recent experimental patches from Magnus for the 
AP4 (sh7372) SoC.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
