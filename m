From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix pio mode when internal dmac is enabled
Date: Mon, 17 Aug 2015 19:21:21 +0900
Message-ID: <55D1B5A1.3050209@samsung.com>
References: <3018549.c8iX1Dbrhm@diego>
 <CAPDyKFoCt=-PBWc+HPaF7Qe3DjgaiBo+-1GWYFvtZhgEsTPkMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:58094 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631AbbHQKVX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Aug 2015 06:21:23 -0400
In-reply-to: <CAPDyKFoCt=-PBWc+HPaF7Qe3DjgaiBo+-1GWYFvtZhgEsTPkMw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi, Ulf.

On 08/17/2015 07:16 PM, Ulf Hansson wrote:
> On 3 August 2015 at 17:04, Heiko St=C3=BCbner <heiko@sntech.de> wrote=
:
>> The dw_mci_init_dma() may decide to not use dma, but pio instead, ca=
used
>> by things like wrong dma settings in the system.
>>
>> Till now the code dw_mci_init_slot() always assumed that dma is avai=
lable
>> when CONFIG_MMC_DW_IDMAC was defined, ignoring the host->use_dma var
>> set during dma init.
>>
>> So when now the dma init failed for whatever reason, the transfer si=
zes
>> would still be set for dma transfers, especially including the maxim=
um
>> block-count calculated from host->ring_size and resulting in a
>>
>> [    4.991109] ------------[ cut here ]------------
>> [    4.991111] kernel BUG at drivers/mmc/core/core.c:256!
>> [    4.991113] Internal error: Oops - BUG: 0 [#1] SMP ARM
>>
>> because host->ring_size is 0 in this case and the slot init code use=
s
>> the wrong code to calculate the values.
>>
>> Fix this by selecting the correct calculations using the host->use_d=
ma
>> variable instead of the CONFIG_MMC_DW_IDMAC config option.
>>
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>>  drivers/mmc/host/dw_mmc.c | 27 ++++++++++++++-------------
>>  1 file changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 40e9d8e..9ec3521 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2391,19 +2391,20 @@ static int dw_mci_init_slot(struct dw_mci *h=
ost, unsigned int id)
>>                 mmc->max_seg_size =3D host->pdata->blk_settings->max=
_seg_size;
>>         } else {
>>                 /* Useful defaults if platform data is unset. */
>> -#ifdef CONFIG_MMC_DW_IDMAC
>> -               mmc->max_segs =3D host->ring_size;
>> -               mmc->max_blk_size =3D 65536;
>> -               mmc->max_seg_size =3D 0x1000;
>> -               mmc->max_req_size =3D mmc->max_seg_size * host->ring=
_size;
>> -               mmc->max_blk_count =3D mmc->max_req_size / 512;
>> -#else
>> -               mmc->max_segs =3D 64;
>> -               mmc->max_blk_size =3D 65536; /* BLKSIZ is 16 bits */
>> -               mmc->max_blk_count =3D 512;
>> -               mmc->max_req_size =3D mmc->max_blk_size * mmc->max_b=
lk_count;
>> -               mmc->max_seg_size =3D mmc->max_req_size;
>> -#endif /* CONFIG_MMC_DW_IDMAC */
>> +               if (host->use_dma) {
>> +                       mmc->max_segs =3D host->ring_size;
>=20
> I expect this may cause a compiler error since host->ring_size is onl=
y
> available in the struct dw_mci *host when CONFIG_MMC_DW_IDMAC is set.
>=20
> I have already pulled in this patch from Jaehoon's pull request.
> Perhaps I should only amend the patch and change the host->ring_size
> to be always available no matter if CONFIG_MMC_DW_IDMAC is set or not=
?

Sorry for this. if you can, i think good that CONFIG_MMC_DW_IDMAC is re=
moved at struct dw_mci.
Could you amend it?
If you want to get patch, i will send patch at now.

Best Regards,
Jaehoon Chung
>=20
>> +                       mmc->max_blk_size =3D 65536;
>> +                       mmc->max_seg_size =3D 0x1000;
>> +                       mmc->max_req_size =3D mmc->max_seg_size * ho=
st->ring_size;
>> +                       mmc->max_blk_count =3D mmc->max_req_size / 5=
12;
>> +               } else {
>> +                       mmc->max_segs =3D 64;
>> +                       mmc->max_blk_size =3D 65536; /* BLKSIZ is 16=
 bits */
>> +                       mmc->max_blk_count =3D 512;
>> +                       mmc->max_req_size =3D mmc->max_blk_size *
>> +                                           mmc->max_blk_count;
>> +                       mmc->max_seg_size =3D mmc->max_req_size;
>> +               }
>>         }
>>
>>         if (dw_mci_get_cd(mmc))
>> --
>> 2.1.4
>>
>>
>=20
> Kind regards
> Uffe
>=20

