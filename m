From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH] mmc: core: Kill block requests if card is removed
Date: Wed, 9 Nov 2011 23:05:24 +0100
Message-ID: <CAFEEs1nQmKues-93zQe7uxNnNqJPEzvBc-2zGkrvUdgPvoGBKw@mail.gmail.com>
References: <1320813119-24383-1-git-send-email-sthumma@codeaurora.org>
	<4EBA4940.6030808@intel.com>
	<CAFEEs1nPe3=TFwdf8rbPk6AtWzMdfaKR=-Rv0OVJhnANX=3fUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAFEEs1nPe3=TFwdf8rbPk6AtWzMdfaKR=-Rv0OVJhnANX=3fUQ@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Sujit Reddy Thumma <sthumma@codeaurora.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 5278ffb..91d7721 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -259,7 +259,7 @@ static void mmc_wait_for_req_done(struct mmc_hos=
t *host,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wait_for_completion(&mrq->completion)=
;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd =3D mrq->cmd;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cmd->error || !cmd->retries)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cmd->error || !cmd->retries || mm=
c_card_gone(host->card))
> host->card will be NULL
> static void mmc_remove(struct mmc_host *host)
> {
> =A0 =A0 =A0 =A0BUG_ON(!host);
> =A0 =A0 =A0 =A0BUG_ON(!host->card);
>
> =A0 =A0 =A0 =A0mmc_remove_card(host->card);
> =A0 =A0 =A0 =A0host->card =3D NULL;
> }
> card is not freed until later.
Please ignore this part. I jumped to conclusions. I had another look
and there can't be any incoming requests when host->card is NULL.
I need to study device_del() further, in order to understand the detail=
s.

Regards,
Per
