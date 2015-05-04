From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 0/3] Add SDHCI support for APM X-Gene SoC using ARASAN SDHCI controller.
Date: Mon, 04 May 2015 17:27:11 +0200
Message-ID: <8897362.mqzfqi11lX@wuerfel>
References: <1430746792-32574-1-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:62700 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbbEDP1h (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 May 2015 11:27:37 -0400
In-Reply-To: <1430746792-32574-1-git-send-email-stripathi@apm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Suman Tripathi <stripathi@apm.com>, chris@printf.net, anton@enomsg.org, michal.simek@xilinx.com, devicetree@vger.kernel.org, mlangsdo@redhat.com, jcm@redhat.com, linux-mmc@vger.kernel.org, patches@apm.com, ddutile@redhat.com, linux-arm-kernel@lists.infradead.org

On Monday 04 May 2015 19:09:49 Suman Tripathi wrote:
> This patch adds the SDHCI support for APM X-Gene SoC using ARASAN SDHCI controller.
> 
> v1 change:
>  * Use the CONFIG_ARM64_DMA_HAS_IOMMU for dma-mapping.
> 
> v2 change:
>  * Drop the IOMMU support and switching to PIO mode for arasan.
>    controller integrated inside APM X-Gene SoC.
> 
> v3 change:
>  * Change the sdhci-of-arasan.c to support arasan4.9a.
>  * Add quirks for arasan4.9a.
> 
> v4 change:
>  * Cleanup the Documentation and dts.
> 

All three patches

Acked-by: Arnd Bergmann <arnd@arndb.de>
