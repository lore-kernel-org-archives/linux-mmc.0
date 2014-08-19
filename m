From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH V2] mmc: sdhci: check 1.2v IO capability for SDHC host
Date: Tue, 19 Aug 2014 05:58:22 +0000
Message-ID: <17296D9F8FF2234F831FC3DF505A87A911B234B3@shsmsx102.ccr.corp.intel.com>
References: <20140819030240.GA3201@intel.com> <53F2DD23.5080003@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:43096 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619AbaHSF6g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Aug 2014 01:58:36 -0400
In-Reply-To: <53F2DD23.5080003@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "chris@printf.org" <chris@printf.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>



> -----Original Message-----
> From: Jaehoon Chung [mailto:jh80.chung@samsung.com]
> Sent: Tuesday, August 19, 2014 1:14 PM
> To: Dong, Chuanxiao; ulf.hansson@linaro.org; chris@printf.org
> Cc: linux-mmc@vger.kernel.org
> Subject: Re: [PATCH V2] mmc: sdhci: check 1.2v IO capability for SDHC host
> 
> Hi, Dong.
> 
> Doesn't it need to consider for HS400 mode?
HS400 should also consider this case, but not in this patch. Right now HS400 caps is still controlled by specific host controller driver, not the same way as HS200. Thus HS400 should be safe without this fix.

MMC_CAPS_HS200 will be set automatically when SDHCI host support SDR104 mode, no matter 1.2v I/O voltage is supported or not. So the purpose of this patch is to help resolve this.

Thanks
Chuanxiao

> 
> Best Regards,
> Jaehoon Chung
> 
> On 08/19/2014 12:02 PM, Chuanxiao Dong wrote:
> > Right now enable 1.2v IO voltage for SDHC is by using vqmmc.
> > Thus for the host which doesn't have vqmmc, or its vqmmc does not
> > support 1.2v, directly use MMC_CAP2_HS200 may cause HS200 failure.
> >
> > So needs to check if vqmmc is able to support 1.2v. If it does not
> > support, disable 1.2v IO for HS200.
> >
> > Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> > ---
> > Changelog V2: rebase this patch, and use IS_ERR to check vqmmc.
> >
> >  drivers/mmc/host/sdhci.c |    7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> > 4cc2ff9..a23738c 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -3009,8 +3009,13 @@ int sdhci_add_host(struct sdhci_host *host)
> >  		/* SD3.0: SDR104 is supported so (for eMMC) the caps2
> >  		 * field can be promoted to support HS200.
> >  		 */
> > -		if (!(host->quirks2 & SDHCI_QUIRK2_BROKEN_HS200))
> > +		if (!(host->quirks2 & SDHCI_QUIRK2_BROKEN_HS200)) {
> >  			mmc->caps2 |= MMC_CAP2_HS200;
> > +			if (IS_ERR(mmc->supply.vqmmc) ||
> > +					!regulator_is_supported_voltage
> > +					(mmc->supply.vqmmc, 1100000, 1300000))
> > +				mmc->caps2 &= ~MMC_CAP2_HS200_1_2V_SDR;
> > +		}
> >  	} else if (caps[1] & SDHCI_SUPPORT_SDR50)
> >  		mmc->caps |= MMC_CAP_UHS_SDR50;
> >
> >

