From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 3/5] dt-bindings: sdhci-omap: Add bindings for the
 sdhci-omap controller
Date: Wed, 23 Aug 2017 19:26:35 +0530
Message-ID: <c9342689-f09e-44af-0975-d43ef122a477@ti.com>
References: <20170821142132.GH6008@atomide.com>
 <20170823054246.23927-1-kishon@ti.com>
 <CAPDyKFp7gchVQ+JPNqv4LktvHRm2Lzx6KakOw85zEZxDEX0OhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFp7gchVQ+JPNqv4LktvHRm2Lzx6KakOw85zEZxDEX0OhA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Uffe,

On Wednesday 23 August 2017 06:37 PM, Ulf Hansson wrote:
> On 23 August 2017 at 07:42, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> Add binding for the TI's sdhci-omap controller. This now includes only
>> a subset of properties documented in ti-omap-hsmmc.txt but will eventually
>> include all the properties.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>> Changes from v2:
>> *) Fixed example to use the updated compatible
>>
>> Changes from v1:
>> *) Create a new sdhci-omap.txt document for TI's sdhci-omap controller instead
>>    of using the ti-omap-hsmmc.txt as suggested by Tony
>>  .../devicetree/bindings/mmc/sdhci-omap.txt         | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-omap.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
>> new file mode 100644
>> index 000000000000..139695ad2d58
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
>> @@ -0,0 +1,22 @@
>> +* TI OMAP SDHCI Controller
>> +
>> +Refer to mmc.txt for standard MMC bindings.
>> +
>> +Required properties:
>> +- compatible: Should be "ti,dra7-sdhci" for DRA7 and DRA72 controllers
>> +- ti,hwmods: Must be "mmc<n>", <n> is controller instance starting 1
>> +
>> +Optional properties:
>> +- ti,dual-volt: boolean, supports dual voltage cards
>> +- ti,non-removable: non-removable slot (like eMMC)
>> +
>> +Example:
>> +       mmc1: mmc@0x4809c000 {
>> +               compatible = "ti,dra7-sdhci";
>> +               reg = <0x4809c000 0x400>;
>> +               ti,hwmods = "mmc1";
>> +               ti,dual-volt;
>> +               bus-width = <4>;
>> +               vmmc-supply = <&vmmc>; /* phandle to regulator node */
>> +               ti,non-removable;
>> +       };
>> --
>> 2.11.0
>>
> 
> I am wondering a bit on the long term plan here.
> 
> Ideally at some point in future, we would like to remove the old
> omap_hsmmc driver, but from compatible string point of view, that
> means we first needs to deprecate the old ones for a while. Right?

right but sdhci-omap is still lacking features that was present in omap_hsmmc
like context save/restore, SDIO support etc. I think we should deprecate
omap_hsmmc compatible once we add all the features in sdhci-omap?
> 
> That said, what is then the reason to why we should bring over the
> existing omap_hsmmc bindings to the sdhci-omap bindings?

This is mainly for old dt compatibility. Even after removing the omap_hsmmc
driver, users should still be able to use newer kernel with their existing dtbs.

Thanks
Kishon
