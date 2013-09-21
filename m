From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: Adding aliases to mmc
Date: Sat, 21 Sep 2013 09:42:38 +0200
Message-ID: <20130921074238.GI30088@pengutronix.de>
References: <CAOMZO5CJ36JHJMaiG3QVdtpBoWd_ZyHQuRTrKHz4bLP39gpJtQ@mail.gmail.com>
 <5239C40C.9030503@wwwdotorg.org>
 <5239DC65.3080803@gmail.com>
 <5239DF55.8010308@wwwdotorg.org>
 <523A8A08.2060508@gmail.com>
 <523C7231.7040701@wwwdotorg.org>
 <523C79C4.1070308@gmail.com>
 <523C7FD0.3030006@wwwdotorg.org>
 <523D2D4F.6030802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37972 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134Ab3IUHmp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 21 Sep 2013 03:42:45 -0400
Content-Disposition: inline
In-Reply-To: <523D2D4F.6030802@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dirk Behme <dirk.behme@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Fabio Estevam <festevam@gmail.com>, linux-mmc@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>

Hi Dirk,

On Sat, Sep 21, 2013 at 07:23:27AM +0200, Dirk Behme wrote:
> Am 20.09.2013 19:03, schrieb Stephen Warren:
> >On 09/20/2013 10:37 AM, Dirk Behme wrote:
> >>Am 20.09.2013 18:05, schrieb Stephen Warren:
> >>>On 09/18/2013 11:22 PM, Dirk Behme wrote:
> >>>...
> >>>>If you have an embedded system were you just care a little about boot
> >>>>time you don't want to do anything like U-Boot's "part uuid" every time
> >>>>you boot. Or even worse, you just have a minimalistic boot loader (e.g.
> >>>>U-Boot's SPL) which doesn't know anything about UUIDs and file systems.
> >>>>
> >>>>As mentioned above, no I don't think UUIDs work for production embedded
> >>>>systems.
> >>>
> >>>As I said above, whatever generates the filesystem image can easily
> >>>embed the appropriate UUID in the system's boot scripts or bootloader
> >>>environment. There's no need to run the "part" command at run-time if
> >>>there's a more appropriate flow for your situation.
> >>
> >>Using a simple boot loader as an example, there are no boot scripts or
> >>boot loader environment. The only thing the boot loader does is loading
> >>the device tree and the kernel into RAM. Where do you want to embed an
> >>UUID in such a product?
> >
> >I think the initrd would be typical.
> 
> An embedded system typically doesn't have an initrd. The kernel
> boots directly into the rootfs on SD/eMMC.
> 
> >>To my understanding, the UUID is different for each SD card/eMMC, correct?
> >
> >Yes by default.
> >
> >Although for an embedded product with a fixed eMMC, there's no reason
> >you couldn't make every device have the same UUID for the fixed device.
> 
> How do you make the eMMC on 1000 boards have the same UUID?

The same way you ensure an identical partition table in these 1000
boards. The disk signature is just a four byte value at offset 440 in
the MBR. Set this to your birthday or whatever on all boards, pass
root=PARTUUID=<yourbirthday>-01 on all boards and you're done.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
