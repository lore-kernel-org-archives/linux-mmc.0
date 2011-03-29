From: Chris Ball <cjb@laptop.org>
Subject: Re: About mmc delayed workqueue.
Date: Tue, 29 Mar 2011 19:44:46 -0400
Message-ID: <m3sju58pap.fsf@pullcord.laptop.org>
References: <AANLkTikB-g44H80hLsrBUcJ4svOZAXisBvFvno4uqKm+@mail.gmail.com>
	<20110329233459.GI27290@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50436 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683Ab1C2Xi5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 29 Mar 2011 19:38:57 -0400
In-Reply-To: <20110329233459.GI27290@trinity.fluff.org> (Ben Dooks's message
	of "Wed, 30 Mar 2011 00:34:59 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben@trinity.fluff.org>
Cc: NamJae Jeon <linkinjeon@gmail.com>, linux-mmc@vger.kernel.org

Hi,

On Tue, Mar 29 2011, Ben Dooks wrote:
> On Wed, Mar 30, 2011 at 08:33:12AM +0900, NamJae Jeon wrote:
>> Hi. Chris.
>> 
>> I found some problem in mmc driver.  As you know, in nand trend, emmc
>> nand is used  booting device in embededd product.
>
> yeah, a really nasty trend if you ask me.
>  
>> It means that kernel, rootfs image is stored in emmc nand device. and
>> when rescaning mmc, mmc driver is working by delay work queue.
>> 
>> It can be cause "can not mount rootfs".  If  kernel mounting is faster
>> than mmc rescan, this problem would occur..
>> 
>> I changed to schedule_work instead of mmc_schedule_delayed_work. I can
>> make patch & test.
>> 
>> could you tell me your opinion ?
>
> Use root_wait on the commandline and it will wait for the root device
> to become reayd.

Ben's right that you should use "rootwait" (I don't think it works with
the underscore in the middle), rootdelay=5 if you want the boot to fail
if the partition isn't mounted after a little extra time, or an initrd
if you want full control over rootfs mounting.

These parameters are documented in Documentation/kernel-parameters.txt.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
