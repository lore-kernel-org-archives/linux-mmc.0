From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: + mmc-add-dma-support-to-tmio_mmc-driver-when-used-on-superh.patch
	added to -mm tree
Date: Thu, 13 May 2010 22:46:31 +0100
Message-ID: <AANLkTikV-qMrdJq9hbdeRnqjZf811lY6eAHPP7rRV2qf@mail.gmail.com>
References: <201005122255.o4CMtmvN025653@imap1.linux-foundation.org>
	<AANLkTim5U-JbrVCBKHnERgHol2GcwTfweQyI4onR1Skh@mail.gmail.com>
	<Pine.LNX.4.64.1005131357500.4671@axis700.grange> <AANLkTinPW2W6aV1smLsQObLOAS3bECDZ7mhSGCm2aqgO@mail.gmail.com>
	<Pine.LNX.4.64.1005131415460.4671@axis700.grange> <AANLkTik4gzuZvrAwbK-dyCXVYf5gLD0RGrpvM55YLzOK@mail.gmail.com>
	<Pine.LNX.4.64.1005131511540.4671@axis700.grange> <Pine.LNX.4.64.1005131616230.4671@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005131616230.4671@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, mm-commits@vger.kernel.org, dan.j.williams@intel.com, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Russell King <rmk@arm.linux.org.uk>, sameo@linux.intel.com, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Sounds good to me, and you're right - the MFD level is good for this
config option.

-- 
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/



On 13 May 2010 15:18, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> On Thu, 13 May 2010, Guennadi Liakhovetski wrote:
>
>> On Thu, 13 May 2010, Ian Molton wrote:
>>
>> > Might be worth exposing for now, whilst the feature is new. but yes,
>> > automatic select yes on all the platforms you are comfortable with.
>> >
>> > Im not sure if it should be per MFD or per platform. I tend to think
>> > the latter, given that its slave DMA and thus I could have the same
>> > MFD in platforms with different CPUs (eg. e740 and e800) where a CPU
>> > bug might upset one but not the other.
>>
>> So far I went for the least effort - not exposed, selected by MFDs. If we
>> ever have a need to change this, e.g., make it user-selectable or per
>> platform, we can always do so later. For now all SuperH / SH-Mobile
>> platforms I tested can use this driver with DMA. Expect updated patches
>> shortly.
>
> One more thing I forgot to mention - even if your MFD enables DMA, it
> still can further decide when (on which platforms) to enable and when to
> disable DMA by providing or not providing DMA slave configuration to
> tmio_mmc.
>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
>
