From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] mmc: add device class attribute for ext_csd
Date: Mon, 26 Jul 2010 20:30:14 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E4177BD@dbde02.ent.ti.com>
References: <20100726100956.GA17996@july> <4C4D6BF9.1040704@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030E4176E6@dbde02.ent.ti.com>
 <4C4D82C8.3040307@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46567 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851Ab0GZPA7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Jul 2010 11:00:59 -0400
In-Reply-To: <4C4D82C8.3040307@nokia.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>



> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
> Sent: Monday, July 26, 2010 6:13 PM
> To: Ghorai, Sukumar
> Cc: linux-mmc@vger.kernel.org; Andrew Morton
> Subject: Re: [PATCH] mmc: add device class attribute for ext_csd
> 
> Ghorai, Sukumar wrote:
> > All,
> > EXT_CSD is 512byte information (read using CMD8) for the MMC (eMMC)
> device.
> > And for the latest and upcoming specification, ext_csd are much relevant
> then past.
> >
> > So please let me know your idea to add and get the same ext_csd as MMC
> device attribute. This is the same way currently available for csd, cid,
> src, etc.
> > (# cat /sys/class/mmc_host/mmc1/mmc1\:0001/ext_csd)
> 
> Some of the values in Extended CSD can change so storing
> it could cause incorrect values to be reported.
[Ghorai] I was thinking to get the original value as reference, such that we know that host is capable for maximum negotiation, like 8-bit, DDR mode, voltage, etc.
1. Is there any other way to get the original value supported by card?
2. If yes, is it worth full to do?

> Note that Extended CSD is available via debugfs
> e.g. for device mmc0:0001 with debugfs mounted on /sys/kernel/debug
> 
>     cat /sys/kernel/debug/mmc0/mmc0\:0001/ext_csd
[Ghorai] Thanks. I got it.

<<snip>>
