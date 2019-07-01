From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2] mmc: sdhci-msm: fix mutex while in spinlock
Date: Mon, 1 Jul 2019 20:52:57 +0530
Message-ID: <20190701152257.GM2911@vkoul-mobl>
References: <20190701150125.2602-1-jorge.ramirez-ortiz@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190701150125.2602-1-jorge.ramirez-ortiz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc: agross@kernel.org, adrian.hunter@intel.com, ulf.hansson@linaro.org, bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, khasim.mohammed@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 01-07-19, 17:01, Jorge Ramirez-Ortiz wrote:
> mutexes can sleep and therefore should not be taken while holding a
> spinlock. move clk_get_rate (can sleep) outside the spinlock protected
> region.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
