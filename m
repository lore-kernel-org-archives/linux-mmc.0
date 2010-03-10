From: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Subject: Re: [PATCH] mxcmmc: fixed max_seg_size value on initialization.
Date: Wed, 10 Mar 2010 12:30:15 +0300
Message-ID: <fcda838a1003100130k9c74fcn6ae844ad5c370842@mail.gmail.com>
References: <1264506004-17827-1-git-send-email-vzapolskiy@gmail.com>
	 <20100224123547.ab622be2.akpm@linux-foundation.org>
	 <20100309143834.3e5a63a9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:60389 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881Ab0CJJaR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Mar 2010 04:30:17 -0500
Received: by wwb39 with SMTP id 39so877857wwb.19
        for <linux-mmc@vger.kernel.org>; Wed, 10 Mar 2010 01:30:15 -0800 (PST)
In-Reply-To: <20100309143834.3e5a63a9.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Pierre Ossman <pierre@ossman.eu>

Hi Andrew,

On Wed, Mar 10, 2010 at 1:38 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Wed, 24 Feb 2010 12:35:47 -0800
> Andrew Morton <akpm@linux-foundation.org> wrote:
>
>> On Tue, 26 Jan 2010 14:40:04 +0300 Vladimir Zapolskiy <vzapolskiy@gm=
ail.com> wrote:
>>
>> > Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
>> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> > Cc: Pierre Ossman <pierre@ossman.eu>
>> > ---
>> > =C2=A0drivers/mmc/host/mxcmmc.c | =C2=A0 =C2=A02 +-
>> > =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
>> > index 60a2b69..faa7b76 100644
>> > --- a/drivers/mmc/host/mxcmmc.c
>> > +++ b/drivers/mmc/host/mxcmmc.c
>> > @@ -708,7 +708,7 @@ static int mxcmci_probe(struct platform_device=
 *pdev)
>> > =C2=A0 =C2=A0 mmc->max_blk_size =3D 2048;
>> > =C2=A0 =C2=A0 mmc->max_blk_count =3D 65535;
>> > =C2=A0 =C2=A0 mmc->max_req_size =3D mmc->max_blk_size * mmc->max_b=
lk_count;
>> > - =C2=A0 mmc->max_seg_size =3D mmc->max_seg_size;
>> > + =C2=A0 mmc->max_seg_size =3D mmc->max_req_size;
>> >
>> > =C2=A0 =C2=A0 host =3D mmc_priv(mmc);
>> > =C2=A0 =C2=A0 host->base =3D ioremap(r->start, resource_size(r));
>>
>> Please don't send unchangelogged patches.
>>
>> I am not able to determine the user-visible impact of this bug hence=
 I
>> am not able to determine which kernel(s) we should merge this patch
>> into.
>>
>
> This patch is still stuck due to lack of any changelog explanation of
> what it does. =C2=A0Vladimir seems to have vanished. =C2=A0Can someon=
e please
> take a look? =C2=A0Review the patch and explain what it does?
>
=46rom my view this unpleasant typo appeared while porting the driver
from Freescale original sources, where anyone can easily find the corre=
ct
version.

Current incorrect version potentially can influence segment and merge
handling in block subsystem via MMC request queue settings.

> Obviously the old code was wrong. =C2=A0But is the new code right, an=
d what
> runtime effects does it have?
>
>
>
> Thanks.
>
>
> From: Vladimir Zapolskiy <vzapolskiy@gmail.com>
>
> -ENOCHANGELOG
>
> Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pierre Ossman <pierre@ossman.eu>
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
> =C2=A0drivers/mmc/host/mxcmmc.c | =C2=A0 =C2=A02 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -puN drivers/mmc/host/mxcmmc.c~mxcmmc-fixed-max_seg_size-value-o=
n-initialization drivers/mmc/host/mxcmmc.c
> --- a/drivers/mmc/host/mxcmmc.c~mxcmmc-fixed-max_seg_size-value-on-in=
itialization
> +++ a/drivers/mmc/host/mxcmmc.c
> @@ -708,7 +708,7 @@ static int mxcmci_probe(struct platform_
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc->max_blk_size =3D 2048;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc->max_blk_count =3D 65535;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc->max_req_size =3D mmc->max_blk_size * =
mmc->max_blk_count;
> - =C2=A0 =C2=A0 =C2=A0 mmc->max_seg_size =3D mmc->max_seg_size;
> + =C2=A0 =C2=A0 =C2=A0 mmc->max_seg_size =3D mmc->max_req_size;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0host =3D mmc_priv(mmc);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0host->base =3D ioremap(r->start, resource_=
size(r));
> _
>
>

Regards,
Vladimir
