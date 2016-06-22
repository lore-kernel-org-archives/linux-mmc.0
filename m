From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V7 1/2] mmc: sdhci-brcmstb: Add driver for Broadcom
 BRCMSTB SoCs
Date: Wed, 22 Jun 2016 12:48:36 +0300
Message-ID: <576A5EF4.5050208@intel.com>
References: <1466095637-27895-1-git-send-email-alcooperx@gmail.com>
 <1466095637-27895-2-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:5773 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752226AbcFVJyB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Jun 2016 05:54:01 -0400
In-Reply-To: <1466095637-27895-2-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Al Cooper <alcooperx@gmail.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

On 16/06/16 19:47, Al Cooper wrote:
> Add SDHCI driver for Broadcom BRCMSTB SoCs.
> This driver works with all ARM based SoCs and the 7425, 7429
> and 7435 MIPS based SoCs.
> 
> The driver disables all UHS speed modes by default and relies
> on the Device Tree node properties to enable these modes for
> SoC/Board combinations that support them.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


