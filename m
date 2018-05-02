From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/3] arm64: allwinner: h6: enable MMC0/2 on
 Pine H64
Date: Wed, 2 May 2018 12:01:53 +0100
Message-ID: <aa2d6072-87a5-cd52-d3a5-17df889e6bc9@arm.com>
References: <20180426140728.43155-1-icenowy@aosc.io>
 <20180426140728.43155-4-icenowy@aosc.io>
 <03cc2e8c-4a35-3fb4-b408-fd8d4ba3e407@arm.com>
 <83EDF187-5EB2-4FEB-99BC-9D5B728D3A45@aosc.io>
 <45956397-a593-e51e-8637-655178c5901c@arm.com>
 <20180502093601.fvkacdv62aqxshbr@flea>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDNZNK75ZIKRBM5VU3LQKGQE32RYLDI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20180502093601.fvkacdv62aqxshbr@flea>
Content-Language: en-GB
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 02/05/18 10:36, Maxime Ripard wrote:
> On Mon, Apr 30, 2018 at 10:47:35AM +0100, Andre Przywara wrote:
>>>> I am just asking because I want to avoid running into the same problem
>>>> as with the A64 before: that future DTs become incompatible with older
>>>> kernels, because we change the power supply to point to the AXP
>>>> regulators, which this kernel does not support yet.
>>>
>>> The answer is just not to keep this compatibility, as it's not
>>> supported option to update DT without updating kernel.
>>
>> Well, I recognise that statement.. ;-) and I understand that it's far
>> easier to handle it this way. But:
>> - Which .dtb are we going to write into the SPI flash? An older one,
>> which covers all kernels, but lacks features? Or a newer one, which
>> limits the bootable kernels to recent versions?
>> - Which DT are we going to give to EFI applications?
>> - Which DT are the BSDs suspected to take? They don't ship their own DTs
>> (which is good!).
>>
>> So I understand that "shipping the DT with the kernel" is the old
>> (embedded!) way of doing things, but I really believe we should stop
>> relying on this and try to come up with backwards compatible DTs, which
>> live in the firmware and get updated there. Because this is what the
>> distros seem to expect from ARM64 boards these days.
> 
> You're not talking about backward compatibility, you're talking about
> forward compatibility. All the changes in this patch and the one
> predicted by Icenowy are backward compatible.

Argh, yes, I meant forward compatibility, sorry!
Shouldn't write those emails while actually doing something completely
different ;-)

>>>> It looks like there are more users of those power rails, so we could
>>>> keep those supplies connected to these fixed regulators here, even with
>>>> AXP-805 support in the kernel.
>>>
>>> It's not a good choice.
>>>
>>>>
>>>> Or we keep this back until we get proper AXP support in the kernel? I
>>>> guess it's quite close to the existing PMICs, so it might be more a
>>>> copy&paste exercise to support the AXP-805?
>>>
>>> It's not a reason to keep it back.
>>
>> So I compared the manuals of the AXP806 and the AXP805, the register
>> interface looks identical to me. I only have a (somewhat) Chinese
>> version of the AXP806 manual, so couldn't really find the difference
>> between the two. Do you know more about it? Is it just maybe the
>> packaging and the electrical properties (like max current supported)?
>>
>> If the I2C register interface is really the same, we could just add the
>> DT nodes for the regulator and be done.
> 
> And that argument is only valid if you 100% trust the fact that both
> datasheet are complete and accurate.
> 
> And experience show that you can't.

Well, but I wonder how paranoid we are going to be? And in this case we
have confirmation from Wink that they are the same.
So I think we can go with just a DT addition, given that we test it and
confirm that it works for our use case. Should we discover something odd
or undocumented later, I'd consider this a bug fix, which we then (and
only then!) could fix by adding the compatible string to the driver. Any
DT would be fine already, because we list both compatible strings in there.

Cheers,
Andre.
