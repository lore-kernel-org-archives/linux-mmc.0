From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [RFC 00/12] OMAP DMA engine conversion
Date: Wed, 25 Apr 2012 01:47:21 +0300
Message-ID: <CANOLnOOf0znGBSSQp5B3U+1q2OJBXnB_1T0aiuma_rJZDZA08Q@mail.gmail.com>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk>
	<20120424103858.GC25053@n2100.arm.linux.org.uk>
	<20120424165147.GP3739@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-13
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120424165147.GP3739@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Apr 24, 2012 at 7:51 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120424 03:42]:
>> Here's another patch - for the OMAP NAND driver.
>>
>> One thing this doesn't do is configure up the source/destination bur=
sts,
>> which the old code did:
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_set_dma_dest_bu=
rst_mode(info->dma_ch,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 OMAP_DMA_DATA_BURST_16);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_set_dma_src_bur=
st_mode(info->dma_ch,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 OMAP_DMA_DATA_BURST_16);
>
> Grazvydas, care to give this patch a go?

Tested-by: Grazvydas Ignotas <notasas@gmail.com>
for:
- SD card connected over transceiver to MMC2
- touchscreen connected over SPI
- NAND on GPMC in DMA mode
Seems to be working just as they did before, except that I'm not sure
SPI was crossing PIO threshold.


--=20
Gra=FEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
