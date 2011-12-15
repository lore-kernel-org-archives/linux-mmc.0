From: Saugata Das <saugata.das@linaro.org>
Subject: Re: Cache Control during mmc_suspend_host
Date: Thu, 15 Dec 2011 15:38:25 +0530
Message-ID: <CAKLKtzfQZrcG330Zf4EXx6rtZ6LZpxzpKnq5=z=fXOO1gZdvSg@mail.gmail.com>
References: <CAKLKtzej1VpD41GwBOoNv_51fPqMHMySViptjk6im_mSkSws9A@mail.gmail.com>
	<000f01ccb960$42ac2a40$c8047ec0$%jun@samsung.com>
	<CAKLKtzdWzhJTy2KjCOsUs6rtf5Uec2vHoQ3Wkex6nfmhT01T+w@mail.gmail.com>
	<002f01ccba19$9c2bd9d0$d4838d70$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:49471 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932426Ab1LOKI0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Dec 2011 05:08:26 -0500
Received: by wgbds13 with SMTP id ds13so840096wgb.1
        for <linux-mmc@vger.kernel.org>; Thu, 15 Dec 2011 02:08:25 -0800 (PST)
In-Reply-To: <002f01ccba19$9c2bd9d0$d4838d70$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org

On 14 December 2011 10:04, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Saugata Das wrote:
>> On 13 December 2011 11:57, Seungwon Jeon <tgih.jun@samsung.com> wrot=
e:
>> > Hi Saugata,
>> >
>> > Saugata Das wrote:
>> >> Hi Seungwon Jeon
>> >>
>> >> I see a small issue with the implementation mmc_suspend_host,
>> >>
>> >> int mmc_suspend_host(struct mmc_host *host)
>> >> {
>> >> .....
>> >> =A0 =A0 =A0 err =3D mmc_cache_ctrl(host, 0);
>> >> }
>> >>
>> >> So, within mmc_suspend_host we are disabling the cache. But I do =
not
>> >> see a corresponding enabling of cache within mmc_resume_host. I
>> >> suggest we have either enabling of cache within mmc_resume_host o=
r
>> >> within mmc_suspend_host, we replace mmc_cache_ctrl(host, 0) with =
the
>> >> flush operation, mmc_flush_cache(host->card).
>> >>
>> > Currently,
>> > Cache is enabled in mmc_init_card() during mmc_resume_host().
>> >
>> Thanks for your answer.
>>
>> If mmc_card_keep_power is TRUE, then do you know why from mmc_resume
>> we call mmc_init_card instead of just mmc_awake which should reduce
>> some latency of system wakeup ?
>>
> I didn't find that case of keeping the power
> during sleep in mmc unlike sdio.

I am talking about keeping VCCQ ON and switching OFF only VCC. This is
normally the SLEEP mode of eMMC, which provides quicker wakeup or
resume. Some platforms will like to have quicker resume and will like
to avoid doing a mmc_init_card during resume. If that happens, then
the cache control disabling from mmc_suspend_host will be a problem.
So, I suggest we change that to mmc_flush_cache which logically does
the same as  you wanted but it is also future proof.

>
>>
>> > Thanks,
>> > Seungwon Jeon.
>> >>
>> >>
>> >> Regards
>> >> Saugata
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe linux-m=
mc" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
