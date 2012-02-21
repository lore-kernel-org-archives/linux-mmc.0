From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH] mmc: core: fix wrong bit operation for SD card's au_size
Date: Tue, 21 Feb 2012 23:14:35 +0900
Message-ID: <CAELcNGQzmHAM-K-2npmQKGJ-oPh3ptaa1hyuDCfUq6zLzfTR8Q@mail.gmail.com>
References: <4F431E23.8050006@samsung.com>
	<000001ccf084$5f956f80$1ec04e80$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39300 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804Ab2BUOOh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Feb 2012 09:14:37 -0500
Received: by bkcjm19 with SMTP id jm19so5350510bkc.19
        for <linux-mmc@vger.kernel.org>; Tue, 21 Feb 2012 06:14:36 -0800 (PST)
In-Reply-To: <000001ccf084$5f956f80$1ec04e80$@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, hyeonsu.kim@samsung.com

Hi Subhash.

Right..sorry..my misunderstanding.
Thank you for your explanation.

Best Regards,
Jaehoon Chung

2012/2/21 Subhash Jadavani <subhashj@codeaurora.org>:
>
>
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Jaehoon Chung
>> Sent: Tuesday, February 21, 2012 10:02 AM
>> To: linux-mmc
>> Cc: Chris Ball; Kyungmin Park; hyeonsu.kim@samsung.com
>> Subject: [PATCH] mmc: core: fix wrong bit operation for SD card's au=
_size
>>
>> In SD spec, AU_SIZE and the value can be selected from 16KB.
>> But this code should be selected from 32KB.
>> I think right that shift (au + 3) instead of (au + 4).
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> CC: Hyeonsu Kim <hyeonsu.kim@samsung.com>
>> ---
>> =A0drivers/mmc/core/sd.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
>> 5017f93..85c7b39 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -245,7 +245,7 @@ static int mmc_read_ssr(struct mmc_card *card)
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 au =3D UNSTUFF_BITS(ssr, 428 - 384, 4);
>> =A0 =A0 =A0 if (au > 0 || au <=3D 9) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 card->ssr.au =3D 1 << (au + 4);
>> + =A0 =A0 =A0 =A0 =A0 =A0 card->ssr.au =3D 1 << (au + 3);
>
> (au+4) is correct only. Look at the definition of "card->ssr.au"
> ("include/linux/mmc/card.h"), au is in terms of sectors.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct sd_ssr {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0=
 =A0 =A0 =A0au; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> In sectors */
>
> Now let's take the example of "AU_SIZE" =3D 1 then (1 << (au+4)) woul=
d be 32.
> Now as "card->sss.au" is in term of sectors, 32 sectors means 16KB (a=
ssuming
> 512 byte sector size).
>
> Regards,
> Subhash
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 es =3D UNSTUFF_BITS(ssr, 408 - 384, 16);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 et =3D UNSTUFF_BITS(ssr, 402 - 384, 6);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 eo =3D UNSTUFF_BITS(ssr, 400 - 384, 2);
>> --
>> 1.7.4.1
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
> the
>> body of a message to majordomo@vger.kernel.org More majordomo info a=
t
>> http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
