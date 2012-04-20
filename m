From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/5] mmc: sh_mmcif: add regulator support
Date: Fri, 20 Apr 2012 18:59:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1204201835230.3974@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi all

The first 3 patches in this series are preparatory, patches 2 and 3 can be 
pushed with later kernel versions to simplify dependencies. Patch 4 
actually adds regulator support. Patch 5 is not (necessarily) for 
inclusion. It's just an implementation example for ecovec. Since ecovec's 
CN12 slot is a combined SD/MMC slot, driven by the SDHI controller in SD 
mode, it might make sense to wait until regulators are supported by SDHI 
too, after which a single regulator device in ecovec platform data can be 
used for both.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
