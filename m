From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 0/2] Fixes for command errors during tuning
Date: Wed, 6 Mar 2019 15:48:23 +0530
Message-ID: <e5fb69c2-72a4-4b82-ea65-e0b314fdf28f@ti.com>
References: <20190301083824.23918-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190301083824.23918-1-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: ulf.hansson@linaro.org, kishon@ti.com, adrian.hunter@intel.com
List-Id: linux-mmc@vger.kernel.org

Hi,

On 01/03/19 2:08 PM, Faiz Abbas wrote:
> These patches fix the following error message in dra7xx boards:
> 
> [4.833198] mmc1: Got data interrupt 0x00000002 even though no data
> operation was in progress.
> 
> Tested with 100 times boot tests on dra71x-evm, dra72x-evm and
> dra7xx-evm.
> 
> v2:
> Added EXPORT_SYMBOL_GPL for sdhci_cmd_err and sdhci_send_command to fix
> errors when built as module.
> 
> Faiz Abbas (2):
>   mmc: sdhci: Add platform_cmd_err() to sdhci_ops
>   mmc: sdhci-omap: Don't finish_mrq() on a command error during tuning
> 
>  drivers/mmc/host/sdhci-omap.c | 24 +++++++++++++++++++++
>  drivers/mmc/host/sdhci.c      | 40 +++++++++++++++++++++++------------
>  drivers/mmc/host/sdhci.h      |  4 ++++
>  3 files changed, 54 insertions(+), 14 deletions(-)
>

Gentle ping.

Thanks,
Faiz
