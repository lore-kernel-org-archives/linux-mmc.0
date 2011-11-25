From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH v2 3/4] mmc: sdhci-pxa: Add SDHCI driver for PXA16x
Date: Fri, 25 Nov 2011 10:53:04 -0800
Message-ID: <2E59C2F0-403B-4F61-971D-14C17FEDF96A@marvell.com>
References: <87r51fwxgt.fsf@laptop.org>
 <1321849609-3013-1-git-send-email-tanmay.upadhyay@einfochips.com>
 <CAMj5Bki3Ev8K63538-dNbyijUw1oNTLChADLd4=Ef-LeCkoacw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:42941 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752417Ab1KYSxP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 Nov 2011 13:53:15 -0500
In-Reply-To: <CAMj5Bki3Ev8K63538-dNbyijUw1oNTLChADLd4=Ef-LeCkoacw@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>, Zhangfei Gao <zgao6@marvell.com>, Jun Nie <njun@marvell.com>, Qiming Wu <wuqm@marvell.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On Nov 25, 2011, at 4:47 AM, zhangfei gao wrote:

> 
> 
> On Mon, Nov 21, 2011 at 12:26 PM, Tanmay Upadhyay <tanmay.upadhyay@einfochips.com> wrote:
> PXA16x devices uses SDHCI controller v1. As it's not much different
> than v2 controller, v1 driver is merged with sdhci-pxav2 driver
> 
> v2 - instead of having separate file sdhci-pxav1, merge code with
>     sdhci-pxav2 driver code as suggested by Chris Ball
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
> ---
> +/*
> + * we cannot talk to controller for 8 bus cycles according to sdio spec
> + * at lowest speed this is 100,000 HZ per cycle or 800,000 cycles
> + * which is quite a LONG TIME on a fast cpu -- so delay if needed
> + */
> 
> Would you mind provide more info, still not understand.
> What sdio spec 12.1 says cards shall switch speed mode within 8 clocks after the end bit of the corresponding response.
> 


The pxa168 h/w controller is broken.  It does NOT wait  for the 8 clocks.


> +static void platform_specific_completion(struct sdhci_host *host)
> +{
> +       struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
> +       struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
> +
> +       if (host->clock < 3200000 && pdata && pdata->delay_in_ms)
> +               mdelay(pdata->delay_in_ms);
> +}
> +
> 

