From: "kyungsik.lee" <kyungsik.lee@lge.com>
Subject: Re: [PATCH RESEND v4] mmc: core: Remove bounce buffer in mmc_send_cxd_data()
Date: Thu, 02 Aug 2012 14:39:39 +0900
Message-ID: <501A129B.2020709@lge.com>
References: <1343783145-17623-1-git-send-email-kyungsik.lee@lge.com> <000001cd7059$8f1a7b10$ad4f7130$@min@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:59576 "EHLO
	LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480Ab2HBFjm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Aug 2012 01:39:42 -0400
In-Reply-To: <000001cd7059$8f1a7b10$ad4f7130$@min@lge.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chanho Min <chanho.min@lge.com>, 'Chris Ball' <cjb@laptop.org>
Cc: 'Venkatraman S' <svenkatr@ti.com>, raphael.andy.lee@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Chanho Min,


On 2012-08-02 =EC=98=A4=EC=A0=84 11:50, Chanho Min wrote:
>> -----Original Message-----
>> From: Kyungsik Lee [mailto:kyungsik.lee@lge.com]
>> Sent: Wednesday, August 01, 2012 10:06 AM
>> To: Chris Ball
>> Cc: Venkatraman S; Jaehoon Chung; raphael.andy.lee@gmail.com; linux-
>> mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Kyungsik Lee
>> Subject: [PATCH RESEND v4] mmc: core: Remove bounce buffer in
>> mmc_send_cxd_data()
>>
>> It is expected that Extended CSD register(the size of this register
>> is larger than CID/CSD) will be referenced more frequently as more
>> fields have been added to Extended CSD and it seems that it is not
>> a good option to double the memory used.
>>
>> This patch is intended to avoid the use of bounce buffer for reading
>> Extended CSD register in mmc_send_cxd_data().
>>
>> Signed-off-by: Kyungsik Lee <kyungsik.lee@lge.com>
>> Signed-off-by: S, Venkatraman <svenkatr@ti.com>
>> ---
>> Changes in v2:
>> - Handling on-stack buffer if it's used in caller.
>>
>> Changes in v3:
>> - Remove unnecesary code.
>>
>> Changes in v4:
>> - Modify codes based-on S, Venkatraman's comments.
>> ---
>> drivers/mmc/core/mmc_ops.c |   54
> +++++++++++++++++++++++++++++++------------
>> -
>> 1 files changed, 38 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>> index 0ed2cc5..920a017 100644
>> --- a/drivers/mmc/core/mmc_ops.c
>> +++ b/drivers/mmc/core/mmc_ops.c
>> @@ -239,13 +239,19 @@ mmc_send_cxd_data(struct mmc_card *card, struc=
t
> mmc_host
>> *host,
>> 	struct mmc_data data =3D {0};
>> 	struct scatterlist sg;
>> 	void *data_buf;
>> +	int is_on_stack;
>>
>> -	/* dma onto stack is unsafe/nonportable, but callers to this
>> -	 * routine normally provide temporary on-stack buffers ...
>> -	 */
>> -	data_buf =3D kmalloc(len, GFP_KERNEL);
>> -	if (data_buf =3D=3D NULL)
>> -		return -ENOMEM;
>> +	is_on_stack =3D object_is_on_stack(buf);
>> +	if (is_on_stack) {
>> +
>> +		/* dma onto stack is unsafe/nonportable, but callers to this
>> +		 * routine normally provide temporary on-stack buffers ...
>> +		 */
>> +		data_buf =3D kmalloc(len, GFP_KERNEL);
>> +		if (data_buf =3D=3D NULL)
>> +			return -ENOMEM;
>> +	} else
>> +		data_buf =3D buf;
>>
>> 	mrq.cmd =3D &cmd;
>> 	mrq.data =3D &data;
>> @@ -280,8 +286,10 @@ mmc_send_cxd_data(struct mmc_card *card, struct
> mmc_host
>> *host,
>>
>> 	mmc_wait_for_req(host, &mrq);
>>
>> -	memcpy(buf, data_buf, len);
>> -	kfree(data_buf);
>> +	if (is_on_stack) {
>> +		memcpy(buf, data_buf, len);
>> +		kfree(data_buf);
>> +	}
>>
>> 	if (cmd.error)
>> 		return cmd.error;
>> @@ -294,24 +302,32 @@ mmc_send_cxd_data(struct mmc_card *card, struc=
t
> mmc_host
>> *host,
>> int mmc_send_csd(struct mmc_card *card, u32 *csd)
>> {
>> 	int ret, i;
>> +	u32 *csd_tmp;
>>
>> 	if (!mmc_host_is_spi(card->host))
>> 		return mmc_send_cxd_native(card->host, card->rca << 16,
>> 				csd, MMC_SEND_CSD);
>>
>> -	ret =3D mmc_send_cxd_data(card, card->host, MMC_SEND_CSD, csd, 16)=
;
>> +	csd_tmp =3D kmalloc(16, GFP_KERNEL);
>> +	if (!csd_tmp)
>> +		return -ENOMEM;
>> +
>> +	ret =3D mmc_send_cxd_data(card, card->host, MMC_SEND_CSD, csd_tmp,
> 16);
>> 	if (ret)
>> -		return ret;
>> +		goto err;
>>
>> 	for (i =3D 0;i < 4;i++)
>> -		csd[i] =3D be32_to_cpu(csd[i]);
>> +		csd[i] =3D be32_to_cpu(csd_tmp[i]);
>>
>> -	return 0;
>> +err:
>> +	kfree(csd_tmp);
>> +	return ret;
>> }
> If we can handle for the on-stack buffer in mmc_send_cxd_data, why do=
 we
> need callers's modification as bellows?
As you comment above, on-stack buffer can be handled with no better=20
performance gain.
In case of both mmc_send_cid() and mmc_send_csd(), on-stack buffers hav=
e=20
not been allocated
in the upper callers to the two functions(you may check it in the upper=
=20
callers).
And you will find out the reason why such a modification below is neede=
d=20
in the mail thread
(Reply to S, Venkatraman's comment).

Thanks
Kyungsik Lee
>> int mmc_send_cid(struct mmc_host *host, u32 *cid)
>> {
>> 	int ret, i;
>> +	u32 *cid_tmp;
>>
>> 	if (!mmc_host_is_spi(host)) {
>> 		if (!host->card)
>> @@ -320,14 +336,20 @@ int mmc_send_cid(struct mmc_host *host, u32 *c=
id)
>> 				cid, MMC_SEND_CID);
>> 	}
>>
>> -	ret =3D mmc_send_cxd_data(NULL, host, MMC_SEND_CID, cid, 16);
>> +	cid_tmp =3D kmalloc(16, GFP_KERNEL);
>> +	if (!cid_tmp)
>> +		return -ENOMEM;
>> +
>> +	ret =3D mmc_send_cxd_data(NULL, host, MMC_SEND_CID, cid_tmp, 16);
>> 	if (ret)
>> -		return ret;
>> +		goto err;
>>
>> 	for (i =3D 0;i < 4;i++)
>> -		cid[i] =3D be32_to_cpu(cid[i]);
>> +		cid[i] =3D be32_to_cpu(cid_tmp[i]);
>>
>> -	return 0;
>> +err:
>> +	kfree(cid_tmp);
>> +	return ret;
>> }
>>
>> int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd)
>> --
>> 1.7.0.4
> Thanks
> Chanho Min
>
>

