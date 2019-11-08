From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 06/12] omap: pdata-quirks: remove openpandora quirks
 for mmc3 and wl1251
Date: Fri, 8 Nov 2019 09:11:06 -0800
Message-ID: <20191108171106.GL5610@atomide.com>
References: <cover.1573122644.git.hns@goldelico.com>
 <ff450c14eb1e13d2db6533fa06e069c5bec3a0c4.1573122644.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ff450c14eb1e13d2db6533fa06e069c5bec3a0c4.1573122644.git.hns@goldelico.com>
Sender: netdev-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>, Mike Rapoport <rppt@linux.ibm.com>, David Sterba <dsterba@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek <pmladek@suse.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Yangtao Li <tiny.windzz@gmail.com>, Alexios Zavras <alexios.zavras@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Stultz <john.stultz@linaro.org>, Bjorn Helgaas <bhelgaas@google.co>
List-Id: linux-mmc@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [191107 10:32]:
> With a wl1251 child node of mmc3 in the device tree decoded
> in omap_hsmmc.c to handle special wl1251 initialization, we do
> no longer need to instantiate the mmc3 through pdata quirks.
> 
> We also can remove the wlan regulator and reset/interrupt definitions
> and do them through device tree.
> 
> Fixes: 81eef6ca9201 ("mmc: omap_hsmmc: Use dma_request_chan() for requesting DMA channel")

Good to see this go away:

Acked-by: Tony Lindgren <tony@atomide.com>
