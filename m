From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: sdhci-pci: probe of 0000:11:00.0 failed with error -22
Date: Tue, 2 Feb 2016 11:18:35 +0200
Message-ID: <56B0746B.9050902@intel.com>
References: <S932267AbcBANb3/20160201133129Z+1138@vger.kernel.org>
 <20160201141944.GT13086@bla.fasel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45884 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754243AbcBBJXL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 2 Feb 2016 04:23:11 -0500
In-Reply-To: <20160201141944.GT13086@bla.fasel.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: peter.guo@bayhubtech.com, adam.lee@canonical.com
Cc: Wolfram Schlich <lists@wolfram.schlich.org>, linux-mmc@vger.kernel.org

+ Peter Guo and Adam Lee


On 01/02/16 16:19, Wolfram Schlich wrote:
> [ Issue originally reported as https://bugzilla.kernel.org/show_bug.cgi?id=110411 ]
> 
> Hi!
> 
> I am working on a Dell Precision M4800 laptop with Gentoo Linux and Kernel 4.3.3:
> 
> --8<--
> Linux zephyr 4.3.3-gentoo #2 SMP Wed Jan 6 00:33:28 CET 2016 x86_64 Intel(R) Core(TM) i7-4910MQ CPU @ 2.90GHz GenuineIntel GNU/Linux
> --8<--
> 
> It has an O2 Micro SD/MMC card reader (1217:8520) which is supposed to be supported by sdhci-pci-o2micro:
> 
> --8<--
> 11:00.0 SD Host controller: O2 Micro, Inc. SD/MMC Card Reader Controller (rev 01)
> 11:00.0 0805: 1217:8520 (rev 01)
> --8<--
> 
> On bootup, the sdhci-pci driver fails to initialize the card reader with error -22:
> --8<--
> [    4.782054] sdhci: Secure Digital Host Controller Interface driver
> [    4.782057] sdhci: Copyright(c) Pierre Ossman
> [    4.782187] sdhci-pci 0000:11:00.0: SDHCI controller found [1217:8520] (rev 1)
> [    4.782328] sdhci-pci: probe of 0000:11:00.0 failed with error -22
> [    4.782376] sdhci-pltfm: SDHCI platform and OF driver helper
> --8<--
> 
> What's wrong?
> 
> BIOS version is A15 from 09/29/2015.
> 
> UPDATE: The issue remains unchanged with kernel 4.3.5-gentoo.
> 
> Cheers,
> Wolfram
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

