From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 4/5] mmc: davinci: don't use dma platform resources
Date: Wed, 16 Mar 2016 10:46:42 +0200
Message-ID: <56E91D72.4030606@ti.com>
References: <56E6BF7E.7020401@ti.com>
 <1457996081-21975-1-git-send-email-david@lechnology.com>
 <1457996081-21975-5-git-send-email-david@lechnology.com>
 <56E7CDAC.1090907@ti.com> <56E842EE.7030301@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55705 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964829AbcCPIr6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2016 04:47:58 -0400
In-Reply-To: <56E842EE.7030301@lechnology.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Lechner <david@lechnology.com>, nsekhar@ti.com
Cc: ulf.hansson@linaro.org, khilman@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 03/15/16 19:14, David Lechner wrote:
> On 03/15/2016 03:54 AM, Peter Ujfalusi wrote:
>> On 03/15/16 00:54, David Lechner wrote:
>>>
>>>       host->dma_tx =3D
>>> -        dma_request_slave_channel_compat(mask, edma_filter_fn,
>>> -                &host->txdma, mmc_dev(host->mmc), "tx");
>>> +        dma_request_slave_channel(mmc_dev(host->mmc), "tx");
>>
>> you would need to use dma_request_chan() to be able to rely on the l=
egacy
>> channel mapping.
>> I have staged commits for converting all daVinci and OMAP drivers, I=
'll attach
>> the patch I have for davinci-mmc for reference.
>> When we convert to use the dma_request_chan() we can handle deferred=
 probing
>> also...
>>
>=20
> OK. So I should redo this patch on top of the patch you attached?

Or replace your patch with mine in your series. In my patch I forgot to=
 remove
the 'u32 rxdma, txdma;' from struct mmc_davinci_host...

--=20
P=E9ter
