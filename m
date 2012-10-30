From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: at91-mci: remove driver
Date: Tue, 30 Oct 2012 11:38:30 -0400
Message-ID: <87a9v4otqh.fsf@octavius.laptop.org>
References: <1351520875-31891-1-git-send-email-ludovic.desroches@atmel.com>
	<87625txrou.fsf@octavius.laptop.org>
	<20121030150113.GB19021@game.jcrosoft.org>
	<87ehkgov3a.fsf@octavius.laptop.org>
	<20121030153350.GC19021@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47154 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757563Ab2J3Pif (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 30 Oct 2012 11:38:35 -0400
In-Reply-To: <20121030153350.GC19021@game.jcrosoft.org> (Jean-Christophe
	PLAGNIOL-VILLARD's message of "Tue, 30 Oct 2012 16:33:50 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com

Hi,

On Tue, Oct 30 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 11:09 Tue 30 Oct     , Chris Ball wrote:
>> Hi,
>> 
>> On Tue, Oct 30 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> >> Thanks!  Pushed to mmc-next for 3.8.
>> >
>> > if you don't mind I prefer to take it via at91
>> >
>> > I've a patch series that cleanup the platform_data it's difficult to merge
>> > with this one
>> 
>> Hm, I don't understand why it should be difficult to merge.  Is it
>> because this patch modifies arch/arm/mach-at91/include/mach/board.h?
>> 
>> If so, sounds like we should just take that change out of this patch
>> and have it go into your platform data cleanup patch, and then I can
>> merge the drivers/mmc change independently?  Let me know what you think.
> I'm modifing and moiving the board.h so this file will not exist anymore
>
> and the platform data are not anymore in arch/arm/mach-at91/include/mach/board.h

Can we take the modification of board.h out of this patch, then,
leaving just the drivers/mmc/ changes?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
