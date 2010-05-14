From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/3] tmio: Support board-specified voltages
Date: Fri, 14 May 2010 12:34:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005141228510.6147@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This patch series allows users to specify, which card voltages their 
system supports, when using the tmio_mmc driver. Also applied to the 
ap4evb sh7372 board. Applies on top of all my previoud patches for tmio / 
sdhi.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
