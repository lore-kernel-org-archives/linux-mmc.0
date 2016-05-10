From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-st: correct name of sd-uhs-sdr50 property
Date: Tue, 10 May 2016 12:28:39 +0200
Message-ID: <CAPDyKFovKxGDnnyKAWjpjTN=7XB5sbTe+gyh2OTSRQ=bmnJTFQ@mail.gmail.com>
References: <1462839264-13300-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37565 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbcEJK2l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2016 06:28:41 -0400
Received: by mail-wm0-f50.google.com with SMTP id a17so19179491wme.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 May 2016 03:28:40 -0700 (PDT)
In-Reply-To: <1462839264-13300-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, kernel@stlinux.com, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 10 May 2016 at 02:14, Simon Horman <horms+renesas@verge.net.au> wrote:
> Correct what appears to be a typo in the name of the sd-uhs-sdr50.
>
> Also fix mixed tab/space indentation.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/sdhci-st.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-st.txt b/Documentation/devicetree/bindings/mmc/sdhci-st.txt
> index 18d950df2749..88faa91125bf 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-st.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-st.txt
> @@ -38,7 +38,7 @@ Optional properties:
>  - bus-width:           Number of data lines.
>                         See:  Documentation/devicetree/bindings/mmc/mmc.txt.
>
> -- max-frequency:       Can be 200MHz, 100Mz or 50MHz (default) and used for
> +- max-frequency:       Can be 200MHz, 100Mz or 50MHz (default) and used for
>                         configuring the CCONFIG3 in the mmcss.
>                         See:  Documentation/devicetree/bindings/mmc/mmc.txt.
>
> @@ -48,7 +48,7 @@ Optional properties:
>  - vqmmc-supply:                Phandle to the regulator dt node, mentioned as the vcc/vdd
>                         supply in eMMC/SD specs.
>
> -- sd-uhs--sdr50:       To enable the SDR50 in the mmcss.
> +- sd-uhs-sdr50:        To enable the SDR50 in the mmcss.
>                         See:  Documentation/devicetree/bindings/mmc/mmc.txt.
>
>  - sd-uhs-sdr104:       To enable the SDR104 in the mmcss.
> --
> 2.1.4
>
