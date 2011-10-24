From: J Freyensee <james_p_freyensee@linux.intel.com>
Subject: Re: A question on IOCTL interface for MMC
Date: Mon, 24 Oct 2011 11:28:52 -0700
Message-ID: <4EA5AE64.2030106@linux.intel.com>
References: <CANYdXnqDYn5-zehsJ9ibviJ7FoofcY=YLUqrROoK8k53v-czNA@mail.gmail.com> <5263525.D4yqBTjgWh@wuerfel> <CANYdXnoS31GLnbFcwj76SUoyVhcti8Q-4_5fmyRy3DUJGbSRjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:62728 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108Ab1JXS3Q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 24 Oct 2011 14:29:16 -0400
In-Reply-To: <CANYdXnoS31GLnbFcwj76SUoyVhcti8Q-4_5fmyRy3DUJGbSRjg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org

On 10/24/2011 05:32 AM, Shashidhar Hiremath wrote:
> Hi Arnd,
>    As explained in previous mail, the IOCTL is actually an inteface to
> block layer and it is only expecting read/write commands to be sent
> through the interface.The prrof of it can be seen in write_flag
> present in the IOCTL structure which indicates the either the command
> can be read or a write command.
>
> So, can I submit a linux module to the kernel which uses the same
> mmc_ioc_cmd structure and do all the required processing in my module.
>
> To be clear on my requirement:
> it is  To test ALL SD/MMC Commands and NOT just the  Read/Write Commands.
> or should I extend the mmc_test module present in kernel to support
> testing of individual commands as well ?

I would think the mmc_test module would be a good vehicle to extend to 
have it test individual commands.

Of course if there is no documentation or HOWTO use mmc_test module to 
test an individual MMC command then the work is kind-of for naught.

> Can I get some suggestions on what approach to take ?
>
>
> On Thu, Oct 20, 2011 at 12:48 PM, Arnd Bergmann<arnd@arndb.de>  wrote:
>>
>> On Thursday 20 October 2011 10:39:00 Shashidhar Hiremath wrote:
>>>    I am planning to use the existing IOCTL interface for SD/MMC present
>>> in the kernel.
>>>    Since, the IOCTL interface expects a read/write flag , and the MMC
>>> IOCTL is actually an interface to block layer I feel without modifying
>>> the block layer for the support of non-read write commands ,I may not
>>> be able to test the non-read/write commands through the IOCTL
>>> interface .
>>> Is there a way of doing this without modifying block layer ?
>>
>> Hi Shashidhar,
>>
>> I think there is actually no problem here at all. The block layer simply
>> passes the ioctl command number and argument to the driver, which can
>> do anything with it.
>>
>> What functionality are you actually looking for?
>>
>>         Arnd
>
>
>
> --
> regards,
> Shashidhar Hiremath
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
J (James/Jay) Freyensee
Storage Technology Group
Intel Corporation
