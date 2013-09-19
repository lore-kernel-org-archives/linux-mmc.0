From: Balaji T K <balajitk@ti.com>
Subject: Re: OMAP35x MMC Host Controller compatibility with SDXC?
Date: Thu, 19 Sep 2013 20:01:13 +0530
Message-ID: <523B0AB1.1050008@ti.com>
References: <CAL1yNcLxUnDCfZJxLVUjSDLtgvuBYEjL-pw_aZ8dA1rVu5o=4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33564 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab3ISObQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Sep 2013 10:31:16 -0400
In-Reply-To: <CAL1yNcLxUnDCfZJxLVUjSDLtgvuBYEjL-pw_aZ8dA1rVu5o=4Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Kevyn-Alexandre_Par=E9?= <kevyn.alexandre.pare@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

On Wednesday 18 September 2013 02:32 AM, Kevyn-Alexandre Par=E9 wrote:
> Hi,
>
> My question is related to the drivers/mmc/host/omap_hsmmc.c host
> controller compatibility with SDXC for the OMAP35x?
>
> Reading the TRM for OMAP35x:
> http://www.ti.com/lit/ug/spruf98x/spruf98x.pdf
>
> It's said that:
> - Full compliance with SD command/response sets as defined in the SD
> Memory Card Specifications, v2.0 including high-capacity SDHC cards u=
p
> to 32GB.
>
> - Full compliance with sets as defined in the SD Card Specification,
> Part A2, SD Host Controller Standard Specification, v2.00
>
> It doesn't mention the SDXC?
> I'm trying to found my way through all the spec of sdcard.org.
>
> I'm still wondering why using SDXC of 64GB is working and doesn't pop
> a WARNING message and if it's safe??
>
> My test shows that I'm having some timeout in some cases (v3.4.60):
> omap_hsmmc omap_hsmmc.0: IRQ Status is 18000
> omap_hsmmc omap_hsmmc.0: MMC IRQ 0x18000 : ERRI CTO
> mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
> mmc0: starting CMD52 arg 80000c08 flags 00000195
>
> omap_hsmmc omap_hsmmc.0: mmc0: CMD5, argument 0x00000000
> omap_hsmmc omap_hsmmc.0: IRQ Status is 18000
> omap_hsmmc omap_hsmmc.0: MMC IRQ 0x18000 : ERRI CTO
> mmc0: req failed (CMD5): -110, retrying...
>
> mmc1: starting CMD8 arg 000001aa flags 000002f5
> omap_hsmmc omap_hsmmc.1: mmc1: CMD8, argument 0x000001aa
> mmc0: starting CMD18 arg 00020000 flags 000000b5
> omap_hsmmc omap_hsmmc.1: IRQ Status is 18000
> omap_hsmmc omap_hsmmc.1: MMC IRQ 0x18000 : ERRI CTO
> mmc1: req done (CMD8): -110: 00000000 00000000 00000000 00000000
>
> So CMD 52,5 and 8 gives me timeout...

=46or SD cards, these cmd's are expected to timeout during card initial=
ization.

>
> Looking at the 3.11.1 there is 2 more validation for UHS that are not=
 in 3.4.60:
> omap_hsmmc_set_clock  // Enable High-Speed Support
> omap_set_bus_width
>

Those changes are not for SD3.0 speed modes

> Is it safe to use SDXC with OMAP35x or not? Should this pop a error m=
essage?

SDXC cards should work albeit at High Speed mode (as in SD2.0).
Refer to [1] for card size Vs speed mode/SD spec version.
Can you check if the filesystem type on SDXC card
is supported by the system software running on OMAP35x.

[1]
https://www.sdcard.org/consumers/speed/bus_speed/

>
> Best Regards,
>
> -KA
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

