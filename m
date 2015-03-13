From: Jun Nie <jun.nie@linaro.org>
Subject: Re: [PATCH] mmc: core: do not abort if wp is disabled
Date: Fri, 13 Mar 2015 18:22:58 +0800
Message-ID: <5502BA82.8090604@linaro.org>
References: <1426234133-5889-1-git-send-email-jun.nie@linaro.org> <CAPDyKFpU2rz4ZuDiyhFR=7BRS2HCySCukcSr-NN5A4gYnGiKYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:46014 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbbCMKXE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Mar 2015 06:23:04 -0400
Received: by padbj1 with SMTP id bj1so28399392pad.12
        for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2015 03:23:03 -0700 (PDT)
In-Reply-To: <CAPDyKFpU2rz4ZuDiyhFR=7BRS2HCySCukcSr-NN5A4gYnGiKYw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawn.guo@linaro.org>

On 2015=E5=B9=B403=E6=9C=8813=E6=97=A5 17:50, Ulf Hansson wrote:
> On 13 March 2015 at 09:08, Jun Nie <jun.nie@linaro.org> wrote:
>> Do not abort probe due to no detection to write protection pin,
>> if host specify disable-wp.
>>
>> Signed-off-by: Jun Nie <jun.nie@linaro.org>
>>
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> index 8be0df7..30ed253 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -394,11 +394,14 @@ int mmc_of_parse(struct mmc_host *host)
>>          /* Parse Write Protection */
>>          ro_cap_invert =3D of_property_read_bool(np, "wp-inverted");
>>
>> -       ret =3D mmc_gpiod_request_ro(host, "wp", 0, false, 0, &ro_gp=
io_invert);
>> -       if (!ret)
>> -               dev_info(host->parent, "Got WP GPIO\n");
>> -       else if (ret !=3D -ENOENT)
>
> I thought this else statement already took care of your issue.
>
> The host driver shouldn't get an error code from mmc_of_parse() if th=
e
> optional "wp-gpio" doesn't exist. Right?
>
Right, in GPIO lib built case. Just find I need enable GPIO_LIB config =
:)
Thanks for reminding!

>> -               return ret;
>> +       if (!of_get_property(np, "disable-wp", NULL)) {
>> +               ret =3D mmc_gpiod_request_ro(host, "wp", 0, false, 0=
,
>> +                                          &ro_gpio_invert);
>> +               if (!ret)
>> +                       dev_info(host->parent, "Got WP GPIO\n");
>> +               else if (ret !=3D -ENOENT)
>> +                       return ret;
>> +       }
>>
>>          /* See the comment on CD inversion above */
>>          if (ro_cap_invert ^ ro_gpio_invert)
>> --
>> 1.9.1
>>
>
> Kind regards
> Uffe
>
B.R.
Jun
