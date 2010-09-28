From: dylan cristiani <d.cristiani@idem-tech.it>
Subject: Re: linux-2.6.36-rc4 problems booting rootfs from SD card
Date: Tue, 28 Sep 2010 16:04:34 +0200
Message-ID: <20100928160434.000044c1@unknown>
References: <20100928130043.000074b1@unknown>
	<4CA1F195.4080601@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from authsmtp04.register.it ([81.88.48.54]:32840 "EHLO
	authsmtp.register.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755505Ab0I1OEl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 10:04:41 -0400
In-Reply-To: <4CA1F195.4080601@yahoo.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hein_Tibosch <hein_tibosch@yahoo.es>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, 28 Sep 2010 21:45:57 +0800
Hein_Tibosch <hein_tibosch@yahoo.es> wrote:

>  On 28-9-2010 19:00, dylan cristiani wrote:
> > Hi sirs, here is my scenario: kernel 2.6.36-rc4; cpu pxa270;
> > platform is an enhancement (i like to see things that way...) and
> > customisation of the mainstone III board; here comes the (my)
> > problem: if i boot with my standard kernel boot command line (to
> > boot from system flash): 'root=/dev/mtdblock2 rootfstype=jffs2
> > mem=64M console=ttyS0,115200n8'
> >
> > i can get the rootfs up, and the SD card is up too, and correctly
> > working; here's the relevant kernel log:
> >
> > ....
> > XScale iWMMXt coprocessor detected.
> >  rtc-ds1307 0-0068: setting system clock to 2010-09-28 03:03:08 UTC
> > (1285642988)
> >  pxa27x-udc pxa27x-udc: USB reset
> >  mmc0: new SD card at address aaaa
> >  mmcblk0: mmc0:aaaa SD02G 1.84 GiB
> >   mmcblk0: p1
> >  pxa27x-udc pxa27x-udc: USB reset
> > .....
> >
> > then the rootfs coems up properly.
> >
> > Else, if i try to boot the rootfs directly form the SD card, with
> > kernel boot command line:
> > 'root=/dev/mmcblk0p1 rootfstype=ext2 mem=64M console=ttyS0,115200n8'
> >
> > the rootfs doen't work, and i can see some problems around with usb
> > client gadget; here's the relevant kernel log:
> >
> Hi Dylan
> 
> A reason could be that you linked the ext2 driver as a module,
> which is normally loaded after your jffs2 fs has booted?
> The solution would be to link it into the kernel, thus using
> "CONFIG_EXT2_FS=y" in stead of "=m"
Hi Hein, foa thanks for your answer, but the ext2 driver in compiled
into kernel not as a module but buil-into the kernel so i've already:
"CONFIG_EXT2_FS=y"
setted in my .config file
as i told you the booting form SD worked till 2.6.19 kernel and first
trouble i've seen is into 2.6.20

> 
> Note that ext3 is again more stable than ext2 and also supported by
> u-boot.
> 
> I hacked init/do_mounts.c
> 
> -        printk("VFS: Cannot open root device \"%s\" or %s\n",
> -                root_device_name, b);
> +        printk("VFS: Cannot open root device \"%s\" or %s (fstype %s
> err %d)\n",
> +                root_device_name, b, fs_names, err);
> 
> so at least I get some more error information.
i'll try this and if i'll get more info i'll post them

> 
> Good luck!
tks
dylan
