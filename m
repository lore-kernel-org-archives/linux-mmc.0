From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH 0/9] OpenPandora: make wl1251 connected to mmc3 sdio port of OpenPandora work again
Date: Sat, 19 Oct 2019 14:06:41 +0300
Message-ID: <87sgnpvvsu.fsf@kamboji.qca.qualcomm.com>
References: <cover.1571430329.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1571430329.git.hns@goldelico.com> (H. Nikolaus Schaller's
        message of "Fri, 18 Oct 2019 22:25:21 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Mike Rapoport <rppt@linux.ibm.com>, David Sterba <dsterba@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek <pmladek@suse.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Yangtao Li <tiny.windzz@gmail.com>, Alexios Zavras <alexios.zavras@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Stultz <john.stultz@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-mmc@vger.kernel.org

"H. Nikolaus Schaller" <hns@goldelico.com> writes:

> Here we have a set of scattered patches to make the OpenPandora WiFi work again.
>
> v4.7 did break the pdata-quirks which made the mmc3 interface
> fail completely, because some code now assumes device tree
> based instantiation.
>
> Fixes: 81eef6ca9201 ("mmc: omap_hsmmc: Use dma_request_chan() for requesting DMA channel")
>
> v4.11 did break the sdio qirks for wl1251 which made the driver no longer
> load, although the device was found as an sdio client.
>
> Fixes: 884f38607897 ("mmc: core: move some sdio IDs out of quirks file")
>
> To solve these issues:
> * we convert mmc3 and wl1251 initialization from pdata-quirks
>   to device tree
> * we make the wl1251 driver read properties from device tree
> * we fix the mmc core vendor ids and quirks
> * we fix the wl1251 (and wl1271) driver to use only vendor ids
>   from header file instead of (potentially conflicting) local
>   definitions
>
>
> H. Nikolaus Schaller (9):
>   Documentation: dt: wireless: update wl1251 for sdio
>   net: wireless: ti: wl1251 add device tree support
>   DTS: ARM: pandora-common: define wl1251 as child node of mmc3
>   mmc: host: omap_hsmmc: add code for special init of wl1251 to get rid
>     of pandora_wl1251_init_card
>   omap: pdata-quirks: remove openpandora quirks for mmc3 and wl1251
>   mmc: sdio: fix wl1251 vendor id
>   mmc: core: fix wl1251 sdio quirks
>   net: wireless: ti: wl1251 use new SDIO_VENDOR_ID_TI_WL1251 definition
>   net: wireless: ti: remove local VENDOR_ID and DEVICE_ID definitions

I didn't get patches 3-7 so I don't know what they have, but what's the
plan how these should be applied? Normally wl1251 patches go via
wireless-drivers-next but are you planning something else?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
