From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/2] mmc: sdhci: Add support for setting parent clock
Date: Mon, 20 Mar 2017 21:22:51 +0200
Message-ID: <693f9e04-b2b0-4d11-1359-0364961687e9@intel.com>
References: <1489660364-17698-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:30248 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755341AbdCTTaR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 15:30:17 -0400
In-Reply-To: <1489660364-17698-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Ritesh Harjani <riteshh@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/16/2017 12:32 PM, Jon Hunter wrote:
> It is common for SD/MMC host controllers to set the parent clock that
> drives the SD/MMC interface in order to support various operating
> speeds. Typically, this is performed by calling common clock framework
> APIs such as clk_set_rate(). The problem is that these APIs may sleep
> and must not be called from within atomic sections and therefore, these
> functions cannot be called within the existing 'set_clock' SDHCI
> operator because they are called from within the context of a spinlock.
> Add a new 'set_parent_clock' operator for the SDHCI driver that is
> called early during the SDHCI 'set_ios' before the spinlock is aquire to
> give the platform driver the opportunity to set the parent clock rate.

I just posted a patch to remove the spin lock from set_ios().  Does that help?

