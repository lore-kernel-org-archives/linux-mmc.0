From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] mmc: sdhci: check voltage range only on regulators
 aware of voltage value
Date: Wed, 5 Dec 2012 10:48:25 +0900
Message-ID: <20121205014823.GA28474@opensource.wolfsonmicro.com>
References: <1354629663-29091-1-git-send-email-m.szyprowski@samsung.com>
 <1354629663-29091-4-git-send-email-m.szyprowski@samsung.com>
 <CADz5_gLAWyD-3nYEV5HJad11wxEmxO867LkWOXDBn1_XmcOA_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58694 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752000Ab2LEBsd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Dec 2012 20:48:33 -0500
Content-Disposition: inline
In-Reply-To: <CADz5_gLAWyD-3nYEV5HJad11wxEmxO867LkWOXDBn1_XmcOA_w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>

On Tue, Dec 04, 2012 at 10:50:03PM +0800, Kevin Liu wrote:
> 2012/12/4 Marek Szyprowski <m.szyprowski@samsung.com>:

> > +       if (host->vmmc && regulator_get_voltage(host->vmmc) > 0) {
> >                 ret = regulator_is_supported_voltage(host->vmmc, 2700000,
> >                         3600000);
> >                 if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_330)))

> Good idea. But how about the regulator is disabled at this point? So I
> suggest to change to
>      if (host->vmmc && regulator_get_voltage(host->vmmc) >= 0)

I'd not expect regulator_get_voltage() to return 0 for disabled
regulators, I'd expect it to return the voltage the regulator will have
when enabled.
