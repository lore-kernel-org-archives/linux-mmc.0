From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v4 1/2] Documentation: synopsys-dw-mshc: add binding for
 resets
Date: Thu, 11 Aug 2016 10:18:28 +0800
Message-ID: <bcf36e9c-4f9c-3626-1b32-7695794d7aab@rock-chips.com>
References: <1470816228-8874-1-git-send-email-guodong.xu@linaro.org>
 <1470816228-8874-2-git-send-email-guodong.xu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470816228-8874-2-git-send-email-guodong.xu@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Guodong Xu <guodong.xu@linaro.org>, heiko@sntech.de, jh80.chung@samsung.com, robh+dt@kernel.org, mark.rutland@arm.com, ulf.hansson@linaro.org
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

ÔÚ 2016/8/10 16:03, Guodong Xu Ð´µÀ:
> Add resets property to synopsys-dw-mshc bindings. It is intended to
> represent the hardware reset signal present internally in some host
> controller IC designs.
>
> See Documentation/devicetree/bindings/reset/reset.txt for details.
>
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> index 8636f5a..4e00e85 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> @@ -39,6 +39,10 @@ Required Properties:
>
>  Optional properties:
>
> +* resets: phandle + reset specifier pair, intended to represent hardware
> +  reset signal present internally in some host controller IC designs.
> +  See Documentation/devicetree/bindings/reset/reset.txt for details.
> +
>  * clocks: from common clock binding: handle to biu and ciu clocks for the
>    bus interface unit clock and the card interface unit clock.
>
>

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

-- 
Best Regards
Shawn Lin
