From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] mmc: sdhci-pltfm: add calling mmc_of_parse in sdhci_pltfm_register
Date: Mon, 11 Mar 2013 09:53:28 -0600
Message-ID: <513DFDF8.5090604@wwwdotorg.org>
References: <1362718371-5074-1-git-send-email-kliu5@marvell.com> <513A479C.9010709@wwwdotorg.org> <CADz5_gJXb85MPcrXer-13rJB7VYG=fuf28NpPVBif9tHUmAG-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:33459 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423Ab3CKPxd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Mar 2013 11:53:33 -0400
In-Reply-To: <CADz5_gJXb85MPcrXer-13rJB7VYG=fuf28NpPVBif9tHUmAG-g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>

On 03/08/2013 09:27 PM, Kevin Liu wrote:
> 2013/3/9 Stephen Warren <swarren@wwwdotorg.org>:
>> On 03/07/2013 09:52 PM, Kevin Liu wrote:
>>> commit 6c56e7a0 provide a function mmc_of_parse for standard MMC
>>> device-tree binding parser centrally. So just call it with
>>> sdhci_get_of_property together in sdhci_pltfm_register.
>>
>> BTW, this patch seems to do two unrelated things; firstly it changes the
>> indentation level throughout sdhci_get_of_property(), and secondly makes
>> the change described in the commit description.
> 
> That's true. I originally want to do the first thing incidentally :-)
> So do you want to split this patch into two?

It's Chris's call, but I think it'd be more usual to make this two
separate patches.
