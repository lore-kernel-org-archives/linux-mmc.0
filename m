From: Dmitry Shmidt <dimitrysh@android.com>
Subject: Re: [PATCH] mmc: core: Allow sdio operations in other thread during sdio_add_func()
Date: Tue, 15 Feb 2011 10:08:50 -0800
Message-ID: <AANLkTinJg2t5tM6+PjUF6jbfCWZfXAG2tObXnbdbn=55@mail.gmail.com>
References: <loom.20110212T012443-915@post.gmane.org>
	<AANLkTimyc-sXEhnPtCjQwHbEsdnwGY-ss6SoRSqDOD+d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43036 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754885Ab1BOSIv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 13:08:51 -0500
Received: by iyj8 with SMTP id 8so322251iyj.19
        for <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 10:08:50 -0800 (PST)
In-Reply-To: <AANLkTimyc-sXEhnPtCjQwHbEsdnwGY-ss6SoRSqDOD+d@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andy Ross <andy.ross@windriver.com>

[Cc +=3D Andy]

On Fri, Feb 11, 2011 at 6:34 PM, Dmitry Shmidt <dimitrysh@android.com> =
wrote:
> On Fri, Feb 11, 2011 at 4:25 PM, Dmitry Shmidt <dimitrysh@android.com=
> wrote:
>> commit 9cb71a1eb86a2acf0762d31af633984cf9e24d32
>> Author: Dmitry Shmidt <dimitrysh@google.com>
>> Date: =A0 Fri Feb 11 16:10:33 2011 -0800
>>
>> =A0 =A0mmc: core: Allow sdio operations in other thread during sdio_=
add_func()
>>
>> =A0 =A0Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
>>
>> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
>> index dec4290..d4e6e6ef 100644
>> --- a/drivers/mmc/core/sdio.c
>> +++ b/drivers/mmc/core/sdio.c
>> @@ -834,7 +834,6 @@ int mmc_attach_sdio(struct mmc_host *host)
>> =A0 =A0 =A0 =A0 */
>> =A0 =A0 =A0 =A0mmc_release_host(host);
>> =A0 =A0 =A0 =A0err =3D mmc_add_card(host->card);
>> - =A0 =A0 =A0 mmc_claim_host(host);
>> =A0 =A0 =A0 =A0if (err)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto remove_added;
>>
>> @@ -846,13 +845,12 @@ int mmc_attach_sdio(struct mmc_host *host)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto remove_added;
>> =A0 =A0 =A0 =A0}
>> -
>> + =A0 =A0 =A0 mmc_claim_host(host);
>> =A0 =A0 =A0 =A0return 0;
>>
>>
>> =A0remove_added:
>> =A0 =A0 =A0 =A0/* Remove without lock if the device has been added. =
*/
>> - =A0 =A0 =A0 mmc_release_host(host);
>> =A0 =A0 =A0 =A0mmc_sdio_remove(host);
>> =A0 =A0 =A0 =A0mmc_claim_host(host);
>> =A0remove:
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
> This is important when wlan driver is doing sdio operations from anot=
her
> =A0thread during initialization.
> This behavior was introduced as a side-effect in patch
> =A0807e8e40673d9628fa7dcdd14423424b4ee5f43b
> =A0mmc: Fix sd/sdio/mmc initialization frequency retries
>
