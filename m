From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: avoid unused function warnings
Date: Tue, 26 Jul 2016 16:28:28 +0200
Message-ID: <5892795.2gjnivGOlz@wuerfel>
References: <20160726123246.879426-1-arnd@arndb.de> <CAA+hA=RPKfRgDc-SesHR8pBFwo0fsbYT=sY=QYyqiAV7U=k_hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAA+hA=RPKfRgDc-SesHR8pBFwo0fsbYT=sY=QYyqiAV7U=k_hA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Dong Aisheng <aisheng.dong@nxp.com>, Haibo Chen <haibo.chen@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tuesday, July 26, 2016 9:41:50 PM CEST Dong Aisheng wrote:
> 
> On Tue, Jul 26, 2016 at 8:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > The driver has just gained a slightly incorrect pm-sleep implementation that causes
> > warnings when CONFIG_PM is set but CONFIG_PM_SLEEP is not:
> >
> > drivers/mmc/host/sdhci-esdhc-imx.c:1302:12: error: 'sdhci_esdhc_resume' defined but not used [-Werror=unused-function]
> >  static int sdhci_esdhc_resume(struct device *dev)
> >             ^~~~~~~~~~~~~~~~~~
> > drivers/mmc/host/sdhci-esdhc-imx.c:1297:12: error: 'sdhci_esdhc_suspend' defined but not used [-Werror=unused-function]
> >  static int sdhci_esdhc_suspend(struct device *dev)
> >
> > This replaces the incorrect #ifdef with a __maybe_unused annotation that does
> > the right thing in all configurations and is more readable.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Fixes: b70d0b3b5b29 ("mmc: sdhci-esdhc-imx: add esdhc specific suspend resume callback")
> 
> Thanks for the fix.
> Looks like the default kernel Makefile does not enable
> -Werror=unused-function wanrings,
> so did not expose it before.

They are enabled by default as warnings, not errors. My test build setup
uses -Werror to turn all warnings into errors so I can catch them
more easily as failed builds.

> Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
> 

Thanks,

	Arnd
