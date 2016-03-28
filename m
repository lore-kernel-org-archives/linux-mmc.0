From: Rob Herring <robh+dt@kernel.org>
Subject: Re: ARC dw-mshc binding compat string
Date: Mon, 28 Mar 2016 14:00:55 -0500
Message-ID: <CAL_JsqL1asMFVFX_p3P+ov_+9prmcQ0PZJOiAX7D5iJ7GEssgQ@mail.gmail.com>
References: <56F66121.8050507@denx.de> <56F6C639.5000301@mentor.com>
 <56F6C71B.6070002@denx.de> <56F6CC68.5040408@mentor.com> <56F6D083.1020402@denx.de>
 <56F6D1E9.3050606@mentor.com> <56F6E860.8070207@denx.de> <56F6ED41.5020908@mentor.com>
 <56F6EFFD.9070007@denx.de> <1459157818.4785.5.camel@synopsys.com>
 <56F908A1.3070701@samsung.com> <56F9287F.1020707@denx.de> <56F958DC.5010203@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56F958DC.5010203@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Marek Vasut <marex@denx.de>, Jaehoon Chung <jh80.chung@samsung.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Mar 28, 2016 at 11:16 AM, Vladimir Zapolskiy
<vladimir_zapolskiy@mentor.com> wrote:
> Hi,
>
> On 28.03.2016 15:50, Marek Vasut wrote:
>> On 03/28/2016 12:34 PM, Jaehoon Chung wrote:
>>> Hi,
>>
>> Hi,
>>
>> [...]
>>
>>>>>>>>>> That said, I would rather prefer to see "snps,dw-mshc" prefix on description
>>>>>>>>>> of an MMC controller found on SoCFPGA series, "altr,socfpga-dw-mshc" seems
>>>>>>>>>> to be redundant.
>>>
>>> Yes..it's redundant..i should be combined to "snps,dw-mshc".
>>
>> Should the compat string be
>>   compatible = "altr,socfpga-dw-mshc", "snps,dw-mshc";
>> or just
>>   compatible = "snps,dw-mshc";
>> ?
>>
>> I am under the impression that a soc-specific identifier in addition to
>> a generic one (used by the driver compat table) is a good idea, because
>> it can help discerning the IP block from a generic one if needed at some
>> future point in time. It will also not break the DT for systems
>> which may depend on the non-generic compat, like *BSDs and such.
>>
>> What do you think ? (btw this is very much my question in this thread)
>
> IMO just 'compatible = "snps,dw-mshc"' is good enough, if it completely
> describes the IP block on SoCFGPA --- and from what I get it is the case.
> You can add a SoC-specific compatible if it is needed later on, and to my
> taste only if SoC specific features can not be covered by properties.

You can add the SoC-specific compatible string to the kernel later on.
You may not be able to update your DTB later on. So the specific
compatible strings need to be in the DT from the start.

There's no set rule on properties vs. implied by a compatible string,
but generally if it is fixed in the SoC, get the information based on
the compatible string. If it is a board level decision or has to be
tuned, then use a property.

> The same sole "snps,dw-mshc" compatible is specified for NXP LPC18xx/43xx,
> ZTE ZX and HiSilicon ARM SoCs.

They should be fixed.

> Another similar example is ARM PrimeCell PLxxx IP blocks, as far as
> I know there is no SoC-specific compatibles/aliases for PrimeCell IP blocks.

There are some for ST variants I think. PrimeCell blocks are a bit
different in that they generally pretty simple blocks, have not
changed much, and they
have a standard ID register that has been sufficient for determining
differences. And we have a standard way to override the ID register
when it is wrong. Look at recent patches for Denali NAND controller if
you want an example of why IP version registers (or compatible
strings) can't be trusted.

Once you get into IP blocks with lots of configuration options,
complicated clocking, power domains, and with phys on the front end,
then you hit all the integration differences.

Rob
