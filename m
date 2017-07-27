From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RESEND PATCH] arc: remove num-slots from arc platforms
Date: Thu, 27 Jul 2017 16:48:04 +0200
Message-ID: <CAPDyKFrNCRn101-abORYmVXR9iZVo2dNu2VB13Nz_VAetey=TQ@mail.gmail.com>
References: <1500424749-206304-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36944 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbdG0OsG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jul 2017 10:48:06 -0400
Received: by mail-qk0-f176.google.com with SMTP id z18so23064366qka.4
        for <linux-mmc@vger.kernel.org>; Thu, 27 Jul 2017 07:48:05 -0700 (PDT)
In-Reply-To: <1500424749-206304-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Vineet Gupta <vgupta@synopsys.com>, Alexey Brodkin <abrodkin@synopsys.com>

On 19 July 2017 at 02:39, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> dwmmc driver deprecated num-slots and plan to get rid
> of it finally. Just move a step to cleanup it from DT.
>
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
> Acked-by: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
> Acked-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> Hi Ulf,
>
> Vineet prefer this patch to go via mmc tree where the driver's
> conversion happened. So could you pick it up?

Sure, thanks, applied for next!

Kind regards
Uffe

>
>  arch/arc/boot/dts/axs10x_mb.dtsi     | 1 -
>  arch/arc/boot/dts/vdk_axs10x_mb.dtsi | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/arch/arc/boot/dts/axs10x_mb.dtsi b/arch/arc/boot/dts/axs10x_mb.dtsi
> index 41cfb29..82e26ad 100644
> --- a/arch/arc/boot/dts/axs10x_mb.dtsi
> +++ b/arch/arc/boot/dts/axs10x_mb.dtsi
> @@ -101,7 +101,6 @@
>                 mmc@0x15000 {
>                         compatible = "altr,socfpga-dw-mshc";
>                         reg = < 0x15000 0x400 >;
> -                       num-slots = < 1 >;
>                         fifo-depth = < 16 >;
>                         card-detect-delay = < 200 >;
>                         clocks = <&apbclk>, <&mmcclk>;
> diff --git a/arch/arc/boot/dts/vdk_axs10x_mb.dtsi b/arch/arc/boot/dts/vdk_axs10x_mb.dtsi
> index 459fc65..48bb4b4 100644
> --- a/arch/arc/boot/dts/vdk_axs10x_mb.dtsi
> +++ b/arch/arc/boot/dts/vdk_axs10x_mb.dtsi
> @@ -104,7 +104,6 @@
>                 mmc@0x15000 {
>                         compatible = "snps,dw-mshc";
>                         reg = <0x15000 0x400>;
> -                       num-slots = <1>;
>                         fifo-depth = <1024>;
>                         card-detect-delay = <200>;
>                         clocks = <&apbclk>, <&mmcclk>;
> --
> 1.9.1
>
>
