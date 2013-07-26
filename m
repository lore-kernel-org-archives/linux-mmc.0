From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH 2/2] mmc: esdhc: get voltage from dts file
Date: Fri, 26 Jul 2013 12:06:08 -0700
Message-ID: <20130726190608.GA14216@lizard>
References: <1374479636-9254-1-git-send-email-Haijun.Zhang@freescale.com>
 <1374479636-9254-2-git-send-email-Haijun.Zhang@freescale.com>
 <1374514847.15592.7@snotra>
 <99E897753B6F7048BD8CCDB4661D02E13E49EC@039-SN2MPN1-022.039d.mgd.msft.net>
 <1374547294.15592.22@snotra>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:38819 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780Ab3GZTKl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jul 2013 15:10:41 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so3082375pad.37
        for <linux-mmc@vger.kernel.org>; Fri, 26 Jul 2013 12:10:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1374547294.15592.22@snotra>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: Zhang Haijun-B42677 <B42677@freescale.com>, Wood Scott-B07421 <B07421@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "cjb@laptop.org" <cjb@laptop.org>, Fleming Andy-AFLEMING <afleming@freescale.com>

On Mon, Jul 22, 2013 at 09:41:34PM -0500, Scott Wood wrote:
[...]
> >> > +static void esdhc_get_voltage(struct sdhci_host *host,
> >> > +			struct platform_device *pdev)
> >> > +{
....
> >> > +}
> >>
> >> Don't duplicate this code.  Move it somewhere common and share it.
> >[Haijun Wrote:] So, move it drivers/mmc/host/sdhci-pltfm.c and
> >share it as
> >Sdhc_get_voltage()....?
> 
> I'll let the MMC maintainer say what the appropriate place would
> be...  Don't capitalize the function name, though. :-)

Somewhere in drivers/mmc/core/core.c, near mmc_vddrange_to_ocrmask() would
be most appropriate, IMO. #ifdef CONFIG_OF would be needed, though.

Thanks,

Anton
