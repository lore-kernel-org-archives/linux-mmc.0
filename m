From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: sdhci-fujitsu: document cmd-dat-delay property
Date: Tue, 7 Nov 2017 14:23:46 +0100
Message-ID: <CAPDyKFq51ZqkBt7y18Jw49ggJbANLnCLur5S6mX=J=h2shZtiw@mail.gmail.com>
References: <20171106152923.32114-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:46616 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933608AbdKGNXs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Nov 2017 08:23:48 -0500
Received: by mail-it0-f68.google.com with SMTP id f187so2379917itb.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 Nov 2017 05:23:47 -0800 (PST)
In-Reply-To: <20171106152923.32114-1-ard.biesheuvel@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 6 November 2017 at 16:29, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Document a new boolean property of the sdhci-fujitsu binding that
> indicates whether the CMD_DAT_DELAY bit needs to be set in the
> F_SDH30_ESD_CONTROL register.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
> v3: added Rob's ack
> v2: use vendor prefix
>
>  Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
> index de2c53cff4f1..3ee9263adf73 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
> @@ -15,6 +15,8 @@ Required properties:
>  Optional properties:
>  - vqmmc-supply: phandle to the regulator device tree node, mentioned
>    as the VCCQ/VDD_IO supply in the eMMC/SD specs.
> +- fujitsu,cmd-dat-delay-select: boolean property indicating that this host
> +  requires the CMD_DAT_DELAY control to be enabled.
>
>  Example:
>
> --
> 2.11.0
>
