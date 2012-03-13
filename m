From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v1 1/5] ARM: imx28: add basic dt support
Date: Tue, 13 Mar 2012 11:28:07 -0600
Message-ID: <20120313172807.AC4763E053B@localhost>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com> <1331628428-24017-2-git-send-email-b29396@freescale.com> <4F5F5B3F.2000303@gmail.com> <4F5F60DB.9090801@itwatchdogs.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62013 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758599Ab2CMR2L (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Mar 2012 13:28:11 -0400
Received: by iagz16 with SMTP id z16so1041158iag.19
        for <linux-mmc@vger.kernel.org>; Tue, 13 Mar 2012 10:28:10 -0700 (PDT)
In-Reply-To: <4F5F60DB.9090801@itwatchdogs.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zach Sadecki <zsadecki@itwatchdogs.com>, Rob Herring <robherring2@gmail.com>
Cc: Dong Aisheng <b29396@freescale.com>, vinod.koul@linux.intel.com, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, rdunlap@xenotime.net, shawn.guo@freescale.com, kernel@pengutronix.de, cjb@laptop.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org

On Tue, 13 Mar 2012 09:59:39 -0500, Zach Sadecki <zsadecki@itwatchdogs.com> wrote:
> On 03/13/2012 09:35 AM, Rob Herring wrote:
> > +	ahb@80080000 {
> > +		fec@800f0000 {
> > Use generic names: ethernet@800f0000
> Generic is good, but consistency is better, IMHO.  grepping existing dts 
> files in 3.2.9 finds 6 instances of "fec@" and 0 instances of "ethernet@"
> >> +			uart1: uart@80074000 {
> > Use generic names: uart1: serial@...
> Same comment here, but unfortunately there is already inconsistency in 
> existing files...  25 instances of "serial@" and 35 instances of "uart@"

No, Rob is correct.  The generic names recommended practice is well
established and documented.  Expand your grep search to include
arch/powerpc/bot/dts/*.

See section 2.2.2 of ePAPR[1]

[1]https://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.1.pdf

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.
