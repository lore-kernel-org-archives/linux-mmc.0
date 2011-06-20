From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: sdhci-pxa move platform data to
 include/linux/platform_data
Date: Mon, 20 Jun 2011 10:48:38 -0700
Message-ID: <FF568A6B-4BC3-477E-BADC-FA1E28B2BE6A@marvell.com>
References: <1308579112-5027-1-git-send-email-zhangfei.gao@marvell.com>
 <201106201829.09485.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:50330 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755388Ab1FTRtI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Jun 2011 13:49:08 -0400
In-Reply-To: <201106201829.09485.arnd@arndb.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zgao6@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>


Zhangfei,

Would you mind posting the patch to the mmc mailing list.  It has not shown up in my inbox.

Philip
On Jun 20, 2011, at 9:29 AM, Arnd Bergmann wrote:

> On Monday 20 June 2011, Zhangfei Gao wrote:
>> 
>>        As suggested by Arnd, move platform data to include/linux/platform_data,
>>        Add 'depends on CLKDEV_LOOKUP' since clk API is used,
>>        As a result driver could be built on all platforms which support CLKDEV_LOOKUP
>>        This can improve the build test coverage
>> 
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> CC: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> BTW, For some reason, your changelog text above is still indented funny. This should
> not happen if you use git-format-patch rather than git-show.
> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

