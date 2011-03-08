From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/3] mmc: skip detection of nonremovable cards on rescan -
 card removal detection regression
Date: Tue, 8 Mar 2011 18:44:43 +0200
Message-ID: <AANLkTin2Ky4sqJCqSePCWBP27Gfo4SdNmr0u16zskPMo@mail.gmail.com>
References: <1290921690-6133-1-git-send-email-ohad@wizery.com>
 <1290921690-6133-2-git-send-email-ohad@wizery.com> <20101217005123.GD17239@void.printf.net>
 <AANLkTi=ff=kkaRHOrDyoxOgw_Bt7raiPf3T=ed1=EveZ@mail.gmail.com>
 <1299205366.4999.3.camel@maxim-laptop> <AANLkTi=8Qi=-Ff1SQwBaxC5xxijMKPKAgFR17UGGTAvS@mail.gmail.com>
 <AANLkTi=tgV0Qqs+GuLVvF6fcVB2tL1e5aWZsMggTQGfX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47313 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab1CHQpE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2011 11:45:04 -0500
Received: by iwn34 with SMTP id 34so5007737iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 08 Mar 2011 08:45:03 -0800 (PST)
In-Reply-To: <AANLkTi=tgV0Qqs+GuLVvF6fcVB2tL1e5aWZsMggTQGfX@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Shmidt <dimitrysh@google.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Mon, Mar 7, 2011 at 9:01 PM, Dmitry Shmidt <dimitrysh@google.com> wr=
ote:
> On Sat, Mar 5, 2011 at 7:03 AM, Ohad Ben-Cohen <ohad@wizery.com> wrot=
e:
>> On Fri, Mar 4, 2011 at 4:22 AM, Maxim Levitsky <maximlevitsky@gmail.=
com> wrote:
>>> This patch breaks the CONFIG_MMC_UNSAFE_RESUME
>>
>> Does the below work for you (untested) ?
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 6625c05..150b5f3 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1529,7 +1529,7 @@ void mmc_rescan(struct work_struct *work)
>> =A0 =A0 =A0 =A0 * still present
>> =A0 =A0 =A0 =A0 */
>> =A0 =A0 =A0 =A0if (host->bus_ops && host->bus_ops->detect && !host->=
bus_dead
>> - =A0 =A0 =A0 =A0 =A0 && mmc_card_is_removable(host))
>> + =A0 =A0 =A0 =A0 =A0 && !(host->caps & MMC_CAP_NONREMOVABLE))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->bus_ops->detect(host);
>>
>> =A0 =A0 =A0 =A0/*
>>
> This works for me,

Thanks.

Maxim, does this work for you too ?
