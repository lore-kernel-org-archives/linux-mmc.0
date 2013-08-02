From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc-socfpga: Staticize dw_mci_socfpga_probe()
Date: Fri, 2 Aug 2013 11:34:00 +0300
Message-ID: <20130802083400.GD5102@mwanda>
References: <004d01ce8e80$91d50d20$b57f2760$@samsung.com>
 <1375373935.26434.1.camel@linux-builds1>
 <000b01ce8f14$d08d4480$71a7cd80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:31484 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872Ab3HBIeT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Aug 2013 04:34:19 -0400
Content-Disposition: inline
In-Reply-To: <000b01ce8f14$d08d4480$71a7cd80$@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Dinh Nguyen' <dinguyen@altera.com>, 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org, 'Seungwon Jeon' <tgih.jun@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>

On Fri, Aug 02, 2013 at 09:11:19AM +0900, Jingoo Han wrote:
> On Friday, August 02, 2013 1:19 AM, Dinh Nguyen wrote:
> > drivers/mmc/host/dw_mmc-pltfm.c:58:24: warning: incorrect type in
> > argument 1 (different address spaces)
> > drivers/mmc/host/dw_mmc-pltfm.c:58:24:    expected void const *ptr
> > drivers/mmc/host/dw_mmc-pltfm.c:58:24:    got void [noderef]
> > <asn:2>*regs
> > drivers/mmc/host/dw_mmc-pltfm.c:59:36: warning: incorrect type in
> > argument 1 (different address spaces)
> > drivers/mmc/host/dw_mmc-pltfm.c:59:36:    expected void const *ptr
> > drivers/mmc/host/dw_mmc-pltfm.c:59:36:    got void [noderef]
> > <asn:2>*regs
> 
> You mean the following.
> 
> 58 if (IS_ERR(host->regs))
> 59                return PTR_ERR(host->regs);
> 
> >From v3.11-rc1, it does not make sparse warnings,
> because of the commit e7152b9 "err.h: IS_ERR() can accept __user pointers"
> submitted by Dan Carpenter.

You have to upgrade to a later version of Sparse as well.

> 
> 
> > drivers/mmc/host/dw_mmc-pltfm.c:36:5: warning: symbol
> > 'dw_mci_pltfm_register' was not declared. Should it be static?
> > drivers/mmc/host/dw_mmc-pltfm.c:94:1: warning: symbol
> > 'dw_mci_pltfm_pmops' was not declared. Should it be static?
> 
> 'dw_mci_pltfm_register' and 'dw_mci_pltfm_pmops' are exported as below:
> 
> 70: EXPORT_SYMBOL_GPL(dw_mci_pltfm_register);
> 95: EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
> 
> So, I am not sure whether these can be static or not. :(
> Dan, if you know how to handle this, please let me know.

No, don't make these static.  The way to silence this warning is to
include "dw_mmc-pltfm.h".

regards,
dan carpenter

