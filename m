From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: exynos: Revert the sdr_timing assignment
Date: Wed, 23 Oct 2013 20:27:39 +0900
Message-ID: <001801cecfe2$e191cb70$a4b56250$%jun@samsung.com>
References: <1382433116-22180-1-git-send-email-yuvaraj.cd@samsung.com>
 <52664F88.50605@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:9306 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262Ab3JWL1l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Oct 2013 07:27:41 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MV400E85D64XI70@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 23 Oct 2013 20:27:40 +0900 (KST)
In-reply-to: <52664F88.50605@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Yuvaraj Kumar C D' <yuvaraj.cd@gmail.com>, cjb@laptop.org, linux-mmc@vger.kernel.org, thomas.ab@samsung.com, grundler@chromium.org
Cc: dianders@chromium.org, sonnyrao@chromium.org, 'Yuvaraj Kumar C D' <yuvaraj.cd@samsung.com>

On Tue, October 22, 2013, Jaehoon Chung wrote:
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reported-by: Grant Grundler <grundler@chromium.org>

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon
> 
> On 10/22/2013 06:11 PM, Yuvaraj Kumar C D wrote:
> > commit 4ad602c9df1e3b04979c260b5612141b4b892257 was wrongly assigning
> > ddr_timing value to sdr_timing.This patch fix's this by reverting
> > the sdr_timing assignment statement to the earlier location.
> >
> > Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> > ---
> >  drivers/mmc/host/dw_mmc-exynos.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> > index d42e664..3423c5e 100644
> > --- a/drivers/mmc/host/dw_mmc-exynos.c
> > +++ b/drivers/mmc/host/dw_mmc-exynos.c
> > @@ -251,12 +251,13 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
> >  	if (ret)
> >  		return ret;
> >
> > +	priv->sdr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], div);
> > +
> >  	ret = of_property_read_u32_array(np,
> >  			"samsung,dw-mshc-ddr-timing", timing, 2);
> >  	if (ret)
> >  		return ret;
> >
> > -	priv->sdr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], div);
> >  	priv->ddr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], div);
> >  	host->priv = priv;
> >  	return 0;
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

