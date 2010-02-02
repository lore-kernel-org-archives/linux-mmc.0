From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 0/10] omap_hsmmc changes V2
Date: Mon, 1 Feb 2010 19:12:41 -0800
Message-ID: <20100202031241.GP22747@atomide.com>
References: <1264149200.1920.11.camel@Nokia-N900-51-1>
 <20100122171427.GQ23467@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58234 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab0BBDMT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2010 22:12:19 -0500
Content-Disposition: inline
In-Reply-To: <20100122171427.GQ23467@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@nokia.com
Cc: madhu.cr@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, akpm@linux-foundation.org

* Tony Lindgren <tony@atomide.com> [100122 09:13]:
> * adrian.hunter@nokia.com <adrian.hunter@nokia.com> [100122 00:31]:

<snip>

> > 
> > Thanks Madhu. Tony, are you ok taking these patches into your tree?
> 
> Looks good to me, will queue them into omap for-next.

Applied now, but there's a build error with omap_2430sdp_defconfig:

drivers/built-in.o: In function `omap_hsmmc_23_set_sleep':
hid-input.c:(.text+0x63dd0): undefined reference to `mmc_regulator_set_ocr'
drivers/built-in.o: In function `omap_hsmmc_23_set_power':
hid-input.c:(.text+0x63e48): undefined reference to `mmc_regulator_set_ocr'
drivers/built-in.o: In function `omap_hsmmc_1_set_power':
hid-input.c:(.text+0x63ee0): undefined reference to `mmc_regulator_set_ocr'
drivers/built-in.o: In function `omap_hsmmc_probe':
hid-input.c:(.init.text+0x3cb0): undefined reference to `mmc_regulator_get_ocrmask'

Any ideas what's missing for 2430?

Regards,

Tony
