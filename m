From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: linux-2.6.36-rc4 problems booting rootfs from SD card
Date: Tue, 28 Sep 2010 17:16:41 +0300
Message-ID: <201009281716.42122.anarsoul@gmail.com>
References: <20100928130043.000074b1@unknown>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54437 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab0I1OSL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 10:18:11 -0400
Received: by eyb6 with SMTP id 6so1773519eyb.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Sep 2010 07:18:10 -0700 (PDT)
In-Reply-To: <20100928130043.000074b1@unknown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: dylan cristiani <d.cristiani@idem-tech.it>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 28 of September 2010 14:00:43 dylan cristiani wrote:
> Hi sirs, here is my scenario: kernel 2.6.36-rc4; cpu pxa270; platform
> is an enhancement (i like to see things that way...) and customisatio=
n
> of the mainstone III board; here comes the (my) problem: if i boot wi=
th
> my standard kernel boot command line (to boot from system flash):
> 'root=3D/dev/mtdblock2 rootfstype=3Djffs2 mem=3D64M console=3DttyS0,1=
15200n8'
>=20
> i can get the rootfs up, and the SD card is up too, and correctly
> working; here's the relevant kernel log:
>=20
> ....
> XScale iWMMXt coprocessor detected.
>  rtc-ds1307 0-0068: setting system clock to 2010-09-28 03:03:08 UTC
> (1285642988)
>  pxa27x-udc pxa27x-udc: USB reset
>  mmc0: new SD card at address aaaa
>  mmcblk0: mmc0:aaaa SD02G 1.84 GiB
>   mmcblk0: p1
>  pxa27x-udc pxa27x-udc: USB reset
> .....
>=20
> then the rootfs coems up properly.
>=20
> Else, if i try to boot the rootfs directly form the SD card, with
> kernel boot command line:
> 'root=3D/dev/mmcblk0p1 rootfstype=3Dext2 mem=3D64M console=3DttyS0,11=
5200n8'
>=20
> the rootfs doen't work, and i can see some problems around with usb
> client gadget; here's the relevant kernel log:
>=20
> ....
> XScale iWMMXt coprocessor detected.
>  rtc-ds1307 0-0068: setting system clock to 2010-09-28 03:03:43 UTC
> (1285643023)
>  VFS: Cannot open root device "mmcblk0p1" or unknown-block(0,0)
>  Please append a correct "root=3D" boot option; here are the availabl=
e
> partitions:
>  1f00             256 mtdblock0 (driver?)
>  1f01            2048 mtdblock1 (driver?)
>  1f02           63232 mtdblock2 (driver?)
>  Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown-block(0,0)
>  Backtrace:
>  [] (dump_backtrace+0x0/0x118) from [] (dump_stack+0x18/0x1c)
> r6:00008000 r5:c3813000 r4:c0417b70 r3:c03f5714
>  [] (dump_stack+0x0/0x1c) from [] (panic+0x60/0x18c)
>  [] (panic+0x0/0x18c) from [] (mount_block_root+0x25c/0x2ac)
>  pxa27x-udc pxa27x-udc: ep0:handle_ep0: state=3DWAIT_FOR_SETUP,
> req=3D(null), udccsr0=3D0x2c1, udcbcr=3D8, irq_msk=3D1
>  pxa27x-udc pxa27x-udc: ep0:set_ep0state:
> state=3DWAIT_FOR_SETUP->SETUP_STAGE, udccsr0=3D0x2c1, udcbcr=3D8
>  pxa27x-udc pxa27x-udc: ep0:handle_ep0_ctrl_req: SETUP 80.06 v0100
> i0000 l0040
>  pxa27x-udc pxa27x-udc: ep0:set_ep0state:
> state=3DSETUP_STAGE->IN_DATA_STAGE, udccsr0=3D0x281, udcbcr=3D0
>  pxa27x-udc pxa27x-udc: ep0:pxa_ep_queue: queue req
> c393dbc0(first=3Dyes), len 18 buf c386d000
>  pxa27x-udc pxa27x-udc: ep0:write_ep0_fifo: in 16 bytes, 2 left,
> req=3Dc393dbc0, udccsr0=3D0x202
>  pxa27x-udc pxa27x-udc: USB reset
>  pxa27x-udc pxa27x-udc: USB reset start
>  pxa27x-udc pxa27x-udc: ep0:req_done: complete req c393dbc0 stat -71
> len 16/18
>  g_ether gadget: setup complete --> -71, 16/18
>  pxa27x-udc pxa27x-udc: ep0:set_ep0state:
> state=3DIN_DATA_STAGE->WAIT_FOR_SETUP, udccsr0=3D0x200, udcbcr=3D0
>  pxa27x-udc pxa27x-udc: ep0:handle_ep0: state=3DWAIT_FOR_SETUP,
> req=3D(null), udccsr0=3D0x200, udcbcr=3D0, irq_msk=3D1
>   r3:00000001 r2:20000013 r1:c3825f60 r0:c039601b
>  [] (mount_block_root+0x0/0x2ac) from [] (mount_root+0x54/0x6c)
>   r8:00000000 r7:00000013 r6:c0051e48 r5:00000000 r4:c039607f
>  [] (mount_root+0x0/0x6c) from [] (prepare_namespace+0x12c/0x184)
>   r5:c00203c1 r4:c00203ac
>  [] (prepare_namespace+0x0/0x184) from [] (kernel_init+0x114/0x154)
>   r5:c00083d4 r4:c0416e60
>  [] (kernel_init+0x0/0x154) from [] (do_exit+0x0/0x5dc)
>   r4:00000000 r3:00000000
> ....
>=20
> last months i ported my system form ancient 2.6.18 kernel to my curre=
nt
> kernel (2.6.36-rc4), but i remember that with 2.6.18 the rootfs's
> booting from SD did work; so i re-loaded 2.6.18 zImage, and in fact t=
he
> SD roots booting worked properly; then i investigated a bit and i hav=
e
> found that also with 2.6.19 it worked, while with 2.6.20 it stopped
> working (i didn't try between 2.6.20 and 2.6.36-rc4 but if it's helpf=
ul
> i can do it).
> The only way to solve my problem was to 'patch' the file
> drivers/Makefile, moving the mmc.o object file upward; here is a sort=
 of
