From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] mmc: dw_mmc: fix pio mode when internal dmac is enabled
Date: Mon, 17 Aug 2015 12:37:03 +0200
Message-ID: <1624956.5P1fMUiods@phil>
References: <3018549.c8iX1Dbrhm@diego> <55D1B5A1.3050209@samsung.com> <CAPDyKFqdOZ4XmV+-wJbHV0uJepVetxkO5GLBkQ1Fm+mCkFM1ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:41623 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753271AbbHQKhN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Aug 2015 06:37:13 -0400
In-Reply-To: <CAPDyKFqdOZ4XmV+-wJbHV0uJepVetxkO5GLBkQ1Fm+mCkFM1ig@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Am Montag, 17. August 2015, 12:34:09 schrieb Ulf Hansson:
> [...]
> 
> >>> -               mmc->max_seg_size = mmc->max_req_size;
> >>> -#endif /* CONFIG_MMC_DW_IDMAC */
> >>> +               if (host->use_dma) {
> >>> +                       mmc->max_segs = host->ring_size;
> >> 
> >> I expect this may cause a compiler error since host->ring_size is only
> >> available in the struct dw_mci *host when CONFIG_MMC_DW_IDMAC is set.
> >> 
> >> I have already pulled in this patch from Jaehoon's pull request.
> >> Perhaps I should only amend the patch and change the host->ring_size
> >> to be always available no matter if CONFIG_MMC_DW_IDMAC is set or not?
> > 
> > Sorry for this. if you can, i think good that CONFIG_MMC_DW_IDMAC is
> > removed at struct dw_mci. Could you amend it?
> > If you want to get patch, i will send patch at now.
> 
> No worries, I amend the patch myself.

thanks and sorry for missing that bit.


Heiko
