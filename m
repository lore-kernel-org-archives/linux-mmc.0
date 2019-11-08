From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 07/12] omap: remove omap2_hsmmc_info in old hsmmc.[ch]
 and update Makefile
Date: Fri, 8 Nov 2019 09:11:32 -0800
Message-ID: <20191108171132.GM5610@atomide.com>
References: <cover.1573122644.git.hns@goldelico.com>
 <c3e0a1392dd6d44fe8bde0161c508007f4abdd5f.1573122644.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c3e0a1392dd6d44fe8bde0161c508007f4abdd5f.1573122644.git.hns@goldelico.com>
Sender: netdev-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>, Mike Rapoport <rppt@linux.ibm.com>, David Sterba <dsterba@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek <pmladek@suse.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Yangtao Li <tiny.windzz@gmail.com>, Alexios Zavras <alexios.zavras@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Stultz <john.stultz@linaro.org>, Bjorn Helgaas <bhelgaas@google.co>
List-Id: linux-mmc@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [191107 10:32]:
> There is a new driver in drivers/mmc/host/omap_hsmmc.c
> configured by CONFIG_MMC_OMAP_HS and the last user
> was the pdata-quirks for pandora.

Thanks for doing this:

Acked-by: Tony Lindgren <tony@atomide.com>
