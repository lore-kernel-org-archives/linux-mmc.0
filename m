From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 0/8] omap*: Fixes/Cleanups for MMC devicetree node
Date: Thu, 3 Aug 2017 16:48:58 +0530
Message-ID: <e9c1cce6-5d6d-3762-8a84-28f36fa3bc33@ti.com>
References: <20170607093749.15656-1-kishon@ti.com>
 <CAPDyKFrJh9qAz6q2-TH8rMshuMjDTkT5pHP==FUUH9KZEOehOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrJh9qAz6q2-TH8rMshuMjDTkT5pHP==FUUH9KZEOehOQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Tony.

On Thursday 08 June 2017 12:50 PM, Ulf Hansson wrote:
> On 7 June 2017 at 11:37, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> There are the set of fixes that were sent initially as part
>> of [1].
>>
>> These are mostly fixes w.r.t populating regulators in
>> mmc dt node. It was working before because the regulators
>> connecting to the IO lines are always on regulators. This will
>> break once we add UHS support where voltage has to be changed
>> dynamically.
>>
>> It also includes a patch to replace all vmmc_aux-supply
>> with vqmmc-supply (In omap3-overo-base.dtsi remove the existing
>> vqmmc-supply and then replace vmmc_aux-supply with vqmmc-supply).
>> This will break old dt compatibility but not sure how better
>> to handle this.
>>
>> Performed enumeration testing on dra72-evm-revc, dra72-evm,
>> dra7-evm, am572x-evm, am571x-idk, am572x-idk, omap5-evm,
>> pandaboard-es, am43xx-evm, am335x-evm, beagleboard etc.,
>>
>> This is a preparation series for adding UHS mode support in
>> the above mentioned platforms.
>>
>> Changes from v1:
>> *) Included a patch to replace deprecated "vmmc_aux" with
>>    "vqmmc"

Have you already merged this series in your for-next? I could see all the
patches except "ARM: dts: omap*: Replace deprecated "vmmc_aux" with "vqmmc" in
your for-next.

Do you want me to resend the entire series or only "ARM: dts: omap*: Replace
deprecated "vmmc_aux" with "vqmmc"?

Please note having vqmmc property is required when we move to sdhci driver.

Thanks
Kishon
>>
>> [1] -> https://lkml.org/lkml/2017/5/19/196
>>
>> Kishon Vijay Abraham I (6):
>>   ARM: dts: dra72-evm-common: Correct vmmc-supply for mmc2
>>   ARM: dts: dra72-evm: Add vqmmc supply to mmc1
>>   ARM: dts: dra72-evm-revc: Add vqmmc supply to mmc1
>>   ARM: dts: am57xx-beagle-x15-revb1: Fix supply name used for MMC1 IO
>>     lines
>>   ARM: dts: dra7: Add "max-frequency" property to MMC dt nodes
>>   ARM: dts: omap*: Replace deprecated "vmmc_aux" with "vqmmc"
>>
>> Ravikumar Kattekola (1):
>>   ARM: dts: dra7-evm: Correct the vmmc-supply for mmc2
>>
>> Sekhar Nori (1):
>>   ARM: OMAP2+: Add pdata-quirks for MMC/SD on DRA74x EVM
>>
>>  arch/arm/boot/dts/am572x-idk.dts               |  2 +-
>>  arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts  |  2 +-
>>  arch/arm/boot/dts/dra7-evm.dts                 | 12 ++++++++--
>>  arch/arm/boot/dts/dra7.dtsi                    |  5 +++++
>>  arch/arm/boot/dts/dra71-evm.dts                | 16 ++++++++++++-
>>  arch/arm/boot/dts/dra72-evm-common.dtsi        |  2 --
>>  arch/arm/boot/dts/dra72-evm-revc.dts           | 18 +++++++++++++++
>>  arch/arm/boot/dts/dra72-evm-tps65917.dtsi      |  2 +-
>>  arch/arm/boot/dts/dra72-evm.dts                | 18 +++++++++++++++
>>  arch/arm/boot/dts/omap3-beagle-xm.dts          |  2 +-
>>  arch/arm/boot/dts/omap3-beagle.dts             |  2 +-
>>  arch/arm/boot/dts/omap3-cm-t3517.dts           |  2 +-
>>  arch/arm/boot/dts/omap3-cm-t3730.dts           |  2 +-
>>  arch/arm/boot/dts/omap3-devkit8000-common.dtsi |  2 +-
>>  arch/arm/boot/dts/omap3-evm-common.dtsi        |  2 +-
>>  arch/arm/boot/dts/omap3-n900.dts               |  2 +-
>>  arch/arm/boot/dts/omap3-overo-base.dtsi        |  3 +--
>>  arch/arm/boot/dts/omap3-tao3530.dtsi           |  2 +-
>>  arch/arm/boot/dts/omap3-zoom3.dts              |  2 +-
>>  arch/arm/boot/dts/omap3430-sdp.dts             |  2 +-
>>  arch/arm/mach-omap2/pdata-quirks.c             | 31 ++++++++++++++++++++++++++
>>  include/linux/platform_data/hsmmc-omap.h       |  3 +++
>>  22 files changed, 114 insertions(+), 20 deletions(-)
>>
>> --
>> 2.11.0
>>
> 
> If it helps, I can host a branch with the updates on the omap_hsmmc
> driver, such it can be pulled in from arm soc?
> 
> I guess you need that as, the DT changes relies on the new vqmmc
> binding. Or you thing it doesn't matter, because for the current
> changes that regulator is always an always on regulator?
> 
> Br
> Uffe
> 
