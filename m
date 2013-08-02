From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc-socfpga: Staticize dw_mci_socfpga_probe()
Date: Fri, 02 Aug 2013 09:11:19 +0900
Message-ID: <000b01ce8f14$d08d4480$71a7cd80$@samsung.com>
References: <004d01ce8e80$91d50d20$b57f2760$@samsung.com>
 <1375373935.26434.1.camel@linux-builds1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:10133 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab3HBAL1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Aug 2013 20:11:27 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQV00L9AN6WOFA0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 02 Aug 2013 09:11:20 +0900 (KST)
In-reply-to: <1375373935.26434.1.camel@linux-builds1>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Dinh Nguyen' <dinguyen@altera.com>
Cc: 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org, 'Seungwon Jeon' <tgih.jun@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>, Jingoo Han <jg1.han@samsung.com>

On Friday, August 02, 2013 1:19 AM, Dinh Nguyen wrote:
> On Thu, 2013-08-01 at 15:30 +0900, Jingoo Han wrote:
> > dw_mci_socfpga_probe() is used only in this file.
> > Fix the following sparse warning:
> >
> > drivers/mmc/host/dw_mmc-socfpga.c:116:5: warning: symbol 'dw_mci_socfpga_probe' was not declared.
> Should it be static?
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  drivers/mmc/host/dw_mmc-socfpga.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc-socfpga.c b/drivers/mmc/host/dw_mmc-socfpga.c
> > index 14b5961..35aebb8 100644
> > --- a/drivers/mmc/host/dw_mmc-socfpga.c
> > +++ b/drivers/mmc/host/dw_mmc-socfpga.c
> > @@ -113,7 +113,7 @@ static const struct of_device_id dw_mci_socfpga_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, dw_mci_socfpga_match);
> >
> > -int dw_mci_socfpga_probe(struct platform_device *pdev)
> > +static int dw_mci_socfpga_probe(struct platform_device *pdev)
> >  {
> >  	const struct dw_mci_drv_data *drv_data;
> >  	const struct of_device_id *match;
> 
> This looks good but do you care to fix the other sparse warnings for
> dw_mmc-pltfm.c too?

+CC Dan Carpenter,

I will not care fix the other sparse warnings for dw_mmc-pltfm.c.

> 
> drivers/mmc/host/dw_mmc-pltfm.c:58:24: warning: incorrect type in
> argument 1 (different address spaces)
> drivers/mmc/host/dw_mmc-pltfm.c:58:24:    expected void const *ptr
> drivers/mmc/host/dw_mmc-pltfm.c:58:24:    got void [noderef]
> <asn:2>*regs
> drivers/mmc/host/dw_mmc-pltfm.c:59:36: warning: incorrect type in
> argument 1 (different address spaces)
> drivers/mmc/host/dw_mmc-pltfm.c:59:36:    expected void const *ptr
> drivers/mmc/host/dw_mmc-pltfm.c:59:36:    got void [noderef]
> <asn:2>*regs

You mean the following.

58 if (IS_ERR(host->regs))
59                return PTR_ERR(host->regs);

>From v3.11-rc1, it does not make sparse warnings,
because of the commit e7152b9 "err.h: IS_ERR() can accept __user pointers"
submitted by Dan Carpenter.


> drivers/mmc/host/dw_mmc-pltfm.c:36:5: warning: symbol
> 'dw_mci_pltfm_register' was not declared. Should it be static?
> drivers/mmc/host/dw_mmc-pltfm.c:94:1: warning: symbol
> 'dw_mci_pltfm_pmops' was not declared. Should it be static?

'dw_mci_pltfm_register' and 'dw_mci_pltfm_pmops' are exported as below:

70: EXPORT_SYMBOL_GPL(dw_mci_pltfm_register);
95: EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);

So, I am not sure whether these can be static or not. :(
Dan, if you know how to handle this, please let me know.


Best regards,
Jingoo Han

