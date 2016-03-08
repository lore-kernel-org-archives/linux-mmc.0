From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v7 4/4] mmc: sdhci-of-arasan: add phy support for
 sdhci-of-arasan
Date: Tue, 8 Mar 2016 15:50:43 +0200
Message-ID: <56DED8B3.2020804@intel.com>
References: <1457365099-23248-1-git-send-email-shawn.lin@rock-chips.com>
 <1457365159-23414-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457365159-23414-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 07/03/16 17:39, Shawn Lin wrote:
> This patch adds Generic PHY access for sdhci-of-arasan. Driver
> can get PHY handler from dt-binding, and power-on/init the PHY.
> Currently, it's just mandatory for arasan,sdhci-5.1.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
