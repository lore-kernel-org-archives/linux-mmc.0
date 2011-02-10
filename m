From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 5/5] OMAP: devices: Modify HSMMC device to adapt to hwmod framework
Date: Thu, 10 Feb 2011 13:10:39 -0800
Message-ID: <87d3mzioj4.fsf@ti.com>
References: <1296660462-28489-1-git-send-email-kishore.kadiyala@ti.com>
	<1296660462-28489-6-git-send-email-kishore.kadiyala@ti.com>
	<878vxqi0un.fsf@ti.com>
	<AANLkTimN68yMC6BxHOvsJSu_Ddw8Lxr9oxzpx3vy7gxP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:34113 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755660Ab1BJVKn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Feb 2011 16:10:43 -0500
In-Reply-To: <AANLkTimN68yMC6BxHOvsJSu_Ddw8Lxr9oxzpx3vy7gxP@mail.gmail.com>
	(Kishore Kadiyala's message of "Thu, 10 Feb 2011 22:38:16 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, paul@pwsan.com

"Kadiyala, Kishore" <kishore.kadiyala@ti.com> writes:

[...]

>
>>
>> The board code should simply call some mmc init routine optionally
>> passing int the platform_data, just like is done for hsmmc_init.
>>
>> With common hwmod data, shouldn't it be possible to unify the init of
>> MMC and HS-MMC controllers?
>
> The init of MMC & HS-MMC are different.

> HSMMC supported boards, the board file fills an intermediate structure
> omap2_hsmmc_info which is used by the hsmmc.c file to update the
> omap_mmc_platform_data.
>
> MMC supported boards, the board file fills the omap_mmc_platform_data.

Yes, I understand how they are different _today_.  My question is that
now that we're using hwmod, is there any real reason they need to remain
different.

>
> Ok, will try to keep an API common for init of both MMC & HSMMC
>

Thanks,

Kevin
