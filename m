From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/3] mmc: skip detection of nonremovable cards on rescan -
 card removal detection regression
Date: Sat, 5 Mar 2011 17:03:39 +0200
Message-ID: <AANLkTi=8Qi=-Ff1SQwBaxC5xxijMKPKAgFR17UGGTAvS@mail.gmail.com>
References: <1290921690-6133-1-git-send-email-ohad@wizery.com>
 <1290921690-6133-2-git-send-email-ohad@wizery.com> <20101217005123.GD17239@void.printf.net>
 <AANLkTi=ff=kkaRHOrDyoxOgw_Bt7raiPf3T=ed1=EveZ@mail.gmail.com> <1299205366.4999.3.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40022 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab1CEPD7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Mar 2011 10:03:59 -0500
Received: by iyb26 with SMTP id 26so2711905iyb.19
        for <linux-mmc@vger.kernel.org>; Sat, 05 Mar 2011 07:03:59 -0800 (PST)
In-Reply-To: <1299205366.4999.3.camel@maxim-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>

On Fri, Mar 4, 2011 at 4:22 AM, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> On Mon, 2010-12-20 at 00:11 +0200, Ohad Ben-Cohen wrote:
>> Hi Chris,
>>
>> On Fri, Dec 17, 2010 at 2:51 AM, Chris Ball <cjb@laptop.org> wrote:
>> ...
>> > Thanks, pushed to mmc-next with trivial cleanup as below:
>>
>> Looks good, thanks.
>>
>> I just briefly tested mmc-next and it looks fine.
>
> This patch breaks the CONFIG_MMC_UNSAFE_RESUME

Does the below work for you (untested) ?

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 6625c05..150b5f3 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1529,7 +1529,7 @@ void mmc_rescan(struct work_struct *work)
 	 * still present
 	 */
 	if (host->bus_ops && host->bus_ops->detect && !host->bus_dead
-	    && mmc_card_is_removable(host))
+	    && !(host->caps & MMC_CAP_NONREMOVABLE))
 		host->bus_ops->detect(host);

 	/*
