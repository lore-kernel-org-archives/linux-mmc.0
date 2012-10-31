From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH V3] mmc: omap_hsmmc: Enable HSPE bit for high speed cards
Date: Thu, 1 Nov 2012 01:21:36 +0530
Message-ID: <CAOyx1LrKBE+xzSRN4F=+e1DuMJL+5SAv-YkJWJdDw8p=kDojmw@mail.gmail.com>
References: <1351684656-30275-1-git-send-email-gururaja.hebbar@ti.com>
	<20121031122639.GA10998@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:33887 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760350Ab2JaTvi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Oct 2012 15:51:38 -0400
In-Reply-To: <20121031122639.GA10998@arwen.pp.htv.fi>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: balbi@ti.com
Cc: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, cjb@laptop.org, balajitk@ti.com, grant.likely@secretlab.ca, nsekhar@ti.com, sudhakar.raj@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com, rob@landley.net, tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org

On Wed, Oct 31, 2012 at 5:56 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Wed, Oct 31, 2012 at 05:27:36PM +0530, Hebbar, Gururaja wrote:
>> HSMMC IP on AM33xx need a special setting to handle High-speed cards.
>> Other platforms like TI81xx, OMAP4 may need this as-well. This depends
>> on the HSMMC IP timing closure done for the high speed cards.
>>
>> From AM335x TRM (SPRUH73F - 18.3.12 Output Signals Generation)
>>
>> The MMC/SD/SDIO output signals can be driven on either falling edge or
>> rising edge depending on the SD_HCTL[2] HSPE bit. This feature allows
>> to reach better timing performance, and thus to increase data transfer
>> frequency.
>>
>> There are few pre-requisites for enabling the HSPE bit
>> - Controller should support High-Speed-Enable Bit and
>> - Controller should not be using DDR Mode and
>> - Controller should advertise that it supports High Speed in
>>   capabilities register and
>> - MMC/SD clock coming out of controller > 25MHz
>>
>> Note:
>> The implementation reuses the output of calc_divisor() so as to reduce
>> code addition.
>>
>> Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
>
> this looks good to my eyes, hopefully I haven't missed anything:
>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
>

Except for the excessively verbose comments which are just duplicating the code,
<Quote>
>> +      * Enable High-Speed Support
>> +      * Pre-Requisites
>> +      *      - Controller should support High-Speed-Enable Bit
>> +      *      - Controller should not be using DDR Mode
>> +      *      - Controller should advertise that it supports High Speed
>> +      *        in capabilities register
>> +      *      - MMC/SD clock coming out of controller > 25MHz
>> +      */
</Quote>

I'm ok with this patch as well. I'm putting a few patches under test
including this one,
and will send it to Chris as part of that series.
I'll strip out the above mentioned comments, unless there are any objections.

Thanks,
Venkat.
