From: Chris Ball <cjb@laptop.org>
Subject: Re: FW: [PATCH 2.6.32]: Add new device IDs and
	registersforMULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) cards.
Date: Tue, 30 Nov 2010 04:51:03 +0000
Message-ID: <20101130045103.GA3451@void.printf.net>
References: <20101127045914.GA28590@void.printf.net> <FC57104DF444434A9D1D8A7B4EBB292308145108@HC-EXCHANGE.nt-fsrvr.o2micro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53961 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046Ab0K3EvG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Nov 2010 23:51:06 -0500
Content-Disposition: inline
In-Reply-To: <FC57104DF444434A9D1D8A7B4EBB292308145108@HC-EXCHANGE.nt-fsrvr.o2micro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Jennifer Li (TP)" <Jennifer.Li@o2micro.com>
Cc: linux-mmc@vger.kernel.org, Mario_Limonciello@Dell.com, Joseph_Yeh@Dell.com, Chris Van Hoof <vanhoof@canonical.com>, Rezwanul_Kabir@Dell.com, "Shirley Her (SC)" <shirley.her@o2micro.com>, "Rich Lin (TP)" <RichLin@o2micro.com>, "Samuel Guan(WH)" <samuel.guan@o2micro.com>, "Hardys Lv(WH)" <hardys.lv@o2micro.com>, "William Lian (TP)" <William.Lian@o2micro.com>

Hi Jennifer,

On Mon, Nov 29, 2010 at 10:06:18AM +0800, Jennifer Li (TP) wrote:
> Hi Chris,
> 
> 1. We don't need disable ADMA on the 8120 device. For safety, we have
> prepared a device ID for device 8120. 
> 
> 2. 0x01 bit is a lock/unlock bit. The CAPABILITIES register could be
> opened by the 0x01 bit. If we set the 0x01, the CAPABILITIES register
> can be written. We have to set the 0x01 bit.

Perfect, thanks for the answers.  I've added a comment explaining the
unlock bit.

I've queued your patch for inclusion in the Linux 2.6.38 release now.
It'd be great if you could test the 2.6.38-rc1 kernel when it's released
(sometime around February) and check that everything's working on your
hardware.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
