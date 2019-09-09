From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/4] mmc: Add virtual command queue support
Date: Mon, 9 Sep 2019 15:01:32 +0300
Message-ID: <3bcd69fd-2f8e-9b87-7292-4b0b1aa5be78@intel.com>
References: <cover.1567740135.git.baolin.wang@linaro.org>
 <14599f7165f23db2bf7b71a2596e808e2bc2056c.1567740135.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <14599f7165f23db2bf7b71a2596e808e2bc2056c.1567740135.git.baolin.wang@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>, ulf.hansson@linaro.org, riteshh@codeaurora.org, asutoshd@codeaurora.org
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de, linus.walleij@linaro.org, vincent.guittot@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 6/09/19 6:52 AM, Baolin Wang wrote:
> Now the MMC read/write stack will always wait for previous request is
> completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> or queue a work to complete request, that will bring context switching
> overhead, especially for high I/O per second rates, to affect the IO
> performance.
> 
> Thus this patch introduces virtual command queue interface, which is
> similar with the hardware command queue engine's idea, that can remove
> the context switching.

CQHCI is a hardware interface for eMMC's that support command queuing.  What
you are doing is a software issue queue, unrelated to CQHCI.  I think you
should avoid all reference to CQHCI i.e. call it something else.
