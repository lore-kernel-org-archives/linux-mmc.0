From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc-socfpga: Staticize dw_mci_socfpga_probe()
Date: Tue, 06 Aug 2013 10:30:29 +0900
Message-ID: <000901ce9244$88e73bd0$9ab5b370$@samsung.com>
References: <004d01ce8e80$91d50d20$b57f2760$@samsung.com>
 <1375373935.26434.1.camel@linux-builds1>
 <000b01ce8f14$d08d4480$71a7cd80$@samsung.com> <20130802083400.GD5102@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:47945 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab3HFBab (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Aug 2013 21:30:31 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR3007HY5ICAJ00@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 06 Aug 2013 10:30:29 +0900 (KST)
In-reply-to: <20130802083400.GD5102@mwanda>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Dan Carpenter' <dan.carpenter@oracle.com>
Cc: 'Dinh Nguyen' <dinguyen@altera.com>, 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org, 'Seungwon Jeon' <tgih.jun@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, Jingoo Han <jg1.han@samsung.com>

On Friday, August 02, 2013 5:34 PM, Dan Carpenter wrote:
> On Fri, Aug 02, 2013 at 09:11:19AM +0900, Jingoo Han wrote:
> > On Friday, August 02, 2013 1:19 AM, Dinh Nguyen wrote:

[...]

> > > drivers/mmc/host/dw_mmc-pltfm.c:36:5: warning: symbol
> > > 'dw_mci_pltfm_register' was not declared. Should it be static?
> > > drivers/mmc/host/dw_mmc-pltfm.c:94:1: warning: symbol
> > > 'dw_mci_pltfm_pmops' was not declared. Should it be static?
> >
> > 'dw_mci_pltfm_register' and 'dw_mci_pltfm_pmops' are exported as below:
> >
> > 70: EXPORT_SYMBOL_GPL(dw_mci_pltfm_register);
> > 95: EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
> >
> > So, I am not sure whether these can be static or not. :(
> > Dan, if you know how to handle this, please let me know.
> 
> No, don't make these static.  The way to silence this warning is to
> include "dw_mmc-pltfm.h".

I really appreciate your answer. :)
Then, I will send the patch to include "dw_mmc-pltfm.h".

Best regards,
Jingoo Han

