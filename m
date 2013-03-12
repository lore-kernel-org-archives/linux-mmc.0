From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pltfm: add calling mmc_of_parse in sdhci_pltfm_register
Date: Tue, 12 Mar 2013 10:03:19 +0800
Message-ID: <CADz5_g+u6wkvTgto1WOz+oo7jSdTqTJWrWqZ0sk5W1=Cq2ok2w@mail.gmail.com>
References: <1362718371-5074-1-git-send-email-kliu5@marvell.com>
	<513A479C.9010709@wwwdotorg.org>
	<CADz5_gJXb85MPcrXer-13rJB7VYG=fuf28NpPVBif9tHUmAG-g@mail.gmail.com>
	<513DFDF8.5090604@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:40864 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549Ab3CLCDU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Mar 2013 22:03:20 -0400
Received: by mail-ob0-f170.google.com with SMTP id wc20so4080083obb.29
        for <linux-mmc@vger.kernel.org>; Mon, 11 Mar 2013 19:03:20 -0700 (PDT)
In-Reply-To: <513DFDF8.5090604@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>

2013/3/11 Stephen Warren <swarren@wwwdotorg.org>:
> On 03/08/2013 09:27 PM, Kevin Liu wrote:
>> 2013/3/9 Stephen Warren <swarren@wwwdotorg.org>:
>>> On 03/07/2013 09:52 PM, Kevin Liu wrote:
>>>> commit 6c56e7a0 provide a function mmc_of_parse for standard MMC
>>>> device-tree binding parser centrally. So just call it with
>>>> sdhci_get_of_property together in sdhci_pltfm_register.
>>>
>>> BTW, this patch seems to do two unrelated things; firstly it changes the
>>> indentation level throughout sdhci_get_of_property(), and secondly makes
>>> the change described in the commit description.
>>
>> That's true. I originally want to do the first thing incidentally :-)
>> So do you want to split this patch into two?
>
> It's Chris's call, but I think it'd be more usual to make this two
> separate patches.

Thanks for review!
I have splited it into different patches as below:
[PATCH v3 1/4] mmc: sdhci-pltfm: add calling mmc_of_parse in
[PATCH 2/4] mmc: sdhci-pltfm: avoid indentation in

Kevin
