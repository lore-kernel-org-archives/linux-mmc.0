From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 3/3] mmc: sdhci-pci: Do not set DMA mask in enable_dma()
Date: Fri, 04 Mar 2016 16:58:03 +0100
Message-ID: <80995892.bmuuFVee6i@wuerfel>
References: <1457087925-992-1-git-send-email-acourbot@nvidia.com> <1457087925-992-4-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457087925-992-4-git-send-email-acourbot@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com
List-Id: linux-mmc@vger.kernel.org

On Friday 04 March 2016 19:38:45 Alexandre Courbot wrote:
> DMA mask will already be set by sdhci_set_dma_mask(), which
> is equivalent to the removed code since pci_set_dma_mask()
> expands to its DMA-API counterpart.
> 
> There should also be no reason to set the DMA mask after probe.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
