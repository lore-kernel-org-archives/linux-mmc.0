From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Disable the non working eMMC on Zoom2/3
Date: Wed, 7 Apr 2010 04:49:39 -0700
Message-ID: <20100407114938.GF7153@atomide.com>
References: <37310.192.168.10.89.1270081542.squirrel@dbdmail.itg.ti.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030D32CEE8@dbde02.ent.ti.com>
 <008601cad1bd$6d0022b0$544ff780@am.dhcp.ti.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030D32D372@dbde02.ent.ti.com>
 <4BB51740.2060802@ti.com>
 <009a01cad1ee$e3bbae70$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58006 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757183Ab0DGLth (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Apr 2010 07:49:37 -0400
Content-Disposition: inline
In-Reply-To: <009a01cad1ee$e3bbae70$544ff780@am.dhcp.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: 'Nishanth Menon' <nm@ti.com>, "'Ghorai, Sukumar'" <s-ghorai@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

* Madhusudhan <madhu.cr@ti.com> [100401 15:54]:

<snip>

> > Ref [1] I believe tony has the brand new zoom board - I think your
> > assumption here might be flawed..
> > 
> 
> Wait, I just looked up the serial number on the board. The one I was using
> is a pilot version where this problem exists.
> 
> I happen to get an other board which is production unit with ser # 1013089
> Rev B. The eMMC on this board has no issue. It reports the EXT_CSD Rev 2
> which is correct and works fine.
> 
> http://omappedia.org/wiki/Zoom_Resources
> 
> There is a table here which could help.
> 
> Tony, do you care to just look up the serial number of your board?

Sorry for the delay in replying, I've been travelling for a few weeks
and been in meetings quite a bit. Anyways, it's a 1013037 REV A board,
which seems to be production in the table above.
 
> But again there are several boards out there which could have this
> non-working eMMC. So what do we do?? It does not make sense to keep
> something enabled which does not work.

There's arm kernel parameter for ATAG_REVISION that can be passed from
bootloader and then the board-*.c code can initialize things accordingly
based on the board revision.

Regards,

Tony


> > [1] http://marc.info/?l=linux-omap&m=126938456103707&w=2
> 
