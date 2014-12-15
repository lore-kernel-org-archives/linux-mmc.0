From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] mmc: host: arasan: Add addition of-arasan quirks and add IOMMU support.
Date: Mon, 15 Dec 2014 22:27:33 +0100
Message-ID: <3866536.C6OiUcuGCr@wuerfel>
References: <1418662867-9210-1-git-send-email-stripathi@apm.com> <1418662867-9210-2-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:50983 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbaLOV2O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Dec 2014 16:28:14 -0500
In-Reply-To: <1418662867-9210-2-git-send-email-stripathi@apm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Suman Tripathi <stripathi@apm.com>, chris@printf.net, anton@enomsg.org, devicetree@vger.kernel.org, jcm@redhat.com, linux-mmc@vger.kernel.org, patches@apm.com, ddutile@redhat.com, linux-arm-kernel@lists.infradead.org

On Monday 15 December 2014 22:31:06 Suman Tripathi wrote:
> @@ -162,6 +206,16 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>                 goto clk_dis_ahb;
>         }
> 
> +#if defined(CONFIG_IOMMU_SUPPORT)
> +       sdhci_arasan->domain = iommu_domain_alloc(&amba_bustype);
> +       if (!sdhci_arasan->domain) {
> +               dev_err(&pdev->dev, "Unable to allocate iommu domain\n");
> +               return PTR_ERR(sdhci_arasan->domain);
> +       }
> +
> +       iommu_attach_device(sdhci_arasan->domain, &pdev->dev);
> +#endif
> +
> 

Device drivers should never care about the implementation details
of the iommu. Please change the code to use the regular dma_map_*
interfaces that will work both with and without IOMMU.

	Arnd
