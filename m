From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RESEND PATCH v7 1/2] mmc: OCTEON: Add DT bindings for OCTEON MMC controller
Date: Tue, 19 Apr 2016 11:15:27 +0200
Message-ID: <CAPDyKFpYfDeT5LDfEMXxgZiHmnNx7Aau+m7Dq=+Sj+4ntrtfDw@mail.gmail.com>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com>
	<CAPDyKFpZqiv7iVbunr+mrLyxLx=V-NVSnDpvbMaaekxn7FdKrQ@mail.gmail.com>
	<9FCBB1D1936B2F4DB2DD02BA3957FB504A067CE2@LEMAIL01.le.imgtec.org>
	<CAPDyKFo+=U978UfjP+zLfAyYm2JptWu77shR8v1z-sD+d9KDOw@mail.gmail.com>
	<9FCBB1D1936B2F4DB2DD02BA3957FB504A067E8D@LEMAIL01.le.imgtec.org>
	<CAPDyKFpw+_Lfk0d5tgZ1iQ9suvrx76foX-hpu503K55buGoiKg@mail.gmail.com>
	<9FCBB1D1936B2F4DB2DD02BA3957FB504A0680EA@LEMAIL01.le.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38290 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbcDSJP3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 05:15:29 -0400
Received: by mail-wm0-f43.google.com with SMTP id u206so18363655wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2016 02:15:28 -0700 (PDT)
In-Reply-To: <9FCBB1D1936B2F4DB2DD02BA3957FB504A0680EA@LEMAIL01.le.imgtec.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Redfearn <Matt.Redfearn@imgtec.com>, David Daney <david.daney@cavium.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>, Rob Herring <robh+dt@kernel.org>, Ralf Baechle <ralf@linux-mips.org>

[...]

>>> Unfortunately not, for example the Rhinolabs UTM8 board which we have several of here (http://www.rhinolabsinc.com/rhino-sdna7130-networking-appliance/) contains an eMMC device attached to "slot 1" and a microSD card slot on "slot 2". The driver as it stands supports this board by registering an mmc host for each slot, and it is possible to use both devices while shaing the controller resources.
>> I see! Are you sure you don't need any additional out of tree patch
>> for the mmc core/block as well?
>
> No, the driver applies to and works with unpatched upstream mmc core. It
> create one mmc_host struct per slot and registers it though
> mmc_add_host. Sharing the controller resources between slots is handled
> within the driver.

Okay, thanks for confirming that.

>
>>
>> Moreover, of course these configurations suffers from poor
>> performance, but I guess that's irrelevant for these systems!?
>
> Indeed, the eMMC and SD are not typically used together, and if they
> are, there's an explainable hardware performance limitation.

I guess there's even a performance penalty involved when they are not
used together, because of the locking overhead, right?

Perhaps that could be fixed by a clever locking implementation, unless
the overhead is negligible!?

>
>>
>> Perhaps we can add specific DT property which tells about whether the
>> childnode is a slot? Then you will have to patch your DTB during boot
>> and add that information.
>
> The DTB in currently shipping devices has a compatible property
> "cavium,octeon-6130-mmc-slot" for each slot. Perhaps that would do? Or,
> we could add a property such as "slot-num" rather than encoding this
> information in the reg property?

>From this discussion I have understood that we clearly need a way to
describe mmc slots in DT!

Unfortunate we should have discussed this before you decided to ship
devices with DTBs containing non accepted DT bindings, but hey better
late than never! :-)

Anyway, I am happy with describing mmc-slots in child nodes as you
proposed, but with one exception. I want a common mmc compatible
string telling that the child node is an mmc slot. Perhaps something
like "mmc-slot" could work or if you have another suggestion.

If such compatible isn't found in a child node from the host device
node, the mmc core shall continue to treat the child node as the
card/SDIO-func. Then we need to extend the mmc core to know about slot
nodes and parse for their child nodes, as those will then represent
the card/SDIO-func.

Do you think this could work?

Also, I did a quick review of the mmc octeon driver in patch 2/2 [1]
and found that there are several legacy DT bindings being parsed, but
which isn't documented in $subject patch. They should, and of course
they must be marked as legacy/deprecated. Let's go through an example
of a slot node from your already deployed DTBs. I have pasted an
example from [1] here.


        mmc-slot@2 {
                compatible = "cavium,octeon-6130-mmc-slot";

Convert to the common mmc slot compatible, whatever we decide to name it.

                reg = <2>;

This is fine, as the way to describe the slot number.

                voltage-ranges = <3300 3300>;

Regarding voltage ranges and power-gpios below, this shall be
converted to a GPIO regulator. In that way, the "voltage range" (in
mmc terminology OCR mask) will be fetched by the mmc core through the
mmc_regulator_get_supply() API as it becomes information about the
regulator.

                spi-max-frequency = <26000000>;

As you already done in [1], convert to "max-frequency"

                /* Power on GPIO 8, active high */
                /* power-gpios = <&gpio 8 0>; */
                power-gpios = <&gpio 8 1>;

See comment about voltage-ranges above.

        /*      spi-max-frequency = <52000000>; */
                /* bus width can be 1, 4 or 8 */
                cavium,bus-max-width = <8>;

As you already done in [1], convert to "bus-width"

        };

Mainly because of the changes for voltage range and power gpios, I
think you shall patch the DTB from arch/SoC specific code instead of
from the mmc octeon driver.

You need to describe a GPIO regulator in DT and then update the slot
node to contain a vmmc-supply handle to it.
I understand this may be a bit tricky, but to be clear - I am not
going to accept the voltage-range/power-gpios binding.

Kind regards
Uffe

[1]
http://www.spinics.net/lists/linux-mmc/msg36018.html
