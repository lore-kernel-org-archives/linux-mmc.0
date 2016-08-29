From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1 1/1] mmc: sdhci-pci: Convert to use managed functions
 (part2)
Date: Mon, 29 Aug 2016 15:48:48 +0300
Message-ID: <f7369cc1-94ba-a34e-fad9-542f55fc2e4d@intel.com>
References: <1471521553-125728-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:44370 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756632AbcH2MxW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 29 Aug 2016 08:53:22 -0400
In-Reply-To: <1471521553-125728-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On 18/08/16 14:59, Andy Shevchenko wrote:
> The commit 52ac7acf412b ("mmc: sdhci-pci: Convert to use managed functions
> pcim_* and devm_*") converted ->probe() / ->remove() functions to use device
> managed resource API. Here is a follow up to cover sdhci_pci_probe_slot() and
> sdhci_pci_remove_slot().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

