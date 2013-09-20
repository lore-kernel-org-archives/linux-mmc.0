From: =?ISO-8859-1?Q?Kevyn=2DAlexandre_Par=E9?=
	<kevyn.alexandre.pare@gmail.com>
Subject: Re: OMAP35x MMC Host Controller compatibility with SDXC?
Date: Fri, 20 Sep 2013 13:13:38 -0400
Message-ID: <CAL1yNcJMOQ8+YQUeiqZssCsQSNenvnRhtipPh+kkcw-rHa6zpQ@mail.gmail.com>
References: <CAL1yNcLxUnDCfZJxLVUjSDLtgvuBYEjL-pw_aZ8dA1rVu5o=4Q@mail.gmail.com>
	<523B0AB1.1050008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <523B0AB1.1050008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Balaji,

>> My test shows that I'm having some timeout in some cases (v3.4.60):
>> omap_hsmmc omap_hsmmc.0: IRQ Status is 18000
>> omap_hsmmc omap_hsmmc.0: MMC IRQ 0x18000 : ERRI CTO
>> mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
>> mmc0: starting CMD52 arg 80000c08 flags 00000195
>>
>> omap_hsmmc omap_hsmmc.0: mmc0: CMD5, argument 0x00000000
>> omap_hsmmc omap_hsmmc.0: IRQ Status is 18000
>> omap_hsmmc omap_hsmmc.0: MMC IRQ 0x18000 : ERRI CTO
>> mmc0: req failed (CMD5): -110, retrying...
>>
>> mmc1: starting CMD8 arg 000001aa flags 000002f5
>> omap_hsmmc omap_hsmmc.1: mmc1: CMD8, argument 0x000001aa
>> mmc0: starting CMD18 arg 00020000 flags 000000b5
>> omap_hsmmc omap_hsmmc.1: IRQ Status is 18000
>> omap_hsmmc omap_hsmmc.1: MMC IRQ 0x18000 : ERRI CTO
>> mmc1: req done (CMD8): -110: 00000000 00000000 00000000 00000000
>>
>> So CMD 52,5 and 8 gives me timeout...
>
>
> For SD cards, these cmd's are expected to timeout during card
> initialization.

When you say that they are expected to timeout for SD are you
including for microSD also? So for what will it not timeout normally
(CMD 52,5 and 8)?

>> Looking at the 3.11.1 there is 2 more validation for UHS that are not in
>> 3.4.60:
>> omap_hsmmc_set_clock  // Enable High-Speed Support
>> omap_set_bus_width
>>
>
> Those changes are not for SD3.0 speed modes

thx for the confirmation.

>> Is it safe to use SDXC with OMAP35x or not? Should this pop a error
>> message?
>
>
> SDXC cards should work albeit at High Speed mode (as in SD2.0).
> Refer to [1] for card size Vs speed mode/SD spec version.

Your link clearly says that there should be no problem running SDXC
with Spec 2.0:

High Speed  SD, SDHC and SDXC ---  25MB/s 2.00

> Can you check if the filesystem type on SDXC card
> is supported by the system software running on OMAP35x.

By that you mean?

I'm using similar script as this one to partition my system:
http://git.sakoman.com/git/gitweb.cgi?p=meta-sakoman.git;a=blob;f=scripts/mksdcard.sh;h=a817935dba988f6f0f0c3dd534374797a661034e;hb=HEAD

Creating 2 partition boot (FAT32) and rootfs (EXT3):
mkfs.vfat -F 32 -n boot ${PART1}
mke2fs -j -L rootfs ${PART2}


Just to help you understand a bit more the reason of my question. I'm
having a MMC error only with (micro)SDXC 64GB ((micro)SDHC 32GB no
problem so far) and our system is not booting the rootfs.

card mmcblk0: error -110 sending status command, retrying
... (stuck there infinitely if tune2fs -e continue)
see my post:
http://marc.info/?l=linux-omap&m=137764004920777&w=3

Best Regards,

-KA
