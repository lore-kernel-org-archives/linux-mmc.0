From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] mmc: sdhci: add support for pre_req and post_req
Date: Tue, 26 Apr 2011 19:59:19 -0500
Message-ID: <BANLkTik2L8b8L5qngtd+fwAa+GJbXYQXWg@mail.gmail.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<1302972516-8673-1-git-send-email-shawn.guo@linaro.org>
	<BANLkTi=pqGyijbfuHD=uQzPnaYvNOQyzdg@mail.gmail.com>
	<4DB16019.8000800@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og105.obsmtp.com ([64.18.0.180]:32921 "EHLO
	exprod5og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab1D0A7W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2011 20:59:22 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3R0xjnL002040
	for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 20:59:45 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3R0u4hq001022
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 20:59:45 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so1252672wwb.3
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 17:59:19 -0700 (PDT)
In-Reply-To: <4DB16019.8000800@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, cjb@laptop.org, per.forlin@linaro.org, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On Fri, Apr 22, 2011 at 6:01 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Andrei..
>
> Did you test this patch with ADMA?
> I wonder that be increased performance or others..

FWIW...

ADMA

With changes

adb shell "echo 0 > /sys/module/sdhci/parameters/no_prepost"
time adb shell "iozone -a -f /cache/file -g 4m > /mnt/obb/with"

real	0m37.245s
user	0m0.010s
sys	0m0.000s

Without changes

adb shell "echo 1 > /sys/module/sdhci/parameters/no_prepost"
time adb shell "iozone -a -f /cache/file -g 4m > /mnt/obb/without"

real	0m38.400s
user	0m0.000s
sys	0m0.010s

SDMA plus BOUNCE_BUFFER

With changes

adb shell "echo 0 > /sys/module/sdhci/parameters/no_prepost"
time adb shell "iozone -a -f /cache/file -g 4m > /mnt/obb/with"

real	0m37.999s
user	0m0.000s
sys	0m0.010s

Without changes

adb shell "echo 1 > /sys/module/sdhci/parameters/no_prepost"
time adb shell "iozone -a -f /cache/file -g 4m > /mnt/obb/without"

real	0m39.717s
user	0m0.000s
sys	0m0.010s

Collected data using this patch on top of Shawn's...

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3320c75..f698586 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -39,6 +39,7 @@
 #endif

 static unsigned int debug_quirks = 0;
+static unsigned int no_prepost = 0;

 static void sdhci_prepare_data(struct sdhci_host *, struct mmc_data *);
 static void sdhci_finish_data(struct sdhci_host *);
@@ -1140,6 +1141,8 @@ static void sdhci_pre_req(struct mmc_host *mmc,
struct mmc_request *mrq,
                          bool is_first_req)
 {
        struct sdhci_host *host = mmc_priv(mmc);
+       if (no_prepost)
+               return;

        if (mrq->data->host_cookie) {
                mrq->data->host_cookie = 0;
@@ -1157,6 +1160,9 @@ static void sdhci_post_req(struct mmc_host *mmc,
struct mmc_request *mrq,
        struct sdhci_host *host = mmc_priv(mmc);
        struct mmc_data *data = mrq->data;

+       if (no_prepost)
+               return;
+
        if (host->flags & SDHCI_REQ_USE_DMA) {
                dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
                             (data->flags & MMC_DATA_WRITE) ?
@@ -2163,6 +2169,7 @@ module_init(sdhci_drv_init);
 module_exit(sdhci_drv_exit);

 module_param(debug_quirks, uint, 0444);
+module_param(no_prepost, uint, 0644);

 MODULE_AUTHOR("Pierre Ossman <pierre@ossman.eu>");
 MODULE_DESCRIPTION("Secure Digital Host Controller Interface core driver");


A
