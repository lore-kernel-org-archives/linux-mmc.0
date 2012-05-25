From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/0/6 v3] mmc core, tmio / sdhi and sh-mmcif updates
Date: Fri, 25 May 2012 17:45:15 +0200
Message-ID: <1337960752-4944-1-git-send-email-g.liakhovetski@gmx.de>
References: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

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
--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
