From: Philip Rakity <prakity@marvell.com>
Subject: Re: [patch] sdhci: remove SDHCI_QUIRK_FORCE_1_BIT_DATA
Date: Tue, 9 Nov 2010 04:31:09 -0800
Message-ID: <E20F99B0-BA20-4B63-B1EB-DD7AE3E2F79F@marvell.com>
References: <AANLkTimBGorfWHVCnVtUWx6n-22anXmQnKFXVGzB6TUf@mail.gmail.com>
 <20101109122739.GA6776@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:54110 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755228Ab0KIMcA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Nov 2010 07:32:00 -0500
In-Reply-To: <20101109122739.GA6776@oksana.dev.rtsoft.ru>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Xiaobo Xie <X.Xie@freescale.com>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kmpark@infradead.org>, Pierre Ossman <pierre@ossman.eu>


On Nov 9, 2010, at 4:27 AM, Anton Vorontsov wrote:

> Hi,
> 
> On Tue, Nov 09, 2010 at 06:37:58AM -0500, zhangfei gao wrote:
>> Here is patch to remove SDHCI_QUIRK_FORCE_1_BIT_DATA, which only used
>> in drivers/mmc/host/sdhci-of-core.c.
>> The reason is quirk is too valuable resource, the type is u32, while
>> the highest is (1<<29) now.
> 
> FYI, initially that wasn't a quirk. Here is Pierre's last opinion on that:
> 
> http://lists.ozlabs.org/pipermail/devicetree-discuss/2009-June/000981.html
> 
> Thanks,
> 
>> 1. MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA  is opened by default in sdhci.c

This a mistake that 8_BIT is opened.  means platform specific drivers need to change since
the functionality they assumed is incorrect.   Should be added after call to add_host() as needed by
each platform driver.  Zhangfei's suggested patch is good starting point for this.

>> 2. platform driver could close such flag after sdhci_add_host.
>> 
>> We have verified on our platform, would you mind check whether it
>> impact your driver behavior.
> 
> -- 
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2

