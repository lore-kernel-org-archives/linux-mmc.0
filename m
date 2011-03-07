From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/5] tmio PM: aggressive clock gating, register layout
 limitation
Date: Mon, 7 Mar 2011 19:47:45 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103071937010.29543@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

Hi

5 more patches, that fix high register access on sh-mobile in a correct 
way and implement aggressive clock gating. Marked as RFC because testing 
on non-SDHI platforms is required! The next step would be to add 
runtime-pm to clock gating, but I'm refraining from this for now, because 
similar patches for SDHCI have still not been committed and it seems, 
there are still doubts about the right way to do that.

Patches apply on top of my previous 2 patches from earlier today.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
