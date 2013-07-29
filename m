From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/2] mmc: add Device Tree properties for UHS modes
Date: Mon, 29 Jul 2013 11:28:29 -0600
Message-ID: <51F6A63D.7050209@wwwdotorg.org>
References: <Pine.LNX.4.64.1307261747210.22137@axis700.grange> <51F2ADA2.2030503@wwwdotorg.org> <Pine.LNX.4.64.1307262215110.27439@axis700.grange> <51F2EBD4.1060603@wwwdotorg.org> <Pine.LNX.4.64.1307290753090.14405@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1307290753090.14405@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Rob Herring <rob.herring@calxeda.com>
List-Id: linux-mmc@vger.kernel.org

On 07/29/2013 12:20 AM, Guennadi Liakhovetski wrote:
> Hi Stephen
> 
> On Fri, 26 Jul 2013, Stephen Warren wrote:
> 
>> On 07/26/2013 02:23 PM, Guennadi Liakhovetski wrote:
>>> Hi Stephen
>>>
>>> On Fri, 26 Jul 2013, Stephen Warren wrote:
>>>
>>>> On 07/26/2013 09:51 AM, Guennadi Liakhovetski wrote:
>>>>> Add DT properties for UHS SDR12, SDR25, SDR50, SDR104 and DDR50 modes and
>>>>> for supported by the host in DDR mode VccQ values. Adding them to DT will
>>>>> automatically enable respective MMC host capabilities.
>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
>>>>
>>>>> +- uhs-sdr12: the host supports UHS SDR12 mode
>>>>> +- uhs-sdr25: the host supports UHS SDR25 mode
>>>>> +- uhs-sdr50: the host supports UHS SDR50 mode
>>>>> +- uhs-sdr104: the host supports UHS SDR104 mode
>>>>> +- uhs-ddr50: the host supports UHS DDR50 mode
>>>>> +- ddr-1v2: the host can support DDR, using 1.2V VccQ
>>>>> +- ddr-1v8: the host can support DDR, using 1.8V VccQ
>>>>
>>>> Surely the driver for the host controller already knows this, so there's
>>>> no need to represent it in DT?
>>>
>>> Not necessarily. One driver can handle several versions of the same chip, 
>>> and some versions of the chip implement some of those features, others 
>>> don't.
>>
>> Certainly.
>>
>>> So, your choice is really whether to specify a chip version in the
>>> compatible string or these properties.
>>
>> There's no choice there. The compatible property needs to specify all of
>> the following:
>>
>> * A value which describes the exact chip the IP block is in. This can be
>> matched on to enable any quirks that need to be handled due to
>> integration of the IP into the particular chip. This value will list the
>> chip version. An example might be tegra20-sdhci.
>>
>> * A value which describes the IP block version (if that IP block has a
>> version independent of the SoC that contains it, as e.g. a Synopsis IP
>> block might). A totally made-up example might be synopsis-dwc2-1.0.0
>>
>> * Various more generic values that describe the HW, and that define a n
>> interface to the HW that is specific and complete enough that HW can
>> program to. An example might be usb-ehci (assuming a chip that doesn't
>> have so many quirks that a driver has to know more than just "it's an
>> EHCI controller).
> 
> Yes, all these certainly make sense. As far as I understand, we are still 
> in the process of defining good clear rules for DTs, there is an "ABI" 
> discussion currently running on ALKML and IIRC this is also going to be a 
> topic for one of coming conferences. So, hopefully we're approaching a 
> state of a greater clarity about DT.

I don't think the rules for the compatible property are up in the air;
they've been pretty well communicated since at least the start of my
involvement in DT perhaps 2 years ago.

>> Further classes of compatible value might exist, but you get the idea.
>>
>> All of those values have to exist in the DT right from the very start,
>> so that the first DT is usable with a future kernel, which might decide
>> to vary the exact compatible value(s) it matches on, provided they're
>> all documented in the DT binding ABI, in order to enable/disable new
>> sets of quirsk.
> 
> Makes sense too, sure.
> 
>>> Now, when you consider that
>>> multiple drivers have to decide upon those, and sometimes you don't have 
>>> an exact IP version of the SD/MMC controller but only the SoC version, you 
>>> choice becomes: 
>>
>> That would be a bug in the DT, given my assertions above.
> 
> Sorry, what exactly would be a bug? Not having an exact IP version?

Yes.

> But 
> you did write above - "if that IP block has a version independent of the 
> SoC that contains it." In my case it doesn't really. Those IPs only exist 
> within those SoCs.

I think this has been well covered in the rest of the thread, but if the
IP block doesn't have a version independent from the SoC itself (because
the SoC is developed as a whole, rather than being pieced together out
of a pool of IP blocks for example), then the IP block's version *is*
the SoC version. In my list of "sources" of compatible values above,
it's possible that the values for multiple of those bullet points end up
being the same.

>> Related, is it really true that zero driver involvement is required to
>> enable these UHS features?
> 
> I think it is, in most cases at least.
> 
>> If absolutely any HW can enable them without
>> any driver support at all, then perhaps it's still reasonable to create
>> DT properties to enable them. However, if driver support is required to
>> make those features actually work, the driver had better be validating
>> that support actually works on the HW it's running on before enabling
>> the feature (and can therefore pass the validation results to the SD
>> core rather than relying on DT properties to be set).
> 
> I think it rather works the other way round. Those flags only mark 
> hardware _capabilities_.

Which HW though?

Presumably eMMC/SD-card capabilities are reported by the card through
the various ID commands.

HW/driver capabilities would be reported by the driver itself. I still
don't buy the argument that no driver support is required, since
historically the different speed modes on MMC have required different
clock rates to the HW, different clock divider rounding/selection
schemes, different bug workarounds, etc.

Board capabilities (i.e. was the board routed with the right trace
impedance/... to support the UHS features, rather than something slower
because the designer didn't care about the UHS features and they're more
expensive) seem fine to go in DT.

> But don't tell the driver to use them yet.
> Normally drivers just collect them in their .caps and .caps2 fields and 
> pass on to the mmc core.

So you would expect individual drivers to parse these (perhaps using
common code) and filter the values depending on their capabilities? If
so, why not just have the drivers set the values up themselves. Why is
there a need to represent the data in DT?

