From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Re: [PATCH 1/1] mmc: sdhci-esdhc-imx: Use pinctrl PM helpers
Date: Tue, 16 Jun 2015 08:52:53 +0200
Message-ID: <CAJ=nTsvT-0UZTRhGrRvqG0Gp5yhPVhUWzMtupXrXVxnwwhfS=Q@mail.gmail.com>
References: <1434101473-4109-1-git-send-email-mirza.krak@hostmobility.com>
	<CAPDyKFoqAV4fW=V56vvPh5-9=w+0Di8VzTBNRmpF_2ETp_pHNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:35428 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbbFPGwy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jun 2015 02:52:54 -0400
Received: by lbbwc1 with SMTP id wc1so4514319lbb.2
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2015 23:52:53 -0700 (PDT)
In-Reply-To: <CAPDyKFoqAV4fW=V56vvPh5-9=w+0Di8VzTBNRmpF_2ETp_pHNA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, Shawn Guo <shawn.guo@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Peter Griffin <peter.griffin@linaro.org>, Stefan Agner <stefan@agner.ch>, linux-mmc <linux-mmc@vger.kernel.org>

2015-06-15 11:55 GMT+02:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 12 June 2015 at 11:31, Mirza Krak <mirza.krak@hostmobility.com> wr=
ote:
>> From: Mirza Krak <mirza.krak@hostmobility.com>
>>
>> Add support for current states of pinctrl, which are "default", "idl=
e"
>> and "sleep".
>>
>> The "default" pinctrl state is set by Drivers core before
>> calling the driver's probe, hence we do not need a initial call to
>> "default" state.
>>
>> Signed-off-by: Mirza Krak <mirza.krak@hostmobility.com>
>
> Hi Mirza,
>
> This looks okay to me, but it seems like it needs a re-base towards m=
y
> mmc next branch.
>
> Kind regards
> Uffe

Looked at the mmc next branch.

I see that the suspend/resume methods of sdhci-esdhci-imx have been
removed and the generic sdhci_pltfm_suspend/resume are used. So I am
unsure if it is OK to set the pinctl "sleep" state in
sdhci_pltfm_suspend or is there a better location for this.

I am thinking sdhci_suspend_host would be good location, but then the
change will effect a lot more drivers. Maybe a good thing?

Regarding the "idle" state of pinctrl, this could also be moved to
sdhci_runtime_suspend_host, affecting more drivers. Again a good
thing?

--=20
Med V=C3=A4nliga H=C3=A4lsningar / Best Regards

*******************************************************************
Mirza Krak
Host Mobility AB
mirza.krak@hostmobility.com
Anders Personsgatan 12, 416 64 G=C3=B6teborg
Sweden
http://www.hostmobility.com
Direct: +46 31 31 32 704
Phone: +46 31 31 32 700
=46ax: +46 31 80 67 51
Mobile: +46 730 28 06 22
*******************************************************************
