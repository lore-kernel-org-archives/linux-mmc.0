From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH 3/3] mmc: sdhci: check voltage range only on regulators
 aware of voltage value
Date: Wed, 5 Dec 2012 10:12:11 +0800
Message-ID: <CADz5_g+nuAenwt46xuYbYE3vubqHWFBda3=GFAQe65-vjYo46g@mail.gmail.com>
References: <1354629663-29091-1-git-send-email-m.szyprowski@samsung.com>
	<1354629663-29091-4-git-send-email-m.szyprowski@samsung.com>
	<CADz5_gLAWyD-3nYEV5HJad11wxEmxO867LkWOXDBn1_XmcOA_w@mail.gmail.com>
	<20121205014823.GA28474@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121205014823.GA28474@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

2012/12/5 Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> On Tue, Dec 04, 2012 at 10:50:03PM +0800, Kevin Liu wrote:
> > 2012/12/4 Marek Szyprowski <m.szyprowski@samsung.com>:
>
> > > +       if (host->vmmc && regulator_get_voltage(host->vmmc) > 0) {
> > >                 ret = regulator_is_supported_voltage(host->vmmc,
> > > 2700000,
> > >                         3600000);
> > >                 if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_330)))
>
> > Good idea. But how about the regulator is disabled at this point? So I
> > suggest to change to
> >      if (host->vmmc && regulator_get_voltage(host->vmmc) >= 0)
>
> I'd not expect regulator_get_voltage() to return 0 for disabled
> regulators, I'd expect it to return the voltage the regulator will have
> when enabled.
Understand.

Thanks
Kevin
