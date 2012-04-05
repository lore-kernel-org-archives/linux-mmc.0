From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: omap4: hsmmc: fix module re-insertion
Date: Thu, 05 Apr 2012 18:14:16 -0400
Message-ID: <87sjgh7rnr.fsf@laptop.org>
References: <1331222320-31370-1-git-send-email-balajitk@ti.com>
	<20120405221136.GG3785@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34925 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755328Ab2DEWOV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Apr 2012 18:14:21 -0400
In-Reply-To: <20120405221136.GG3785@atomide.com> (Tony Lindgren's message of
	"Thu, 5 Apr 2012 15:11:37 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

Hi Tony,

On Thu, Apr 05 2012, Tony Lindgren wrote:
> * Balaji T K <balajitk@ti.com> [120308 07:27]:
>> OMAP4 and OMAP3 HSMMC IP registers differ by 0x100 offset.
>> Addng the offset to platform_device resource structure
>> increments the start address for every insmod operation.
>> MMC command fails on re-insertion as module due to incorrect register base.
>> Fix this by updating the ioremap base address only.
>
> Any news on getting this fix merged during the -rc cycle?
>
> This is pretty important fix for anybody wanting to reload
> the omap_hsmmc.ko module..

It's in my fixes branch, planning on sending that to Linus tomorrow.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
