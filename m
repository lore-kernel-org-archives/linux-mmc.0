From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC] MMC: Proposals on reworking clock and power management
Date: Wed, 27 Oct 2010 15:57:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010271551500.29484@xanadu.home>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0356A579AF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_g1A92fycO2PlA94sCdDjQA)"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:32009 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840Ab0J0T5R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Oct 2010 15:57:17 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LAY00FAASR6AQM0@vl-mh-mrz21.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Wed, 27 Oct 2010 15:57:07 -0400 (EDT)
In-reply-to: <2A3DCF3DA181AD40BDE86A3150B27B6B0356A579AF@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: Chris Ball <cjb@laptop.org>, Linus Walleij <linus.ml.walleij@gmail.com>, Adrian Hunter <adrian.hunter@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "S, Venkatraman" <svenkatr@ti.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_g1A92fycO2PlA94sCdDjQA)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Wed, 27 Oct 2010, Ghorai, Sukumar wrote:

> Hi Chris, Linus, Nicolas, Adrian and all,
> 
> It has been identified after several discussions [1], [2], that
> MMC/SD/SDIO driver need to re-work on clock and power management.
> I am trying to list all the design considerations which are part
> of this study/discussion are following:
>  
> 1. Remove clock handling APIs currently implemented through claim_host/
>    release_host
> 
> 2. Ideally host-driver driver should not tell the core to shut down
>    the upper layers, instead the core should decide when to
>    "disabled clock or cut the power". 
> 
>    Going in details of different state handlings - Clock disable,
>    Card sleep, card power cutoff;
>    
>    2.a) clock disable: 
>      Option-1: can be handled in the host itself using a timer based
>                on some idle period, OR

only for the clock going into the controller, not the clock going to the 
card.

>                existing enable/ disable provided in the host, OR
>      Option-3: with the *existing* API calls, namely the set_ios()
>                method as proposed by Linus Walleij  [4]

That's for the clock going to the card.  So both options 1 and 3 may 
coexist as they address different clocks.

>    2.a) Card sleep, Power cutoff to the card:
>      This should be handled in the core where based on block layer
>      activity, calling corresponding API's from bus layer:
>      mmc_power_save_host/ mmc_power_restore_host 

Same issue here.  Card power is for the core to decide, but the 
controller driver may perform opportunistic power down of the controller 
itself when it is possible and the core does not need to know about it.

> 3. MMC_CAP_DISABLE - should not be a host capability.  This should be
>    a core feature that should be _transparent_  to all hosts with no
>    changes to any of the host drivers.  

Right.



Nicolas

--Boundary_(ID_g1A92fycO2PlA94sCdDjQA)--
