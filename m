From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: eMMC tuning issue on Odroid C2 and a possible solution
Date: Thu, 12 Oct 2017 21:49:02 +0200
Message-ID: <fa52e311-bafe-0a6a-1b85-ac8f40db62ed@gmail.com>
References: <b931985f-16b2-0a90-e73b-b6c349ad7d6c@gmail.com>
 <1507821759.16356.225.camel@baylibre.com>
 <aa13028e-b42a-094f-7bd1-ef22e8cdacbd@gmail.com>
 <1507836874.16356.258.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:51829 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754604AbdJLTtK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Oct 2017 15:49:10 -0400
Received: by mail-wm0-f44.google.com with SMTP id f4so16246943wme.0
        for <linux-mmc@vger.kernel.org>; Thu, 12 Oct 2017 12:49:09 -0700 (PDT)
In-Reply-To: <1507836874.16356.258.camel@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, Kevin Hilman <khilman@baylibre.com>

Am 12.10.2017 um 21:34 schrieb Jerome Brunet:
> On Thu, 2017-10-12 at 20:17 +0200, Heiner Kallweit wrote:
>>> You did not mention it in this mail, but I going to guess this is done,
>>> again,
>>> in hs400 ...
>>>
>>
>> Sorry. I use the default, hs200 with 200MHz.
>>
> 
> Please state this clearly next time. This seems to change with each of your
> issue report, I'm done guessing.
> 
> [...]
> 
>>> As far as I can tell, your eMMC card + your odroidc2 is simply not able to
>>> cope
>>> (reliably) with 166Mhz. The fact that you continue to have CRC errors with
>>> your
>>> "hand picked phases" is an evidence of this fact.
>>>
>>
>> When setting the default tx phase to 0 I have a rock-stable system w/o any CRC
>> error (hs200 with DT 200MHz).
> 
> Getting CRC Errors is not my definition of "rock stable"
> 
When changing the initial tx phase to 0 I have no CRC errors at all with
hs200@200.
hs200@200 fails with initial tx phase = 270, just with my patch I get one
CRC error and after retuning system works w/oo further CRC errors.

With initial tx phase = 0 hs400@142 fails whilst hs400@125 works w/o CRC errors
and gives me 177 MB/s result when doing
dd if=/dev/mmcblk0 of=/dev/null iflag=direct bs=1G count=1

>>
>> When leaving the default tx phase at 270, after tuning I end up with rx phase
>> 90 and tx phase 300. This combination works perfect when tuning but fails
>> in real life.
>>
> 
> Ok, starting from Rx:0 Tx:270 then tuning gives you Tx:300 Rx:90
> And what different did it gives you starting Rx:0/Tx:0 ?
> 
> The result of the tuning does not depends on starting point, so I don't really
> understand how it would significantly change things.
> 
I think it depends on the tx phase starting point.

Tuning does:
rx phase tuning
tx phase tuning
rx phase tuning

Result of each step depends on result of previous step. So also the initial
rx phase tuning result depends on the starting point of tx phase.

> There is nothing vastly innovative in this driver. There is at least 2 other
> drivers upstream which use the same kind of algorithm to perform the tuning.
> I've tested it on the vast majority of amlogic supported platforms, including
> yours.
> 
> Yes, I don't have your particular eMMC chip but I gave you my understanding of
> the situation based on my experience : If the tuning succeed but you then get
> CRC, it means that signal (quality) is not good enough.
> 
> If you think it is something else, I'm happy to review your changes but you need
> to provide a better explanation than "Don't ask me how this can happen, I just
> see it happen." ... because I will ask !
> 
>> I saw in the chip spec that there are few emmc-related calibration values in
>> SD_EMMC_ADJUST 
> 
> Adjust is just another fancy way to change clock phase based on the input clock
> resampling. When the rate increase the precision of this method decrease (with
> the divisor value). I tried it, it is not useful.
> 
>> and SD_EMMC_CALOUT. However there's no documentation how to
>> use them. Looking at the vendor driver might help, though.
> 
> The vendor kernel around this calibration is very complex. It is used to set per
> line delays to adjust for track length differences. Given that I tested the
> odroidc2 with both hs200 and hs400 w/o this, I doubt it will change anything for
> you
> 
>> Did you have a closer look at these values ?
> 
> 

