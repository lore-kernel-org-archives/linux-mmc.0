From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V7] mmc:host:sdhci-pci:Addition of Arasan PCI Controller
 with integrated phy.
Date: Thu, 4 Jan 2018 10:37:51 +0200
Message-ID: <bfcc0ced-9235-9d4c-106c-a7a711d94d9d@intel.com>
References: <1515039456-9173-1-git-send-email-agarg@arasan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:4559 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbeADIiX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 4 Jan 2018 03:38:23 -0500
In-Reply-To: <1515039456-9173-1-git-send-email-agarg@arasan.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Atul Garg <agarg@arasan.com>, linux-mmc@vger.kernel.org, kishon@ti.com, rk@ti.com, nm@ti.com, nsekhar@ti.com, ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org

On 04/01/18 06:17, Atul Garg wrote:
> The Arasan Controller is based on a FPGA platform and has integrated phy
> with specific registers used during initialization and
> management of different modes. The phy and the controller are integrated
> and registers are very specific to Arasan.
> 
> Arasan being an IP provider, licenses these IPs to various companies for
> integration of IP in custom SOCs. The custom SOCs define own register
> map depending on how bits are tied inside the SOC for phy registers,
> depending on SOC memory plan and hence will require own platform drivers.
> 
> If more details on phy registers are required, an interface document is
> hosted at https://arasan.com/NF/eMMC5.1 PHY Programming in Linux.pdf.
> 
> Signed-off-by: Atul Garg <agarg@arasan.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
