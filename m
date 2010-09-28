From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH] mmc: failure of block read wait for long time
Date: Tue, 28 Sep 2010 21:32:36 +0300
Message-ID: <4CA234C4.8070907@nokia.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0315F026F6@dbde02.ent.ti.com> <4C8A2C5D.2050408@nokia.com> <2A3DCF3DA181AD40BDE86A3150B27B6B0315F0318B@dbde02.ent.ti.com> <4C971320.7050906@nokia.com> <2A3DCF3DA181AD40BDE86A3150B27B6B03160624F6@dbde02.ent.ti.com> <4C974A5D.5050608@nokia.com> <2A3DCF3DA181AD40BDE86A3150B27B6B03160626B5@dbde02.ent.ti.com> <4C975CFB.6070907@nokia.com> <20100920133703.GC30793@n2100.arm.linux.org.uk> <2A3DCF3DA181AD40BDE86A3150B27B6B031610E332@dbde02.ent.ti.com> <20100922124309.GA15699@void.printf.net> <2A3DCF3DA181AD40BDE86A3150B27B6B03560991F7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56543 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757448Ab0I1SdU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 14:33:20 -0400
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B03560991F7@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On 28/09/10 18:03, Ghorai, Sukumar wrote:
> Chris and Adrian,
>
> [..snip..]
>>
>> Chris and Adrian,
>>
>> [..snip..]
>>>
>>>> -----Original Message-----
> [..snip..]
>>>> Subject: Re: [PATCH] mmc: failure of block read wait for long time
>>>>
>>>> On Wed, Sep 22, 2010 at 11:02:08AM +0530, Ghorai, Sukumar wrote:
>>>>> Would you please review and merge this patch [1] (attached too)?
>>>>> [1] http://comments.gmane.org/gmane.linux.kernel.mmc/2714
>>>>
>>>> I've been following the thread.  I believe Adrian has NACKed this
>> patch,
>>>> by saying "It is absolutely unacceptable to return I/O errors to the
>>>> upper layers for segments that do not have errors."
>>>
>>> [Ghorai]
>>> I think Russell also mentioned his opinion. Would you please add your
>> idea
>>> too?
>>>
>>> 1. I would prefer Adrian to explain again what this statement means, in
>>> the context - data read fail and how we make it success?

Because I/O requests are made up of segments and every segment can be a
success or failure.

>>>
>>> 2. if data read fail for sector(x) why we have to try for
>>> sector(x+1, ..x+n)?

See answer to q. 1

>>>
>>> 3. how to inform reader function which sector having the valid data out
>> of
>>> (1...n) sectors.

__blk_end_request() does that

>>>
>>> 4. do we have any driver/code in Linux or any other os, which give
>> inter-
>>> leave data and return as success?

Here is the problem with that question.  The *same* I/O request
can have data for *different*sources.

>>>
>> [Ghorai] please reply with your input on my/ Russell's suggestion?
> [Ghorai] any input?

I have a question for you.  What use cases do you want to address
  - other than card removal?

>>
>>>>
>>>> I think it's possible to merge patches to improve the situation (such
>>>> as the idea of noticing a card disappearing earlier), but your initial
>>>> patch is not the patch to do that.  You should continue to work with
>>>> Adrian -- when he's happy that a patch does not break the semantics
>>>> above, we can consider merging it.
>>>>
>>>> Thanks,
>>>>
>>>> --
>>>> Chris Ball<cjb@laptop.org>    <http://printf.net/>
>>>> One Laptop Per Child
>

