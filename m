From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: core: Substitute mmc_flush_cash for mmc_cache_ctrl in
 suspend
Date: Wed, 07 Mar 2012 12:49:46 +0900
Message-ID: <000b01ccfc15$570e27c0$052a7740$%jun@samsung.com>
References: <000101cce7a7$fc0df6b0$f429e410$%jun@samsung.com>
 <CAKLKtzd486AB8U7kxqo1_9FebD-MB-Nm2V4zBPHthQGDpPjKAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:45527 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759366Ab2CGDtt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Mar 2012 22:49:49 -0500
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0M0H00EYPXAU07J0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 07 Mar 2012 12:49:47 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0M0H00L6IXAZRHJ0@mmp1.samsung.com>
 for linux-mmc@vger.kernel.org; Wed, 07 Mar 2012 12:49:47 +0900 (KST)
In-reply-to: <CAKLKtzd486AB8U7kxqo1_9FebD-MB-Nm2V4zBPHthQGDpPjKAQ@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Saugata Das' <saugata.das@linaro.org>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, ygardi@codeaurora.org

Saugata Das <saugata.das@linaro.org>:
> On 10 February 2012 09:26, Seungwon Jeon <tgih.jun@samsung.com> wrote=
:
> > After the cache is disabled in suspend, enabling cache can be done =
by
> > mmc_init_card in resume. Currently this call path has been changed.=
 In
> > case of sleep mode mmc_init_card isn't called. So mmc_cache_ctrl ne=
ed to
> > be replaced with mmc_flush_cache in suspend.
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> > =A0drivers/mmc/core/core.c | =A0 =A09 +++++++--
> > =A01 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 8a19143..70e25d8 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -2329,9 +2329,14 @@ EXPORT_SYMBOL(mmc_card_can_sleep);
> > =A0*/
> > =A0int mmc_flush_cache(struct mmc_card *card)
> > =A0{
> > - =A0 =A0 =A0 struct mmc_host *host =3D card->host;
> > + =A0 =A0 =A0 struct mmc_host *host;
> > =A0 =A0 =A0 =A0int err =3D 0;
> >
> > + =A0 =A0 =A0 if (!card)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> > +
> > + =A0 =A0 =A0 host =3D card->host;
> > +
> > =A0 =A0 =A0 =A0if (!(host->caps2 & MMC_CAP2_CACHE_CTRL))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
> >
> > @@ -2401,7 +2406,7 @@ int mmc_suspend_host(struct mmc_host *host)
> > =A0 =A0 =A0 =A0cancel_delayed_work(&host->detect);
> > =A0 =A0 =A0 =A0mmc_flush_scheduled_work();
> > =A0 =A0 =A0 =A0if (mmc_try_claim_host(host)) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_cache_ctrl(host, 0);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_flush_cache(host->card);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_do_release_host(host);
> > =A0 =A0 =A0 =A0} else {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -EBUSY;
> > --
> > 1.7.0.4
>=20
> Thanks for the changes.
> Reviewed-by: Saugata Das <saugata.das@linaro.org>
>=20
Is there more opinions?

Thanks,
Seungwon Jeon.
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

