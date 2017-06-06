From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 0/7] dra7: Fixes for MMC devicetree node
Date: Tue, 6 Jun 2017 16:06:23 +0530
Message-ID: <1d15c9e9-f257-fd97-a9a2-055ee90d7e84@ti.com>
References: <20170601143401.16852-1-kishon@ti.com>
 <CAPDyKFqHHjZQnnaGLP=xDj3eYgzADDYoomzBuXRviBgh-n2QFw@mail.gmail.com>
 <f78dd61c-6689-4dbc-d1db-128f92be8e51@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <f78dd61c-6689-4dbc-d1db-128f92be8e51@ti.com>
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Tony,

On Tuesday 06 June 2017 09:47 AM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Friday 02 June 2017 04:20 PM, Ulf Hansson wrote:
>> On 1 June 2017 at 16:33, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>> There are the set of fixes that were sent initially as part
>>> of [1].
>>>
>>> These are mostly fixes w.r.t populating regulators in
>>> mmc dt node. It was working before because the regulators
>>> connecting to the IO lines are always on regulators. This will
>>> break once we add UHS support where voltage has to be changed
>>> dynamically.
>>>
>>> Performed enumeration testing on dra72-evm-revc, dra72-evm,
>>> dra7-evm, am572x-evm, am571x-idk and am572x-idk.
>>>
>>> This is a preparation series for adding UHS mode support in
>>> the above mentioned platforms.
>>>
>>> [1] -> https://lkml.org/lkml/2017/5/19/196
>>>
>>> Kishon Vijay Abraham I (5):
>>>   ARM: dts: dra72-evm-common: Correct vmmc-supply for mmc2
>>>   ARM: dts: dra72-evm: Add vmmc_aux supply to mmc1
>>>   ARM: dts: dra72-evm-revc: Add vmmc_aux supply to mmc1
>>>   ARM: dts: am57xx-beagle-x15-revb1: Fix supply name used for MMC1 IO
>>>     lines
>>>   ARM: dts: dra7: Add "max-frequency" property to MMC dt nodes
>>>
>>> Ravikumar Kattekola (1):
>>>   ARM: dts: dra7-evm: Correct the vmmc-supply for mmc2
>>>
>>> Sekhar Nori (1):
>>>   ARM: OMAP2+: Add pdata-quirks for MMC/SD on DRA74x EVM
>>>
>>>  arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts |  2 +-
>>>  arch/arm/boot/dts/dra7-evm.dts                | 10 ++++++++-
>>>  arch/arm/boot/dts/dra7.dtsi                   |  5 +++++
>>>  arch/arm/boot/dts/dra71-evm.dts               | 14 ++++++++++++
>>>  arch/arm/boot/dts/dra72-evm-common.dtsi       |  2 --
>>>  arch/arm/boot/dts/dra72-evm-revc.dts          | 18 ++++++++++++++++
>>>  arch/arm/boot/dts/dra72-evm.dts               | 18 ++++++++++++++++
>>>  arch/arm/mach-omap2/pdata-quirks.c            | 31 +++++++++++++++++++++++++++
>>>  include/linux/platform_data/hsmmc-omap.h      |  3 +++
>>>  9 files changed, 99 insertions(+), 4 deletions(-)
>>
>> This series add a bunch of new vmmc_aux regulators for the mmc
>> controller nodes. I would rather see that omap_hsmmc also converts to
>> use the generic mmc binding for this regulator, which is "vqmmc".
>>
>> To accomplish that, omap_hsmmc needs to convert to use
>> mmc_regulator_get_supply(). If the "vqmmc" regulator isn't found, it
>> should fallback to try the "vmmc_aux".
>>
>> Can you do that?
> 
> sure, I'll prepare that change.

omap3-overo-base.dtsi has the following dt node for mmc.
/* optional on board WiFi */
&mmc2 {
        pinctrl-names = "default";
        pinctrl-0 = <&mmc2_pins>;
        vmmc-supply = <&w3cbw003c_npoweron>;
        vqmmc-supply = <&w3cbw003c_bt_nreset>;
        vmmc_aux-supply = <&w3cbw003c_wifi_nreset>;
        bus-width = <4>;
        cap-sdio-irq;
        non-removable;
};

It has both "vqmmc-supply" and "vmmc_aux-supply". However omap-hsmmc driver has
never parsed vqmmc so far. So I'd assume bt was never functional and it's used
only for wifi.

So for the change suggested by Ulf, Can I do something like below, so that we
can keep wifi functional (ignoring bt since that was never functional)?
-       vqmmc-supply = <&w3cbw003c_bt_nreset>;
-       vmmc_aux-supply = <&w3cbw003c_wifi_nreset>;
+       vqmmc-supply = <&w3cbw003c_wifi_nreset>;

Thanks
Kishon
