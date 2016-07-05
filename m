From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH RFC 2/5] mmc: sdhci: Split sdhci_add_host()
Date: Tue, 5 Jul 2016 10:02:57 +0100
Message-ID: <577B77C1.10609@nvidia.com>
References: <1467120192-6479-1-git-send-email-adrian.hunter@intel.com>
 <1467120192-6479-3-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17092 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbcGEJDE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jul 2016 05:03:04 -0400
In-Reply-To: <1467120192-6479-3-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Dong Aisheng <dongas86@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>


On 28/06/16 14:23, Adrian Hunter wrote:
> Split sdhci-add_host() in order to further our objective to make
> sdhci into a library.

s/sdhci-add_host/sdhci_add_host

> The split divides code that sets up mmc and sdhci parameters, from
> code that actually activates things - such as tasklet initialization,
> requesting the irq, and adding (and starting) the host.
> 
> This gives drivers an opportunity to change various settings before
> committing to start the host.
> 
> Drivers can continue to call sdhci_add_host() but drivers that want
> to take advantage of the split instead call sdhci_setup_host() followed
> by __sdhci_add_host().

If sdhci_setup_host() is successful, but then the subsequent call to
__sdhci_add_host() fails, then what should be called to clean-up? Does
not look like we can still call sdhci_remove_host() in this case.

Cheers
Jon

-- 
nvpublic
