From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: Cache Control during mmc_suspend_host
Date: Fri, 16 Dec 2011 17:50:21 +0900
Message-ID: <002901ccbbcf$be9b3990$3bd1acb0$%jun@samsung.com>
References: <CAKLKtzej1VpD41GwBOoNv_51fPqMHMySViptjk6im_mSkSws9A@mail.gmail.com>
 <000f01ccb960$42ac2a40$c8047ec0$%jun@samsung.com>
 <CAKLKtzdWzhJTy2KjCOsUs6rtf5Uec2vHoQ3Wkex6nfmhT01T+w@mail.gmail.com>
 <002f01ccba19$9c2bd9d0$d4838d70$%jun@samsung.com>
 <CAKLKtzfQZrcG330Zf4EXx6rtZ6LZpxzpKnq5=z=fXOO1gZdvSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:28005 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab1LPIuX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Dec 2011 03:50:23 -0500
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LWA003RSGJ9VFJ0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 16 Dec 2011 17:50:22 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0LWA00D9WGJX8J80@mmp1.samsung.com>
 for linux-mmc@vger.kernel.org; Fri, 16 Dec 2011 17:50:21 +0900 (KST)
In-reply-to: <CAKLKtzfQZrcG330Zf4EXx6rtZ6LZpxzpKnq5=z=fXOO1gZdvSg@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Saugata Das' <saugata.das@linaro.org>
Cc: linux-mmc@vger.kernel.org

Saugata Das wrote:
> On 14 December 2011 10:04, Seungwon Jeon <tgih.jun@samsung.com> wrote=
:
> > Saugata Das wrote:
> >> On 13 December 2011 11:57, Seungwon Jeon <tgih.jun@samsung.com> wr=
ote:
> >> > Hi Saugata,
> >> >
> >> > Saugata Das wrote:
> >> >> Hi Seungwon Jeon
> >> >>
> >> >> I see a small issue with the implementation mmc_suspend_host,
> >> >>
> >> >> int mmc_suspend_host(struct mmc_host *host)
> >> >> {
> >> >> .....
> >> >> =A0 =A0 =A0 err =3D mmc_cache_ctrl(host, 0);
> >> >> }
> >> >>
> >> >> So, within mmc_suspend_host we are disabling the cache. But I d=
o not
> >> >> see a corresponding enabling of cache within mmc_resume_host. I
> >> >> suggest we have either enabling of cache within mmc_resume_host=
 or
> >> >> within mmc_suspend_host, we replace mmc_cache_ctrl(host, 0) wit=
h the
> >> >> flush operation, mmc_flush_cache(host->card).
> >> >>
> >> > Currently,
> >> > Cache is enabled in mmc_init_card() during mmc_resume_host().
> >> >
> >> Thanks for your answer.
> >>
> >> If mmc_card_keep_power is TRUE, then do you know why from mmc_resu=
me
> >> we call mmc_init_card instead of just mmc_awake which should reduc=
e
> >> some latency of system wakeup ?
> >>
> > I didn't find that case of keeping the power
> > during sleep in mmc unlike sdio.
>=20
> I am talking about keeping VCCQ ON and switching OFF only VCC. This i=
s
> normally the SLEEP mode of eMMC, which provides quicker wakeup or
> resume. Some platforms will like to have quicker resume and will like
> to avoid doing a mmc_init_card during resume. If that happens, then
> the cache control disabling from mmc_suspend_host will be a problem.
> So, I suggest we change that to mmc_flush_cache which logically does
> the same as  you wanted but it is also future proof.

Yes.
Currently mmc can wake up from sleep state using only CMD0 in mmc_init_=
card.
If we separate the escape route from sleep state, it must be considered=
=2E
Thank you for suggestion.

>=20
> >
> >>
> >> > Thanks,
> >> > Seungwon Jeon.
> >> >>
> >> >>
> >> >> Regards
> >> >> Saugata
> >> >> --
> >> >> To unsubscribe from this list: send the line "unsubscribe linux=
-mmc" in
> >> >> the body of a message to majordomo@vger.kernel.org
> >> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info=
=2Ehtml
> >> >
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

