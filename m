From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Use macros in pci_ids definition
Date: Tue, 30 May 2017 12:09:05 +0300
Message-ID: <d2c82289-8e85-3dba-7461-ebc90cb4a7b4@intel.com>
References: <1494884657-18268-1-git-send-email-matthiasmartinsson@gmail.com>
 <1494884657-18268-2-git-send-email-matthiasmartinsson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60413 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751552AbdE3JPG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 30 May 2017 05:15:06 -0400
In-Reply-To: <1494884657-18268-2-git-send-email-matthiasmartinsson@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matthias Kraemer <matthiasmartinsson@gmail.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org

On 16/05/17 00:44, Matthias Kraemer wrote:
> This patch applies customized PCI_DEVICE_ macros to specify the pci_ids
> instead of open-coding them within the sdhci-pci driver.
> 
> By introducing device specific macros the pci_ids table becomes much
> shorter and easier to comprehend than it would be possible using the
> generic version of the PCI_DEVICE_ macros.
> 
> Signed-off-by: Matthias Kraemer <matthiasmartinsson@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

