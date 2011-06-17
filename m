From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v4 02/12] omap_hsmmc: use original sg_len for dma_unmap_sg
Date: Fri, 17 Jun 2011 12:58:20 +0200
Message-ID: <BANLkTikb=gXBpxSvgdg4Ni1sXj99m7zj2g@mail.gmail.com>
References: <1306360653-6196-1-git-send-email-per.forlin@linaro.org>
	<1306360653-6196-3-git-send-email-per.forlin@linaro.org>
	<BANLkTinWzJ22NrVGofSNvgOcQePD1BKAuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39339 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab1FQK6V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jun 2011 06:58:21 -0400
In-Reply-To: <BANLkTinWzJ22NrVGofSNvgOcQePD1BKAuA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linaro-dev <linaro-dev@lists.linaro.org>, David Vrabel <david.vrabel@csr.com>

On 16 June 2011 15:16, S, Venkatraman <svenkatr@ti.com> wrote:
> On Thu, May 26, 2011 at 3:27 AM, Per Forlin <per.forlin@linaro.org> w=
rote:
>> Don't use the returned sg_len from dma_map_sg() as inparameter
>> to dma_unmap_sg(). Use the original sg_len for both dma_map_sg
>> and dma_unmap_sg.
>>
>> Signed-off-by: Per Forlin <per.forlin@linaro.org>
>> ---
>> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A05 +++--
>> =A01 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_h=
smmc.c
>> index 259ece0..ad3731a 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -959,7 +959,8 @@ static void omap_hsmmc_dma_cleanup(struct omap_h=
smmc_host *host, int errno)
>> =A0 =A0 =A0 =A0spin_unlock(&host->irq_lock);
>>
>> =A0 =A0 =A0 =A0if (host->use_dma && dma_ch !=3D -1) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), host-=
>data->sg, host->dma_len,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), host-=
>data->sg,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->data->sg_len,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hsmmc_get_dma_di=
r(host, host->data));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_free_dma(dma_ch);
>> =A0 =A0 =A0 =A0}
>> @@ -1343,7 +1344,7 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_=
status, void *cb_data)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->dma_l=
en,
>> + =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_le=
n,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hsmmc_get_dma_dir(host, data));
>>
>> =A0 =A0 =A0 =A0req_in_progress =3D host->req_in_progress;
>> --
>> 1.7.4.1
>>
>
> Reviewed-by: Venkatraman S <svenkatr@ti.com>
>
> Perhaps this doesn't belong to $FEATURE and can be posted as a separa=
te patch ?
Yes, I will resend it as a separate patch.

Thanks,
Per
