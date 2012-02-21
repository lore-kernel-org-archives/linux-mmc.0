From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v4 2/2] mmc: core: Support packed command for eMMC4.5 device
Date: Tue, 21 Feb 2012 11:08:44 +0900
Message-ID: <CAKYAXd_Md14TB+kJz3L5spF6jdcZL86eE1Oe8T6T3umpByyKbQ@mail.gmail.com>
References: <000b01ccdc0a$0336abc0$09a40340$%jun@samsung.com>
	<e62a9b49ee1778129ef1b0adf2e14fc7.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36952 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab2BUCIp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Feb 2012 21:08:45 -0500
In-Reply-To: <e62a9b49ee1778129ef1b0adf2e14fc7.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-kernel@vger.kernel.org

2012/2/21  <merez@codeaurora.org>:
>>
>> @@ -1262,21 +1608,32 @@ static int mmc_blk_issue_rw_rq(struct mmc_qu=
eue
>> *mq, struct request *rqc)
>> =C2=A0 =C2=A0 =C2=A0 int ret =3D 1, disable_multi =3D 0, retry =3D 0=
, type;
>> =C2=A0 =C2=A0 =C2=A0 enum mmc_blk_status status;
>> =C2=A0 =C2=A0 =C2=A0 struct mmc_queue_req *mq_rq;
>> - =C2=A0 =C2=A0 struct request *req;
>> + =C2=A0 =C2=A0 struct request *req, *prq;
>> =C2=A0 =C2=A0 =C2=A0 struct mmc_async_req *areq;
>> + =C2=A0 =C2=A0 u8 reqs =3D 0;
>>
>> =C2=A0 =C2=A0 =C2=A0 if (!rqc && !mq->mqrq_prev->req)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>>
>> + =C2=A0 =C2=A0 if (rqc)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reqs =3D mmc_blk_prep_pa=
cked_list(mq, rqc);
>> +
>> =C2=A0 =C2=A0 =C2=A0 do {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rqc) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (reqs >=3D card->host->packed_min)
> In case host->packed_min will be set to a value bigger than 2 you wil=
l
> loose all the requests that were added to the packed list. If you wan=
t to
> support dynamic number of min packed requests you need to move the pa=
cked
> list preparation to queue.c where you can issue the fetched requests =
one
> after another, when (reqs < card->host->packed_min).
I don't understand why packed list preparation should be moved to
queue.c for dynamic number of packed min.
we can change packed min value via sysfs without compiling.
Would you explain more ?

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc_blk_packed_hdr_wrq_prep(mq->mqrq_cu=
r, card, mq, reqs);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc_blk_rw_rq_prep(mq->mqrq_cur, card, =
0, mq);
>
> Thanks,
> Maya Erez
> Consultant for Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
