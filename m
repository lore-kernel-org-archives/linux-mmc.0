From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/2:5/6 v3] mmc: add primitive OF support to sh-mmcif and
 sdhi
Date: Fri, 25 May 2012 17:16:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205251422040.13353@axis700.grange>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56703 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246Ab2EYPQe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 May 2012 11:16:34 -0400
In-Reply-To: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Olof Johansson <olof@lixom.net>

I removed most OF support code from the previous version. In this version 
I'm only adding the bare minimum with no support for any mmc- or 
driver-specific properties. They can be added slowly as need arises.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
