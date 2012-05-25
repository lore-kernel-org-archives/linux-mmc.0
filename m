From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/2:5/6 v3] mmc: add primitive OF support to sh-mmcif and sdhi
Date: Fri, 25 May 2012 17:45:46 +0200
Message-ID: <1337960752-4944-32-git-send-email-g.liakhovetski@gmx.de>
References: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Olof Johansson <olof@lixom.net>
List-Id: linux-mmc@vger.kernel.org

I removed most OF support code from the previous version. In this version 
I'm only adding the bare minimum with no support for any mmc- or 
driver-specific properties. They can be added slowly as need arises.

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
