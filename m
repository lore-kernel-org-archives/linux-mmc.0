From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 2/2] mmc: core: fall back host->f_init if failing to init
 mmc card after resume
Date: Wed, 20 Jul 2016 09:33:10 +0800
Message-ID: <dda44de1-6467-802f-4b4d-9de8f604357c@rock-chips.com>
References: <1468918715-24914-1-git-send-email-shawn.lin@rock-chips.com>
 <1468918715-24914-2-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFq9ZogJjGyR6gB3QxnJeP_5XH-GXKY6+-HXsOBDDTAMqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:49979 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbcGTBdm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jul 2016 21:33:42 -0400
In-Reply-To: <CAPDyKFq9ZogJjGyR6gB3QxnJeP_5XH-GXKY6+-HXsOBDDTAMqQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>

=E5=9C=A8 2016/7/19 18:31, Ulf Hansson =E5=86=99=E9=81=93:
> On 19 July 2016 at 10:58, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> We observed the failure of initializing card after resume
>> accidentally. It's hard to reproduce but we did get report from
>> the suspend/resume test of our RK3399 mp test farm . Unfortunately,
>> we still fail to figure out what was going wrong at that time.
>> Also we can't achieve it by retrying the host->f_init without fallin=
g
>> back it. But this patch will solve the problem as we could add some =
log
>> there and see that we resume the mmc card successfully after falling
>> back the host->f_init. There is no obvious side effect found, so it =
seems
>> this patch will improve the stability.
>
> What f_init did the original rescan work find out being successful?

The original f_init was 400k when booting up the system.

>
> Did you then verify that it was *another* frequency that made the
> initialization to work in the resume?

yes, I added some log and saw 100k made the initialization to work in
the resume finally with the patch applied.

Also I mentioned in the commit msg that if I just retried 400K, it
cannot made the initialization successful.

>
>>
>> [   93.405085] mmc1: unexpected status 0x800900 after switch
>> [   93.408474] mmc1: switch to bus width 1 failed
>> [   93.408482] mmc1: mmc_select_hs200 failed, error -110
>> [   93.408492] mmc1: error -110 during resume (card was removed?)
>> [   93.408705] PM: resume of devices complete after 213.453 msecs
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>  drivers/mmc/core/mmc.c | 22 ++++++++++++++++++++--
>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 403b97b..bef40c8 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1945,6 +1945,7 @@ static int mmc_suspend(struct mmc_host *host)
>>  static int _mmc_resume(struct mmc_host *host)
>>  {
>>         int err =3D 0;
>> +       int i;
>>
>>         BUG_ON(!host);
>>         BUG_ON(!host->card);
>> @@ -1954,8 +1955,25 @@ static int _mmc_resume(struct mmc_host *host)
>>         if (!mmc_card_suspended(host->card))
>>                 goto out;
>>
>> -       mmc_power_up(host, host->card->ocr);
>> -       err =3D mmc_init_card(host, host->card->ocr, host->card);
>> +       /*
>> +        * Let's try to fallback the host->f_init
>> +        * if failing to init card after resume.
>> +        */
>> +
>> +       for (i =3D 0; i < ARRAY_SIZE(freqs); i++) {
>> +               if (host->f_init < freqs[i])
>> +                       continue;
>> +               else
>> +                       host->f_init =3D freqs[i];
>
> This loop is wrong, as you don't consider that host->f_min may not
> exactly match the frequencies in the freqs array.

Ah, seems I should use 'max(freqs[i], host->f_min)'.. :)

>
>> +
>> +               mmc_power_up(host, host->card->ocr);
>> +               err =3D mmc_init_card(host, host->card->ocr, host->c=
ard);
>> +               if (!err)
>> +                       break;
>> +
>> +               mmc_power_off(host);
>
> The mmc core expects the host/card to be powered up after a resume, a=
s
> it may send commands to it without first invoking mmc_power_up().
> Even if those commands may fail (or timeout), at least those doesn't
> hang which may be the case if the host/card isn't powered up first.
>

I got it, thanks.

> So, you must *not* leave the host/card in "mmc_power_off()" state in
> _mmc_resume().
>
> [...]
>
> Kind regards
> Uffe
>
>
>


--=20
Best Regards
Shawn Lin

