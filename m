From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/2] mmc: sdhci-pltfm: add calling mmc_of_parse in sdhci_pltfm_register
Date: Fri, 08 Mar 2013 20:30:32 -0500
Message-ID: <87li9xz7ev.fsf@octavius.laptop.org>
References: <1362755263-6832-1-git-send-email-kliu5@marvell.com>
	<513A475A.7040803@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44617 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759941Ab3CIBbD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Mar 2013 20:31:03 -0500
In-Reply-To: <513A475A.7040803@wwwdotorg.org> (Stephen Warren's message of
	"Fri, 08 Mar 2013 13:17:30 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>

Hi,

On Fri, Mar 08 2013, Stephen Warren wrote:
> On 03/08/2013 08:07 AM, Kevin Liu wrote:
>> commit 6c56e7a0 provide a function mmc_of_parse for standard MMC
>> device-tree binding parser centrally. So just call it with
>> sdhci_get_of_property together in sdhci_pltfm_register.
>
>> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
>
>> @@ -212,6 +213,7 @@ int sdhci_pltfm_register(struct platform_device *pdev,
>>  	if (IS_ERR(host))
>>  		return PTR_ERR(host);
>>  
>> +	mmc_of_parse(host->mmc);
>
> A few drivers already call mmc_of_parse() themselves. This change will
> make that call happen twice. Mostly this won't be an issue, but there
> are a couple gpio_request() calls in there, the error-handling for which
> in mmc_of_parse() will spew error messages if attempted twice.

Thanks for noticing that.  We'll have to remove those mmc_of_parse()
calls at the same time, if we want to do this.

> have a patch in the Tegra tree that adds a call to mmc_of_parse() into
> the Tegra driver, and that relies on fixing some bugs in the device
> tree; the CD GPIO polarity was previously specified incorrectly in the DT...
>
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
> Chris, do you want to do this?

Sure, that sounds fine.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
