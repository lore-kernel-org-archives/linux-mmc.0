From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 1/4 v2] mmc: mn57xx: only access registers above 0xff, if available
Date: Sun, 13 Mar 2011 12:54:04 +0900
Message-ID: <AANLkTi=cGjomEu4uPbOFcwQfMYu6q4kjMwmdetRXeefC@mail.gmail.com>
References: <Pine.LNX.4.64.1103110854050.23675@axis700.grange>
	<Pine.LNX.4.64.1103110900080.23675@axis700.grange>
	<AANLkTi=CwkzwvDy+CTzJBni-OtZUMEtmceNr+-xpuVOK@mail.gmail.com>
	<Pine.LNX.4.64.1103122349080.28741@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40554 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156Ab1CMDyG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Mar 2011 22:54:06 -0500
In-Reply-To: <Pine.LNX.4.64.1103122349080.28741@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

On Sun, Mar 13, 2011 at 7:57 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Sun, 13 Mar 2011, Magnus Damm wrote:
>
>> On Fri, Mar 11, 2011 at 5:09 PM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> > Not all mn57xx / tmio implementations have registers above oxff.
>> > Accessing them on thise platforms is dangerous. In some cases it l=
eads
>> > to address wrapping to addresses below 0x100, which corrupts rando=
m
>> > unrelated registers.
>> >
>> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> > ---
>> >
>> > v2:
>>
>> > --- a/drivers/mmc/host/tmio_mmc_pio.c
>> > +++ b/drivers/mmc/host/tmio_mmc_pio.c
>>
>> Nice, it looks like this patch should apply on your earlier broken o=
ut
>> patch set...
>>
>> > + =A0 =A0 =A0 if (resource_size(res) > 0x100) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sd_ctrl_write16(host, CTL_CLK_AND_WA=
IT_CTL, 0x0000);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(10);
>> > + =A0 =A0 =A0 }
>>
>> ... but now since you've separated the tmio specific code from the
>> SDHI implementation, why don't you just make all the offsets above
>> 0x100 stay in the tmio code, and let the SDHI only access below 0xff=
?
>
> The current split is:
>
> tmio_mmc_pio.c: _all_ driver functionality in PIO mode, including MMC=
 API
> tmio_mmc_dma.c: DMA
>
> tmio_mmc.c: _only_ MFD glue - no IO at all
>
> sh_mobile_sdhi.c: _only_ platform glue for SDHI - no IO at all
>
> This split seems logical to me - every file performs one function. Bu=
t I
> do agree, that special-casing addresses > 0xff in the generic core is=
 not
> very nice... We could otherwise modify the actual read / write access=
ors
> to check, whether _each_ register address is within the resource, but=
 that
> would be too much of a performance hit. But pulling those couple of >=
 0xff
> accesses out of the driver proper and into the MFD glue didn't look l=
ike a
> very logical thing to me. I thought this version provided both - no
> performance hit and preserved clean function separation - at the cost=
 of
> "slight ugliness." Opinions?

I don't really see why you want to have "no IO at all" in the
tmio/sdhi specific files.

Actually, I think it makes sense to abstract based on the hardware
register layout difference.

 Since some parts of the code only applies to tmio (offset >=3D 0x100)
and some only to SDHI (TMIO_MMC_SDIO_IRQ), why don't you do the
following:

In tmio_mmc_pio.c:

tmio_mmc_core_clk_start()
tmio_mmc_core_clk_stop()
tmio_mmc_core_reset()

Above functions only implement offset < 0x100 and no TMIO_MMC_ stuff
in there if possible

In tmio_mmc.c

tmio_mmc_clk_start()
tmio_mmc_clk_stop()
tmio_mmc_reset()

Above 3 functions call tmio_mmc_core_xxx() and also implement >=3D 0x10=
0
offset access.

In sh_mobile_sdhi.c

sh_mobile_sdhi_clk_start()
sh_mobile_sdhi_clk_stop()
sh_mobile_sdhi_reset()

Above 3 functions call tmio_mmc_core_xxx() and perhaps also implement S=
DIO IRQ.

Ideally we want to share the SDIO IRQ code with the TMIO MFD
implementation, but we're not really receiving any test feedback from
anyone, so from my POV to avoid breakage we may as well keep things in
the SDHI portion and move over to the common place if needed in the
future.

/ magnus
