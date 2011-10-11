From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH 2/3] mmc: Add OF bindings support for mmc host controller capabilities
Date: Tue, 11 Oct 2011 23:38:19 +0530
Message-ID: <CAJuYYwRfdUOTPxc5dTip28F5VGsNjzOHvuxRuu3AhyQ_Y4Ye1Q@mail.gmail.com>
References: <1317809581-28783-1-git-send-email-thomas.abraham@linaro.org>
	<1317809581-28783-3-git-send-email-thomas.abraham@linaro.org>
	<4E8C5BD6.2070709@gmail.com>
	<CAJuYYwS_NeE6OG9X2p2rkjgo4OqO-ijeVwr1sLGkUuLJOxMw2g@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173A2C7245@HQMAIL01.nvidia.com>
	<CAJuYYwSOZsqKObmt4MeaJa+aPmktwLsFocfmpjbJbOYyvmuwLQ@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF173BE19AAE@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF173BE19AAE@HQMAIL01.nvidia.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Chris Ball <cjb@laptop.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 11 October 2011 21:59, Stephen Warren <swarren@nvidia.com> wrote:
> Thomas Abraham wrote at Sunday, October 09, 2011 12:58 AM:
>> On 5 October 2011 21:25, Stephen Warren <swarren@nvidia.com> wrote:
>> > Thomas Abraham wrote at Wednesday, October 05, 2011 8:28 AM:
>> >> On 5 October 2011 18:59, Rob Herring <robherring2@gmail.com> wrot=
e:
>> >> > On 10/05/2011 05:13 AM, Thomas Abraham wrote:
>> >> >> Device nodes representing sd/mmc controllers in a device tree =
would include
>> >> >> mmc host controller capabilities. Add support for parsing of m=
mc host
>> >> >> controller capabilities included in device nodes.
>> > ...
>> >> >> +- linux,mmc_cap_4_bit_data - host can do 4 bit transfers
>> >> >> +- linux,mmc_cap_mmc_highspeed - host can do MMC high-speed ti=
ming
>> >> >> +- linux,mmc_cap_sd_highspeed - host can do SD high-speed timi=
ng
>> >> >> +- linux,mmc_cap_needs_poll - host needs polling for card dete=
ction
>> >> >> +- linux,mmc_cap_8_bit_data - host can do 8 bit transfer
>> >> >
>> >> > "sdhci,1-bit-only" already exists as a binding. Perhaps add
>> >> > "sdhci,4-bit-only". No property then means can do 8-bit.
>> >>
>> >> Ok. But that would remain just as sdhci host controller capabilit=
y and
>> >> will not be applicable to other types of host controllers.
>> >
>> > Just as an FYI, NVIDIA's SDHCI controller bindings use property
>> > "support-8bit" to indicate 8-bit support. A similar property could=
 be
>> > used for 4-bit support too.
>>
>> In this case, the binding would be applicable only to nVidia's SDHCI
>> controller.
>
> Sure, this is the case right now. And I thought I'd copied this prope=
rty
> name from some other driver, but it looks like I'm mistaken.
>
>> And this binding would select MMC_CAP_8_BIT_DATA in the
>> sdhci-tegra driver. There are sdhci drivers that can accept host
>> capabilities via platform data.
>>
>> The MMC_CAP_XXX macros in linux/mmc/host.h file are usuable across
>> host controllers and some of them are supplied as platform data for
>> non-device tree platforms.
>>
>> So, bindings for MMC_CAP_XXX macros can be defined which any host
>> controller supporting device tree could use. Host controllers could
>> use the mmc_of_parse_host_caps() helper function (listed in this
>> patch) to parse all the bindings for MMC_CAP_XXX =A0available in the
>> device node.
>>
>> I would like to retain this patch in this series but if there is a
>> definite no, then I will drop it. Please let me know your opinion.
>
> I was simply pointing out that there are already some properties in t=
his
> area. It'd be nice if we could unify everything on a single style; ei=
ther
> expanding the existing "sdhci,1-bit-only" style that Rob mentioned, o=
r
> expanding the "support-8bit" style that Tegra currently uses, rather =
than
> adding a third way of indicating this. Still, given the early state o=
f
> DT on Tegra, I'd be happy migrating Tegra to whatever single unified
> approach is chosen, so don't take my comments as nak'ing your patch o=
r
> anything like that.

Ok.

The sdhci bus width binding is an example that can be extended as you
have suggested. If done this way, the sdhci bus width bindings would
be converted by the driver to either of MMC_CAP_[4/8]_BIT_DATA
capability.

But there are other MMC_CAP_XXX values as well which the host
controller driver needs to report to the upper mmc core layer. Some of
these capabilities are determined by reading caps register of the host
controller and converting them to equivalent MMC_CAP_XXX flags. But
some of them are board dependent such as

MMC_CAP_NEEDS_POLL,
MMC_CAP_DISABLE,
MMC_CAP_NONREMOVABLE,
MMC_CAP_POWER_OFF_CARD and others.

These flags which are tied to the characteristics of the board is
usually supplied using platform data. The driver picks up these from
platform data, adds its own set of CAP's and reports to the upper
layer.

When we do not have platform data (as in the case of dt), there could
be two options to bind these CAP's. Either define custom bindings for
these and then translate them in each host controller driver using
them or provide direct bindings for MMC_CAP_xxx with a common function
to parse them. I tend towards direct bindings for MMC_CAP_XXX because
it can be used by any type of mmc/sd host controller and not just
sdhci controller and provides common binding for all host controllers.

Thanks for your comments.

Regards,
Thomas.

>
> --
> nvpublic
>
>
