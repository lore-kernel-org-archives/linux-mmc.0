From: Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: Bug report: MIPS CI20/jz4740-mmc DMA and PREEMPT_NONE
Date: Wed, 17 Oct 2018 14:55:18 -0300
Message-ID: <75b42b9f86b504bbd84dfab1e2c6fd0965216c67.camel@collabora.com>
References: <20181014170431.GK3461@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181014170431.GK3461@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Mathieu Malaterre <malat@debian.org>, Ezequiel Garcia <ezequiel@collabora.co.uk>
List-Id: linux-mmc@vger.kernel.org

On Sun, 2018-10-14 at 20:04 +0300, Aaro Koskinen wrote:
> Hi,
> 
> There is something wrong with jz4740-mmc in current mainline kernel
> (tested v4.18 and 4.19-rc, the MMC support for CI20 does not exist
> prior those), as the DMA support does not work properly if I disable
> kernel pre-emption. The console gets flooded with:
> 
> [   16.461094] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 567 host->next_data.cookie 568
> [   16.473120] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 568 host->next_data.cookie 569
> [   16.485144] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 569 host->next_data.cookie 570
> [   16.497170] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 570 host->next_data.cookie 571
> [   16.509194] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 571 host->next_data.cookie 572
> [   16.532421] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 572 host->next_data.cookie 573
> [   16.544594] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 573 host->next_data.cookie 574
> [   16.556621] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 574 host->next_data.cookie 575
> [   16.568638] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 575 host->next_data.cookie 576
> [   16.601092] jz4740-mmc 13450000.mmc: [jz4740_mmc_prepare_dma_data] invalid cookie: data->host_cookie 582 host->next_data.cookie 583
> 
> etc. ad inf.
> 
> This should be easily reproducible on CI20 board with ci20_defconfig
> and setting CONFIG_PREEMPT_NONE=y.
> 

Will take a look as soon as possible, most likely after ELCE.

Thanks,
Eze