> 'patch', but i regret in advance for some 'possible' (i had to write
> 'sure', but i like to be modest person....) syntax mistake, but i'm n=
ot
> in habbit with patches...:
>=20
>  --- a/drivers/Makefile
>  +++ b/drivers/Makefile
>  @@ -44,7 +44,8 @@
>   obj-y                +=3D macintosh/
>   obj-$(CONFIG_IDE)        +=3D ide/
>   obj-$(CONFIG_SCSI)        +=3D scsi/
>   obj-$(CONFIG_ATA)        +=3D ata/
>   obj-$(CONFIG_MTD)        +=3D mtd/
>   obj-$(CONFIG_SPI)        +=3D spi/
>  +obj-$(CONFIG_MMC)        +=3D mmc/
>   obj-y                +=3D net/
>  @@ -92,9 +93,8 @@
>   obj-y                +=3D lguest/
>   obj-$(CONFIG_CPU_FREQ)        +=3D cpufreq/
>   obj-$(CONFIG_CPU_IDLE)        +=3D cpuidle/
>  -obj-$(CONFIG_MMC)        +=3D mmc/
>   obj-$(CONFIG_MEMSTICK)        +=3D memstick/
>   obj-$(CONFIG_NEW_LEDS)        +=3D leds/
>   obj-$(CONFIG_INFINIBAND)    +=3D infiniband/
>   obj-$(CONFIG_SGI_SN)        +=3D sn/
>   obj-y                +=3D firmware/
>=20
> stated that it's not clear to me why when i don't try to boot the
> rootfs directly from the SD, its driver comes up in the right way, an=
d
> the SD works, while when i try to boot the rootfs from the SD i canno=
t
> get things to work (maybe the device is not up yet when the VFS
> tryies to come up in fact in such a situation i cannot read any log
> about mmc0 device!), i was wondering if this patch could be fair or
> maybe (probably) i'm missing some potential side effects???
> any hint will be appreciated!!!
> thanks and bye
>=20
> -
>=20
> dylan cristiani
>=20
> --
> Fortunately I=E2=80=99ve been adhering to a pretty strict, uh, drug r=
egimen to
> keep my mind, you know, uh, limber...
> ---

It seems you're missing rootdelay=3D[0-9]+ argument to kernel
