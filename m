From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH/RFC 0/2 v2] mmc: tmio: power management and clock gating
Date: Fri, 11 Mar 2011 09:24:02 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103110915290.23675@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50828 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab1CKIYG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Mar 2011 03:24:06 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

I think, the tmio driver currently misinterprets MMC power modes, which is 
fixed by the first patch in this series. The second one implements 
aggressive clock gating. Both are marked "RFC," because I cannot test them 
on MFD-based hardware.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
