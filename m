From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: sdhci-pltfm: add calling mmc_of_parse in sdhci_pltfm_register
Date: Sat, 9 Mar 2013 12:24:14 +0800
Message-ID: <CADz5_g+inqmv7zih2fmOy+o9_EANB1wuDZGScqA9AzvHDMj=7A@mail.gmail.com>
References: <1362755263-6832-1-git-send-email-kliu5@marvell.com>
	<513A475A.7040803@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:34702 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760295Ab3CIEYR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Mar 2013 23:24:17 -0500
Received: by mail-oa0-f48.google.com with SMTP id j1so2849624oag.35
        for <linux-mmc@vger.kernel.org>; Fri, 08 Mar 2013 20:24:14 -0800 (PST)
In-Reply-To: <513A475A.7040803@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>

2013/3/9 Stephen Warren <swarren@wwwdotorg.org>:
> On 03/08/2013 08:07 AM, Kevin Liu wrote:
>> commit 6c56e7a0 provide a function mmc_of_parse for standard MMC
>> device-tree binding parser centrally. So just call it with
>> sdhci_get_of_property together in sdhci_pltfm_register.
>
>> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
>
>> @@ -212,6 +213,7 @@ int sdhci_pltfm_register(struct platform_device *pdev,
>>       if (IS_ERR(host))
>>               return PTR_ERR(host);
>>
>> +     mmc_of_parse(host->mmc);
>
> A few drivers already call mmc_of_parse() themselves. This change will
> make that call happen twice. Mostly this won't be an issue, but there
> are a couple gpio_request() calls in there, the error-handling for which
> in mmc_of_parse() will spew error messages if attempted twice. I also
> have a patch in the Tegra tree that adds a call to mmc_of_parse() into
> the Tegra driver, and that relies on fixing some bugs in the device
> tree; the CD GPIO polarity was previously specified incorrectly in the DT...
>

Stephen,

I don't think so. I add calling mmc_of_parse in sdhci_pltfm_register
rather than sdhci_pltfm_init.

In latest code, only sh_mmcif.c and tmio_mmc_pio.c called mmc_of_parse
explicitly and they are not sdhci based driver and won't call any
sdhci-pltfm functions. So this change won't make that call
mmc_of_parse twice.

For the gpio related issue. That's true and that's why I call
mmc_of_parse in sdhci_pltfm_register rather than in sdhci_pltfm_init.
The sdhci based drivers which call sdhci_pltfm_register means want
sdhci_pltfm do everything for them which include sdhci_pltfm_init,
parse dt property and sdhci_add_host.
Meanwhile some other sdhci based drivers just call sdhci_pltfm_init
and then do some specific tasks such as gpio handling. If these
drivers call mmc_of_parse with their current code will lead to the
gpio issue you mentioned above.


> I guess to resolve this, what I could do is as follows:
>
> a) Create a topic branch in the Tegra tree that contains just the DT
> fixes that mmc_of_parse() relies on for Tegra.
>
> b) Have Chris merge that into the MMC tree.
>
> c) Then, it's safe to move the Tegra driver patch out of the Tegra tree
> into the MMC tree, so this issue can be addressed there. Equally, if the
> merge in (b) above happens before this current patch is applied, this
> current patch won't cause any breakage on Tegra.
>

But I'm afraid we still can't call mmc_of_parse directly in
sdhci_pltfm_init after this issue fixed.
1. some host drivers want to do specific gpio handling and use their
gpio irq handler.
2. some host drivers want to request gpio irq after sdhci_add_host
like sdhci-dove.c
So I think it's better to seperate gpio handling from mmc_of_parse.
How do you think?

> Chris, do you want to do this?
