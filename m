From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [RESEND PATCH v7 1/2] mmc: OCTEON: Add DT bindings for OCTEON
 MMC controller
Date: Wed, 20 Apr 2016 15:32:56 -0700
Message-ID: <57180398.6040507@caviumnetworks.com>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com> <CAPDyKFpZqiv7iVbunr+mrLyxLx=V-NVSnDpvbMaaekxn7FdKrQ@mail.gmail.com> <9FCBB1D1936B2F4DB2DD02BA3957FB504A067CE2@LEMAIL01.le.imgtec.org> <CAPDyKFo+=U978UfjP+zLfAyYm2JptWu77shR8v1z-sD+d9KDOw@mail.gmail.com> <9FCBB1D1936B2F4DB2DD02BA3957FB504A067E8D@LEMAIL01.le.imgtec.org> <CAPDyKFpw+_Lfk0d5tgZ1iQ9suvrx76foX-hpu503K55buGoiKg@mail.gmail.com> <9FCBB1D1936B2F4DB2DD02BA3957FB504A0680EA@LEMAIL01.le.imgtec.org> <CAPDyKFpYfDeT5LDfEMXxgZiHmnNx7Aau+m7Dq=+Sj+4ntrtfDw@mail.gmail.com> <5716592A.6000505@caviumnetworks.com> <CAPDyKFqM3VxYE+KtC++=5=Bjket0mCnLAuN3_436O_=TSMzAHA@mail.gmail.com> <57169429.10601@caviumnetworks.com> <CAPDyKFrZ2FU2iGJG-KK3fLwZpu49uFamZCb7PBt+MaCGfy0Dpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0099.outbound.protection.outlook.com ([65.55.169.99]:33895
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750991AbcDTWdE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Apr 2016 18:33:04 -0400
In-Reply-To: <CAPDyKFrZ2FU2iGJG-KK3fLwZpu49uFamZCb7PBt+MaCGfy0Dpw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matt Redfearn <Matt.Redfearn@imgtec.com>, David Daney <david.daney@cavium.com>, linux-mmc <linux-mmc@vger.kernel.org>, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>, Rob Herring <robh+dt@kernel.org>, Ralf Baechle <ralf@linux-mips.org>

On 04/20/2016 02:32 AM, Ulf Hansson wrote:
[...]
>>
>> It is a matter of how much manipulation of the device tree we want to do
>> before it is handed off to the driver core for device creation.  I would
>> like to not do any.
>>
>> There is a global cost to changing the device tree in early boot.  It may
>> not be borne by the MMC sub-system, but it exists none the less.
>
> I don't think your concern is right.
>
> What I request are *small* updates to the DTB from arch/SoC specific
> code, those should be really simple to fix.
>
> The benefit is that the driver becomes more portable and it don't have
> to carry around supporting legacy bindings.
>
> Moreover, for new SoCs revisions, which still may re-use the same MMC
> controller, the DTB patching isn't needed.
>
>>
>> Given that:
>>
>>   A) The MMC core doesn't contain the concept of one bus controller with
>> multiple "slots".
>>
>>   B) The existing OCTEON device tree bindings should continue to be
>> supported.
>>
>> There are several options.
>>
>>    1) Invent new MMC device tree bindings that are different from what we
>> currently have, but that convey the same information.
>>
>>    1a) Change the OCTEON MMC driver to use only these new bindings, and write
>> some sort of device tree fix up code that runs in early boot to rewrite the
>> device tree MMC properties.   This results in the code supporting the OCTEON
>> MMC devices being split between the driver and system early boot code.  The
>> cost is an increase in system complexity to generate the device tree nodes
>> with new bindings.
>>
>>    1b) Change the OCTEON MMC driver to use either these new bindings or
>> legacy bindings.  In this case all OCTEON MMC code is localized to a single
>> driver file.  There is a small increase in complexity to carry code to
>> decode both new and legacy device tree bindings.
>>
>>    2) Use existing OCTEON MMC device tree bindings, as they are sufficient to
>> achieve a working driver.  Since the code is all specific to the OCTEON MMC
>> driver, any ugliness is contained lexicographically near to the features
>> being implemented.  Any feedback related to the architecture and style of
>> the driver code would be addressed.
>>
>> The current state is #2.  My interpretation of your desires is #1a.
>>
>> I am fine with introducing a new device tree binding.  But, I don't think
>> the kernel as a whole nor this specific OCTEON MMC driver will be improved
>> by adding more device tree synthesis code in early boot.  Any thing that is
>> there should be limited to supporting very old (pre OCTEON MMC) firmware
>> that doesn't supply a device tree.  So I would strongly support either
>> approach #1b or #2.
>
> Let me elaborate once more on how I see the way forward.
>
> For A):
> I have suggested a solution that I think can be generic, see my earlier email.
>
>  From the DTB point of view, I request you to update the slot
> compatible string to a generic one. Is that a difficult task to patch
> the DTB with?

It depends on the length of the new compatible property.  If it is 
longer than the old property, then it is much more difficult.


> If so, let's keep yours as well, but make sure it's documented as deprecated.
>
> Regarding the changes needed to the mmc core, as to enable it to know
> about mmc-slots, this should be quite easy to implement. I even
> volunteer to can help, if you think it's needed.
>
> So to summarize regarding A). I want a generic solution for slot nodes!
>
> For B), there are two cases:
> 1. Legacy bindings that already has a corresponding generic MMC
> binding. Renaming these properties by patching the DTB is an easy
> operation.

It is not so easy to rename things in the DTB.  Any renaming causes the 
string table to grow, so you have to have to allocate extra space for 
it.  Currently everything we do with the DTB is done in-place, so you 
would have to rewrite the early DTB handling code to allocate memory and 
make a copy of the DTB.

>
> 2. Regarding the DT bindings for "power-gpios" and "voltage-ranges".
> Under *no* circumstances I won't accept any similar bindings. Instead
> a GPIO regulator shall be used and I have explained why in an earlier
> response.
>

power-gpios is somewhat of a misnomer.  It may not even control the 
device power supply, on some boards it just isolates the data lines so 
the MMC/SD cannot influence the bus.

voltage-ranges I almost think we can drop, and not deal with.


> I do realize that patching the DTB to create the GPIO regulator is not
> an easy task, that was my initial thought but let's just avoid that!
>
> Instead, you can parse the DTB from arch/SoC specific code to find the
> slot compatible string. Then continue to search for the
> power-gpios/voltage-ranges DT properties and register a GPIO regulator
> via the regulator API for the slot-node device. I believe this should
> be an easy task for you to implement, right!?
>
> Then the mmc octeon driver can ignore the power-gpios and
> voltage-ranges DT bindings and instead just use
> mmc_regulator_get_supply() (and other mmc regulator APIs from the mmc
> core) to deal with power to the card.
>

We will consider that.

David Daney


