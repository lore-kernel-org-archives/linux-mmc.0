From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 08/10] ARM: STi: DT: Enable second sdhci controller for
 stih416 b2020 boards.
Date: Wed, 9 Jul 2014 12:09:36 +0200
Message-ID: <CAPDyKFor1LqgAcJZc14iSY6D8RYm4w7sysRR3c2inSr4LVYt8w@mail.gmail.com>
References: <1401898054-686-1-git-send-email-peter.griffin@linaro.org>
	<1401898054-686-9-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:47372 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537AbaGIKJh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Jul 2014 06:09:37 -0400
Received: by mail-qg0-f47.google.com with SMTP id q108so6187270qgd.34
        for <linux-mmc@vger.kernel.org>; Wed, 09 Jul 2014 03:09:36 -0700 (PDT)
In-Reply-To: <1401898054-686-9-git-send-email-peter.griffin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Chris Ball <chris@printf.net>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice CHOTARD <patrice.chotard@st.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 4 June 2014 18:07, Peter Griffin <peter.griffin@linaro.org> wrote:
> The second controller is only present on the stih416 SoC. Also
> mark this as non-removeable as its eMMC.
>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
> ---
>  arch/arm/boot/dts/stih416-b2020-revE.dts | 6 ++++++
>  arch/arm/boot/dts/stih416-b2020.dts      | 8 ++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stih416-b2020-revE.dts b/arch/arm/boot/dts/stih416-b2020-revE.dts
> index ba0fa2c..68dfdaf 100644
> --- a/arch/arm/boot/dts/stih416-b2020-revE.dts
> +++ b/arch/arm/boot/dts/stih416-b2020-revE.dts
> @@ -31,5 +31,11 @@
>                 ethernet1: dwmac@fef08000 {
>                         snps,reset-gpio = <&PIO0 7>;
>                 };
> +
> +               mmc1: sdhci@fe81f000 {
> +                       status       = "okay";
> +                       bus-width    = <8>;
> +                       non-removable;
> +               };
>         };

Hi Peter,

I was trying to apply this patchset on my next branch, but the above
file /arch/arm/boot/dts/stih416-b2020-revE.dts does not exist. And I
don't see it in linux-next either.

What tree/patch are this based upon?

Kind regards
Uffe
