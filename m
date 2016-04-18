From: Matt Redfearn <Matt.Redfearn@imgtec.com>
Subject: Re: [RESEND PATCH v7 1/2] mmc: OCTEON: Add DT bindings for OCTEON
 MMC controller
Date: Mon, 18 Apr 2016 12:57:33 +0000
Message-ID: <9FCBB1D1936B2F4DB2DD02BA3957FB504A0680EA@LEMAIL01.le.imgtec.org>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com>
 <CAPDyKFpZqiv7iVbunr+mrLyxLx=V-NVSnDpvbMaaekxn7FdKrQ@mail.gmail.com>
 <9FCBB1D1936B2F4DB2DD02BA3957FB504A067CE2@LEMAIL01.le.imgtec.org>
 <CAPDyKFo+=U978UfjP+zLfAyYm2JptWu77shR8v1z-sD+d9KDOw@mail.gmail.com>
 <9FCBB1D1936B2F4DB2DD02BA3957FB504A067E8D@LEMAIL01.le.imgtec.org>
 <CAPDyKFpw+_Lfk0d5tgZ1iQ9suvrx76foX-hpu503K55buGoiKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:49190 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbcDRM5i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2016 08:57:38 -0400
In-Reply-To: <CAPDyKFpw+_Lfk0d5tgZ1iQ9suvrx76foX-hpu503K55buGoiKg@mail.gmail.com>
Content-Language: en-GB
Content-ID: <7BDFD16A871FE145874E0CBEDA2419CA@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, David Daney <david.daney@cavium.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>, Rob Herring <robh+dt@kernel.org>, Ralf Baechle <ralf@linux-mips.org>

HI Ulf,

On 18/04/16 13:08, Ulf Hansson wrote:
> [...]
>
>>> Thanks for taking the time to reply and your detailed answer. I see why the bindings currently don't fit into the mmc core model. However, we still have the issue that these bindings are shipping in hardware and we can't change them. As far as I can see, ther major difference between these bindings and what is upstream, is the interpretation of the reg property, and the compatible string of what is connected to the controller. The Octeon MMC controller supports connections to up to 4 devices, either eMMC devices or SD card slots. I think it will be difficult to impossible to programatically interpret the device tree supplied by the bootloader to classify the slots as SD card / eMMC such that the necessary reg / compatible strings can be added.
>>> If we were to remove the slots entirely from the device tree, how would the core deal with having one controller with multiple devices attached? Obviously we need some locking of the shared controller between the child devices.
>> Currently the core doesn't deal with multiple card slots and I doubt
>> we ever will be adding that. The reason is simply because, in practice
>> there don't exist such configurations, even if some HWs supports it. I
>> assume that's the case here as well, right!?
>>
>> Kind regards
>> Uffe
>>
>> Hi Ulf,
>> Unfortunately not, for example the Rhinolabs UTM8 board which we have several of here (http://www.rhinolabsinc.com/rhino-sdna7130-networking-appliance/) contains an eMMC device attached to "slot 1" and a microSD card slot on "slot 2". The driver as it stands supports this board by registering an mmc host for each slot, and it is possible to use both devices while shaing the controller resources.
> I see! Are you sure you don't need any additional out of tree patch
> for the mmc core/block as well?

No, the driver applies to and works with unpatched upstream mmc core. It 
create one mmc_host struct per slot and registers it though 
mmc_add_host. Sharing the controller resources between slots is handled 
within the driver.

>
> Moreover, of course these configurations suffers from poor
> performance, but I guess that's irrelevant for these systems!?

Indeed, the eMMC and SD are not typically used together, and if they 
are, there's an explainable hardware performance limitation.

>
> Perhaps we can add specific DT property which tells about whether the
> childnode is a slot? Then you will have to patch your DTB during boot
> and add that information.

The DTB in currently shipping devices has a compatible property 
"cavium,octeon-6130-mmc-slot" for each slot. Perhaps that would do? Or, 
we could add a property such as "slot-num" rather than encoding this 
information in the reg property?

Thanks,
Matt

>
> Or you have another suggestion?
>
> Kind regards
> Uffe

