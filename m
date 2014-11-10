From: lautriv <lautriv@coldplug.net>
Subject: Re: [PATCH] mmc: wmt-sdmmc: fix unmatched release_mem_region
Date: Mon, 10 Nov 2014 21:17:03 +0100
Message-ID: <54611D3F.2010903@coldplug.net>
References: <1415567571-6144-1-git-send-email-alchark@gmail.com>	<CAOMZO5C+O4h=f=vtLTdBZktnfVWzfeLjOQG-oecxh_c9u-QMqA@mail.gmail.com>	<545FE821.5060107@coldplug.net> <CABjd4YxyUJi6RaGWicFeoJ7C27qhUFsAbq-nJTreACrt-voeYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080106070506070707090806"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from coldplug.net ([109.75.184.172]:42451 "EHLO
	external.coldplug.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbaKJUQw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Nov 2014 15:16:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by external.coldplug.net (Postfix) with ESMTP id F02113A547
	for <linux-mmc@vger.kernel.org>; Mon, 10 Nov 2014 21:16:47 +0100 (CET)
Received: from external.coldplug.net ([127.0.0.1])
	by localhost (external.coldplug.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lkPg4HJRXzZn for <linux-mmc@vger.kernel.org>;
	Mon, 10 Nov 2014 21:16:47 +0100 (CET)
In-Reply-To: <CABjd4YxyUJi6RaGWicFeoJ7C27qhUFsAbq-nJTreACrt-voeYA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexey Charkov <alchark@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, Tony Prisk <linux@prisktech.co.nz>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------080106070506070707090806
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/2014 06:15 AM, Alexey Charkov wrote:
> 2014-11-10 1:18 GMT+03:00 lautriv <lautriv@coldplug.net>:
>> On 11/09/2014 10:55 PM, Fabio Estevam wrote:
>>> On Sun, Nov 9, 2014 at 7:12 PM, Alexey Charkov <alchark@gmail.com> wrote:
>>>
>>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> +       if (!res) {
>>>> +               ret = -ENODEV;
>>>> +               goto fail1;
>>> You could save this NULL check...
>>>
>>>> +       }
>>>>           mmc = mmc_alloc_host(sizeof(struct wmt_mci_priv), &pdev->dev);
>>>>           if (!mmc) {
>>>>                   dev_err(&pdev->dev, "Failed to allocate mmc_host\n");
>>>> @@ -813,7 +819,7 @@ static int wmt_mci_probe(struct platform_device
>>>> *pdev)
>>>>           if (of_get_property(np, "cd-inverted", NULL))
>>>>                   priv->cd_inverted = 1;
>>>>
>>>> -       priv->sdmmc_base = of_iomap(np, 0);
>>> If you move ' res = platform_get_resource' right here as
>>> devm_ioremap_resource() already does the NULL check.
>>>
>>>> +       priv->sdmmc_base = devm_ioremap_resource(&pdev->dev, res);
>>>>           if (!priv->sdmmc_base) {
>>>>                   dev_err(&pdev->dev, "Failed to map IO space\n");
>>>>                   ret = -ENOMEM;
>> This was the original intention but it would fall between the failX jumps, i
>> discussed that with Alexey and we decided to change it with the cleanup to
>> hold this patch small.
> I think Fabio means something slightly different than what we
> discussed. We haven't realized that the first thing
> devm_ioremap_resource does is exactly that (!res) check, so we can
> skip ours altogether.
>
> Looking at the function code a bit closer, we should also make the
> check look like "if (IS_ERR(priv->sdmmc_base)", kill the dev_err call
> (as it's also done internally), and then just do "ret =
> PTR_ERR(priv->sdmmc_base)" and jump to the label.
>
> Thanks a lot,
> Alexey
>
Sorry for the delay, 8880's are used to crash a lot since
we have not enought information ;)
Attached a changed patch which will hopefully meet all needs.


--------------080106070506070707090806
Content-Type: text/x-patch;
 name="0001-mmc-vt8500-change-resource-mapping-to-devm_.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-mmc-vt8500-change-resource-mapping-to-devm_.patch"

>From 7c8ebb55fde8786cd16d95659ff73675bedc287c Mon Sep 17 00:00:00 2001
From: Helmut Stengele <lautriv@coldplug.net>
Date: Mon, 10 Nov 2014 11:26:51 +0100
Subject: [PATCH] mmc: vt8500: change resource-mapping to devm_*

Current code calls release_mem_region upon module unload
without requesting the region first. This patch fixes it
by moving to a devres-based ioremap implementation, which
handles requesting and releasing memory region internally.

This also makes the error/unload paths a bit simpler.

Signed-off-by: Helmut Stengele <lautriv@coldplug.net>
---
 drivers/mmc/host/wmt-sdmmc.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 54181b4..f874d36 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -759,6 +759,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
 	const struct wmt_mci_caps *wmt_caps;
 	int ret;
 	int regular_irq, dma_irq;
+	struct resource *res;
 
 	if (!of_id || !of_id->data) {
 		dev_err(&pdev->dev, "Controller capabilities data missing\n");
@@ -813,10 +814,11 @@ static int wmt_mci_probe(struct platform_device *pdev)
 	if (of_get_property(np, "cd-inverted", NULL))
 		priv->cd_inverted = 1;
 
-	priv->sdmmc_base = of_iomap(np, 0);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->sdmmc_base = devm_ioremap_resource(&pdev->dev, res);
 	if (!priv->sdmmc_base) {
 		dev_err(&pdev->dev, "Failed to map IO space\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(priv->sdmmc_base);
 		goto fail2;
 	}
 
@@ -826,7 +828,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
 	ret = request_irq(regular_irq, wmt_mci_regular_isr, 0, "sdmmc", priv);
 	if (ret) {
 		dev_err(&pdev->dev, "Register regular IRQ fail\n");
-		goto fail3;
+		goto fail2;
 	}
 
 	ret = request_irq(dma_irq, wmt_mci_dma_isr, 0, "sdmmc", priv);
@@ -869,8 +871,6 @@ fail5:
 	free_irq(dma_irq, priv);
 fail4:
 	free_irq(regular_irq, priv);
-fail3:
-	iounmap(priv->sdmmc_base);
 fail2:
 	mmc_free_host(mmc);
 fail1:
@@ -881,7 +881,6 @@ static int wmt_mci_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
 	struct wmt_mci_priv *priv;
-	struct resource *res;
 	u32 reg_tmp;
 
 	mmc = platform_get_drvdata(pdev);
@@ -904,14 +903,9 @@ static int wmt_mci_remove(struct platform_device *pdev)
 	free_irq(priv->irq_regular, priv);
 	free_irq(priv->irq_dma, priv);
 
-	iounmap(priv->sdmmc_base);
-
 	clk_disable_unprepare(priv->clk_sdmmc);
 	clk_put(priv->clk_sdmmc);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, resource_size(res));
-
 	mmc_free_host(mmc);
 
 	dev_info(&pdev->dev, "WMT MCI device removed\n");
-- 
1.7.10.4


--------------080106070506070707090806--
