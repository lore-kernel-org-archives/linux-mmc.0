From: Dmitry Shmidt <dimitrysh@google.com>
Subject: Re: [PATCH 1/3] mmc: skip detection of nonremovable cards on rescan -
 card removal detection regression
Date: Mon, 7 Mar 2011 11:01:51 -0800
Message-ID: <AANLkTi=tgV0Qqs+GuLVvF6fcVB2tL1e5aWZsMggTQGfX@mail.gmail.com>
References: <1290921690-6133-1-git-send-email-ohad@wizery.com>
	<1290921690-6133-2-git-send-email-ohad@wizery.com>
	<20101217005123.GD17239@void.printf.net>
	<AANLkTi=ff=kkaRHOrDyoxOgw_Bt7raiPf3T=ed1=EveZ@mail.gmail.com>
	<1299205366.4999.3.camel@maxim-laptop>
	<AANLkTi=8Qi=-Ff1SQwBaxC5xxijMKPKAgFR17UGGTAvS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:9304 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747Ab1CGTB5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2011 14:01:57 -0500
Received: from wpaz13.hot.corp.google.com (wpaz13.hot.corp.google.com [172.24.198.77])
	by smtp-out.google.com with ESMTP id p27J1rLd029079
	for <linux-mmc@vger.kernel.org>; Mon, 7 Mar 2011 11:01:53 -0800
Received: from iyf40 (iyf40.prod.google.com [10.241.50.104])
	by wpaz13.hot.corp.google.com with ESMTP id p27J1hTK020821
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 7 Mar 2011 11:01:52 -0800
Received: by iyf40 with SMTP id 40so5639006iyf.16
        for <linux-mmc@vger.kernel.org>; Mon, 07 Mar 2011 11:01:52 -0800 (PST)
In-Reply-To: <AANLkTi=8Qi=-Ff1SQwBaxC5xxijMKPKAgFR17UGGTAvS@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Sat, Mar 5, 2011 at 7:03 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Fri, Mar 4, 2011 at 4:22 AM, Maxim Levitsky <maximlevitsky@gmail.c=
om> wrote:
>> On Mon, 2010-12-20 at 00:11 +0200, Ohad Ben-Cohen wrote:
>>> Hi Chris,
>>>
>>> On Fri, Dec 17, 2010 at 2:51 AM, Chris Ball <cjb@laptop.org> wrote:
>>> ...
>>> > Thanks, pushed to mmc-next with trivial cleanup as below:
>>>
>>> Looks good, thanks.
>>>
>>> I just briefly tested mmc-next and it looks fine.
>>
>> This patch breaks the CONFIG_MMC_UNSAFE_RESUME
>
> Does the below work for you (untested) ?
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 6625c05..150b5f3 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1529,7 +1529,7 @@ void mmc_rescan(struct work_struct *work)
> =A0 =A0 =A0 =A0 * still present
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (host->bus_ops && host->bus_ops->detect && !host->b=
us_dead
> - =A0 =A0 =A0 =A0 =A0 && mmc_card_is_removable(host))
> + =A0 =A0 =A0 =A0 =A0 && !(host->caps & MMC_CAP_NONREMOVABLE))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->bus_ops->detect(host);
>
> =A0 =A0 =A0 =A0/*
>
This works for me,
Thanks,

Dmitry
