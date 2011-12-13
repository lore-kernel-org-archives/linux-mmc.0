From: Saugata Das <saugata.das@linaro.org>
Subject: Re: Cache Control during mmc_suspend_host
Date: Tue, 13 Dec 2011 16:07:54 +0530
Message-ID: <CAKLKtzdWzhJTy2KjCOsUs6rtf5Uec2vHoQ3Wkex6nfmhT01T+w@mail.gmail.com>
References: <CAKLKtzej1VpD41GwBOoNv_51fPqMHMySViptjk6im_mSkSws9A@mail.gmail.com>
	<000f01ccb960$42ac2a40$c8047ec0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51205 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab1LMKhz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2011 05:37:55 -0500
Received: by bkcjm19 with SMTP id jm19so2596665bkc.19
        for <linux-mmc@vger.kernel.org>; Tue, 13 Dec 2011 02:37:54 -0800 (PST)
In-Reply-To: <000f01ccb960$42ac2a40$c8047ec0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org

On 13 December 2011 11:57, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Hi Saugata,
>
> Saugata Das wrote:
>> Hi Seungwon Jeon
>>
>> I see a small issue with the implementation mmc_suspend_host,
>>
>> int mmc_suspend_host(struct mmc_host *host)
>> {
>> .....
>> =A0 =A0 =A0 err =3D mmc_cache_ctrl(host, 0);
>> }
>>
>> So, within mmc_suspend_host we are disabling the cache. But I do not
>> see a corresponding enabling of cache within mmc_resume_host. I
>> suggest we have either enabling of cache within mmc_resume_host or
>> within mmc_suspend_host, we replace mmc_cache_ctrl(host, 0) with the
>> flush operation, mmc_flush_cache(host->card).
>>
> Currently,
> Cache is enabled in mmc_init_card() during mmc_resume_host().
>
Thanks for your answer.

If mmc_card_keep_power is TRUE, then do you know why from mmc_resume
we call mmc_init_card instead of just mmc_awake which should reduce
some latency of system wakeup ?


> Thanks,
> Seungwon Jeon.
>>
>>
>> Regards
>> Saugata
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
