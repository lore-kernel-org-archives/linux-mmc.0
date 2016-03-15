From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 4/5] mmc: davinci: don't use dma platform resources
Date: Tue, 15 Mar 2016 10:56:01 +0200
Message-ID: <56E7CE21.7070605@ti.com>
References: <56E6BF7E.7020401@ti.com>
 <1457996081-21975-1-git-send-email-david@lechnology.com>
 <1457996081-21975-5-git-send-email-david@lechnology.com>
 <56E7CDAC.1090907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54914 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965193AbcCOI50 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Mar 2016 04:57:26 -0400
In-Reply-To: <56E7CDAC.1090907@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Lechner <david@lechnology.com>, nsekhar@ti.com
Cc: ulf.hansson@linaro.org, khilman@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 03/15/16 10:54, Peter Ujfalusi wrote:
> On 03/15/16 00:54, David Lechner wrote:
>> The davinci arch now has dma_slave_map tables for dma resources, so =
it is
>> no longer necessary to pass dma resources through the platform devic=
e.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>
>> v2 changes: Remove platform_get_resource completly instead of just i=
gnoring it.
>>
>>
>>  drivers/mmc/host/davinci_mmc.c | 19 ++-----------------
>>  1 file changed, 2 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davin=
ci_mmc.c
>> index 8d10a92..dc96401 100644
>> --- a/drivers/mmc/host/davinci_mmc.c
>> +++ b/drivers/mmc/host/davinci_mmc.c
>> @@ -202,7 +202,6 @@ struct mmc_davinci_host {
>>  	u32 buffer_bytes_left;
>>  	u32 bytes_left;
>> =20
>> -	u32 rxdma, txdma;
>>  	struct dma_chan *dma_tx;
>>  	struct dma_chan *dma_rx;
>>  	bool use_dma;
>> @@ -520,16 +519,14 @@ static int __init davinci_acquire_dma_channels=
(struct mmc_davinci_host *host)
>>  	dma_cap_set(DMA_SLAVE, mask);
>> =20
>>  	host->dma_tx =3D
>> -		dma_request_slave_channel_compat(mask, edma_filter_fn,
>> -				&host->txdma, mmc_dev(host->mmc), "tx");
>> +		dma_request_slave_channel(mmc_dev(host->mmc), "tx");
>=20
> you would need to use dma_request_chan() to be able to rely on the le=
gacy
> channel mapping.

In other words: w/o dma_request_chan() legacy boot will not work as you=
 will
not get the DMA channel.

> I have staged commits for converting all daVinci and OMAP drivers, I'=
ll attach
> the patch I have for davinci-mmc for reference.
> When we convert to use the dma_request_chan() we can handle deferred =
probing
> also...
>=20
>=20
>=20
>>  	if (!host->dma_tx) {
>>  		dev_err(mmc_dev(host->mmc), "Can't get dma_tx channel\n");
>>  		return -ENODEV;
>>  	}
>> =20
>>  	host->dma_rx =3D
>> -		dma_request_slave_channel_compat(mask, edma_filter_fn,
>> -				&host->rxdma, mmc_dev(host->mmc), "rx");
>> +		dma_request_slave_channel(mmc_dev(host->mmc), "rx");
>>  	if (!host->dma_rx) {
>>  		dev_err(mmc_dev(host->mmc), "Can't get dma_rx channel\n");
>>  		r =3D -ENODEV;
>> @@ -1251,18 +1248,6 @@ static int __init davinci_mmcsd_probe(struct =
platform_device *pdev)
>>  	host =3D mmc_priv(mmc);
>>  	host->mmc =3D mmc;	/* Important */
>> =20
>> -	r =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
>> -	if (!r)
>> -		dev_warn(&pdev->dev, "RX DMA resource not specified\n");
>> -	else
>> -		host->rxdma =3D r->start;
>> -
>> -	r =3D platform_get_resource(pdev, IORESOURCE_DMA, 1);
>> -	if (!r)
>> -		dev_warn(&pdev->dev, "TX DMA resource not specified\n");
>> -	else
>> -		host->txdma =3D r->start;
>> -
>>  	host->mem_res =3D mem;
>>  	host->base =3D devm_ioremap(&pdev->dev, mem->start, mem_size);
>>  	if (!host->base)
>>
>=20
>=20


--=20
P=E9ter
