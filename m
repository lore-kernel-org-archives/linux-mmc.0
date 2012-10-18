From: Heiko =?iso-8859-15?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 3/3] mmc: sdhci-s3c: Add clk_(enable/disable) in runtime suspend/resume
Date: Thu, 18 Oct 2012 11:52:18 +0200
Message-ID: <201210181152.18686.heiko@sntech.de>
References: <1347613731-29428-1-git-send-email-chander.kashyap@linaro.org> <201210180941.06091.heiko@sntech.de> <004601cdad13$fdb4c980$f91e5c80$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:36304 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754859Ab2JRJwY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Oct 2012 05:52:24 -0400
In-Reply-To: <004601cdad13$fdb4c980$f91e5c80$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chander Kashyap' <chander.kashyap@linaro.org>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, ben@simtec.co.uk, broonie@opensource.wolfsonmicro.com, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, patches@linaro.org

Am Donnerstag, 18. Oktober 2012, 11:36:03 schrieb Seungwon Jeon:
> On Thursday, October 18, 2012, Heiko St=FCbner <heiko@sntech.de> wrot=
e:
> > Hi,
> >=20
> > Am Donnerstag, 18. Oktober 2012, 04:04:42 schrieb Jaehoon Chung:
> > > Sorry, i didn't check this patch with s3c2416.
> > > (i didn't have the s3c2416 board.)
> > > If you have a problem, i think good that revert this patch for fi=
xing
> > > your problem. Also, i will check and share the result.
> >=20
> > After looking a bit more through the code, I don't think the proble=
m is
> > 2416- specific but seems to be caused by the gpio card-detect code.
> >=20
> > sdhci_s3c_gpio_card_detect_thread calls sdhci_s3c_notify_change whi=
ch in
> > turn runs host->card_tasklet that seems to want to read stuff from =
the
> > card. But this path seems to be missing a runtime-pm wakeup.
> >=20
> > I'm not yet sure what to add, especially, as tasklet_finish (called=
 on
> > some occasions from tasklet_card) already has a runtime_pm_put call=
,
> > which would be unpaired in this code path.
> >=20
> > As there also could be other Samsung platforms affected that use th=
e
> > ext-gpio code, it's probably right to revert it for now. Or you see=
 a
> > easy fix :-) .
>=20
> Hi,
>=20
> I think clock is disabled during bus transaction.
> I'll send a patch. Could you test it?

Sure, I'll test it.

Heiko


> > > On 10/17/2012 06:15 PM, Heiko St=FCbner wrote:
> > > > Hi,
> > > >=20
> > > > Am Freitag, 14. September 2012, 11:08:51 schrieb Chander Kashya=
p:
> > > >> Perform clock disable/enable in runtime suspend/resume.
> > > >>=20
> > > >> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> > > >=20
> > > > It seems this patch breaks my S3C2416 based machine with 3.7-rc=
1. I'm
> > > > not
> > > >=20
> > > > yet sure why, but the only response I get is loop of:
> > > > 	mmc0: Timeout waiting for hardware interrupt.
> > > > 	mmc0: Internal clock never stabilised.
> > > > 	mmc0: Timeout waiting for hardware interrupt.
> > > > 	mmc0: Internal clock never stabilised.
> > > >=20
> > > > This only happens on the hsmmc channel using the gpio-based car=
d
> > > > detect and even prevents the card from beeing fully detected. T=
he
> > > > other hsmmc channel using a permanent emmc seems to be working =
fine.
> > > >=20
> > > > And of course, when I revert this patch everything works fine a=
gain.
> > > >=20
> > > > I'll investigate further, but it'd be also ok if someone has a =
fix
> > > > for this before me :-) .
> > > >=20
> > > >=20
> > > > Heiko
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe linux=
-mmc"
> > > > in the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
> >=20
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

