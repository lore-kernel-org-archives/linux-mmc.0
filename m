From: J Freyensee <james_p_freyensee@linux.intel.com>
Subject: Re: Testing Infrastructure for SD/MMC Commands
Date: Tue, 16 Aug 2011 09:03:56 -0700
Message-ID: <4E4A94EC.7040606@linux.intel.com>
References: <CANYdXnoZK3OoWOnJhyq645GofnsXuk7tJm09Wv8=Y+gLujPSkQ@mail.gmail.com> <CANYdXnrHWGPCeAEJQq6cmsZAyYfvvcSZ_1_3jKhcMbTARJpGVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38774 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752012Ab1HPQCx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 16 Aug 2011 12:02:53 -0400
In-Reply-To: <CANYdXnrHWGPCeAEJQq6cmsZAyYfvvcSZ_1_3jKhcMbTARJpGVw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: cjb@laptop.org, Will Newton <will.newton@gmail.com>, Jae hoon Chung <jh80.chung@gmail.com>, James Hogan <james.hogan@imgtec.com>, kyungmin.park@samsung.com, linux-mmc@vger.kernel.org

On 08/16/2011 02:26 AM, Shashidhar Hiremath wrote:
> adding mmc mailing list
>
> On Tue, Aug 16, 2011 at 11:12 AM, Shashidhar Hiremath
> <shashidharh@vayavyalabs.com>  wrote:
>> Hi All,
>>   i am planning to come up with a module that would help for testing
>> the SD/MMC controller to see if supports the particular command.
>>
>> For example ,Through this module , we will be able to see if a
>> particular command has been accepted by the device and whether device
>> has responded in the expected manner or not by checking its response.
>>
>> Can I get some points on how useful this infrastructure would be ,and
>> any inputs on what else  to cover under this ?
>>
>

It sounds like you are looking to design a functional model, a module 
that utilizes some type of design spec or standard to verify if the 
design implementation works according to the design-spec/standard, correct?

If true, my first question would be, what document will you be basing 
this module on?

It probably could be useful- the more testing on something the better. 
But I think the first step is you need to define what 
document/spec/standard this module is going to follow, then how this 
module is going to be designed and used, then go from there.

>
>


-- 
J (James/Jay) Freyensee
Storage Technology Group
Intel Corporation
