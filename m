From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [RFC 00/12] OMAP DMA engine conversion
Date: Wed, 25 Apr 2012 02:59:44 +0300
Message-ID: <CANOLnOM5tkVyLzBvT6i7ziXq1Ld=yzeL5upUdAMUav=wF3HL+A@mail.gmail.com>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
	<20120424103858.GC25053@n2100.arm.linux.org.uk>
	<20120424165147.GP3739@atomide.com>
	<CANOLnOOf0znGBSSQp5B3U+1q2OJBXnB_1T0aiuma_rJZDZA08Q@mail.gmail.com>
	<20120424232928.GB6290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60878 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755956Ab2DXX7p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Apr 2012 19:59:45 -0400
In-Reply-To: <20120424232928.GB6290@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

On Wed, Apr 25, 2012 at 2:29 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Apr 25, 2012 at 01:47:21AM +0300, Grazvydas Ignotas wrote:
>> On Tue, Apr 24, 2012 at 7:51 PM, Tony Lindgren <tony@atomide.com> wr=
ote:
>> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120424 03:42]=
:
>> >> Here's another patch - for the OMAP NAND driver.
>> >>
>> >> One thing this doesn't do is configure up the source/destination =
bursts,
>> >> which the old code did:
>> >>
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 omap_set_dma_dest_burst_mode(info->dma_ch,
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 OMAP_DMA_DATA_BURST_16);
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 omap_set_dma_src_burst_mode(info->dma_ch,
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 OMAP_DMA_DATA_BURST_16);
>> >
>> > Grazvydas, care to give this patch a go?
>>
>> Tested-by: Grazvydas Ignotas <notasas@gmail.com>
>> for:
>> - SD card connected over transceiver to MMC2
>> - touchscreen connected over SPI
>> - NAND on GPMC in DMA mode
>> Seems to be working just as they did before, except that I'm not sur=
e
>> SPI was crossing PIO threshold.
>
> I think my testing on OMAP4430SDP with the SPI based ethernet should'=
ve
> caught anything untoward there.
>
> For the MMC2, could you say whether this was the hsmmc driver or the
> older omap1/2 driver please?

hsmmc running on OMAP3 pandora.


--=20
Gra=C5=BEvydas
