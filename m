From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 05/12] omap: pdata-quirks: revert pandora specific
 gpiod additions
Date: Fri, 8 Nov 2019 09:10:35 -0800
Message-ID: <20191108171035.GK5610@atomide.com>
References: <cover.1573122644.git.hns@goldelico.com>
 <a90b488031c3d5da2feb2f157efa6c4287cf1922.1573122644.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a90b488031c3d5da2feb2f157efa6c4287cf1922.1573122644.git.hns@goldelico.com>
Sender: netdev-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>, Mike Rapoport <rppt@linux.ibm.com>, David Sterba <dsterba@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek <pmladek@suse.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Yangtao Li <tiny.windzz@gmail.com>, Alexios Zavras <alexios.zavras@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Stultz <john.stultz@linaro.org>, Bjorn Helgaas <bhelgaas@google.co>
List-Id: linux-mmc@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [191107 10:33]:
> introduced by commit
> 
> efdfeb079cc3b ("regulator: fixed: Convert to use GPIO descriptor only")
> 
> We must remove this from mainline first, so that the following patch
> to remove the openpandora quirks for mmc3 and wl1251 cleanly applies
> to stable v4.9, v4.14, v4.19 where the above mentioned patch is not yet
> present.
> 
> Since the code affected is removed (no pandora gpios in pdata-quirks
> and more), there will be no matching revert-of-the-revert.

This too:

Acked-by: Tony Lindgren <tony@atomide.com>
