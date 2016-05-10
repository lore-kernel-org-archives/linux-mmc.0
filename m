From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: core: fix using wrong io voltage if
 mmc_select_hs200 fails
Date: Tue, 10 May 2016 11:46:40 +0200
Message-ID: <CAPDyKFogfeCKTW030MN-yA2xSiTOjGOoVvU2x3QHsWq6brjvYw@mail.gmail.com>
References: <1461171092-30631-1-git-send-email-aisheng.dong@nxp.com>
	<CAPDyKFrZW=FVd-5CNrkH4=PgHRxUkT3Vic3vDuuho0NACmziww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:32831 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbcEJJqm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2016 05:46:42 -0400
Received: by mail-wm0-f51.google.com with SMTP id g17so26293679wme.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 May 2016 02:46:41 -0700 (PDT)
In-Reply-To: <CAPDyKFrZW=FVd-5CNrkH4=PgHRxUkT3Vic3vDuuho0NACmziww@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawnguo@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <dongas86@gmail.com>

On 28 April 2016 at 11:26, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 20 April 2016 at 18:51, Dong Aisheng <aisheng.dong@nxp.com> wrote:
>> Currently MMC core will keep going if HS200/HS timing switch failed
>> with -EBADMSG error by the assumption that the old timing is still valid.
>>
>> However, for mmc_select_hs200 case, the signal voltage may have already
>> been switched. If the timing switch failed, we should fall back to
>> the old voltage in case the card is continue run with legacy timing.
>>
>> If fall back signal voltage failed, we explicitly report an EIO error
>> to force retry during the next power cycle.
>>
>> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
>> ---
>>  drivers/mmc/core/mmc.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index b8aa12c..f6683a9 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1245,9 +1245,11 @@ static int mmc_select_hs200(struct mmc_card *card)
>>         struct mmc_host *host = card->host;
>>         bool send_status = true;
>>         unsigned int old_timing;
>> +       unsigned int old_signal_voltage;
>
> Nitpick; you can merge this change into the line above.
>

Applied for next with a minor change dealing with the nitpick above, thanks!

Kind regards
Uffe
