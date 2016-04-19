From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [RESEND PATCH v7 1/2] mmc: OCTEON: Add DT bindings for OCTEON
 MMC controller
Date: Tue, 19 Apr 2016 13:25:13 -0700
Message-ID: <57169429.10601@caviumnetworks.com>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com> <CAPDyKFpZqiv7iVbunr+mrLyxLx=V-NVSnDpvbMaaekxn7FdKrQ@mail.gmail.com> <9FCBB1D1936B2F4DB2DD02BA3957FB504A067CE2@LEMAIL01.le.imgtec.org> <CAPDyKFo+=U978UfjP+zLfAyYm2JptWu77shR8v1z-sD+d9KDOw@mail.gmail.com> <9FCBB1D1936B2F4DB2DD02BA3957FB504A067E8D@LEMAIL01.le.imgtec.org> <CAPDyKFpw+_Lfk0d5tgZ1iQ9suvrx76foX-hpu503K55buGoiKg@mail.gmail.com> <9FCBB1D1936B2F4DB2DD02BA3957FB504A0680EA@LEMAIL01.le.imgtec.org> <CAPDyKFpYfDeT5LDfEMXxgZiHmnNx7Aau+m7Dq=+Sj+4ntrtfDw@mail.gmail.com> <5716592A.6000505@caviumnetworks.com> <CAPDyKFqM3VxYE+KtC++=5=Bjket0mCnLAuN3_436O_=TSMzAHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0066.outbound.protection.outlook.com ([157.56.111.66]:11215
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933690AbcDSUlT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 19 Apr 2016 16:41:19 -0400
In-Reply-To: <CAPDyKFqM3VxYE+KtC++=5=Bjket0mCnLAuN3_436O_=TSMzAHA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matt Redfearn <Matt.Redfearn@imgtec.com>, David Daney <david.daney@cavium.com>, linux-mmc <linux-mmc@vger.kernel.org>, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>, Rob Herring <robh+dt@kernel.org>, Ralf Baechle <ralf@linux-mips.org>

On 04/19/2016 12:33 PM, Ulf Hansson wrote:
> On 19 April 2016 at 18:13, David Daney <ddaney@caviumnetworks.com> wrote:
>> On 04/19/2016 02:15 AM, Ulf Hansson wrote:
>> [...]
>>>
>>>
>>>   From this discussion I have understood that we clearly need a way to
>>> describe mmc slots in DT!
>>>
>>> Unfortunate we should have discussed this before you decided to ship
>>> devices with DTBs containing non accepted DT bindings, but hey better
>>> late than never! :-)
>>
>>
>> This is a point where the DT and mmc maintainers have a continual
>> misunderstanding of the facts.
>>
>> There were requests to discuss the binding as far back as 2012:
>>
>> https://www.linux-mips.org/archives/linux-mips/2012-05/msg00119.html
>>
>> They were met with silence.
>
> I am aware of that. I was not the maintainer of MMC back then, if I
> where I would probably said the same thing as of today.
>
> Moreover, for sure you could have been more persistent trying to get
> peoples attention before you decided to deploy the DTB.

We cannot change the past.  Our only concern should be to develop the 
simplest and cleanest overall implementation possible given the facts as 
they exist today.

>
>>
>> The firmware containing these bindings is out in the wild.  If we deprecate
>> some of the bindings, the driver will still have to support them in the
>> future.
>>
>> In the case of OCTEON based devices, the device tree bindings are a firmware
>> <--> kernel ABI as the device trees always come from the firmware and not
>> some other place.
>
> Now, I am not going spend more time arguing, instead I prefer if we
> can be constructive.
>
> As the maintainer of MMC, I have tried to be helpful by providing you
> with my view on how we can move forward.
>
> I don't think it's a big deal for you to implement something along
> those lines for what I have requested, or is it?

It is a matter of how much manipulation of the device tree we want to do 
before it is handed off to the driver core for device creation.  I would 
like to not do any.

There is a global cost to changing the device tree in early boot.  It 
may not be borne by the MMC sub-system, but it exists none the less.

Given that:

  A) The MMC core doesn't contain the concept of one bus controller with 
multiple "slots".

  B) The existing OCTEON device tree bindings should continue to be 
supported.

There are several options.

   1) Invent new MMC device tree bindings that are different from what 
we currently have, but that convey the same information.

   1a) Change the OCTEON MMC driver to use only these new bindings, and 
write some sort of device tree fix up code that runs in early boot to 
rewrite the device tree MMC properties.   This results in the code 
supporting the OCTEON MMC devices being split between the driver and 
system early boot code.  The cost is an increase in system complexity to 
generate the device tree nodes with new bindings.

   1b) Change the OCTEON MMC driver to use either these new bindings or 
legacy bindings.  In this case all OCTEON MMC code is localized to a 
single driver file.  There is a small increase in complexity to carry 
code to decode both new and legacy device tree bindings.

   2) Use existing OCTEON MMC device tree bindings, as they are 
sufficient to achieve a working driver.  Since the code is all specific 
to the OCTEON MMC driver, any ugliness is contained lexicographically 
near to the features being implemented.  Any feedback related to the 
architecture and style of the driver code would be addressed.

The current state is #2.  My interpretation of your desires is #1a.

I am fine with introducing a new device tree binding.  But, I don't 
think the kernel as a whole nor this specific OCTEON MMC driver will be 
improved by adding more device tree synthesis code in early boot.  Any 
thing that is there should be limited to supporting very old (pre OCTEON 
MMC) firmware that doesn't supply a device tree.  So I would strongly 
support either approach #1b or #2.

David Daney

