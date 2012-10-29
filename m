From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2] mmc: sdhci-s3c: fix the card detection in runtime-pm
Date: Mon, 29 Oct 2012 23:37:25 +0100
Message-ID: <201210292337.35620.heiko@sntech.de>
References: <004801cdad17$498d9140$dca8b3c0$%jun@samsung.com> <201210191010.48776.heiko@sntech.de> <87liepq8qo.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:50670 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755281Ab2J2Whl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Oct 2012 18:37:41 -0400
In-Reply-To: <87liepq8qo.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, 'Chander Kashyap' <chander.kashyap@linaro.org>

Hi Chris,

Am Montag, 29. Oktober 2012, 22:16:47 schrieb Chris Ball:
> Hi,
>=20
> On Fri, Oct 19 2012, Heiko St=C3=BCbner wrote:
> > Am Freitag, 19. Oktober 2012, 10:04:14 schrieb Seungwon Jeon:
> >> On Thursday, October 18, 2012, Heiko Stuebner <heiko@sntech.de>
> >>=20
> >> > If host clock is disabled, host cannot detect a card
> >> > in case of using the internal or gpio card-detect for detection.
> >> >=20
> >> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> >> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> >> > ---
> >> > I've added the SDHCI_CD_GPIO to the conditional. With this chang=
e it
> >> > works on my machine. But I'm not sure if this would also be nece=
ssary
> >> > for the external card detect.
> >>=20
> >> Card detection will be asserted out of host in case of using
> >> SDHCI_CD_GPIO. Adding SDHCI_CD_GPIO to the conditional seems
> >> unnecessary.
> >=20
> > But it _was_ necessary :-) . Because only then did the problem go a=
way.
> > You might be right, that there exists a better solution for this, b=
ut
> > something in the original patch is at least still missing to fix th=
e
> > problem.
>=20
> Seungwon, what would you like to do here?  (I'm unhappy taking a patc=
h
> with your name on it that's been modified in a way you disagree with.=
)

I agree with Seungwon, that the solution in my v2 is not the correct on=
e :-) -=20
should've called it RFC or so. The gpio-card-detect code _should_ be ab=
le to=20
handle the resume of the host itself in the card detect case, but it se=
ems=20
it's not able to.

The patch in its v1 form does not fix the problem commit 2abeb5c5ded2 (=
mmc:=20
sdhci-s3c: Add clk_(enable/disable) in runtime suspend/resume) has caus=
ed for=20
Samsung devices using the gpio card-detect - it's broken in 3.7 current=
ly.


So for 3.7 the easiest way would of course be to revert the commit abov=
e and=20
find a correct solution for 3.8.


Heiko
