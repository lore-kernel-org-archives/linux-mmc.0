From: Ben Dooks <ben@trinity.fluff.org>
Subject: Re: About mmc delayed workqueue.
Date: Wed, 30 Mar 2011 00:34:59 +0100
Message-ID: <20110329233459.GI27290@trinity.fluff.org>
References: <AANLkTikB-g44H80hLsrBUcJ4svOZAXisBvFvno4uqKm+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:52159 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751746Ab1C2XfQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 29 Mar 2011 19:35:16 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikB-g44H80hLsrBUcJ4svOZAXisBvFvno4uqKm+@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NamJae Jeon <linkinjeon@gmail.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

On Wed, Mar 30, 2011 at 08:33:12AM +0900, NamJae Jeon wrote:
> Hi. Chris.
> 
> I found some problem in mmc driver.  As you know, in nand trend, emmc
> nand is used  booting device in embededd product.

yeah, a really nasty trend if you ask me.
 
> It means that kernel, rootfs image is stored in emmc nand device. and
> when rescaning mmc, mmc driver is working by delay work queue.
> 
> It can be cause "can not mount rootfs".  If  kernel mounting is faster
> than mmc rescan, this problem would occur..
> 
> I changed to schedule_work instead of mmc_schedule_delayed_work. I can
> make patch & test.
> 
> could you tell me your opinion ?

Use root_wait on the commandline and it will wait for the root device
to become reayd.
 
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.

