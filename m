From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC 0/2] dw_mmc: add multislot support
Date: Thu, 26 Apr 2018 19:30:02 +0900
Message-ID: <396f24f0-2b51-9218-8d15-fd77f49735e8@samsung.com>
References: <CGME20180417121325epcas2p319c672feee4203d8b90131da461f4bd6@epcas2p3.samsung.com>
        <20180417121130.25281-1-Eugeniy.Paltsev@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180417121130.25281-1-Eugeniy.Paltsev@synopsys.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>, shawn.lin@rock-chips.com, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 04/17/2018 09:11 PM, Eugeniy Paltsev wrote:
> This series consists of two patches:
> 1. revert removal of previously existed "pseudo-multislot" support.
>  * Revert "mmc: dw_mmc: remove the deprecated "num-slots""
>  * Revert "mmc: dw_mmc: fix the wrong condition check of getting num-slots from DT"
>  * Revert "mmc: dw_mmc: remove the unnecessary slot variable"
>  * Revert "mmc: dw_mmc: update kernel-doc comments for dw_mci"
>  * Revert "mmc: dw_mmc: use the 'slot' instead of 'cur_slot'"
>  * Revert "mmc: dw_mmc: remove the 'id' arguments about functions relevant to slot"
>  * Revert "mmc: dw_mmc: change the array of slots"
>  * Revert "mmc: dw_mmc: remove the loop about finding slots"
>  * Revert "mmc: dw_mmc: deprecated the "num-slots" property"
> 
> 2. Add missing stuff to support multislot mode in DesignWare MMC driver.
>  * Add missing slot switch to __dw_mci_start_request() function.
>  * Refactor set_ios function:
>    a) Calculate common clock which is
>       suitable for all slots instead of directly use clock value
>       provided by mmc core. We calculate common clock as the minimum
>       among each used slot clocks. This clock is calculated in
>       dw_mci_calc_common_clock() function which is called
>       from set_ios()
>    b) Disable clock only if no other slots are ON.
>    c) Setup clock directly in set_ios() only if no other slots
>       are ON. Otherwise adjust clock in __dw_mci_start_request()
>       function before slot switch.
>    d) Move timings and bus_width setup to separate funcions.
>  * Use timing field in each slot structure instead of common field in
>    host structure.
>  * Add locks to serialize access to registers.

Sorry for late. :(
Well, I will read the other comments..and reply soon. 

Best Regards,
Jaehoon Chung

> 
> NOTE: this patch is based off of v4.17-rc1
> 
> NOTE: as of today I tested this changes (in singleslot and multislot
>    modes) only on Synopsys HSDK board. But I will get ODROID-XU4 board
>    (with Exynos5422 which has DW MMC controller) the next week
>    so I will test it on this board too to catch any regressions.
> 
> Eugeniy Paltsev (2):
>   dw_mmc: revert removal multislot support
>   dw_mmc: add multislot support
> 
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |   5 +
>  drivers/mmc/host/dw_mmc-exynos.c                   |   4 +-
>  drivers/mmc/host/dw_mmc-pci.c                      |   1 +
>  drivers/mmc/host/dw_mmc.c                          | 486 +++++++++++++++------
>  drivers/mmc/host/dw_mmc.h                          |  35 +-
>  5 files changed, 387 insertions(+), 144 deletions(-)
> 
