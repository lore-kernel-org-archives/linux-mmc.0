From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 10/13] ARM: dts: exynos: replace to "max-frequecy"
 instead of "clock-freq-min-max"
Date: Thu, 3 Nov 2016 20:41:12 +0200
Message-ID: <20161103184112.GB11071@kozik-lap>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
 <20161103062135.10697-11-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161103062135.10697-11-jh80.chung@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, ulf.hansson@linaro.org, robh+dt@kernel.org, krzk@kernel.org, heiko@sntech.de, shawn.lin@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

On Thu, Nov 03, 2016 at 03:21:32PM +0900, Jaehoon Chung wrote:
> In drivers/mmc/core/host.c, there is "max-frequency" property.
> It should be same behavior. So Use the "max-frequency" instead of
> "clock-freq-min-max".
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250-artik5-eval.dts | 2 +-
>  arch/arm/boot/dts/exynos3250-artik5.dtsi     | 2 +-
>  arch/arm/boot/dts/exynos3250-monk.dts        | 2 +-
>  arch/arm/boot/dts/exynos3250-rinato.dts      | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

This looks totally independent to rest of patches so it can be applied
separately without any functional impact (except lack of minimum
frequency). Is that correct?

Best regards,
Krzysztof
