From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 3/9] DTS: ARM: pandora-common: define wl1251 as child node
 of mmc3
Date: Mon, 21 Oct 2019 20:22:15 +0200
Message-ID: <0C476142-BC54-4950-8B7A-A422ABC2AEB9@goldelico.com>
References: <cover.1571430329.git.hns@goldelico.com>
 <58c57f194e35b2a055a58081a0ea0d3ffcd07b6d.1571430329.git.hns@goldelico.com>
 <20191021171321.GZ5610@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191021171321.GZ5610@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>, linux-wireless@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>, letux-kernel@openphoenux.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>, Kalle Valo <kvalo@codeaurora.org>, Petr Mladek <pmladek@suse.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, kernel@pyra-handheld.com, Alexios Zavras <alexios.zavras@intel.com>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, David Sterba <dsterba@suse.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Allison Randal <allison@lohutok.net>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundat>
List-Id: linux-mmc@vger.kernel.org


> Am 21.10.2019 um 19:13 schrieb Tony Lindgren <tony@atomide.com>:
> 
> * H. Nikolaus Schaller <hns@goldelico.com> [191018 20:28]:
>> Since v4.7 the dma initialization requires that there is a
>> device tree property for "rx" and "tx" channels which is
>> not provided by the pdata-quirks initialization.
>> 
>> By conversion of the mmc3 setup to device tree this will
>> finally allows to remove the OpenPandora wlan specific omap3
>> data-quirks.
>> 
>> Fixes: 81eef6ca9201 ("mmc: omap_hsmmc: Use dma_request_chan() for requesting DMA channel")
> 
> Here you have the subject line the wrong way around,
> please update it to start with "ARM: dts: ...".

Ok.
