From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH v2 1/3] mmc: omap_hsmmc: Enable SDIO IRQ using a
 GPIO in idle mode.
Date: Sat, 1 Jun 2013 07:44:02 -0700
Message-ID: <20130601144402.GA3331@atomide.com>
References: <1368607516-2789-1-git-send-email-andreas.fenkart@streamunlimited.com>
 <1368607516-2789-2-git-send-email-andreas.fenkart@streamunlimited.com>
 <20130520205815.GJ10378@atomide.com>
 <20130531075858.GA16701@kuttelsuppe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:24587 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754506Ab3FAOoK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 1 Jun 2013 10:44:10 -0400
Content-Disposition: inline
In-Reply-To: <20130531075858.GA16701@kuttelsuppe>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <andreas.fenkart@streamunlimited.com>, afenkart@gmail.com
Cc: cjb@laptop.org, arnd@arndb.de, svenkatr@ti.com, balajitk@ti.com, grant.likely@secretlab.ca, linux-mmc@vger.kernel.org, rob@landley.net, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, zonque@gmail.com

* Andreas Fenkart <andreas.fenkart@streamunlimited.com> [130531 01:05]:
> Hi,
> 
> this email adress will soon expire,
> my alternate email adress is

OK, noticed that the SDIO wake behaves in a different way between
wl12xx and mwifiex, and there's an issue with the muxing still for
legacy non-SDIO booting. So at least one more update coming from me
for this patch.

Regards,

Tony
