From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: sdhci: fix retuning timer wrongly deleted in sdhci_tasklet_finish
Date: Thu, 21 Jul 2011 17:35:02 +0800
Message-ID: <CAMj5BkhT2-mybTHTVxXm1TG0w=Ap34etwKgxg3QVVzohaZWupA@mail.gmail.com>
References: <1310362031-8186-1-git-send-email-Aaron.Lu@amd.com>
	<6C03668EAF45B747AF947A1603D1B300018F85B9E0@SAUSEXMBP01.amd.com>
	<20110721052358.GA31584@lovegaga>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:60157 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab1GUJfD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jul 2011 05:35:03 -0400
Received: by qyk9 with SMTP id 9so613681qyk.19
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jul 2011 02:35:02 -0700 (PDT)
In-Reply-To: <20110721052358.GA31584@lovegaga>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: "Nath, Arindam" <Arindam.Nath@amd.com>, Philip Rakity <prakity@marvell.com>, subhashj@codeaurora.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

> This is a bug fix for exsting code, if the re-tuning timer is deleted=
,
> the re-tuning will not happen again, that will cause problems for SDH=
C
> 3.0 hosts which utilize re-tuning mode 1.
>
> Thanks.
>
>>
>> > -----Original Message-----
>> > From: Aaron Lu [mailto:Aaron.Lu@amd.com]
>> > Sent: Monday, July 11, 2011 10:57 AM
>> > To: Chris Ball
>> > Cc: Nath, Arindam; linux-mmc@vger.kernel.org; Lu, Aaron
>> > Subject: [PATCH] mmc: sdhci: fix retuning timer wrongly deleted in
>> > sdhci_tasklet_finish
>> >
>> > Currently, the retuning timer for retuning mode 1 will be deleted =
in
>> > function sdhci_tasklet_finish after a mmc request done, which will
>> make
>> > retuning timing never trigger again. This patch fixed this problem=
=2E

Does the execute_tuning is called again?
del_timer is not delete timer really, but deactivate the timer, which
could be re-activated by mod_timer.
So if execute_tuning is called, the mod_timer will tigger the tuning
timer again.

>> >
>> > Signed-off-by: Aaron Lu <Aaron.Lu@amd.com>
>> > ---
>> > =A0drivers/mmc/host/sdhci.c | =A0 =A03 ---
>> > =A01 files changed, 0 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> > index 91d9892..6250bac 100644
>> > --- a/drivers/mmc/host/sdhci.c
>> > +++ b/drivers/mmc/host/sdhci.c
>> > @@ -1863,9 +1863,6 @@ static void sdhci_tasklet_finish(unsigned lo=
ng
>> > param)
>> >
>> > =A0 =A0 del_timer(&host->timer);
>> >
>> > - =A0 if (host->version >=3D SDHCI_SPEC_300)
>> > - =A0 =A0 =A0 =A0 =A0 del_timer(&host->tuning_timer);
>> > -
>> > =A0 =A0 mrq =3D host->mrq;
>> >
>> > =A0 =A0 /*
>> > --
>> > 1.7.1
>>
>>
>
>
