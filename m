From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RESEND PATCH v7 1/2] mmc: OCTEON: Add DT bindings for OCTEON MMC controller
Date: Wed, 20 Apr 2016 11:32:06 +0200
Message-ID: <CAPDyKFrZ2FU2iGJG-KK3fLwZpu49uFamZCb7PBt+MaCGfy0Dpw@mail.gmail.com>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com>
	<CAPDyKFpZqiv7iVbunr+mrLyxLx=V-NVSnDpvbMaaekxn7FdKrQ@mail.gmail.com>
	<9FCBB1D1936B2F4DB2DD02BA3957FB504A067CE2@LEMAIL01.le.imgtec.org>
	<CAPDyKFo+=U978UfjP+zLfAyYm2JptWu77shR8v1z-sD+d9KDOw@mail.gmail.com>
	<9FCBB1D1936B2F4DB2DD02BA3957FB504A067E8D@LEMAIL01.le.imgtec.org>
	<CAPDyKFpw+_Lfk0d5tgZ1iQ9suvrx76foX-hpu503K55buGoiKg@mail.gmail.com>
	<9FCBB1D1936B2F4DB2DD02BA3957FB504A0680EA@LEMAIL01.le.imgtec.org>
	<CAPDyKFpYfDeT5LDfEMXxgZiHmnNx7Aau+m7Dq=+Sj+4ntrtfDw@mail.gmail.com>
	<5716592A.6000505@caviumnetworks.com>
	<CAPDyKFqM3VxYE+KtC++=5=Bjket0mCnLAuN3_436O_=TSMzAHA@mail.gmail.com>
	<57169429.10601@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35387 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbcDTJcI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2016 05:32:08 -0400
Received: by mail-wm0-f49.google.com with SMTP id e201so43216575wme.0
        for <linux-mmc@vger.kernel.org>; Wed, 20 Apr 2016 02:32:08 -0700 (PDT)
In-Reply-To: <57169429.10601@caviumnetworks.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: Matt Redfearn <Matt.Redfearn@imgtec.com>, David Daney <david.daney@cavium.com>, linux-mmc <linux-mmc@vger.kernel.org>, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>, Rob Herring <robh+dt@kernel.org>, Ralf Baechle <ralf@linux-mips.org>

[...]

>
> We cannot change the past.  Our only concern should be to develop the
> simplest and cleanest overall implementation possible given the facts as
> they exist today.
>

I understand, but it seems like we don't agree on what is the "cleanest".

>>
>>>
>>> The firmware containing these bindings is out in the wild.  If we
>>> deprecate
>>> some of the bindings, the driver will still have to support them in the
>>> future.
>>>
>>> In the case of OCTEON based devices, the device tree bindings are a
>>> firmware
>>> <--> kernel ABI as the device trees always come from the firmware and not
>>> some other place.
>>
>>
>> Now, I am not going spend more time arguing, instead I prefer if we
>> can be constructive.
>>
>> As the maintainer of MMC, I have tried to be helpful by providing you
>> with my view on how we can move forward.
>>
>> I don't think it's a big deal for you to implement something along
>> those lines for what I have requested, or is it?
>
>
> It is a matter of how much manipulation of the device tree we want to do
> before it is handed off to the driver core for device creation.  I would
> like to not do any.
>
> There is a global cost to changing the device tree in early boot.  It may
> not be borne by the MMC sub-system, but it exists none the less.

I don't think your concern is right.

What I request are *small* updates to the DTB from arch/SoC specific
code, those should be really simple to fix.

The benefit is that the driver becomes more portable and it don't have
to carry around supporting legacy bindings.

Moreover, for new SoCs revisions, which still may re-use the same MMC
controller, the DTB patching isn't needed.

>
> Given that:
>
>  A) The MMC core doesn't contain the concept of one bus controller with
> multiple "slots".
>
>  B) The existing OCTEON device tree bindings should continue to be
> supported.
>
> There are several options.
>
>   1) Invent new MMC device tree bindings that are different from what we
> currently have, but that convey the same information.
>
>   1a) Change the OCTEON MMC driver to use only these new bindings, and write
> some sort of device tree fix up code that runs in early boot to rewrite the
> device tree MMC properties.   This results in the code supporting the OCTEON
> MMC devices being split between the driver and system early boot code.  The
> cost is an increase in system complexity to generate the device tree nodes
> with new bindings.
>
>   1b) Change the OCTEON MMC driver to use either these new bindings or
> legacy bindings.  In this case all OCTEON MMC code is localized to a single
> driver file.  There is a small increase in complexity to carry code to
> decode both new and legacy device tree bindings.
>
>   2) Use existing OCTEON MMC device tree bindings, as they are sufficient to
> achieve a working driver.  Since the code is all specific to the OCTEON MMC
> driver, any ugliness is contained lexicographically near to the features
> being implemented.  Any feedback related to the architecture and style of
> the driver code would be addressed.
>
> The current state is #2.  My interpretation of your desires is #1a.
>
> I am fine with introducing a new device tree binding.  But, I don't think
> the kernel as a whole nor this specific OCTEON MMC driver will be improved
> by adding more device tree synthesis code in early boot.  Any thing that is
> there should be limited to supporting very old (pre OCTEON MMC) firmware
> that doesn't supply a device tree.  So I would strongly support either
> approach #1b or #2.

Let me elaborate once more on how I see the way forward.

For A):
I have suggested a solution that I think can be generic, see my earlier email.

>From the DTB point of view, I request you to update the slot
compatible string to a generic one. Is that a difficult task to patch
the DTB with?
If so, let's keep yours as well, but make sure it's documented as deprecated.

Regarding the changes needed to the mmc core, as to enable it to know
about mmc-slots, this should be quite easy to implement. I even
volunteer to can help, if you think it's needed.

So to summarize regarding A). I want a generic solution for slot nodes!

For B), there are two cases:
1. Legacy bindings that already has a corresponding generic MMC
binding. Renaming these properties by patching the DTB is an easy
operation.

2. Regarding the DT bindings for "power-gpios" and "voltage-ranges".
Under *no* circumstances I won't accept any similar bindings. Instead
a GPIO regulator shall be used and I have explained why in an earlier
response.

I do realize that patching the DTB to create the GPIO regulator is not
an easy task, that was my initial thought but let's just avoid that!

Instead, you can parse the DTB from arch/SoC specific code to find the
slot compatible string. Then continue to search for the
power-gpios/voltage-ranges DT properties and register a GPIO regulator
via the regulator API for the slot-node device. I believe this should
be an easy task for you to implement, right!?

Then the mmc octeon driver can ignore the power-gpios and
voltage-ranges DT bindings and instead just use
mmc_regulator_get_supply() (and other mmc regulator APIs from the mmc
core) to deal with power to the card.

Kind regards
Uffe
