From: "kyungsik.lee" <kyungsik.lee@lge.com>
Subject: Re: [PATCH RESEND v3] mmc: core: Remove bounce buffer in mmc_send_cxd_data()
Date: Tue, 31 Jul 2012 17:37:52 +0900
Message-ID: <50179960.2030007@lge.com>
References: <1343700024-29861-1-git-send-email-kyungsik.lee@lge.com> <CANfBPZ_9XOjgeeRk8zrNWHH1VgevXu74P4bYGcRBSVj7Rs6GEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:65222 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809Ab2GaIhz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jul 2012 04:37:55 -0400
In-Reply-To: <CANfBPZ_9XOjgeeRk8zrNWHH1VgevXu74P4bYGcRBSVj7Rs6GEw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, raphael.andy.lee@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 2012-07-31 =EC=98=A4=ED=9B=84 4:19, S, Venkatraman wrote:
> On Tue, Jul 31, 2012 at 7:30 AM, Kyungsik Lee <kyungsik.lee@lge.com> =
wrote:
>> It is expected that Extended CSD register(the size of this register
>> is larger than CID/CSD) will be referenced more frequently as more
>> fields have been added to Extended CSD and it seems that it is not
>> a good option to double the memory used.
>>
>> This patch is intended to avoid the use of bounce buffer for reading
>> Extended CSD register in mmc_send_cxd_data().
>>
>> Signed-off-by: Kyungsik Lee <kyungsik.lee@lge.com>
>> ---
>> Changes in v2:
>> - Handling on-stack buffer if it's used in caller.
>>
>> Changes in v3:
>> - Remove unnecesary code.
>> ---
>>   drivers/mmc/core/mmc_ops.c |   54 ++++++++++++++++++++++++++++++++=
-----------
>>   1 files changed, 40 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>> index 0ed2cc5..036e6d5 100644
>> --- a/drivers/mmc/core/mmc_ops.c
>> +++ b/drivers/mmc/core/mmc_ops.c
>> @@ -239,13 +239,19 @@ mmc_send_cxd_data(struct mmc_card *card, struc=
t mmc_host *host,
>>          struct mmc_data data =3D {0};
>>          struct scatterlist sg;
>>          void *data_buf;
>> +       int is_on_stack;
>>
>> -       /* dma onto stack is unsafe/nonportable, but callers to this
>> -        * routine normally provide temporary on-stack buffers ...
>> -        */
>> -       data_buf =3D kmalloc(len, GFP_KERNEL);
>> -       if (data_buf =3D=3D NULL)
>> -               return -ENOMEM;
>> +       is_on_stack =3D object_is_on_stack(buf);
>> +       if (is_on_stack) {
>> +
>> +               /* dma onto stack is unsafe/nonportable, but callers=
 to this
>> +                * routine normally provide temporary on-stack buffe=
rs ...
>> +                */
>> +               data_buf =3D kmalloc(len, GFP_KERNEL);
>> +               if (data_buf =3D=3D NULL)
>> +                       return -ENOMEM;
>> +       } else
>> +               data_buf =3D buf;
>>
>>          mrq.cmd =3D &cmd;
>>          mrq.data =3D &data;
>> @@ -280,8 +286,10 @@ mmc_send_cxd_data(struct mmc_card *card, struct=
 mmc_host *host,
>>
>>          mmc_wait_for_req(host, &mrq);
>>
>> -       memcpy(buf, data_buf, len);
>> -       kfree(data_buf);
>> +       if (is_on_stack) {
>> +               memcpy(buf, data_buf, len);
>> +               kfree(data_buf);
>> +       }
>>
>>          if (cmd.error)
>>                  return cmd.error;
>> @@ -294,24 +302,34 @@ mmc_send_cxd_data(struct mmc_card *card, struc=
t mmc_host *host,
>>   int mmc_send_csd(struct mmc_card *card, u32 *csd)
>>   {
>>          int ret, i;
>> +       u32 *csd_tmp;
>>
>>          if (!mmc_host_is_spi(card->host))
>>                  return mmc_send_cxd_native(card->host, card->rca <<=
 16,
>>                                  csd, MMC_SEND_CSD);
>>
>> -       ret =3D mmc_send_cxd_data(card, card->host, MMC_SEND_CSD, cs=
d, 16);
>> +       csd_tmp =3D kmalloc(16, GFP_KERNEL);
>> +       if (!csd_tmp)
>> +               return -ENOMEM;
>> +
>> +       ret =3D mmc_send_cxd_data(card, card->host, MMC_SEND_CSD, cs=
d_tmp, 16);
>>          if (ret)
>> -               return ret;
>> +               goto err;
>> +
>> +       memcpy(csd, csd_tmp, 16);
> Can this memcpy be folded into the for loop below
> as for (....) { csd[i] =3D be32_to_cpu(csd_tmp[i]); ?
Yes, you're right. I will fix it as you suggested.

Thanks,
Kyungsik Lee
>>          for (i =3D 0;i < 4;i++)
>>                  csd[i] =3D be32_to_cpu(csd[i]);
>>
>> -       return 0;
>> +err:
>> +       kfree(csd_tmp);
>> +       return ret;
>>   }
>>
>>   int mmc_send_cid(struct mmc_host *host, u32 *cid)
>>   {
>>          int ret, i;
>> +       u32 *cid_tmp;
>>
>>          if (!mmc_host_is_spi(host)) {
>>                  if (!host->card)
>> @@ -320,14 +338,22 @@ int mmc_send_cid(struct mmc_host *host, u32 *c=
id)
>>                                  cid, MMC_SEND_CID);
>>          }
>>
>> -       ret =3D mmc_send_cxd_data(NULL, host, MMC_SEND_CID, cid, 16)=
;
>> +       cid_tmp =3D kmalloc(16, GFP_KERNEL);
>> +       if (!cid_tmp)
>> +               return -ENOMEM;
>> +
>> +       ret =3D mmc_send_cxd_data(NULL, host, MMC_SEND_CID, cid_tmp,=
 16);
>>          if (ret)
>> -               return ret;
>> +               goto err;
>> +
>> +       memcpy(cid, cid_tmp, 16);
>>
> <Same comment as above>
>
>>          for (i =3D 0;i < 4;i++)
>>                  cid[i] =3D be32_to_cpu(cid[i]);
>>
>> -       return 0;
>> +err:
>> +       kfree(cid_tmp);
>> +       return ret;
>>   }
>>
>>   int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd)
>> --
>> 1.7.0.4
>>

