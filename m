From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Disable the non working eMMC on Zoom2/3
Date: Tue, 27 Apr 2010 11:21:11 -0700
Message-ID: <20100427182111.GE7225@atomide.com>
References: <37310.192.168.10.89.1270081542.squirrel@dbdmail.itg.ti.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030D32CEE8@dbde02.ent.ti.com>
 <008601cad1bd$6d0022b0$544ff780@am.dhcp.ti.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030D32D372@dbde02.ent.ti.com>
 <4BB51740.2060802@ti.com>
 <009a01cad1ee$e3bbae70$544ff780@am.dhcp.ti.com>
 <20100407114938.GF7153@atomide.com>
 <003801cad73e$86841df0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <003801cad73e$86841df0$544ff780@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: 'Nishanth Menon' <nm@ti.com>, "'Ghorai, Sukumar'" <s-ghorai@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Madhusudhan <madhu.cr@ti.com> [100408 10:07]:
> > >
> > > Tony, do you care to just look up the serial number of your board?
> > 
> > Sorry for the delay in replying, I've been travelling for a few weeks
> > and been in meetings quite a bit. Anyways, it's a 1013037 REV A board,
> > which seems to be production in the table above.
> > 
> 
> That means we can not assume all production units have a working eMMC.
> Would you mind sharing your bootup log? When this device is detected 
> something like below is a clear issue.
> 
> mmcblk1: mmc1:0001 STM16G 1.00 GiB 
> mmcblk1: p1 p2

Hmm, finally got around looking into this again. Looks like the mmc
is now working on my zoom3 with the current Linus' tree at commit 
7c6bd2010fced38444c9fd658f4c6ce61bd185bf. So I guess something that
we had in omap-fixes fixed this. Or maybe some fix for drivers/mmc?

This is with the debug_ll patch applied:

https://patchwork.kernel.org/patch/87532/

Regards,

Tony
