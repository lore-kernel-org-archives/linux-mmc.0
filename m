From: Heiko =?iso-8859-15?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 3/3] mmc: sdhci-s3c: Add clk_(enable/disable) in runtime suspend/resume
Date: Thu, 18 Oct 2012 09:41:05 +0200
Message-ID: <201210180941.06091.heiko@sntech.de>
References: <1347613731-29428-1-git-send-email-chander.kashyap@linaro.org> <201210171115.48401.heiko@sntech.de> <507F63BA.7040809@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:35390 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752443Ab2JRHlL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Oct 2012 03:41:11 -0400
In-Reply-To: <507F63BA.7040809@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chander Kashyap <chander.kashyap@linaro.org>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, ben@simtec.co.uk, broonie@opensource.wolfsonmicro.com, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, patches@linaro.org

Hi,

Am Donnerstag, 18. Oktober 2012, 04:04:42 schrieb Jaehoon Chung:
> Sorry, i didn't check this patch with s3c2416.
> (i didn't have the s3c2416 board.)
> If you have a problem, i think good that revert this patch for fixing=
 your
> problem. Also, i will check and share the result.


After looking a bit more through the code, I don't think the problem is=
 2416-
specific but seems to be caused by the gpio card-detect code.

sdhci_s3c_gpio_card_detect_thread calls sdhci_s3c_notify_change which i=
n turn=20
runs host->card_tasklet that seems to want to read stuff from the card.=
 But=20
this path seems to be missing a runtime-pm wakeup.

I'm not yet sure what to add, especially, as tasklet_finish (called on =
some=20
occasions from tasklet_card) already has a runtime_pm_put call, which w=
ould be=20
unpaired in this code path.

As there also could be other Samsung platforms affected that use the ex=
t-gpio=20
code, it's probably right to revert it for now. Or you see a easy fix :=
-) .


Heiko


> Best Regards,
> Jaehoon Chung
>=20
> On 10/17/2012 06:15 PM, Heiko St=FCbner wrote:
> > Hi,
> >=20
> > Am Freitag, 14. September 2012, 11:08:51 schrieb Chander Kashyap:
> >> Perform clock disable/enable in runtime suspend/resume.
> >>=20
> >> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> >=20
> > It seems this patch breaks my S3C2416 based machine with 3.7-rc1. I=
'm not
> >=20
> > yet sure why, but the only response I get is loop of:
> > 	mmc0: Timeout waiting for hardware interrupt.
> > 	mmc0: Internal clock never stabilised.
> > 	mmc0: Timeout waiting for hardware interrupt.
> > 	mmc0: Internal clock never stabilised.
> >=20
> > This only happens on the hsmmc channel using the gpio-based card de=
tect
> > and even prevents the card from beeing fully detected. The other hs=
mmc
> > channel using a permanent emmc seems to be working fine.
> >=20
> > And of course, when I revert this patch everything works fine again=
=2E
> >=20
> > I'll investigate further, but it'd be also ok if someone has a fix =
for
> > this before me :-) .
> >=20
> >=20
> > Heiko
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

