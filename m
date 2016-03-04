From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/3] mmc: sdhci-acpi: Remove enable_dma() hook
Date: Fri, 04 Mar 2016 16:57:44 +0100
Message-ID: <2588443.l6d6cBKpRe@wuerfel>
References: <1457087925-992-1-git-send-email-acourbot@nvidia.com> <1457087925-992-3-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:57751 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756332AbcCDP5z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2016 10:57:55 -0500
In-Reply-To: <1457087925-992-3-git-send-email-acourbot@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com

On Friday 04 March 2016 19:38:44 Alexandre Courbot wrote:
> This hook was solely used to set the DMA mask, which is now done
> by the newly-added sdhci_set_dma_mask() function.
> 
> The use of a flag to ensure the mask is only set once is a strong hint
> that it should not have been done there anyway.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
