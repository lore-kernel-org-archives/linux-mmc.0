From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/0/6 v3] mmc core, tmio / sdhi and sh-mmcif updates
Date: Fri, 25 May 2012 17:14:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:64636 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284Ab2EYPOP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 May 2012 11:14:15 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

Hi all

as follow ups to this email I'll send 6 patch series, which are updates to 
the following 2 patch series:

http://thread.gmane.org/gmane.linux.ports.sh.devel/14448
http://thread.gmane.org/gmane.linux.ports.sh.devel/14673

I have further split the latter of the above to make reviewing easier. 
These series address different topics, but since they touch the same 
files, it would be easier to also commit them in the same order. Some 
patches also touch files under arch/arm and arch/sh, they will require 
respective acks. The patches have been developed, based on "next" of 21 
May.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
