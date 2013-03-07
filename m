From: Matt Porter <mporter@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: add AM33XX MMC support
Date: Thu, 7 Mar 2013 09:51:12 -0500
Message-ID: <20130307145112.GS6209@beef>
References: <1362629799-22485-1-git-send-email-mporter@ti.com>
 <1362629799-22485-3-git-send-email-mporter@ti.com>
 <41fde401c8e646689123d7c6d3a2dffc@DLEE71.ent.ti.com>
 <20130307141235.GQ6209@beef>
 <79CD15C6BA57404B839C016229A409A83EC20C57@DBDE01.ent.ti.com>
 <20130307144656.GR6209@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:42250 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674Ab3CGOuj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Mar 2013 09:50:39 -0500
Content-Disposition: inline
In-Reply-To: <20130307144656.GR6209@beef>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Thu, Mar 07, 2013 at 09:46:56AM -0500, Matt Porter wrote:
> On Thu, Mar 07, 2013 at 02:39:55PM +0000, Vaibhav Hiremath wrote:
> > 2. And MMC rootFS mount is __not__ working for me.
> > 
> > 3. I get following error message - 
> > 
> > [    2.118207] omap_hsmmc mmc.3: unable to obtain RX DMA engine channel 25
> 
> See below, you don't have CONFIG_EDMA on most likely.

That's CONFIG_TI_EDMA, of course.

-Matt
