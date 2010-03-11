From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH 03/03] omap hsmmc: adaptation of sdma descriptor
	autoloading feature
Date: Thu, 11 Mar 2010 20:38:02 +0530
Message-ID: <618f0c911003110708s5015f2bftb443b9ea57cb6477@mail.gmail.com>
References: <618f0c911003100612l33b1fec9s163720a5a93a1787@mail.gmail.com>
	 <20100310224110.GW2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20100310224110.GW2900@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>
List-Id: linux-mmc@vger.kernel.org

Tony Lindgren wrote:
> * Venkatraman S <svenkatr@ti.com> [100310 06:08]:
>> @@ -1400,14 +1471,23 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_ho=
st
>> *host, struct mmc_request *req)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | (req->data->blocks << 16));
>> =A0 =A0 =A0 set_data_timeout(host, req->data->timeout_ns, req->data-=
>timeout_clks);
>>
>> - =A0 =A0 if (host->use_dma) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_hsmmc_start_dma_transfer(host=
, req);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(mmc_dev(host->mmc)=
, "MMC start dma failure\n");
>> + =A0 =A0 if (host->dma_caps & DMA_TYPE_SDMA) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_hsmmc_configure_sdma(host, re=
q);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->dma_in_use =3D DMA_TYPE_SDMA;
>> =A0 =A0 =A0 }
>> - =A0 =A0 return 0;
>> + =A0 =A0 if ((host->dma_caps & DMA_TYPE_SDMA_DLOAD) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->data->sg_len > 4) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_hsmmc_configure_sdma_sglist(h=
ost, req);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->dma_in_use =3D DMA_TYPE_SDMA_DLOAD;
>> +
>> + =A0 =A0 }
>> + =A0 =A0 ret =3D omap_hsmmc_start_dma_transfer(host);
>> + =A0 =A0 return ret;
>> +
>> =A0}
>
> Does the driver still work in PIO mode?
>
> We need to have the drivers capable to fail over to PIO mode
> as the DMA channels can run out.
>

   The driver doesn't have an automatic fallback to PIO,
even without my patch. A error return from omap_request_dma is
propogated all the way back to the transfer request.
  The decision to use_dma (the variable) is unaltered.

   Infact, it would be easier to implement a runtime fallback after
this patch is
merged as I have separated out the capability and runtime selection.
(dma_caps and dma_in_use).

Regards,

Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
