From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: sdhci-esdhc-imx: could not set regulator OCR (-22)
Date: Tue, 06 Mar 2012 14:30:01 +0900
Message-ID: <4F55A0D9.4020408@samsung.com>
References: <CAOMZO5CYu82TkaNEMVMAVe82-Zu-T=hydi8GKS1_wgGNNWmkcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:25000 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab2CFFaF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Mar 2012 00:30:05 -0500
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0M0G00A1K79WZO00@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 06 Mar 2012 14:30:03 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0M0G00EBM7A2ULH0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 06 Mar 2012 14:30:03 +0900 (KST)
In-reply-to: <CAOMZO5CYu82TkaNEMVMAVe82-Zu-T=hydi8GKS1_wgGNNWmkcw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-mmc@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>

Hi.

It seems like my case.
http://www.spinics.net/lists/linux-mmc/msg12130.html

Thanks,
Jaehoon Chung

On 03/06/2012 04:10 AM, Fabio Estevam wrote:

> Hi,
> 
> On a mx51babbage board running linux-next I get:
> 
> sdhci: Secure Digital Host Controller Interface driver
> sdhci: Copyright(c) Pierre Ossman
> sdhci-pltfm: SDHCI platform and OF driver helper
> sdhci-esdhc-imx51.0 supply vmmc not found, using dummy regulator
> mmc0: SDHCI controller on sdhci-esdhc-imx51.0 [sdhci-esdhc-imx51.0] using DMA
> mmc0: mmc_rescan_try_freq: trying to init card at 400000 Hz
> sdhci-esdhc-imx sdhci-esdhc-imx51.0: could not set regulator OCR (-22)
> sdhci-esdhc-imx51.1 supply vmmc not found, using dummy regulator
> 
> Before I start investigating I would like to check whether these
> regulator message errors have been fixed by some recent patches?
> 
> Thanks,
> 
> Fabio Estevam
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


