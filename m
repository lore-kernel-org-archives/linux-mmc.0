From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Subject: RE: [PATCH 04/22] mmc: bfin_sdh: remove unnecessary
 platform_set_drvdata()
Date: Mon, 6 May 2013 06:21:04 +0000
Message-ID: <B168F8A49F4BCF4C84FD23DA5F6363EE97B4@NWD2MBX7.ad.analog.com>
References: <004f01ce4a20$9c599ad0$d50cd070$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:9205 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752387Ab3EFGWH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 May 2013 02:22:07 -0400
In-Reply-To: <004f01ce4a20$9c599ad0$d50cd070$@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>, 'Chris Ball' <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Acked-by: Sonic Zhang <sonic.zhang@analog.com>

>-----Original Message-----
>From: Jingoo Han [mailto:jg1.han@samsung.com]
>Sent: Monday, May 06, 2013 2:12 PM
>To: 'Chris Ball'
>Cc: linux-mmc@vger.kernel.org; Jingoo Han; Zhang, Sonic
>Subject: [PATCH 04/22] mmc: bfin_sdh: remove unnecessary
>platform_set_drvdata()
>
>The driver core clears the driver data to NULL after device_release or on probe
>failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
>(device-core: Ensure drvdata = NULL when no driver is bound).
>Thus, it is not needed to manually clear the device driver data to NULL.
>
>Signed-off-by: Jingoo Han <jg1.han@samsung.com>
>---
> drivers/mmc/host/bfin_sdh.c |    2 --
> 1 files changed, 0 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c index
>fb4348c..94fae2f 100644
>--- a/drivers/mmc/host/bfin_sdh.c
>+++ b/drivers/mmc/host/bfin_sdh.c
>@@ -621,8 +621,6 @@ static int sdh_remove(struct platform_device *pdev)  {
>       struct mmc_host *mmc = platform_get_drvdata(pdev);
>
>-      platform_set_drvdata(pdev, NULL);
>-
>       if (mmc) {
>               struct sdh_host *host = mmc_priv(mmc);
>
>--
>1.7.2.5
>
>


