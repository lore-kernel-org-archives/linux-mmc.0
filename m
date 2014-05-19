From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH v2 0/5] mmc: sdhci: a few fixes on timeout and max_discard_to
Date: Mon, 19 May 2014 10:43:01 +0800
Message-ID: <CAA+hA=QuWZudYbgv+K-amUJxLC7MyY2MNUXw10tTFvCOTCo8xA@mail.gmail.com>
References: <1387268191-19859-1-git-send-email-b29396@freescale.com>
	<20140517140902.GB12916@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:41591 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969AbaESCnC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 May 2014 22:43:02 -0400
Received: by mail-qg0-f48.google.com with SMTP id i50so7747799qgf.21
        for <linux-mmc@vger.kernel.org>; Sun, 18 May 2014 19:43:01 -0700 (PDT)
In-Reply-To: <20140517140902.GB12916@dragon>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Dong Aisheng <b29396@freescale.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ed Sutter <ed.sutter@alcatel-lucent.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, May 17, 2014 at 10:09 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Tue, Dec 17, 2013 at 04:16:26PM +0800, Dong Aisheng wrote:
>> Patch 1~4 mainly fixes the issue that the max timeout counter for uSDHC is
>> 1 << 28 rather than 1 << 27. 1~2 fix getting the max timeout counter
>> while 3~4 fix setting the max timeout.
>> Thus it introduces two new platform hook: get_max_timeout_count and set_timeout
>> for those platform which have different timeout setting.
>>
>> This issue is firstly reported here by Ed Sutter:
>> http://www.spinics.net/lists/linux-mmc/msg23375.html
>> The root cause is the max_discard_to got from uSDHC is too small, only 677ms,
>> which cause the max_discard_bytes for eMMC is only 512, then the discard operation
>> of mkfs.ext3 for an eMMC card is too slow, just like dead.
>> With above patches, the issue can be fixed.
>
> It seems the series got lost?  The issue reported by Ed Sutter is still
> there with the latest kernel.
>
> Dong, you may need to rebase it a little bit and resend.
>

Yes, it's lost.
I will rebase and resend it.

Regards
Dong Aisheng

> Shawn
>
>>
>> Patch 5 adds the capability to calcalute the max_discard_to dynamically
>> for SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK.
>>
>> Originally the max_discard_to for a high speed sdhc card may be:
>> mmc1: new high speed SDHC card at address aaaa
>> mmc1: calculated max. discard sectors 49152 for timeout 1355 ms
>> After fix:
>> mmc1: new high speed SDHC card at address aaaa
>> mmc1: calculated max. discard sectors 712704 for timeout 5422 ms
>>
>> It also improves the card discard performance a lot due to max_discard_sectors
>> increase a lot.
>>
>> There's also discussion about remove max_discard_to limit here:
>> http://www.spinics.net/lists/linux-mmc/msg23395.html
>> But it does not help for uSDHC since we can observe data timeout
>> on a Toshiba SD3.0 cards if we do not disable data timeout interrupt.
>>
>> ChangeLog:
>> v1->v2:
>>  1. change .get_max_timeout to .get_max_timeout_count to reuse some code
>>  2. some other minor changes based on Shawn's comment.
>>  3. patch 6 in v1 is dropped since not need anymore after change 1
>>
>>
>>
>> Dong Aisheng (5):
>>   mmc: sdhci: add platfrom get_max_timeout_count hook
>>   mmc: sdhci-esdhc-imx: fix incorrect max_discard_to for uSDHC
>>   mmc: sdhci: add platform set_timeout hook
>>   mmc: sdhci-esdhc-imx: set the correct max timeout value for uSDHC
>>   mmc: sdhci: calculate max_discard_to dynamically for
>>     SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
>>
>>  drivers/mmc/host/sdhci-esdhc-imx.c |   20 +++++++++++
>>  drivers/mmc/host/sdhci.c           |   66 +++++++++++++++++++++++------------
>>  drivers/mmc/host/sdhci.h           |    3 ++
>>  3 files changed, 66 insertions(+), 23 deletions(-)
>>
>> --
>> 1.7.2.rc3
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
