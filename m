From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 2/3] mmc: Add OF bindings support for mmc host controller capabilities
Date: Sun, 9 Oct 2011 12:28:15 +0530
Message-ID: <CAJuYYwSOZsqKObmt4MeaJa+aPmktwLsFocfmpjbJbOYyvmuwLQ@mail.gmail.com>
References: <1317809581-28783-1-git-send-email-thomas.abraham@linaro.org>
	<1317809581-28783-3-git-send-email-thomas.abraham@linaro.org>
	<4E8C5BD6.2070709@gmail.com>
	<CAJuYYwS_NeE6OG9X2p2rkjgo4OqO-ijeVwr1sLGkUuLJOxMw2g@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173A2C7245@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173A2C7245@HQMAIL01.nvidia.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Chris Ball <cjb@laptop.org>
Cc: "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 5 October 2011 21:25, Stephen Warren <swarren@nvidia.com> wrote:
> Thomas Abraham wrote at Wednesday, October 05, 2011 8:28 AM:
>> On 5 October 2011 18:59, Rob Herring <robherring2@gmail.com> wrote:
>> > On 10/05/2011 05:13 AM, Thomas Abraham wrote:
>> >> Device nodes representing sd/mmc controllers in a device tree would include
>> >> mmc host controller capabilities. Add support for parsing of mmc host
>> >> controller capabilities included in device nodes.
> ...
>> >> +- linux,mmc_cap_4_bit_data - host can do 4 bit transfers
>> >> +- linux,mmc_cap_mmc_highspeed - host can do MMC high-speed timing
>> >> +- linux,mmc_cap_sd_highspeed - host can do SD high-speed timing
>> >> +- linux,mmc_cap_needs_poll - host needs polling for card detection
>> >> +- linux,mmc_cap_8_bit_data - host can do 8 bit transfer
>> >
>> > "sdhci,1-bit-only" already exists as a binding. Perhaps add
>> > "sdhci,4-bit-only". No property then means can do 8-bit.
>>
>> Ok. But that would remain just as sdhci host controller capability and
>> will not be applicable to other types of host controllers.
>
> Just as an FYI, NVIDIA's SDHCI controller bindings use property
> "support-8bit" to indicate 8-bit support. A similar property could be
> used for 4-bit support too.


In this case, the binding would be applicable only to nVidia's SDHCI
controller. And this binding would select MMC_CAP_8_BIT_DATA in the
sdhci-tegra driver. There are sdhci drivers that can accept host
capabilities via platform data.

The MMC_CAP_XXX macros in linux/mmc/host.h file are usuable across
host controllers and some of them are supplied as platform data for
non-device tree platforms.

So, bindings for MMC_CAP_XXX macros can be defined which any host
controller supporting device tree could use. Host controllers could
use the mmc_of_parse_host_caps() helper function (listed in this
patch) to parse all the bindings for MMC_CAP_XXX  available in the
device node.

I would like to retain this patch in this series but if there is a
definite no, then I will drop it. Please let me know your opinion.

Thanks,
Thomas.

>
> --
> nvpublic
>
>
