From: Johan Rudholm <johan.rudholm@axis.com>
Subject: Re: [PATCH v2 3/4] mmc: core: turn hw_reset into a bus_ops
Date: Wed, 5 Nov 2014 15:40:51 +0100
Message-ID: <CA+20K0Czsb6PkqiicvxLN_UVe90u0-VOiOMw_n_xWkMQQg6_vg@mail.gmail.com>
References: <1415113626-30187-1-git-send-email-johanru@axis.com>
	<1415113626-30187-4-git-send-email-johanru@axis.com>
	<545A13A7.1040301@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:53611 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112AbaKEOlA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Nov 2014 09:41:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id EF745180E4
	for <linux-mmc@vger.kernel.org>; Wed,  5 Nov 2014 15:40:58 +0100 (CET)
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zbGvc6ROUCZG for <linux-mmc@vger.kernel.org>;
	Wed,  5 Nov 2014 15:40:54 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bastet.se.axis.com (Postfix) with ESMTP id 0FA37180E0
	for <linux-mmc@vger.kernel.org>; Wed,  5 Nov 2014 15:40:54 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id ED1A4AAD
	for <linux-mmc@vger.kernel.org>; Wed,  5 Nov 2014 15:40:53 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id DD4401205
	for <linux-mmc@vger.kernel.org>; Wed,  5 Nov 2014 15:40:53 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id DA1D93E0DF
	for <linux-mmc@vger.kernel.org>; Wed,  5 Nov 2014 15:40:53 +0100 (CET)
Received: by mail-qc0-f176.google.com with SMTP id x3so622403qcv.35        for
 <linux-mmc@vger.kernel.org>; Wed, 05 Nov 2014 06:40:52 -0800 (PST)
In-Reply-To: <545A13A7.1040301@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Johan Rudholm <johanru@axis.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, Jesper Nilsson <jespern@axis.com>

Hi Adrian,

2014-11-05 13:10 GMT+01:00 Adrian Hunter <adrian.hunter@intel.com>:
> On 04/11/14 17:07, Johan Rudholm wrote:
>> Move the (e)MMC specific hw_reset code from core.c into mmc.c and call
>> it from the new bus_ops member hw_reset. This also lets us add code
>> for reseting SD cards as well.
>>
>> Signed-off-by: Johan Rudholm <johanru@axis.com>
>> ---
>>  drivers/mmc/card/mmc_test.c |    3 --
>>  drivers/mmc/core/core.c     |   48 ++++++++----------------------------------
>>  drivers/mmc/core/core.h     |    4 +++
>>  drivers/mmc/core/mmc.c      |   37 +++++++++++++++++++++++++++++++++
>>  include/linux/mmc/core.h    |    1 -
>>  5 files changed, 50 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
>> index 0c0fc52..2cd3385 100644
>> --- a/drivers/mmc/card/mmc_test.c
>> +++ b/drivers/mmc/card/mmc_test.c
>> @@ -2349,9 +2349,6 @@ static int mmc_test_hw_reset(struct mmc_test_card *test)
>>       if (err != -EOPNOTSUPP)
>>               return err;
>>
>> -     if (!mmc_can_reset(card))
>> -             return RESULT_UNSUP_CARD;
>> -
>
> I would like to retain the ability for mmc_test to distinguish
> RESULT_UNSUP_CARD from RESULT_UNSUP_HOST

Ok, coming up in v3, thanks.

//Johan
