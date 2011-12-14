From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: Cache Control during mmc_suspend_host
Date: Wed, 14 Dec 2011 13:34:04 +0900
Message-ID: <002f01ccba19$9c2bd9d0$d4838d70$%jun@samsung.com>
References: <CAKLKtzej1VpD41GwBOoNv_51fPqMHMySViptjk6im_mSkSws9A@mail.gmail.com>
 <000f01ccb960$42ac2a40$c8047ec0$%jun@samsung.com>
 <CAKLKtzdWzhJTy2KjCOsUs6rtf5Uec2vHoQ3Wkex6nfmhT01T+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:16554 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134Ab1LNEeG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2011 23:34:06 -0500
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LW6005WXFCCKCH0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 14 Dec 2011 13:34:04 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0LW600DZFFCSM770@mmp2.samsung.com>
 for linux-mmc@vger.kernel.org; Wed, 14 Dec 2011 13:34:04 +0900 (KST)
In-reply-to: <CAKLKtzdWzhJTy2KjCOsUs6rtf5Uec2vHoQ3Wkex6nfmhT01T+w@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Saugata Das' <saugata.das@linaro.org>
Cc: linux-mmc@vger.kernel.org

Saugata Das wrote:
> On 13 December 2011 11:57, Seungwon Jeon <tgih.jun@samsung.com> wrote=
:
> > Hi Saugata,
> >
> > Saugata Das wrote:
> >> Hi Seungwon Jeon
> >>
> >> I see a small issue with the implementation mmc_suspend_host,
> >>
> >> int mmc_suspend_host(struct mmc_host *host)
> >> {
> >> .....
> >> =A0 =A0 =A0 err =3D mmc_cache_ctrl(host, 0);
> >> }
> >>
> >> So, within mmc_suspend_host we are disabling the cache. But I do n=
ot
> >> see a corresponding enabling of cache within mmc_resume_host. I
> >> suggest we have either enabling of cache within mmc_resume_host or
> >> within mmc_suspend_host, we replace mmc_cache_ctrl(host, 0) with t=
he
> >> flush operation, mmc_flush_cache(host->card).
> >>
> > Currently,
> > Cache is enabled in mmc_init_card() during mmc_resume_host().
> >
> Thanks for your answer.
>=20
> If mmc_card_keep_power is TRUE, then do you know why from mmc_resume
> we call mmc_init_card instead of just mmc_awake which should reduce
> some latency of system wakeup ?
>=20
I didn't find that case of keeping the power
during sleep in mmc unlike sdio.

>=20
> > Thanks,
> > Seungwon Jeon.
> >>
> >>
> >> Regards
> >> Saugata
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

