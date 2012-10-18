From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 3/3] mmc: sdhci-s3c: Add clk_(enable/disable) in runtime
 suspend/resume
Date: Thu, 18 Oct 2012 18:36:03 +0900
Message-ID: <004601cdad13$fdb4c980$f91e5c80$%jun@samsung.com>
References: <1347613731-29428-1-git-send-email-chander.kashyap@linaro.org>
 <201210171115.48401.heiko@sntech.de> <507F63BA.7040809@samsung.com>
 <201210180941.06091.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <201210180941.06091.heiko@sntech.de>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: =?iso-8859-15?Q?'Heiko_St=FCbner'?= <heiko@sntech.de>, 'Jaehoon Chung' <jh80.chung@samsung.com>
Cc: 'Chander Kashyap' <chander.kashyap@linaro.org>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, ben@simtec.co.uk, broonie@opensource.wolfsonmicro.com, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

On Thursday, October 18, 2012, Heiko St=FCbner <heiko@sntech.de> wrote:
> Hi,
>=20
> Am Donnerstag, 18. Oktober 2012, 04:04:42 schrieb Jaehoon Chung:
> > Sorry, i didn't check this patch with s3c2416.
> > (i didn't have the s3c2416 board.)
> > If you have a problem, i think good that revert this patch for fixi=
ng your
> > problem. Also, i will check and share the result.
>=20
>=20
> After looking a bit more through the code, I don't think the problem =
is 2416-
> specific but seems to be caused by the gpio card-detect code.
>=20
> sdhci_s3c_gpio_card_detect_thread calls sdhci_s3c_notify_change which=
 in turn
> runs host->card_tasklet that seems to want to read stuff from the car=
d. But
> this path seems to be missing a runtime-pm wakeup.
>=20
> I'm not yet sure what to add, especially, as tasklet_finish (called o=
n some
> occasions from tasklet_card) already has a runtime_pm_put call, which=
 would be
> unpaired in this code path.
>=20
> As there also could be other Samsung platforms affected that use the =
ext-gpio
> code, it's probably right to revert it for now. Or you see a easy fix=
 :-) .
>=20
Hi,

I think clock is disabled during bus transaction.
I'll send a patch. Could you test it?

Thanks.

Seungwon Jeon
>=20
> Heiko
>=20
>=20
> > Best Regards,
> > Jaehoon Chung
> >
> > On 10/17/2012 06:15 PM, Heiko St=FCbner wrote:
> > > Hi,
> > >
> > > Am Freitag, 14. September 2012, 11:08:51 schrieb Chander Kashyap:
> > >> Perform clock disable/enable in runtime suspend/resume.
> > >>
> > >> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> > >
> > > It seems this patch breaks my S3C2416 based machine with 3.7-rc1.=
 I'm not
> > >
> > > yet sure why, but the only response I get is loop of:
> > > 	mmc0: Timeout waiting for hardware interrupt.
> > > 	mmc0: Internal clock never stabilised.
> > > 	mmc0: Timeout waiting for hardware interrupt.
> > > 	mmc0: Internal clock never stabilised.
> > >
> > > This only happens on the hsmmc channel using the gpio-based card =
detect
> > > and even prevents the card from beeing fully detected. The other =
hsmmc
> > > channel using a permanent emmc seems to be working fine.
> > >
> > > And of course, when I revert this patch everything works fine aga=
in.
> > >
> > > I'll investigate further, but it'd be also ok if someone has a fi=
x for
> > > this before me :-) .
> > >
> > >
> > > Heiko
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-m=
mc" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
