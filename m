From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: Enabling MMC BKOPs in kernel based on host caps
Date: Wed, 5 Oct 2016 17:37:20 +0800
Message-ID: <74289549-5576-c4fc-5270-8820c8654bc5@rock-chips.com>
References: <1475491384-15818-1-git-send-email-rk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:52819 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754060AbcJEJh1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2016 05:37:27 -0400
In-Reply-To: <1475491384-15818-1-git-send-email-rk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, Alex Lemberg <Alex.Lemberg@sandisk.com>

Hi Ravikumar,

+ Alex,

ÔÚ 2016/10/3 18:43, Ravikumar Kattekola Ð´µÀ:
> Hi all,
> 	I¡¯ve seen an eMMC failure due to pending background operations on a certain OMAP device since bkops enable bit was not set.
> Further investigation showed me that someone already posted patch to enable Background operations in kernel  based on a host capability check (Caps2 & BK_OPS_EN)
> but was turned down quoting that it should be enabled from user space using mmc-utils.
>
> Enabling this would add one additional check for exception event in the response R1 or R1B (only on hosts that explicitly set BK_OPS_EN in caps2).
> But not enabling this could lead to a system failure especially when the Filesystem is on eMMC and the card stops responding due to pending critical bkops.
>
> I would like to ask for expert opinion on ¡®why is it a bad idea to enable bkops in kernel?¡¯

Some discussion about the similar topic could be found here:
https://patchwork.kernel.org/patch/9157121/


> It¡¯s a one time programmable bit but if it helps in keeping system functional why not do it?

Actually BKOPS_EN is not OTP bit.. Quoted from Ulf "I don't have any
issue to allow all non-OTP registers bits to be written." So I guess
you could do this, although it needs more discussion there.

But it's persistent EXT_CSD register and we get used to control it from
userspace, which is the policy we have been sticking to when writing to
persistent EXT_CSD registers. I guess that is nothing about "right and
wrong", just a rule for us in case someone wants to set the persistent
bit in kernel but setting other persistent bits from user-space, which
is prone to mess up the mmc core. Or, someone will sent mail to the list
asking "why is it a good idea to enable bkops in kernel" ? :)

> I haven¡¯t measured the performance impact but I don¡¯t see a reason for major drop because the frequency of critical bkops events would be less.
>
> Regards,
> RK
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin

