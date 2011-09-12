From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: DMA unmap only once in case of MMC error
Date: Mon, 12 Sep 2011 10:34:06 +0200
Message-ID: <CAJ0pr1-ytbiXLYi_vXRx80j+H0CqvZSOFTQBpz=ia90GsH0TGQ@mail.gmail.com>
References: <1314569323-6886-1-git-send-email-per.forlin@linaro.org>
	<CANfBPZ-azGV0H7asRHD5+vdFjCkrx=E2Oypnrk_SW9K5+DwTLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f42.google.com ([209.85.216.42]:51512 "EHLO
	mail-qw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735Ab1ILIeH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Sep 2011 04:34:07 -0400
In-Reply-To: <CANfBPZ-azGV0H7asRHD5+vdFjCkrx=E2Oypnrk_SW9K5+DwTLQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh <santosh.shilimkar@ti.com>, Balaji T Krishnamoorthy <balajitk@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nicolas.pitre@linaro.org>

On 1 September 2011 21:19, S, Venkatraman <svenkatr@ti.com> wrote:
> On Mon, Aug 29, 2011 at 3:38 AM, Per Forlin <per.forlin@linaro.org> w=
rote:
>> Reported by Russell King:
>> ------------
>> mmcblk0: error -84 transferring data, sector 149201, nr 64,
>> cmd response 0x900, card status 0xb00
>> mmcblk0: retrying using single block read
>>
>> WARNING: at /home/rmk/git/linux-2.6-rmk/lib/dma-debug.c:811 check_un=
map
>> omap_hsmmc omap_hsmmc.0: DMA-API: device driver tries to free DMA me=
mory
>> it has not allocated [device address=3D0x0000000080933000] [size=3D2=
0480 bytes]
>> -------------
>>
>> In case of an error dma_unmap() is issued in omap_hsmmc_dma_cleanup(=
)
>> and then again in omap_hsmmc_post_req(). Resolve this by clearing th=
e
>> host_cookie to indicate there is no DMA mapped memory to unmap.
>>
>> Signed-off-by: Per Forlin <per.forlin@linaro.org>
>> ---
>> Bug fix on 3.1-rc3
>>
>> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A07 +++++--
>> =A01 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_h=
smmc.c
>> index 21e4a79..31d9817 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -1011,6 +1011,7 @@ static void omap_hsmmc_dma_cleanup(struct omap=
_hsmmc_host *host, int errno)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->data->sg_len,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hsmmc_get_dma_di=
r(host, host->data));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_free_dma(dma_ch);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->data->host_cookie =3D 0;
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0host->data =3D NULL;
>> =A0}
>> @@ -1576,8 +1577,10 @@ static void omap_hsmmc_post_req(struct mmc_ho=
st *mmc, struct mmc_request *mrq,
>> =A0 =A0 =A0 =A0struct mmc_data *data =3D mrq->data;
>>
>> =A0 =A0 =A0 =A0if (host->use_dma) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), data-=
>sg, data->sg_len,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hsmmc_=
get_dma_dir(host, data));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->host_cookie)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_sg(mmc_dev(h=
ost->mmc), data->sg,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0data->sg_len,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0omap_hsmmc_get_dma_dir(host, data));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->host_cookie =3D 0;
>> =A0 =A0 =A0 =A0}
>> =A0}
>> --
>> 1.7.4.1
>>
>>
>
> I just posted a patch [1] which just consolidates all unmapping to
> just post_req.
> This would obviously prevent double unmapping, and keeps all the rela=
ted
> dma operations at a single place. Let me know if that works better.
>
I'm in favour of such patch. My patch only tries to do the minimal bug =
fix.
I have been out of office the last 10 days or so. I'll look at your
patch later today.

Thanks,
Per
