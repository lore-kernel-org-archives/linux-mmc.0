From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 1/2] mmc: sdhci-pltfm: add calling mmc_of_parse in
 sdhci_pltfm_register
Date: Mon, 11 Mar 2013 09:53:00 -0600
Message-ID: <513DFDDC.8050908@wwwdotorg.org>
References: <1362755263-6832-1-git-send-email-kliu5@marvell.com> <513A475A.7040803@wwwdotorg.org> <CADz5_g+inqmv7zih2fmOy+o9_EANB1wuDZGScqA9AzvHDMj=7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:46532 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab3CKPxH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Mar 2013 11:53:07 -0400
In-Reply-To: <CADz5_g+inqmv7zih2fmOy+o9_EANB1wuDZGScqA9AzvHDMj=7A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>

n 03/08/2013 09:24 PM, Kevin Liu wrote:
> 2013/3/9 Stephen Warren <swarren@wwwdotorg.org>:
>> On 03/08/2013 08:07 AM, Kevin Liu wrote:
>>> commit 6c56e7a0 provide a function mmc_of_parse for standard MMC
>>> device-tree binding parser centrally. So just call it with
>>> sdhci_get_of_property together in sdhci_pltfm_register.
>>
>>> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
>>
>>> @@ -212,6 +213,7 @@ int sdhci_pltfm_register(struct platform_device *pdev,
>>>       if (IS_ERR(host))
>>>               return PTR_ERR(host);
>>>
>>> +     mmc_of_parse(host->mmc);
>>
>> A few drivers already call mmc_of_parse() themselves. This change will
>> make that call happen twice. Mostly this won't be an issue, but there
>> are a couple gpio_request() calls in there, the error-handling for which
>> in mmc_of_parse() will spew error messages if attempted twice. I also
>> have a patch in the Tegra tree that adds a call to mmc_of_parse() into
>> the Tegra driver, and that relies on fixing some bugs in the device
>> tree; the CD GPIO polarity was previously specified incorrectly in the DT...
>>
> 
> Stephen,
> 
> I don't think so. I add calling mmc_of_parse in sdhci_pltfm_register
> rather than sdhci_pltfm_init.

Ah yes, you're right. So, there's no issue.

Chris, I do think I'll still send you a pull request to move the Tegra
SDHCI change that's currently in the Tegra tree into the MMC tree, just
in case there do turn out to be any MMC core cleanup/... issues this
kernel cycle. Best to be safe! I suspect that Tegra might be able to be
converted to using sdhci_pltfm_register() rather than sdhci_pltfm_init()
after Kevin's change, but I'll have to investigate more to be certain.
