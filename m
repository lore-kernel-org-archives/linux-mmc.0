From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 4/4] mmc: davinci: suppress waring when using DT
Date: Mon, 14 Mar 2016 19:11:18 +0530
Message-ID: <56E6BF7E.7020401@ti.com>
References: <1457567405-30475-1-git-send-email-david@lechnology.com>
 <1457567405-30475-5-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43275 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932432AbcCNNmf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Mar 2016 09:42:35 -0400
In-Reply-To: <1457567405-30475-5-git-send-email-david@lechnology.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Lechner <david@lechnology.com>, ulf.hansson@linaro.org, k.kozlowski.k@gmail.com, linux-mmc@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On Thursday 10 March 2016 05:20 AM, David Lechner wrote:
> When using device tree dms resources are not obtained via IORESOURCE_DMA.
> As a result, we would get warning even though DMA was working.
> 
> This fixes the problem by checking for dev.of_node and skipping trying to
> get the dma platform resource if we are using device tree.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Actually, with Peter's series adding dma_slave_map[] for all
mach-davinci platforms, this code should not be needed at all. Can you
try that dropping the platform_get_resource() calls for DMA works with
linux-next?

Thanks,
Sekhar
