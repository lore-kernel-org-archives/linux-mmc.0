From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 3/5] Documentation: synopsys-dw-mshc: add binding for fifo
 quirks
Date: Mon, 24 Oct 2016 20:19:07 +0800
Message-ID: <02e88f2e-d87b-c999-a148-65cfe5cf84d0@rock-chips.com>
References: <1477300316-1420-1-git-send-email-jun.nie@linaro.org>
 <1477300316-1420-4-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:53265 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756858AbcJXMT2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2016 08:19:28 -0400
In-Reply-To: <1477300316-1420-4-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jun Nie <jun.nie@linaro.org>, shawn.guo@linaro.org, xie.baoyou@zte.com.cn
Cc: shawn.lin@rock-chips.com, ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, linux-mmc@vger.kernel.org

On 2016/10/24 17:11, Jun Nie wrote:
> Add fifo-addr-override property and fifo-watermark-quirk property to
> synopsys-dw-mshc bindings. It is intended to provide workarounds to
> support more SoCs that break current assumption.
>
> See Documentation/devicetree/bindings/reset/reset.txt for details.
>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> index 4e00e85..eb64921 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> @@ -76,6 +76,17 @@ Optional properties:
>
>  * broken-cd: as documented in mmc core bindings.
>
> +* fifo-addr-override: Override fifo address with value provided by DT. The FIFO
> +  reg offset of version 0x210A break current assumption that 0x100 (version < 0x240A)
> +  and 0x200(version >= 0x240A) in some implementation. So this property serves as
> +  workaround.

Can we hardcode this to the code by checking the host version?

> +
> +* fifo-watermark-quirk: Data done irq is expected if data length is less than
> +  watermark in PIO mode. But fifo watermark is requested to be aligned with data
> +  length in some SoC so that TX/RX irq can be generated with data done irq. Add the
> +  watermark quirk to mark this requirement and force fifo watermark setting
> +  accordingly.

I would like to know if this limitation is *really* related to some
Socs or the version of 210A dw_mmc?


> +
>  * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
>    specified we'll defer probe until we can find this regulator.
>
> @@ -103,6 +114,8 @@ board specific portions as listed below.
>  		interrupts = <0 75 0>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		fifo-addr-override = <0x200>;
> +		fifo-watermark-quirk;
>  	};
>
>  [board specific internal DMA resources]
>


-- 
Best Regards
Shawn Lin

