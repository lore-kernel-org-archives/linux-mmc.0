From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4] mmc: OCTEON: Add host driver for OCTEON MMC controller
Date: Mon, 23 Mar 2015 11:48:56 +0100
Message-ID: <CAPDyKFqdOuZfcvdFNq5dw-6k_eES-GMJAtq_V_YtF5AgE4QTig@mail.gmail.com>
References: <1426518362-24349-1-git-send-email-aleksey.makarov@auriga.com>
	<CAPDyKFoZsx_GtGT1NsZnFB9PPWKzsLv8dU26eWcobz4cCdKAOw@mail.gmail.com>
	<550C57E3.60800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:32998 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbbCWKs5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Mar 2015 06:48:57 -0400
Received: by qgfa8 with SMTP id a8so142048543qgf.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2015 03:48:56 -0700 (PDT)
In-Reply-To: <550C57E3.60800@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Daney <ddaney.cavm@gmail.com>
Cc: Aleksey Makarov <aleksey.makarov@auriga.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-mips@linux-mips.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <david.daney@cavium.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Chris Ball <chris@printf.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

[...]

>>> +
>>> +This controller is present on some members of the Cavium OCTEON SoC
>>> +family, provide an interface for eMMC, MMC and SD devices.  There is a
>>> +single controller that may have several "slots" connected.  These
>>
>>
>> Even it it may have several slots, that's not being supported by the
>> mmc core from a MMC/SD/SDIO protocol perspective.
>>
>> We have hade some discussions around this historocally, and I doubt
>> that we ever will be adding this.
>>
>> So, with that in mind I would rather see that you remove the concept
>> of "slot" entirely and thus don't do the DT configuration within a
>> child node.
>
>
> As you note this is a device tree representation, and thus really has
> nothing to do with the capabilities and internal structure of any given
> operating system.
>
> The hardware really is structured as a single controller with a single set
> of registers and register fields that can control multiple "slots".  There
> are not multiple independent slot controllers.
>
> This device tree representation reflects,  with fidelity, the actual
> hardware topology.

I understand, you have point - but...

We can debate whether why you think using a child-node for a slot is
reflecting the hardware better, but I rather don't. Everybody else
isn't using a child node, so I don't think you should.

Moreover in the SDIO case, child nodes of mmc hosts reflects the
actual embedded functional SDIO devices. So if child nodes are going
to be used for anything, it should be to contain properties of an
embedded SD/MMC/SDIO card. At least that's my view.

>
> But none of this matters, because the device tree bindings train has already
> left the station.  You should have expressed opposition to this binding back
> when it was first discussed:
>
> http://www.linux-mips.org/archives/linux-mips/2012-05/msg00119.html

I don't get it. What happened with the RFC above? It wasn't merged for
any release, but the DT-bindings that was proposed was accepted? How
is that possible?

>
> The device tree is deployed in the boot firmware of shipping devices, and we
> are merely documenting what is there.

That's a problem. :-)

[...]

Kind regards
Uffe
