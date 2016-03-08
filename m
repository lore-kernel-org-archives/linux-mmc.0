From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v7 3/4] mmc: sdhci-of-arasan: fix missing sdhci_pltfm_free
 for err handling
Date: Tue, 8 Mar 2016 15:50:38 +0200
Message-ID: <56DED8AE.4060608@intel.com>
References: <1457365099-23248-1-git-send-email-shawn.lin@rock-chips.com>
 <1457365148-23373-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:1343 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627AbcCHNyQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Mar 2016 08:54:16 -0500
In-Reply-To: <1457365148-23373-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On 07/03/16 17:39, Shawn Lin wrote:
> Currently, some err handling of sdhci_arasan_probe return directly
> without calling sdhci_pltfm_free. This patch fixes them.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

