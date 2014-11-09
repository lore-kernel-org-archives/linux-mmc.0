From: lautriv <lautriv@coldplug.net>
Subject: Re: [PATCH] mmc: wmt-sdmmc: fix unmatched release_mem_region
Date: Sun, 09 Nov 2014 23:18:09 +0100
Message-ID: <545FE821.5060107@coldplug.net>
References: <1415567571-6144-1-git-send-email-alchark@gmail.com> <CAOMZO5C+O4h=f=vtLTdBZktnfVWzfeLjOQG-oecxh_c9u-QMqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from coldplug.net ([109.75.184.172]:41862 "EHLO
	external.coldplug.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbaKIWZe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Nov 2014 17:25:34 -0500
Received: from localhost (localhost [127.0.0.1])
	by external.coldplug.net (Postfix) with ESMTP id 6A54B3A546
	for <linux-mmc@vger.kernel.org>; Sun,  9 Nov 2014 23:17:53 +0100 (CET)
Received: from external.coldplug.net ([127.0.0.1])
	by localhost (external.coldplug.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zMvJD3zvrhyp for <linux-mmc@vger.kernel.org>;
	Sun,  9 Nov 2014 23:17:53 +0100 (CET)
In-Reply-To: <CAOMZO5C+O4h=f=vtLTdBZktnfVWzfeLjOQG-oecxh_c9u-QMqA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, Alexey Charkov <alchark@gmail.com>
Cc: Tony Prisk <linux@prisktech.co.nz>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On 11/09/2014 10:55 PM, Fabio Estevam wrote:
> On Sun, Nov 9, 2014 at 7:12 PM, Alexey Charkov <alchark@gmail.com> wrote:
>
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       if (!res) {
>> +               ret = -ENODEV;
>> +               goto fail1;
> You could save this NULL check...
>
>> +       }
>>          mmc = mmc_alloc_host(sizeof(struct wmt_mci_priv), &pdev->dev);
>>          if (!mmc) {
>>                  dev_err(&pdev->dev, "Failed to allocate mmc_host\n");
>> @@ -813,7 +819,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
>>          if (of_get_property(np, "cd-inverted", NULL))
>>                  priv->cd_inverted = 1;
>>
>> -       priv->sdmmc_base = of_iomap(np, 0);
> If you move ' res = platform_get_resource' right here as
> devm_ioremap_resource() already does the NULL check.
>
>> +       priv->sdmmc_base = devm_ioremap_resource(&pdev->dev, res);
>>          if (!priv->sdmmc_base) {
>>                  dev_err(&pdev->dev, "Failed to map IO space\n");
>>                  ret = -ENOMEM;
This was the original intention but it would fall between the failX 
jumps, i discussed that with Alexey and we decided to change it with the 
cleanup to hold this patch small.
