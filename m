From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH] mmc: sdhci-of-arasan: Add auto tuning support for
 ZynqMP Platform
Date: Mon, 5 Feb 2018 00:07:40 -0600
Message-ID: <20180205024420.iagez2mue2skrngq@rob-hp-laptop>
References: <1517336073-18142-1-git-send-email-mnarani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36309 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752621AbeBEGHm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Feb 2018 01:07:42 -0500
Content-Disposition: inline
In-Reply-To: <1517336073-18142-1-git-send-email-mnarani@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Manish Narani <manish.narani@xilinx.com>
Cc: michal.simek@xilinx.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, mark.rutland@arm.com, anirudh@xilinx.com, sgoud@xilinx.com, Manish Narani <mnarani@xilinx.com>

On Tue, Jan 30, 2018 at 11:44:33PM +0530, Manish Narani wrote:
> This patch adds support of SD auto tuning for ZynqMP platform. Auto
> tuning sequence sends tuning block to card when operating in UHS-1
> modes. This resets the DLL and sends CMD19/CMD21 as a part of the auto
> tuning process. Once the auto tuning process gets completed, reset the
> DLL to load the newly obtained SDHC tuned tap value.
> 
> Signed-off-by: Manish Narani <mnarani@xilinx.com>
> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt       |   1 +
>  drivers/mmc/host/sdhci-of-arasan.c                 | 219 ++++++++++++++++++++-
>  2 files changed, 219 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 60481bf..7d29751 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -14,6 +14,7 @@ Required Properties:
>      - "arasan,sdhci-4.9a": generic Arasan SDHCI 4.9a PHY
>      - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
>      - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
> +    - "xlnx,zynqmp-8.9a": Xilinx ZynqMP 8.9a PHY

This should be a separate patch.

>        For this device it is strongly suggested to include arasan,soc-ctl-syscon.
>    - reg: From mmc bindings: Register location and length.
>    - clocks: From clock bindings: Handles to clock inputs.
