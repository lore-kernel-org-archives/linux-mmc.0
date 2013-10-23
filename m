From: Peter Guo <peter.guo@bayhubtech.com>
Subject: RE: [PATCH v2] mmc:sdhci-pci: Add Support of O2Mirco/BayHubTech SD
 Host
Date: Wed, 23 Oct 2013 03:49:51 +0000
Message-ID: <ba51eef0193e40df9cf25b73af6890b6@BL2PR04MB083.namprd04.prod.outlook.com>
References: <97254cf7c23548fdbb3ebc10170af6a8@BL2PR04MB083.namprd04.prod.outlook.com>
 <20131016081532.GB3416@adam-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2lp0244.outbound.protection.outlook.com ([207.46.163.244]:31077
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754343Ab3JWDt4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Oct 2013 23:49:56 -0400
In-Reply-To: <20131016081532.GB3416@adam-laptop>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bill Pemberton <wfp5p@virginia.edu>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Samuel Guan <samuel.guan@bayhubtech.com>, Xiaoguang Yu <xiaoguang.yu@bayhubtech.com>, Shirley Her <shirley.her@bayhubtech.com>, Yuxiang Wan <yuxiang.wan@bayhubtech.com>, Adam Lee <adam.lee@canonical.com>

Hi Chris,

Do you have any comments on this patch?

Thanks,
Peter.Guo

-----Original Message-----
From: Adam Lee [mailto:adam.lee@canonical.com] 
Sent: Wednesday, October 16, 2013 4:16 PM
To: Peter Guo; Chris Ball
Cc: Adrian Hunter; Greg Kroah-Hartman; Bill Pemberton; Guennadi Liakhovetski; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Samuel Guan; Xiaoguang Yu; Shirley Her; Yuxiang Wan
Subject: Re: [PATCH v2] mmc:sdhci-pci: Add Support of O2Mirco/BayHubTech SD Host

On Wed, Oct 16, 2013 at 07:26:23AM +0000, Peter Guo wrote:
> Add O2Micro/BayHubTech SD Host DeviceId 8520 support and specified Init.
> Apply SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 for SD Host Controller.
> Apply SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC for SD Host Controller.
> 
> Signed-off-by: peter.guo <peter.guo@bayhubtech.com>
> ---
>  drivers/mmc/host/sdhci-pci.c |  208 
> ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 208 insertions(+)

I'm enabling "O2 Micro, Inc. Device [1217:8520]" on some laptops, it works after this patch applied.

Chris, please take a look? Thanks.

Tested-by: Adam Lee <adam.lee@canonical.com>

--
Adam Lee
