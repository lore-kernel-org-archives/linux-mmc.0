From: David Daney <ddaney@caviumnetworks.com>
Subject: Re: [RESEND PATCH v7 1/2] mmc: OCTEON: Add DT bindings for OCTEON
 MMC controller
Date: Mon, 18 Apr 2016 15:59:39 -0700
Message-ID: <571566DB.90609@caviumnetworks.com>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com> <CAPDyKFpZqiv7iVbunr+mrLyxLx=V-NVSnDpvbMaaekxn7FdKrQ@mail.gmail.com> <9FCBB1D1936B2F4DB2DD02BA3957FB504A067CE2@LEMAIL01.le.imgtec.org> <CAPDyKFo+=U978UfjP+zLfAyYm2JptWu77shR8v1z-sD+d9KDOw@mail.gmail.com> <9FCBB1D1936B2F4DB2DD02BA3957FB504A067E8D@LEMAIL01.le.imgtec.org> <CAPDyKFpw+_Lfk0d5tgZ1iQ9suvrx76foX-hpu503K55buGoiKg@mail.gmail.com> <9FCBB1D1936B2F4DB2DD02BA3957FB504A0680EA@LEMAIL01.le.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0056.outbound.protection.outlook.com ([157.56.110.56]:59568
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751071AbcDSAde (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Apr 2016 20:33:34 -0400
In-Reply-To: <9FCBB1D1936B2F4DB2DD02BA3957FB504A0680EA@LEMAIL01.le.imgtec.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Redfearn <Matt.Redfearn@imgtec.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, David Daney <david.daney@cavium.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>, Rob Herring <robh+dt@kernel.org>, Ralf Baechle <ralf@linux-mips.org>

On 04/18/2016 05:57 AM, Matt Redfearn wrote:
> HI Ulf,
>
> On 18/04/16 13:08, Ulf Hansson wrote:
>> [...]
>>
>>>> Thanks for taking the time to reply and your detailed answer. I see why the bindings currently don't fit into the mmc core model. However, we still have the issue that these bindings are shipping in hardware and we can't change them. As far as I can see, ther major difference between these bindings and what is upstream, is the interpretation of the reg property, and the compatible string of what is connected to the controller. The Octeon MMC controller supports connections to up to 4 devices, either eMMC devices or SD card slots. I think it will be difficult to impossible to programatically interpret the device tree supplied by the bootloader to classify the slots as SD card / eMMC such that the necessary reg / compatible strings can be added.
>>>> If we were to remove the slots entirely from the device tree, how would the core deal with having one controller with multiple devices attached? Obviously we need some locking of the shared controller between the child devices.
>>> Currently the core doesn't deal with multiple card slots and I doubt
>>> we ever will be adding that. The reason is simply because, in practice
>>> there don't exist such configurations, even if some HWs supports it. I
>>> assume that's the case here as well, right!?
>>>
>>> Kind regards
>>> Uffe
>>>
>>> Hi Ulf,
>>> Unfortunately not, for example the Rhinolabs UTM8 board which we have several of here (http://www.rhinolabsinc.com/rhino-sdna7130-networking-appliance/) contains an eMMC device attached to "slot 1" and a microSD card slot on "slot 2". The driver as it stands supports this board by registering an mmc host for each slot, and it is possible to use both devices while shaing the controller resources.
>> I see! Are you sure you don't need any additional out of tree patch
>> for the mmc core/block as well?
>
> No, the driver applies to and works with unpatched upstream mmc core. It
> create one mmc_host struct per slot and registers it though
> mmc_add_host. Sharing the controller resources between slots is handled
> within the driver.
>
>>
>> Moreover, of course these configurations suffers from poor
>> performance, but I guess that's irrelevant for these systems!?
>
> Indeed, the eMMC and SD are not typically used together, and if they
> are, there's an explainable hardware performance limitation.
>

None of this matters as the hardware cannot be reconfigured or changed. 
  For better or worse, we have a single MMC bus controller that is 
multiplexed between four "slots", and commands between the various slots 
must be serialized to ensure there is no intra-slot contention of resources.

It actually gets even better...  On some systems, the MMC "slots" can 
contend with non MMC devices and the scope of the serialization is even 
wider (see the octeon_bootbus_sem in the driver).

>>
>> Perhaps we can add specific DT property which tells about whether the
>> childnode is a slot? Then you will have to patch your DTB during boot
>> and add that information.
>
> The DTB in currently shipping devices has a compatible property
> "cavium,octeon-6130-mmc-slot" for each slot. Perhaps that would do? Or,
> we could add a property such as "slot-num" rather than encoding this
> information in the reg property?

The most useful course forward would be to use the already widely 
deployed device tree binding that is implemented in the posted driver. 
Since the device tree is it supplied by the boot firmware of many 
commercially available devices (Ubiquti ER-8, Rhinolabs UTM8, etc.), 
this would allow the thing to function without jumping through hoops 
with a device-tree du jour at the whim of kernel device tree ABI tweakers.

Since the concept of an MMC "slot" is foreign to the kernel's MMC core, 
there is nothing to be gained by giving it a non-vendor specific 
property name like "slot-num".  By continuing to use 
"cavium,octeon-6130-mmc-slot", we denote that it is vendor specific 
thing for this weird hardware.

David Daney

>
> Thanks,
> Matt
>
>>
>> Or you have another suggestion?
>>
>> Kind regards
>> Uffe
>

