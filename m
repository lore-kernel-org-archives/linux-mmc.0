From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-of-esdhc: add workaround for T4240
 incorrect HOSTVER value
Date: Wed, 26 Aug 2015 09:16:22 -0500
Message-ID: <1440598582.16577.109.camel@freescale.com>
References: <1437471937-34218-1-git-send-email-yangbo.lu@freescale.com>
	 <CAPDyKFpf6Ayw28dmbHhLJ8HSOSie60sUjaAnK7qqONHsRN4BDA@mail.gmail.com>
	 <1437791242.2993.268.camel@freescale.com>
	 <CAPDyKFp8ZStYVaFm8tjPL190dqV6vCE+oT706M=6wVCckWesLw@mail.gmail.com>
	 <1438012638.2993.289.camel@freescale.com>
	 <BY1PR0301MB119219D4C4E53A73216BCF53F2600@BY1PR0301MB1192.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0138.outbound.protection.outlook.com ([157.56.111.138]:51552
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756188AbbHZOQb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 26 Aug 2015 10:16:31 -0400
In-Reply-To: <BY1PR0301MB119219D4C4E53A73216BCF53F2600@BY1PR0301MB1192.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lu Yangbo-B47093 <yangbo.lu@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Wed, 2015-08-26 at 02:49 -0500, Lu Yangbo-B47093 wrote:
> > > > > > For T4240-R1.0-R2.0, the HOSTVER register has incorrcet vender
> > > > > > version value and sdhc spec version value. This will break down
> > > > > > the ADMA data transfer. So add workaround to get right value
> > > > > > VVN=0x13, SVN = 0x1.
> > > > > 
> > > > > So T4240-R1.0-R2.0 is the version of the controller, right?
> > > > > 
> > > > > If I understand correct you are checking what CPU/SoC you are
> > > > > running on, to figure out which controller version you are using,
> > > > > as that can't be fetched (trusted) from the registers of the esdhc
> > > > > controller itself!?
> > > > > 
> > > > > Instead, you could deal with this directly in the DTS files. I
> > > > > assume you have some DTS file for each SoC/board variant, right?
> > > > 
> > > > No, we do not have a separate DTS file for each revision of an SoC
> > > > -- and if we did, we'd constantly have people using the wrong one.
> > > > 
> > > > > In principle, in your DTS file specific for the board/SoC that
> > > > > holds the T4240-R1.0-R2.0 version of the controller, should add a
> > > > > specific esdhc DT property to indicate this errata.
> > > > 
> > > > No, because (in addition to the above issue about chip revisions)
> > > > the device tree is stable ABI and errata are often discovered after
> > > > device trees are deployed.
> > > 
> > > Fair enough. Then what is your suggestion for the solution here?
> > 
> > As I said in my comment on patch 2/3, read SVR from the device-
> > config/guts MMIO block, which works on both PPC and ARM.
> > 
> > -Scott
> 
> Thanks, Scott.
> I checked the device nodes of device-config/guts, finding all the platforms 
> has not a uniform compatible name.
> Could I add a compatible name called "fsl, dcfg"("fsl, guts" if using guts) 
> for PowerPC P series, T series, B series boards, so that I could get this 
> device node by compatible without knowing platform? 

No.  It's too vague.  Linux should keep a list of all the nodes it can match 
against for this.  Centralize it in one place rather than having each driver 
that cares about SVR do it.

-Scott

