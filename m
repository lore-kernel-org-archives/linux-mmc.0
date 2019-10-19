From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH 0/9] OpenPandora: make wl1251 connected to mmc3 sdio port
 of OpenPandora work again
Date: Sat, 19 Oct 2019 14:34:57 +0300
Message-ID: <87d0etvuhq.fsf@kamboji.qca.qualcomm.com>
References: <cover.1571430329.git.hns@goldelico.com>
 <87sgnpvvsu.fsf@kamboji.qca.qualcomm.com>
 <584D2E2D-7617-4F7D-A567-507C7CCB4A53@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <584D2E2D-7617-4F7D-A567-507C7CCB4A53@goldelico.com> (H. Nikolaus
 Schaller's message of "Sat, 19 Oct 2019 13:25:20 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-wireless@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>, letux-kernel@openphoenux.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>, Yangtao Li <tiny.windzz@gmail.com>, linux-arm-kernel@lists.infradead.org, Petr Mladek <pmladek@suse.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, kernel@pyra-handheld.com, Alexios Zavras <alexios.zavras@intel.com>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, David Sterba <dsterba@suse.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundati>
List-Id: linux-mmc@vger.kernel.org

"H. Nikolaus Schaller" <hns@goldelico.com> writes:

> Hi,
>
>> Am 19.10.2019 um 13:06 schrieb Kalle Valo <kvalo@codeaurora.org>:
>> 
>> "H. Nikolaus Schaller" <hns@goldelico.com> writes:
>> 
>>> Here we have a set of scattered patches to make the OpenPandora WiFi work again.
>>> 
>>> v4.7 did break the pdata-quirks which made the mmc3 interface
>>> fail completely, because some code now assumes device tree
>>> based instantiation.
>>> 
>>> Fixes: 81eef6ca9201 ("mmc: omap_hsmmc: Use dma_request_chan() for requesting DMA channel")
>>> 
>>> v4.11 did break the sdio qirks for wl1251 which made the driver no longer
>>> load, although the device was found as an sdio client.
>>> 
>>> Fixes: 884f38607897 ("mmc: core: move some sdio IDs out of quirks file")
>>> 
>>> To solve these issues:
>>> * we convert mmc3 and wl1251 initialization from pdata-quirks
>>>  to device tree
>>> * we make the wl1251 driver read properties from device tree
>>> * we fix the mmc core vendor ids and quirks
>>> * we fix the wl1251 (and wl1271) driver to use only vendor ids
>>>  from header file instead of (potentially conflicting) local
>>>  definitions
>>> 
>>> 
>>> H. Nikolaus Schaller (9):
>>>  Documentation: dt: wireless: update wl1251 for sdio
>>>  net: wireless: ti: wl1251 add device tree support
>>>  DTS: ARM: pandora-common: define wl1251 as child node of mmc3
>>>  mmc: host: omap_hsmmc: add code for special init of wl1251 to get rid
>>>    of pandora_wl1251_init_card
>>>  omap: pdata-quirks: remove openpandora quirks for mmc3 and wl1251
>>>  mmc: sdio: fix wl1251 vendor id
>>>  mmc: core: fix wl1251 sdio quirks
>>>  net: wireless: ti: wl1251 use new SDIO_VENDOR_ID_TI_WL1251 definition
>>>  net: wireless: ti: remove local VENDOR_ID and DEVICE_ID definitions
>> 
>> I didn't get patches 3-7
>
> oh sorry. I don't know why.
>
> Here they are all: https://patchwork.kernel.org/cover/11199599/

Thanks.

>> so I don't know what they have, but what's the
>> plan how these should be applied? Normally wl1251 patches go via
>> wireless-drivers-next but are you planning something else?
>
> Well, I have no plan for that except that all should end up fixed in mainline
> and stable.
>
> The issue is that multiple subsystems are involved (net/wireless, mmc and arm/omap)
> and all patches should be ideally be applied in combination.

Ok, I then assume someone else is going to handle these, wl1251 rarely
has any changes so the chance of conflicts is small anyway, and I'll
drop the wl1251 patches from my patchwork.

For wl1251 patches 1, 2, 8 and 9:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
