From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/6 v2] mmc: split the tmio driver into several modules
Date: Wed, 23 Mar 2011 14:42:29 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103231156220.6836@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

Hi all

This is version 2 of the patch series, posted on 11th of March. The only 
change in this version is the dynamic allocation of the DMA bounce buffer, 
as suggested by Magnus. Desription from the original post:

The tmio_mmc SD/SDIO driver is serving very different hardware 
configurations: on the one hand multi-function style chips from Toshiba, 
Compaq, on the other hand SDHI units in ARM- and SuperH-based sh-mobile 
SoCs. Apart from the different native APIs: MFD for the former and 
platform-device in the latter, sh-mobile implementations also have a 
number of features, exclusive to them, which, if implemented in the common 
driver, clutter it needlessly and make its maintenance more difficult. 
This patch series simplifies the situation by splitting the driver up into 
3 modules: the core, consisting of the main part and, on sh-mobile, of the 
DMA part; the mfd glue; and the platform glue. This way also (imaginary) 
sh-mobile systems with additional tmio mfd chips on them can be supported.

This patch-series touches code under

arch/arm/mach-shmobile
arch/sh/boards
drivers/mfd
drivers/mmc/host

Perhaps, it would be best to collect necessary acks from Paul and push 
them all via mmc?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
