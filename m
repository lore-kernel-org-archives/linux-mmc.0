From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: core: Separate the timeout value for cache-ctrl
Date: Tue, 25 Oct 2011 08:51:37 +0900
Message-ID: <002001cc92a7$de7d2940$9b777bc0$%jun@samsung.com>
References: <001a01cc9235$2f626000$8e272000$%jun@samsung.com>
 <CAGxe1ZG3LBk5uyJjKDRbbv0rFbJQeXYEd04EaKwY9Yfuekg_YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:21242 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755772Ab1JXXvj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 19:51:39 -0400
In-reply-to: <CAGxe1ZG3LBk5uyJjKDRbbv0rFbJQeXYEd04EaKwY9Yfuekg_YA@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Girish K S' <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com

Girish K S wrote:
> On 24 October 2011 15:40, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > Turning the cache off implies flushing cache which doesn't define
> > maximum timeout unlike cache-on. This patch will apply the generic
> > CMD6 timeout only for cache-on. Additionally the kernel message is
> > added for checking failure case of cache-on.
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> > =A0drivers/mmc/core/core.c | =A0 22 +++++++++++++---------
> > =A0drivers/mmc/core/mmc.c =A0| =A0 10 ++++++++--
> > =A02 files changed, 21 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 5278ffb..65b5643 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -2248,6 +2248,7 @@ EXPORT_SYMBOL(mmc_flush_cache);
> > =A0int mmc_cache_ctrl(struct mmc_host *host, u8 enable)
> > =A0{
> > =A0 =A0 =A0 =A0struct mmc_card *card =3D host->card;
> > + =A0 =A0 =A0 unsigned int timeout;
> > =A0 =A0 =A0 =A0int err =3D 0;
> >
> > =A0 =A0 =A0 =A0if (!(host->caps2 & MMC_CAP2_CACHE_CTRL) ||
> > @@ -2258,16 +2259,19 @@ int mmc_cache_ctrl(struct mmc_host *host, u=
8
> enable)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(card->ext_csd.cache=
_size > 0)) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enable =3D !!enable;
> >
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->ext_csd.cache_ctrl ^ enable=
)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->ext_csd.cache_ctrl ^ enable=
) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D enable ?
card->ext_csd.generic_cmd6_time :
> 0;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(c=
ard, EXT_CSD_CMD_SET_NORMAL,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_CACHE_CTRL, enable, 0);
> Here timeout value used is 0. If it has to be 0 then why should you c=
heck
> timeout =3D enable ? card->ext_csd.generic_cmd6_time : 0;
> I think it should be card->ext_csd.generic_cmd6_time instead of 0
Upper line you pointed was removed. Could check '-', please?
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: cache %s =
error %d\n",
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mmc_hostname(card->host),
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 enable ? "on" : "off",
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 err);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.cache_c=
trl =3D enable;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_CACHE_CTRL, enable,
timeout);
Here is modified line.

Beset regards,
Seungwon Jeon.
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_er=
r("%s: cache %s error %d\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0
mmc_hostname(card->host),
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 enable ? "on" : "off",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 err);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card-=
>ext_csd.cache_ctrl =3D enable;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > =A0 =A0 =A0 =A0}
> >
> > =A0 =A0 =A0 =A0return err;
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index fb5bf01..6354eb3 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -1064,14 +1064,20 @@ static int mmc_init_card(struct mmc_host *h=
ost,
> u32 ocr,
> > =A0 =A0 =A0 =A0if ((host->caps2 & MMC_CAP2_CACHE_CTRL) &&
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.cache_=
size > 0) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(card, EXT_CSD_CMD=
_SET_NORMAL,
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_C=
SD_CACHE_CTRL, 1, 0);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_C=
SD_CACHE_CTRL, 1,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card-=
>ext_csd.generic_cmd6_time);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err && err !=3D -EBADMSG)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_card;
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Only if no error, cache is turned=
 on successfully.
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.cache_ctrl =3D err ? 0 =
: 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Cache=
 is supported, but enabling
> failed\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mmc_hostname(card->host));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.cache_c=
trl =3D 1;
> > =A0 =A0 =A0 =A0}
> >
> > =A0 =A0 =A0 =A0if (!oldcard)
> > --
> > 1.7.0.4
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >

