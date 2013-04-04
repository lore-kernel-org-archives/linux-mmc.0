From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: Check return value of regulator_enable
Date: Thu, 4 Apr 2013 11:26:37 +0530
Message-ID: <CAK9yfHz0LveFzHgqKABo3vzpixac7OckitrAgM+_BK0o8+5dNw@mail.gmail.com>
References: <1364444747-16777-1-git-send-email-sachin.kamat@linaro.org>
	<004401ce30f8$3afdfe70$b0f9fb50$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:60998 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755433Ab3DDF4i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Apr 2013 01:56:38 -0400
Received: by mail-oa0-f52.google.com with SMTP id k14so2331646oag.39
        for <linux-mmc@vger.kernel.org>; Wed, 03 Apr 2013 22:56:37 -0700 (PDT)
In-Reply-To: <004401ce30f8$3afdfe70$b0f9fb50$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, jh80.chung@samsung.com, cjb@laptop.org, patches@linaro.org

On 4 April 2013 11:19, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Thursday, March 28, 2013, Sachin Kamat wrote:
>> regulator_enable() is declared with __must_check attribute.
>> Hence check the return value to ensure that the regulator is enabled=
=2E
>> Fixes the following warning:
>> drivers/mmc/host/dw_mmc.c:2461:19: warning:
>> ignoring return value of =91regulator_enable=92, declared with attri=
bute
>> warn_unused_result [-Wunused-result]
>> drivers/mmc/host/dw_mmc.c: In function =91dw_mci_init_slot=92:
>> drivers/mmc/host/dw_mmc.c:1994:19: warning:
>> ignoring return value of =91regulator_enable=92, declared with attri=
bute
>> warn_unused_result [-Wunused-result]
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>  drivers/mmc/host/dw_mmc.c |   20 ++++++++++++++++----
>>  1 files changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index a443820..1ba09d0 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1990,8 +1990,14 @@ static int dw_mci_init_slot(struct dw_mci *ho=
st, unsigned int id)
>>       if (IS_ERR(host->vmmc)) {
>>               pr_info("%s: no vmmc regulator found\n", mmc_hostname(=
mmc));
>>               host->vmmc =3D NULL;
>> -     } else
>> -             regulator_enable(host->vmmc);
>> +     } else {
>> +             ret =3D regulator_enable(host->vmmc);
>> +             if (ret !=3D 0) {
> Just for trivial style... if (ret) {
> It looks like more simple?

Ok. I will resend with this change.

>
>> +                     dev_err(host->dev,
>> +                             "failed to enable regulator: %d\n", re=
t);
>> +                     goto err_setup_bus;
>> +             }
>> +     }
>>
>>       if (dw_mci_get_cd(mmc))
>>               set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
>> @@ -2457,8 +2463,14 @@ int dw_mci_resume(struct dw_mci *host)
>>  {
>>       int i, ret;
>>
>> -     if (host->vmmc)
>> -             regulator_enable(host->vmmc);
>> +     if (host->vmmc) {
>> +             ret =3D regulator_enable(host->vmmc);
>> +             if (ret !=3D 0) {
> As above,
>
> Thanks,
> Seungwon Jeon
>> +                     dev_err(host->dev,
>> +                             "failed to enable regulator: %d\n", re=
t);
>> +                     return ret;
>> +             }
>> +     }
>>
>>       if (!mci_wait_reset(host->dev, host)) {
>>               ret =3D -ENODEV;
>> --
>> 1.7.4.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



--=20
With warm regards,
Sachin
