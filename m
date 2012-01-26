From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v3 2/2] mmc: core: Support packed command for eMMC4.5 device
Date: Thu, 26 Jan 2012 15:42:42 +0900
Message-ID: <CAKYAXd8zFf7AF5_X-divH51+B=Y2YC1ZjZF00D_=+R6eF8qe9g@mail.gmail.com>
References: <002701ccd728$edab9350$c902b9f0$%jun@samsung.com>
	<CAKLKtzddDXhbT6o8XUsMxad9+_a_StJCQz+eBnfQ+q+xLuJQKg@mail.gmail.com>
	<CAKYAXd8A70X1gb-NFHVDMXd-aSG6+Y3PWvRTZDMT3-Ze3aF5Yw@mail.gmail.com>
	<002501ccdb20$c98b2e80$5ca18b80$%jun@samsung.com>
	<CAKYAXd_jdGfpC9kcYht=qnfaTPwE+YEx1fo89GkpRyWcN6igig@mail.gmail.com>
	<CAKYAXd-pCS4kRsg0PJp98YRqz_P0CtTKWEWiQJarE_iHqiesYQ@mail.gmail.com>
	<000c01ccdbf0$71fe58b0$55fb0a10$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:57754 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab2AZGmo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Jan 2012 01:42:44 -0500
In-Reply-To: <000c01ccdbf0$71fe58b0$55fb0a10$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Saugata Das <saugata.das@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-kernel@vger.kernel.org

2012/1/26 Seungwon Jeon <tgih.jun@samsung.com>:
> Namjae Jeon <linkinjeon@gmail.com>:
>> 2012/1/25 Namjae Jeon <linkinjeon@gmail.com>:
>> >>> >> +
>> >>> >> +static int mmc_blk_issue_packed_rd(struct mmc_queue *mq,
>> >>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mmc=
_queue_req *mq_rq)
>> >>> >> +{
>> >>> >> + =C2=A0 =C2=A0 =C2=A0 struct mmc_blk_data *md =3D mq->data;
>> >>> >> + =C2=A0 =C2=A0 =C2=A0 struct mmc_card *card =3D md->queue.ca=
rd;
>> >>> >> + =C2=A0 =C2=A0 =C2=A0 int status, ret =3D -EIO, retry =3D 2;
>> > Hi. Seungwon.
>> > First Thansk for your reply.
>> > There is one more my review comment.
>> > I think that EIO of ret is not needed. there is no case to be skip=
ped
>> > if/ese condition in do while loop.
> Oh, no need practically.
> Thank you for your inspection.
>
>>
>> Hi. Seungwon.
>>
>> =C2=A0 if ((!mmc_host_is_spi(card->host) && rq_data_dir(req) !=3D RE=
AD) ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (mq_mrq->packed_cmd =3D=3D MMC_PACKED_WR_HDR)) {
>>
>> it seems more better that upper if condition is changed like the bel=
ow.
> Do you have any reason for your comment?
> Packed command(4.5 feature) is regardless of SPI.
> SPI mode has been removed since version 4.3.
>
>>
>> if (!mmc_host_is_spi(card->host) && ((rq_data_dir(req) !=3D READ) ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (mq_mrq->packed_cmd =3D=3D MMC_PACKED_WR_HDR))) {
>>
>>
>> +++ b/drivers/mmc/core/host.c
>> @@ -346,6 +346,8 @@ struct mmc_host *mmc_alloc_host(int extra, struc=
t
>> device *dev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0host->max_blk_size =3D 512;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0host->max_blk_count =3D PAGE_CACHE_SIZE /=
 512;
>>
>> + =C2=A0 =C2=A0 =C2=A0 host->packed_min =3D 2;
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return host;
>>
>> if packed_min is fixed value without increasing/decreasing, =C2=A0it=
 seems
>> more better to use macro.
>> Thanks.
> packed_min is not fixed value.
> Could you refer the following is changes log about v3?
>
> Changes in v3:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- Add a variable member in mmc_host for mi=
nimum number of packed entries.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This value can be overridden by hos=
t.
Ah.. Okay~ I clearly understand about two queston.
Totally, Looks good to me.
Thanks for your reply.
And I heard that packed cmd is not good while reading small chunk,
If so, I want to use packed write cmd not read cmd.
Can I use packed only packed write cmd by seperating
MMC_CAP2_PACKED_READ_CMD and MMC_CAP2_PACKED_WRITE_CMD ?
>
> Best regards,
> Seungwon Jeon.
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
