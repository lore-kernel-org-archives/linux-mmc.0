From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH] mmc: sdhci: fix retuning timer wrongly deleted in
 sdhci_tasklet_finish
Date: Wed, 27 Jul 2011 17:15:51 +0800
Message-ID: <20110727091549.GC3340@lovegaga>
References: <1310362031-8186-1-git-send-email-Aaron.Lu@amd.com>
 <6C03668EAF45B747AF947A1603D1B300018F85B9E0@SAUSEXMBP01.amd.com>
 <20110721052358.GA31584@lovegaga>
 <CAMj5BkhT2-mybTHTVxXm1TG0w=Ap34etwKgxg3QVVzohaZWupA@mail.gmail.com>
 <20110721100351.GA31886@lovegaga>
 <CAMj5BkjnskRO=HwmbPgjuOZ2VWyoVp=8ViWw8j22Y7M8oC8Kig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:40149
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752766Ab1G0JQv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Jul 2011 05:16:51 -0400
Content-Disposition: inline
In-Reply-To: <CAMj5BkjnskRO=HwmbPgjuOZ2VWyoVp=8ViWw8j22Y7M8oC8Kig@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>, Philip Rakity <prakity@marvell.com>
Cc: "Nath, Arindam" <Arindam.Nath@amd.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Fri, Jul 22, 2011 at 06:21:11PM +0800, zhangfei gao wrote:
>=20
> Thanks for explanation, looks good to me.
>=20

Hi Philip & Zhangfei,

Can I have your reviewed-by tag in the patch?

Thanks,
Aaron

> >> >> >
> >> >> > Signed-off-by: Aaron Lu <Aaron.Lu@amd.com>
> >> >> > ---
> >> >> > =A0drivers/mmc/host/sdhci.c | =A0 =A03 ---
> >> >> > =A01 files changed, 0 insertions(+), 3 deletions(-)
> >> >> >
> >> >> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhc=
i.c
> >> >> > index 91d9892..6250bac 100644
> >> >> > --- a/drivers/mmc/host/sdhci.c
> >> >> > +++ b/drivers/mmc/host/sdhci.c
> >> >> > @@ -1863,9 +1863,6 @@ static void sdhci_tasklet_finish(unsign=
ed long
> >> >> > param)
> >> >> >
> >> >> > =A0 =A0 del_timer(&host->timer);
> >> >> >
> >> >> > - =A0 if (host->version >=3D SDHCI_SPEC_300)
> >> >> > - =A0 =A0 =A0 =A0 =A0 del_timer(&host->tuning_timer);
> >> >> > -
> >> >> > =A0 =A0 mrq =3D host->mrq;
> >> >> >
> >> >> > =A0 =A0 /*
> >> >> > --
> >> >> > 1.7.1
> >> >>
> >> >>
> >> >
> >> >
> >>
> >
> >
>=20

