From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] drivers/mmc/card/block.c: fix potential null dereference 'idata'
Date: Mon, 9 May 2011 18:13:55 +0300
Message-ID: <BANLkTimOfmS=tKMY7Z_vRcCWEO6drgwegQ@mail.gmail.com>
References: <4DC7F4AB.90607@gmail.com>
	<Pine.LNX.4.64.1105091631400.15483@pc-004.diku.dk>
	<4DC802C0.9040302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63448 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879Ab1EIPN4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 May 2011 11:13:56 -0400
In-Reply-To: <4DC802C0.9040302@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vladimir Motyka <vladimir.motyka@gmail.com>
Cc: Julia Lawall <julia@diku.dk>, cjb@laptop.org, kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 9, 2011 at 6:05 PM, Vladimir Motyka
<vladimir.motyka@gmail.com> wrote:
> On 05/09/2011 04:32 PM, Julia Lawall wrote:
>> On Mon, 9 May 2011, Vladimir Motyka wrote:
>>
>>> When allocation of idata fails there was a null dereferece.
>>
>> Why not have a different label for the two cases? =C2=A0That would m=
ake the
>> code easier to statically analyze, and perhaps be more understandabl=
e as
>> well.
>>
>> julia
>>
> I think You are right. So it could be better like this?
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 3dec493..a03cdc6 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -237,7 +237,7 @@ static struct mmc_blk_ioc_data
> *mmc_blk_ioctl_copy_from_user(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0idata =3D kzalloc(sizeof(*idata), GFP_KERN=
EL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!idata) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D -ENOME=
M;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto copy_err;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto alloc_err;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (copy_from_user(&idata->ic, user, sizeo=
f(idata->ic))) {
> @@ -266,9 +266,9 @@ static struct mmc_blk_ioc_data
> *mmc_blk_ioctl_copy_from_user(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return idata;
>
> =C2=A0copy_err:
> - =C2=A0 =C2=A0 =C2=A0 if(idata)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(idata->buf);
> + =C2=A0 =C2=A0 =C2=A0 kfree(idata->buf);
Make it one patch not series.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(idata);
> +alloc_err:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PTR(err);
> =C2=A0}
>
> Or it could return right after allocation fails so there needn't be
> goto. It is simplier, but maybe worse looking and to read. What is yo=
ur
> opinion?
>
> Vladimir Motyka
>
>>
>>> Signed-off-by: Vladimir Motyka <vladimir.motyka@gmail.com>
>>>
>>> ---
>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>> index 407836d..3dec493 100644
>>> --- a/drivers/mmc/card/block.c
>>> +++ b/drivers/mmc/card/block.c
>>> @@ -266,10 +266,10 @@ static struct mmc_blk_ioc_data
>>> *mmc_blk_ioctl_copy_from_user(
>>> =C2=A0 =C2=A0 =C2=A0return idata;
>>>
>>> =C2=A0copy_err:
>>> - =C2=A0 =C2=A0kfree(idata->buf);
>>> + =C2=A0 =C2=A0if(idata)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(idata->buf);
>>> =C2=A0 =C2=A0 =C2=A0kfree(idata);
>>> =C2=A0 =C2=A0 =C2=A0return ERR_PTR(err);
>>> -
>>> =C2=A0}
>>>
>>> =C2=A0static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe kernel-ja=
nitors" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html
>>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>



--=20
With Best Regards,
Andy Shevchenko
