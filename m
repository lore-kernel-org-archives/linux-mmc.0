From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/3:6/6 v3] sh, ARM: mach-shmobile: update MMC platform data
Date: Fri, 25 May 2012 17:17:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205251704490.13353@axis700.grange>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:61574 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846Ab2EYPR3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 May 2012 11:17:29 -0400
In-Reply-To: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

The patches in this series update ecovec and mackerel to use voltage 
regulators and GPIO slot functions, available for SDHI and MMCIF blocks.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
