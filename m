From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/3] mmc: dt: usdhi6rol0: add optional pinctrl binding
Date: Tue, 19 Apr 2016 11:43:05 +0200
Message-ID: <CAPDyKFq_9pv==9BFWCJSu6x9ncCP7ZzQRaArAvCD-Rr9eXaddg@mail.gmail.com>
References: <cover.1460986983.git.larper@axis.com>
	<0376e04a938f459cee9e1f80e1447e060ba7e497.1460986983.git.larper@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:34670 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbcDSJnI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 05:43:08 -0400
Received: by mail-wm0-f46.google.com with SMTP id l6so26960726wml.1
        for <linux-mmc@vger.kernel.org>; Tue, 19 Apr 2016 02:43:06 -0700 (PDT)
In-Reply-To: <0376e04a938f459cee9e1f80e1447e060ba7e497.1460986983.git.larper@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars Persson <lars.persson@axis.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lars Persson <larper@axis.com>

On 18 April 2016 at 15:44, Lars Persson <lars.persson@axis.com> wrote:
> Add a pinctrl binding to specify different pin settings for high speed
> modes and UHS modes.
>
> Signed-off-by: Lars Persson <larper@axis.com>
> ---
>  Documentation/devicetree/bindings/mmc/usdhi6rol0.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt b/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
> index 8babdaa..9dd9478 100644
> --- a/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
> +++ b/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
> @@ -12,6 +12,10 @@ Optional properties:
>
>  - vmmc-supply: a phandle of a regulator, supplying Vcc to the card
>  - vqmmc-supply:        a phandle of a regulator, supplying VccQ to the card
> +- pinctrl-names: Must contain a "default" entry and optionally a "pins_uhs"

"state_uhs" is becoming more and more widely deployed, I suggest you
use that as well.

Moreover, I am reviewing patch 3/3 and I think some more clarification
is needed here, on whether what is required and optional. See those
comment on patch 3/3.

> +                 entry for the UHS pin configuration.
> +- pinctrl-N: One property for each name listed in pinctrl-names, see
> +             ../pinctrl/pinctrl-bindings.txt.
>
>  Additionally any standard mmc bindings from mmc.txt can be used.
>
> --
> 2.1.4
>

Kind regards
Uffe
