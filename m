From: Chris Ball <cjb@laptop.org>
Subject: Re: mmc: dw_mmc: miscaculated the fifo-depth with wrong bit operation
Date: Wed, 11 Jan 2012 14:14:37 -0500
Message-ID: <m28vlef3vm.fsf@bob.laptop.org>
References: <4F0A3DA4.8010909@samsung.com> <4F0AB63B.4030202@imgtec.com>
	<4F0D5635.50201@imgtec.com> <4F0D5D6A.9040200@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56665 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932901Ab2AKTOw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 Jan 2012 14:14:52 -0500
In-Reply-To: <4F0D5D6A.9040200@samsung.com> (Jaehoon Chung's message of "Wed,
	11 Jan 2012 18:59:06 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: James Hogan <james.hogan@imgtec.com>, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>

Hi,

On Wed, Jan 11 2012, Jaehoon Chung wrote:
> Hi James,
>
> Thank you..:)
>
> Best Regards,
> Jaehoon Chung
>
> On 01/11/2012 06:28 PM, James Hogan wrote:
>
>> On 09/01/12 09:41, James Hogan wrote:
>>> On 01/09/2012 01:06 AM, Jaehoon Chung wrote:
>>>> In FIFOTH register, can find "bit[27:16] = FIFO_DEPTH - 1".
>>>> Finally, FIFO_DEPTH = bit[27:16] + 1.
>>>>
>>>> Now, Used the 0x7ff. but 0xfff is right.
>>>
>>> Nice catch. The patch itself looks okay, but I don't think the commit
>>> message is very understandable, maybe something like this would be better?:
>>>
>>> In FIFOTH register, the RX_WMark field (bits[27:16]) defaults to
>>> FIFO_DEPTH - 1. When reading it, bits[26:16] were being used, so fix it
>>> to use the mask 0xfff instead of 0x7ff.
>>>
>>> Cheers
>>> James
>> 
>> Are you happy having your signed-off-by against this identical patch with
>> a modified message Jaehoon?
>> 
>> From: Jaehoon Chung <jh80.chung@samsung.com>
>> 
>> In FIFOTH register, the RX_WMark field (bits[27:16]) defaults to
>> FIFO_DEPTH - 1. When reading it, bits[26:16] were being used, so fix it
>> to use the mask 0xfff instead of 0x7ff.
>> 
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Reviewed-by: James Hogan <james.hogan@imgtec.com>

Thanks, merged to mmc-next for 3.3.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
