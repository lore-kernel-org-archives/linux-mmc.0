From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 1/2] mmc: add Device Tree properties for UHS modes
Date: Mon, 29 Jul 2013 08:39:29 -0500
Message-ID: <51F67091.70502@gmail.com>
References: <Pine.LNX.4.64.1307261747210.22137@axis700.grange> <51F2ADA2.2030503@wwwdotorg.org> <Pine.LNX.4.64.1307262215110.27439@axis700.grange> <51F2EBD4.1060603@wwwdotorg.org> <Pine.LNX.4.64.1307290753090.14405@axis700.grange> <Pine.LNX.4.64.1307290903360.14405@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:56522 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab3G2Nje (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Jul 2013 09:39:34 -0400
In-Reply-To: <Pine.LNX.4.64.1307290903360.14405@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>

On 07/29/2013 02:18 AM, Guennadi Liakhovetski wrote:
> On Mon, 29 Jul 2013, Guennadi Liakhovetski wrote:
> 
>> Hi Stephen
>>
>> On Fri, 26 Jul 2013, Stephen Warren wrote:
>>
>>> On 07/26/2013 02:23 PM, Guennadi Liakhovetski wrote:
>>>> Hi Stephen
>>>>
>>>> On Fri, 26 Jul 2013, Stephen Warren wrote:
>>>>
>>>>> On 07/26/2013 09:51 AM, Guennadi Liakhovetski wrote:
>>>>>> Add DT properties for UHS SDR12, SDR25, SDR50, SDR104 and DDR50 modes and
>>>>>> for supported by the host in DDR mode VccQ values. Adding them to DT will
>>>>>> automatically enable respective MMC host capabilities.
>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
>>>>>
>>>>>> +- uhs-sdr12: the host supports UHS SDR12 mode
>>>>>> +- uhs-sdr25: the host supports UHS SDR25 mode
>>>>>> +- uhs-sdr50: the host supports UHS SDR50 mode
>>>>>> +- uhs-sdr104: the host supports UHS SDR104 mode
>>>>>> +- uhs-ddr50: the host supports UHS DDR50 mode
>>>>>> +- ddr-1v2: the host can support DDR, using 1.2V VccQ
>>>>>> +- ddr-1v8: the host can support DDR, using 1.8V VccQ
>>>>>
>>>>> Surely the driver for the host controller already knows this, so there's
>>>>> no need to represent it in DT?
>>>>
>>>> Not necessarily. One driver can handle several versions of the same chip, 
>>>> and some versions of the chip implement some of those features, others 
>>>> don't.
>>>
>>> Certainly.
>>>
>>>> So, your choice is really whether to specify a chip version in the
>>>> compatible string or these properties.
>>>
>>> There's no choice there. The compatible property needs to specify all of
>>> the following:
>>>
>>> * A value which describes the exact chip the IP block is in. This can be
>>> matched on to enable any quirks that need to be handled due to
>>> integration of the IP into the particular chip. This value will list the
>>> chip version. An example might be tegra20-sdhci.
>>>
>>> * A value which describes the IP block version (if that IP block has a
>>> version independent of the SoC that contains it, as e.g. a Synopsis IP
>>> block might). A totally made-up example might be synopsis-dwc2-1.0.0
>>>
>>> * Various more generic values that describe the HW, and that define a n
>>> interface to the HW that is specific and complete enough that HW can
>>> program to. An example might be usb-ehci (assuming a chip that doesn't
>>> have so many quirks that a driver has to know more than just "it's an
>>> EHCI controller).
>>
>> Yes, all these certainly make sense. As far as I understand, we are still 
>> in the process of defining good clear rules for DTs, there is an "ABI" 
>> discussion currently running on ALKML and IIRC this is also going to be a 
>> topic for one of coming conferences. So, hopefully we're approaching a 
>> state of a greater clarity about DT.
> 
> A short addendum. At least with Renesas SoCs I see the situation in the 
> following way: new SoC versions appear relatively frequently. They often 
> re-use multiple IP blocks, drivers for which are scattered across the 
> entire kernel. Often the difference between an IP block on SoC A and A+1 
> can be expressed by some integers, e.g. maximum size of addressable 
> memory. Some other differences might never get supported by the driver. 
> And only occasionally the new IP would get a feature, support for which is 
> added to the driver and really modifies its behaviour. With platform data 
> therefore you either get very similar or identical configurations, maybe 
> some .max_frame_size will change, but the driver won't change anyway, and 
> only in some rare cases the driver really needs to be changed. With 
> compatibility strings we have to change _all_ Renesas drivers for _each_ 
> SoC version even if just to add a new struct of_device_id entry. This 
> doesn't seem very productive to me.

If there is no change in the IP, then you can continue to use the
previous compatible string in your binding for the new SoC. The kernel
only has to be updated when there is a new feature, bug or other change.

Rob
