From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Fix the incorrect calculation for erase unit size.
Date: Tue, 13 Sep 2011 22:29:52 -0400
Message-ID: <m21uvjc0v3.fsf@bob.laptop.org>
References: <1315461565-16009-1-git-send-email-tgih.jun@samsung.com>
	<m24o0n6ujm.fsf@bob.laptop.org>
	<002f01cc7285$d80dc660$88295320$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59975 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753681Ab1INCaC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 13 Sep 2011 22:30:02 -0400
In-Reply-To: <002f01cc7285$d80dc660$88295320$%jun@samsung.com> (Seungwon
	Jeon's message of "Wed, 14 Sep 2011 11:27:26 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com

Hi,

On Tue, Sep 13 2011, Seungwon Jeon wrote:
>> On Thu, Sep 08 2011, Seungwon Jeon wrote:
>> > Erase unit size of high capacity is multiple of 512KiB not 1024KiB.
>> 
>> Could we have some more info, please?  What are the visible symptoms
>> of the erase unit size being incorrect, how did you realize this was
>> a problem, should this patch be applied to stable@, etc.
>
> It is mentioned from eMMC Spec.
> Erase unit size is defined in 512Kbyte * HC_ERASE_GRP_SIZE(EXT_CSD[224]).

You haven't answered any of the other questions I asked, though.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
