From: Igor Plyatov <plyatov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: spi-atmel.c: regression
Date: Thu, 5 Oct 2017 10:05:57 +0300
Message-ID: <1ab533fa-7bb5-8a83-c4a3-8f066754a27c@gmail.com>
References: <0876ce0a-cb93-07b7-8019-e365d08cca2a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0876ce0a-cb93-07b7-8019-e365d08cca2a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cyrille Pitchen <cyrille.pitchen-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hello!

> Hello!
>
> please help to manage issue with data corruption by PDC of SPI.
>
>
> I have compared operation of Linux-2.6.39 and linux4sam kernel 4.9.36+ 
> on the AT91SAM9G20 (Stamp9G20 SOM from Taskit.de) and found regression 
> in the spi-atmel.c.
>
> New spi-atmel.c driver works very bad with SPI speeds above 6 MHz. I 
> see corruption in data received by Linux and SPI overruns when OS has 
> big CPI and IO load.
>
> Old kernel works fine at 22 MHz with the same device driver and hardware.
>
> Can somebody comment and/or help on how to resolve this issue?
>
> Best wishes.
> -- 
> Igor Plyatov

For those, who has same interest or encountered the same issue as I had...

Notes:
A) My "gs_mgms_dsp" linux driver is the same for linux-2.6.39 and 
linux-4.9.36
    and communicates with DSP through SPI-bus, where data packets are 32 
byte
    long and last byte is CRC8 to check data integrity.
B) CPU is AT91SAM9G20.

I have encoutered SPI data corruption during receiving of data from DSP by
linux-4.9.36 if SPI-bus has big traffic in parallel with big traffic at MMC
interface.

Old linux-2.6.39 does not suffer from such issue, because atmel-mci.c 
driver has
PIO access to MMC interface. While new kernel has changed the 
atmel-mci.c driver
for use of PDC (Peripheral DMA Controller) for access to MMC interface.

Both kernels have Atmel SPI driver where PDC used for SPI data transfers.

SPI data corruption looks like duplication of one of received bytes.
Such bytes surrounded by "**" at log below.

gs_mgms_dsp spi32766.0: CRC error.
gs_mgms_dsp spi32766.0: <- 35 36 37 38 39 3A 3B 3C 3D  3E 3F  40 41 42 43 44
gs_mgms_dsp spi32766.0: <- 45 46 47 48 49 4A 4B 4C 4D *4F 4F* 50 51 52 53 A4
gs_mgms_dsp spi32766.0: -> EIO=0x05
gs_mgms_dsp spi32766.0: CRC error.
gs_mgms_dsp spi32766.0: <- 0F C2 C3 C4 C5 C6 C7 C8 C9  CA CB  CC CD CE CF D0
gs_mgms_dsp spi32766.0: <- D1 D2 D3 D4 D5 D6 D7 D8 D9 *DB DB* DC DD DE DF 02
gs_mgms_dsp spi32766.0: -> EIO=0x05
gs_mgms_dsp spi32766.0: CRC error.
gs_mgms_dsp spi32766.0: <-  03 5A  5B 5C 5D 5E 5F 60 61 62 63 64 65 66 67 68
gs_mgms_dsp spi32766.0: <- *6A 6A* 6B 6C 6D 6E 6F 70 71 72 73 74 75 76 77 25
gs_mgms_dsp spi32766.0: -> EIO=0x05
gs_mgms_dsp spi32766.0: CRC error.
gs_mgms_dsp spi32766.0: <- 15 76 77 78 79 7A  7B 7C  7D 7E 7F 80 81 82 83 84
gs_mgms_dsp spi32766.0: <- 85 86 87 88 89 8A *8C 8C* 8D 8E 8F 90 91 92 93 00
gs_mgms_dsp spi32766.0: -> EIO=0x05
gs_mgms_dsp spi32766.0: CRC error.
gs_mgms_dsp spi32766.0: <- 2A EC ED EE EF F0 F1  F2 F3  F4 F5 F6 F7 F8 F9 FA
gs_mgms_dsp spi32766.0: <- FB FC FD FE FF 00 01 *03 03* 04 05 06 07 08 09 0A
gs_mgms_dsp spi32766.0: -> EIO=0x05

This looks like silent SPI overruns not detected by AT91SAM9G20 HW.

At the end, after some seconds or milliseconds of communication, HW SPI 
overrun
flag detected by the spi-atmel.c driver:
"atmel_spi fffcc000.spi: overrun (0/0 remaining)".

Strictly speaking this is not a regression of spi-atmel.c, but unfortunate
combination with atmel-mmc.c, where PDC used too and I suppose a HW bug in
AT91SAM9G20 CPU.

Please help to answer on questions:
   1) How to modify atmel-mci.c driver to have option for PIO access to MMC
      interface?
   2) Why SPI overrun flag does not asserted each time? I have not found 
such HW bug
      in the Errata for AT91SAM9G20 CPU.

Best wishes.
--
Igor Plyatov
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
