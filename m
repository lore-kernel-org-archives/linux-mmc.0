From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 04/22] mmc: bfin_sdh: remove unnecessary
 platform_set_drvdata()
Date: Mon, 06 May 2013 15:48:19 +0900
Message-ID: <007701ce4a25$b1f59470$15e0bd50$@samsung.com>
References: <004f01ce4a20$9c599ad0$d50cd070$@samsung.com>
 <B168F8A49F4BCF4C84FD23DA5F6363EE97B4@NWD2MBX7.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:18915 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081Ab3EFGsW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2013 02:48:22 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMD004WO6VDP6M0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 06 May 2013 15:48:20 +0900 (KST)
In-reply-to: <B168F8A49F4BCF4C84FD23DA5F6363EE97B4@NWD2MBX7.ad.analog.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "'Zhang, Sonic'" <Sonic.Zhang@analog.com>, 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

On Monday, May 06, 2013 3:21 PM, Zhang, Sonic wrote:
> 
> Acked-by: Sonic Zhang <sonic.zhang@analog.com>

Thank you for your Acked-by. :)

Best regards,
Jingoo Han

> 
> >-----Original Message-----
> >From: Jingoo Han [mailto:jg1.han@samsung.com]
> >Sent: Monday, May 06, 2013 2:12 PM
> >To: 'Chris Ball'
> >Cc: linux-mmc@vger.kernel.org; Jingoo Han; Zhang, Sonic
> >Subject: [PATCH 04/22] mmc: bfin_sdh: remove unnecessary
> >platform_set_drvdata()
> >
> >The driver core clears the driver data to NULL after device_release or on probe
> >failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> >(device-core: Ensure drvdata = NULL when no driver is bound).
> >Thus, it is not needed to manually clear the device driver data to NULL.
> >
> >Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> >---
> > drivers/mmc/host/bfin_sdh.c |    2 --
> > 1 files changed, 0 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c index
> >fb4348c..94fae2f 100644
> >--- a/drivers/mmc/host/bfin_sdh.c
> >+++ b/drivers/mmc/host/bfin_sdh.c
> >@@ -621,8 +621,6 @@ static int sdh_remove(struct platform_device *pdev)  {
> >       struct mmc_host *mmc = platform_get_drvdata(pdev);
> >
> >-      platform_set_drvdata(pdev, NULL);
> >-
> >       if (mmc) {
> >               struct sdh_host *host = mmc_priv(mmc);
> >
> >--
> >1.7.2.5
> >
> >


