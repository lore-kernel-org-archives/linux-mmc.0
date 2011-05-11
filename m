From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/3] cold card detection on TMIO / SDHI
Date: Wed, 11 May 2011 18:51:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105111843290.5557@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <damm@opensource.se>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

This patch series implemnts card detection, when the TMIO SD/SDIO 
controller is powered down. Yes, I know, I have to rebase all my TMIO 
patches, will do and repost this one too, so, this is just FYI / for 
review.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
