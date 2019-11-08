From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 03/12] ARM: dts: pandora-common: define wl1251 as
 child node of mmc3
Date: Fri, 8 Nov 2019 09:10:08 -0800
Message-ID: <20191108171008.GJ5610@atomide.com>
References: <cover.1573122644.git.hns@goldelico.com>
 <bd14b481105b21a0c1882a1ea34281893233db31.1573122644.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bd14b481105b21a0c1882a1ea34281893233db31.1573122644.git.hns@goldelico.com>
Sender: netdev-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>, Mike Rapoport <rppt@linux.ibm.com>, David Sterba <dsterba@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek <pmladek@suse.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Yangtao Li <tiny.windzz@gmail.com>, Alexios Zavras <alexios.zavras@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Stultz <john.stultz@linaro.org>, Bjorn Helgaas <bhelgaas@google.co>
List-Id: linux-mmc@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [191107 10:33]:
> Since v4.7 the dma initialization requires that there is a
> device tree property for "rx" and "tx" channels which is
> not provided by the pdata-quirks initialization.
> 
> By conversion of the mmc3 setup to device tree this will
> finally allows to remove the OpenPandora wlan specific omap3
> data-quirks.
> 
> Fixes: 81eef6ca9201 ("mmc: omap_hsmmc: Use dma_request_chan() for requesting DMA channel")

Probably best to queue this all via the mmc tree when no more comments:

Acked-by: Tony Lindgren <tony@atomide.com>
