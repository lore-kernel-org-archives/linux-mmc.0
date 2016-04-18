From: Matt Redfearn <Matt.Redfearn@imgtec.com>
Subject: RE: [RESEND PATCH v7 1/2] mmc: OCTEON: Add DT bindings for OCTEON
 MMC controller
Date: Mon, 18 Apr 2016 11:37:06 +0000
Message-ID: <9FCBB1D1936B2F4DB2DD02BA3957FB504A067E8D@LEMAIL01.le.imgtec.org>
References: <1459438013-25088-1-git-send-email-matt.redfearn@imgtec.com>
	<CAPDyKFpZqiv7iVbunr+mrLyxLx=V-NVSnDpvbMaaekxn7FdKrQ@mail.gmail.com>
	<9FCBB1D1936B2F4DB2DD02BA3957FB504A067CE2@LEMAIL01.le.imgtec.org>,<CAPDyKFo+=U978UfjP+zLfAyYm2JptWu77shR8v1z-sD+d9KDOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:7602 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbcDRLhK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2016 07:37:10 -0400
In-Reply-To: <CAPDyKFo+=U978UfjP+zLfAyYm2JptWu77shR8v1z-sD+d9KDOw@mail.gmail.com>
Content-Language: en-GB
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Aleksey Makarov <aleksey.makarov@caviumnetworks.com>, Chandrakala Chavva <cchavva@caviumnetworks.com>, David Daney <david.daney@cavium.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>, Rob Herring <robh+dt@kernel.org>, Ralf Baechle <ralf@linux-mips.org>


________________________________________
From: Ulf Hansson [ulf.hansson@linaro.org]
Sent: 18 April 2016 12:13
To: Matt Redfearn
Cc: linux-mmc; Aleksey Makarov; Chandrakala Chavva; David Daney; Aleksey Makarov; Leonid Rosenboim; Peter Swain; Aaron Williams; Rob Herring; Ralf Baechle
Subject: Re: [RESEND PATCH v7 1/2] mmc: OCTEON: Add DT bindings for OCTEON MMC controller

[...]

> +
> +2) Slot nodes
> +Properties in mmc.txt apply to each slot node that the platform uses.
> +
> +Required properties:
> +- reg : The slot number.
> +
> +Optional properties:
> +- cavium,cmd-clk-skew : the amount of delay (in pS) past the clock edge
> +       to sample the command pin.
> +- cavium,dat-clk-skew : the amount of delay (in pS) past the clock edge
> +       to sample the data pin.
> +
> +Example:
> +       mmc@1180000002000 {
> +               compatible = "cavium,octeon-6130-mmc";
> +               reg = <0x11800 0x00002000 0x0 0x100>,
> +                     <0x11800 0x00000168 0x0 0x20>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               /* EMM irq, DMA irq */
> +               interrupts = <1 19>, <0 63>;
> +
> +               mmc-slot@0 {
> +                       reg = <0>;
>
>
> Let me elaborate on how child nodes are being used by the MMC subsystem today.
>
> 1)
> When a child node has "reg = <0>", the mmc core treat this as being
> represented by a non-removable/embedded card.
> We have also added a compatible string, "mmc-card", that help us to
> deal with constraints for eMMC cards during initialization. You may
> have a look at Documentation/devicetree/bindings/mmc/mmc-card.txt to
> know more about this.
>
> Additionally, the dynamically created struct device representing the
> card, gets its device node pointer assigned to the child node when
> "reg = <0>". In that way, the bus/drivers for the card can use it as
> well.
>
> 2)
> When "reg" is non-zero and it's an SDIO card that has been detected,
> we treat the child node as representing the embedded SDIO functional
> device. The maximum amount of SDIO functional devices that is
> supported is dynamic, as it's encoded inside registers of the SDIO
> card. The "reg" number needs to be within this range, which allows the
> dynamically created struct device for the SDIO func device, to get its
> device node assigned to its corresponding child node.
>
> Typically an SDIO function device may be a WLAN chip, which thus is
> being attached to an SDIO interface. This is especially needed when
> the WLAN driver requires platform specific resources, like some GPIOs
> or wake IRQs. An example is available in
> arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts, where mmc3 use this.
>
>
>
> +                       max-frequency = <20000000>;
> +                       bus-width = <8>;
> +                       vmmc-supply = <&reg_vmmc3>;
> +                       cd-gpios = <&gpio 9 0>;
> +                       wp-gpios = <&gpio 10 0>;
> +               };
> +       };
> --
> 2.5.0
>
>
>
> So to summarize, the mmc core has a different view of what child nodes
> represents than what is being suggested here. I am not sure it's good
> idea to add/change that interpretation.
>
> Perhaps it's better to implement the machine specific patching of the
> DTS and then remove the "mmc-slot". I think something along those
> lines was proposed in one of the earlier versions as well!?
>
> What do you think?
>
> Kind regards
> Uffe
>
>
> Hi Ulf,
>
> Thanks for taking the time to reply and your detailed answer. I see why the bindings currently don't fit into the mmc core model. However, we still have the issue that these bindings are shipping in hardware and we can't change them. As far as I can see, ther major difference between these bindings and what is upstream, is the interpretation of the reg property, and the compatible string of what is connected to the controller. The Octeon MMC controller supports connections to up to 4 devices, either eMMC devices or SD card slots. I think it will be difficult to impossible to programatically interpret the device tree supplied by the bootloader to classify the slots as SD card / eMMC such that the necessary reg / compatible strings can be added.

>
> If we were to remove the slots entirely from the device tree, how would the core deal with having one controller with multiple devices attached? Obviously we need some locking of the shared controller between the child devices.

Currently the core doesn't deal with multiple card slots and I doubt
we ever will be adding that. The reason is simply because, in practice
there don't exist such configurations, even if some HWs supports it. I
assume that's the case here as well, right!?

Kind regards
Uffe

Hi Ulf,
Unfortunately not, for example the Rhinolabs UTM8 board which we have several of here (http://www.rhinolabsinc.com/rhino-sdna7130-networking-appliance/) contains an eMMC device attached to "slot 1" and a microSD card slot on "slot 2". The driver as it stands supports this board by registering an mmc host for each slot, and it is possible to use both devices while shaing the controller resources.

Thanks,
Matt
