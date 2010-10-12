From: Hein_Tibosch <hein_tibosch@yahoo.es>
Subject: Re: [PATCH v2] mmc_rescan: reduce verbosity
Date: Wed, 13 Oct 2010 04:51:46 +0800
Message-ID: <4CB4CA62.7040009@yahoo.es>
References: <20101012060045.GA8252@pengutronix.de> <1286868577-7729-1-git-send-email-eric@eukrea.com> <20101012150850.GA18009@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bosmailout11.eigbox.net ([66.96.184.11]:53413 "EHLO
	bosmailout11.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab0JLV7T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2010 17:59:19 -0400
Received: from bosmailscan04.eigbox.net ([10.20.15.4])
	by bosmailout11.eigbox.net with esmtp (Exim)
	id 1P5lrM-00046C-4f
	for linux-mmc@vger.kernel.org; Tue, 12 Oct 2010 16:54:08 -0400
In-Reply-To: <20101012150850.GA18009@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>

 On 12-10-2010 23:08, Chris Ball wrote:
> Hi Eric,
>
> On Tue, Oct 12, 2010 at 09:29:37AM +0200, Eric B=E9nard wrote:
>> since commit 820f2bcfdc32cd90061224c930cf670f961e12d1 mmc_rescan
>> includes a pr_info which prints 4 lines each second for hosts config=
ured
>> with MMC_CAP_NEEDS_POLL. Tested on i.MX51's sdhci-esdhc.
>> This patch enable the log only if CONFIG_MMC_DEBUG is selected.
>>
>> Signed-off-by: Eric B=E9nard <eric@eukrea.com>
>> ---
>> v2 : enable log only if CONFIG_MMC_DEBUG is selected
>> v1 : use pr_debug instead of pr_info
>>  drivers/mmc/core/core.c |    3 ++-
>>  1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index c94565d..cda9d29 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1482,9 +1482,10 @@ void mmc_rescan(struct work_struct *work)
>>  			mmc_release_host(host);
>>  			goto out;
>>  		}
>> +#ifdef CONFIG_MMC_DEBUG
>>  		pr_info("%s: %s: trying to init card at %u Hz\n",
>>  			mmc_hostname(host), __func__, host->f_init);
>> -
>> +#endif
I first wrote this line while testing the patch for "configurable ID fr=
eq".
I left it in thinking it would only trigger while booting or mounting a
new card, not being aware of the MMC_CAP_NEEDS_POLL option.
Sorry for that,

Acked-by: Hein Tibosch <hein_tibosch@yahoo.es>

