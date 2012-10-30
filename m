From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v2] mmc: sdhci-s3c: fix the card detection in runtime-pm
Date: Tue, 30 Oct 2012 12:54:47 +0900
Message-ID: <00ad01cdb652$4df5a490$e9e0edb0$%jun@samsung.com>
References: <004801cdad17$498d9140$dca8b3c0$%jun@samsung.com>
 <201210191010.48776.heiko@sntech.de> <87liepq8qo.fsf@octavius.laptop.org>
 <201210292337.35620.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:39461 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642Ab2J3Dyt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Oct 2012 23:54:49 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MCO004S5THH4RM0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 30 Oct 2012 12:54:47 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MCO00I60TJBFP80@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 30 Oct 2012 12:54:47 +0900 (KST)
In-reply-to: <201210292337.35620.heiko@sntech.de>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?Q?'Heiko_St=C3=BCbner'?= <heiko@sntech.de>, 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Chander Kashyap' <chander.kashyap@linaro.org>

Tuesday, October 30, 2012, Heiko Stuebner <heiko@sntech.de> wrote:
> Hi Chris,
>=20
> Am Montag, 29. Oktober 2012, 22:16:47 schrieb Chris Ball:
> > Hi,
> >
> > On Fri, Oct 19 2012, Heiko St=C3=BCbner wrote:
> > > Am Freitag, 19. Oktober 2012, 10:04:14 schrieb Seungwon Jeon:
> > >> On Thursday, October 18, 2012, Heiko Stuebner <heiko@sntech.de>
> > >>
> > >> > If host clock is disabled, host cannot detect a card
> > >> > in case of using the internal or gpio card-detect for detectio=
n.
> > >> >
> > >> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > >> > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > >> > ---
> > >> > I've added the SDHCI_CD_GPIO to the conditional. With this cha=
nge it
> > >> > works on my machine. But I'm not sure if this would also be ne=
cessary
> > >> > for the external card detect.
> > >>
> > >> Card detection will be asserted out of host in case of using
> > >> SDHCI_CD_GPIO. Adding SDHCI_CD_GPIO to the conditional seems
> > >> unnecessary.
> > >
> > > But it _was_ necessary :-) . Because only then did the problem go=
 away.
> > > You might be right, that there exists a better solution for this,=
 but
> > > something in the original patch is at least still missing to fix =
the
> > > problem.
> >
> > Seungwon, what would you like to do here?  (I'm unhappy taking a pa=
tch
> > with your name on it that's been modified in a way you disagree wit=
h.)
>=20
> I agree with Seungwon, that the solution in my v2 is not the correct =
one :-) -
> should've called it RFC or so. The gpio-card-detect code _should_ be =
able to
> handle the resume of the host itself in the card detect case, but it =
seems
> it's not able to.
>=20
> The patch in its v1 form does not fix the problem commit 2abeb5c5ded2=
 (mmc:
> sdhci-s3c: Add clk_(enable/disable) in runtime suspend/resume) has ca=
used for
> Samsung devices using the gpio card-detect - it's broken in 3.7 curre=
ntly.
>=20
>=20
> So for 3.7 the easiest way would of course be to revert the commit ab=
ove and
> find a correct solution for 3.8.

Hi Chris,

This patch doesn't aim Heiko's problem but guarantee card detection for=
 using internal CD.
Clock should be enabled for internal card detection of host.

Thanks,
Seungwon Jeon
>=20
>=20
> Heiko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

