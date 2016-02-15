From: Wolfram Schlich <lists@wolfram.schlich.org>
Subject: Re: sdhci-pci: probe of 0000:11:00.0 failed with error -22
Date: Mon, 15 Feb 2016 08:38:25 +0100
Message-ID: <20160215073825.GK17591@bla.fasel.org>
References: <S932267AbcBANb3/20160201133129Z+1138@vger.kernel.org>
 <20160201141944.GT13086@bla.fasel.org>
 <56B0746B.9050902@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.laber.fasel.org ([212.7.178.68]:53688 "EHLO
	mail.laber.fasel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbcBOHi3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Feb 2016 02:38:29 -0500
Content-Disposition: inline
In-Reply-To: <56B0746B.9050902@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org

* Adrian Hunter <adrian.hunter@intel.com> [2016-02-02 10:23]:
> + Peter Guo and Adam Lee

Adrian,

any news here?
Adam Lee has left Canonical and Peter Guo doesn't respond.
Is there something I can do to help?

Cheers,
Wolfram

> On 01/02/16 16:19, Wolfram Schlich wrote:
> > [ Issue originally reported as https://bugzilla.kernel.org/show_bug.cgi?id=110411 ]
> > 
> > Hi!
> > 
> > I am working on a Dell Precision M4800 laptop with Gentoo Linux and Kernel 4.3.3:
> > 
> > --8<--
> > Linux zephyr 4.3.3-gentoo #2 SMP Wed Jan 6 00:33:28 CET 2016 x86_64 Intel(R) Core(TM) i7-4910MQ CPU @ 2.90GHz GenuineIntel GNU/Linux
> > --8<--
> > 
> > It has an O2 Micro SD/MMC card reader (1217:8520) which is supposed to be supported by sdhci-pci-o2micro:
> > 
> > --8<--
> > 11:00.0 SD Host controller: O2 Micro, Inc. SD/MMC Card Reader Controller (rev 01)
> > 11:00.0 0805: 1217:8520 (rev 01)
> > --8<--
> > 
> > On bootup, the sdhci-pci driver fails to initialize the card reader with error -22:
> > --8<--
> > [    4.782054] sdhci: Secure Digital Host Controller Interface driver
> > [    4.782057] sdhci: Copyright(c) Pierre Ossman
> > [    4.782187] sdhci-pci 0000:11:00.0: SDHCI controller found [1217:8520] (rev 1)
> > [    4.782328] sdhci-pci: probe of 0000:11:00.0 failed with error -22
> > [    4.782376] sdhci-pltfm: SDHCI platform and OF driver helper
> > --8<--
> > 
> > What's wrong?
> > 
> > BIOS version is A15 from 09/29/2015.
> > 
> > UPDATE: The issue remains unchanged with kernel 4.3.5-gentoo.
> > 
> > Cheers,
> > Wolfram
