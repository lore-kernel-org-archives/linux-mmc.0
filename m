Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C759F37A48A;
	Mon, 22 Jun 2026 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782126530; cv=none; b=F0fb5ePW/3fZl5lwt6NUVeQFE4KpawCZHRU+7+3jUXj5snleM/2pTkMpFWn4nEnH/2bQ5Te2aPuqwVj7evTFGnqSBLwrR9+Na94WC2PH3OAOdOCqo/aSznSL4lrVcTzPLrWHCBEaKR3YwRnQJ8yq1jhGqobtWBGDxKC1FRxY/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782126530; c=relaxed/simple;
	bh=XPqLZhbsHjND7Lw/3WXD9MQBDcbCQ5VFMGrLEWXPguo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQm4iy9prtxFDLi1Clx0f8YmMzArPl50ECRb2SIKeF0S3QkoDf0/nTyXhtmK2Dr+TG6O0GeX/iMlXaUe66Q8tjxdfJSX0YDT+iIpYKgV+SQLcTf+hTjv5jMQimTfHWtiSmE89RwJ4voJslfQ4cMnvJFMUdNVeJ/ljtHq9+Rtdg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=TkzZZP5y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BivKHeEP; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="TkzZZP5y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BivKHeEP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id BA30F1380C10;
	Mon, 22 Jun 2026 07:08:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 22 Jun 2026 07:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782126525;
	 x=1782133725; bh=LguAGRbklnAjbBMOvcGYnxIAQF/oYbOFEYVOadF6eW4=; b=
	TkzZZP5y3ICFReCcaoFP/hs+Zk7fuHzD38jeQQhsRkDCEKGpxeqzElYQ21ISw1mR
	sUAiLtKsmkUIyQckwv8yldIQXCtpA7RfBnoaj4TOjg90T4BsXXhDeHCncWQo3axh
	hnzzCtVsoO4sFYLVnGNg9RV+YFrvSyEj3czxH5kKvcsQac2iDC+WiDJVjqdwXqKA
	Hz+xWxnzCbJQpSqEM7AcT8udhqOGo8jSt5jW3ghTfkwEt+By7YAPP59nXmD+zq7c
	ZcfMHl7fQjMBkiwgSB7USv+q5aYwOLL0br5nH2h5y6+hIUS+i3Cmi9fguAl0YD+g
	/nOqnC29a2XjovPgQSKgjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782126525; x=
	1782133725; bh=LguAGRbklnAjbBMOvcGYnxIAQF/oYbOFEYVOadF6eW4=; b=B
	ivKHeEPjS+2BV2ZMvPBYrKcomOrRMLwCGRMcvmleS4SXAY3g5r/QXC46CcyE07+f
	+eBnS1VDYOOZJw+6toHBInj6iKuadpzuLT+aSgMLv4GYudWfEdOa2ftoS6boKJep
	h88Ynvx/cYfQlp1yBUpe7Vt0VmRbCGrcA8+gr4qdugFjq6sJ/qa3/XlkRek6POt2
	gZj0tmCzUjRsRcRdlpTOMllos4oooppqYeRoBBmW1AzTT253XxmWzcRT6k2dgEfp
	G00/p8MZGISi/yFoq08zD49dH9/X6Y/mWAQItxFUWop7rbsNAVdXZNGjAP+m1GJd
	hQ5+kORSw3G9sedB3VbLQ==
X-ME-Sender: <xms:uRc5aniQ8MAL2kPdVksgiBfNswsrgXtT5k2IIN9DU6Lfuhl42k_mZg>
    <xme:uRc5ag1Ta4JuxuGE3N6_ymCV_vazMYWS9c89y9DHg6NkRkwgNIDGO54p4NCcmitsy
    es-_l7EhZimSdzxri_UC7m5JjY3N_2fQyh_hNY0PLXn-snvvx-235g>
X-ME-Received: <xmr:uRc5apXoTS5PI3SOz8lgqkaqscd3-kKO8Btt4moSW6UQsqMyWAQDSKFB_LgAGdKvhjate4Do-XdeJjJ50RG75elhOPq6>
X-ME-Proxy-Cause: dmFkZTGWre/gjjuXeplMqGsRAVfOUrCqTvo16C/1vqhusP4Ws2eNs4Ost2O1Z1scLnZzwr
    unQDMnwHsj5r3PBDJpNzfgVvo7W0DhqdKMZS/i4W4s3i1QbzBiXgMlbd4QeadL001yL5sv
    QQLcOaZIzrFLAjB7dNRAZJ5HJXv1cDxCS4SeLOPxH5D5CmDnJiVUuRGR7BqrugwbMk2Y6L
    A/N8sGHczVnGDobsJbEHNu+PQXXVTJmxpKoFc+ITwXjQLWKTPYP8N3uBcY0/SXa+azTd/c
    8SYiTxqqfOZkU6Tj3NoSIQvQS7CEMpkwA2/xz4pdYJbhYDh5RKVTUHGnZIG81bxc5w4lHz
    WJx+fKYXy2E9OH3qDP2JSGwpEw39kk15NU1BEJaPFTNiOfyl+tWJdTFaUk//ybfd4/Ys7B
    tJ5jaDnp8lu/wYtCWYr96Brzkq6ow3Xw2AoVH2SY1C24aRT5s3nnuQJeibDVcf1wR0wxG5
    cq1Ob9Sa9BGYwjSY4C05k7Vlc51zosKSM/l9r/cs1KD/jS3KvpubFIAoVyhI/r2sr1GyVc
    Fy0vPlCLw7xebPLcRcq1iPwzLpUzHxFAiIUQiVNMKwv5onh9rushd8ZWV9ftQs50v+3rEF
    wIJc+Rv+GOW1ne2tjex5/TjWRf0Sm5eE0E5hXncaFrjarB6nFfisr+ppRnTA
X-ME-Proxy: <xmx:uRc5akbm0BkkzFSqJpGBObcrvB9ttXfWL58p3a2mhZM1Vduy7k6qdw>
    <xmx:uRc5ap4qQAKAATRhEoKukbtAH_1UHqv15P7wf2k4aq_fR2Kb5cfcZA>
    <xmx:uRc5agHBWI0XAfPguMPwgAFfJM4Zd8_Cgirnje2WVAKK8qUw73E3lw>
    <xmx:uRc5atby8sAJ1XU7yJNk1cdNE-dGFTAzJpM3fc8KjJjHo4CW8wNDFg>
    <xmx:vRc5auzSWTQ6K0876RnXOSkes520_5JwHoQPdtvG_mDUquSBKjnenwdK>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 07:08:40 -0400 (EDT)
Date: Mon, 22 Jun 2026 13:08:38 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,	Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Andi Shyti <andi.shyti@kernel.org>,	Georgi Djakov <djakov@kernel.org>,
 Lee Jones <lee@kernel.org>,	Pavel Machek <pavel@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>, Peter Rosin <peda@lysator.liu.se>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Linus Walleij <linusw@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,	Sebastian Reichel <sre@kernel.org>,
	Javier Martinez Canillas <javier@dowhile0.org>,
	Liam Girdwood <lgirdwood@gmail.com>,	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Jonathan Marek <jonathan@marek.ca>,	Taniya Das <quic_tdas@quicinc.com>,
	Robert Marko <robimarko@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Adam Skladowski <a_skl39@protonmail.com>,
	Sireesh Kodali <sireeshkodali@protonmail.com>,
	Barnabas Czeman <barnabas.czeman@mainlining.org>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Anusha Rao <quic_anusha@quicinc.com>,	Luo Jie <quic_luoj@quicinc.com>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Chanho Park <chanho61.park@samsung.com>,
	Sunyeal Hong <sunyeal.hong@samsung.com>,	Shin Son <shin.son@samsung.com>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alina Yu <alina_yu@richtek.com>, Andy Gross <agross@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,	linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org,	linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,	linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org,	dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org,	linux-i2c@vger.kernel.org,
 linux-pm@vger.kernel.org,	linux-leds@vger.kernel.org,
 linux-media@vger.kernel.org,	linux-mmc@vger.kernel.org,
 linux-phy@lists.infradead.org,	linux-gpio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,	linux-serial@vger.kernel.org,
 linux-sound@vger.kernel.org,	linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: Drop incorrect usage of double '::'
Message-ID: <20260622110838.GA3937090@ragnatech.se>
References: <20260622101606.485961-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260622101606.485961-4-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260622101606.485961-4-krzysztof.kozlowski@oss.qualcomm.com>

Hi Krzysztof,

Thanks for your work.

On 2026-06-22 12:16:08 +0200, Krzysztof Kozlowski wrote:
> There is no use of double colon '::' in YAML. OTOH, the literal style
> block, e.g. using '|' treats all characters as content [1] therefore
> single use of ':' in descriptions is perfectly fine, whenever '|' is
> used.
> 
> Cleanup existing code, so the confusing style won't be re-used in new
> contributions.
> 
> Link: https://yaml.org/spec/1.2.2/#literal-style [1]
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

For the two Renesas bindings,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> 
> ---
> 
> Intention for this patch is to go via Rob's tree.
> ---
>  .../devicetree/bindings/arm/qcom-soc.yaml     |  4 ++--
>  .../devicetree/bindings/arm/qcom.yaml         |  4 ++--
>  .../bindings/arm/samsung/samsung-soc.yaml     |  4 ++--
>  .../display/msm/dsi-controller-main.yaml      | 20 +++++++++----------
>  .../display/samsung/samsung,fimd.yaml         |  4 ++--
>  .../bindings/i2c/samsung,s3c2410-i2c.yaml     |  2 +-
>  .../interconnect/qcom,msm8998-bwmon.yaml      |  2 +-
>  .../interconnect/samsung,exynos-bus.yaml      | 14 ++++++-------
>  .../bindings/leds/qcom,pm8058-led.yaml        |  4 ++--
>  .../bindings/leds/skyworks,aat1290.yaml       |  6 +++---
>  .../bindings/media/cec/cec-gpio.yaml          |  2 +-
>  .../bindings/mmc/samsung,exynos-dw-mshc.yaml  |  2 +-
>  .../devicetree/bindings/mux/mux-consumer.yaml |  4 ++--
>  .../bindings/phy/samsung,mipi-video-phy.yaml  |  4 ++--
>  .../bindings/phy/samsung,usb2-phy.yaml        |  2 +-
>  .../bindings/phy/samsung,usb3-drd-phy.yaml    |  2 +-
>  .../bindings/pinctrl/samsung,pinctrl.yaml     |  2 +-
>  .../bindings/power/renesas,rcar-sysc.yaml     |  2 +-
>  .../bindings/power/reset/restart-handler.yaml |  8 ++++----
>  .../bindings/regulator/maxim,max77802.yaml    |  4 ++--
>  .../bindings/regulator/richtek,rtq2208.yaml   |  2 +-
>  .../bindings/serial/qcom,msm-uartdm.yaml      |  2 +-
>  .../devicetree/bindings/slimbus/slimbus.yaml  |  4 ++--
>  .../bindings/soc/qcom/qcom,apr-services.yaml  |  2 +-
>  .../bindings/soc/qcom/qcom,rpmh-rsc.yaml      |  8 ++++----
>  .../bindings/soc/qcom/qcom,wcnss.yaml         |  2 +-
>  .../bindings/soc/renesas/renesas-soc.yaml     |  4 ++--
>  .../bindings/sound/qcom,q6asm-dais.yaml       |  2 +-
>  .../thermal/samsung,exynos-thermal.yaml       |  4 ++--
>  .../devicetree/bindings/usb/qcom,dwc3.yaml    | 12 +++++------
>  .../bindings/usb/qcom,snps-dwc3.yaml          | 12 +++++------
>  31 files changed, 75 insertions(+), 75 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> index 27261039d56f..37fdd5a080b7 100644
> --- a/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> @@ -11,10 +11,10 @@ maintainers:
>  
>  description: |
>    Guidelines for new compatibles for SoC blocks/components.
> -  When adding new compatibles in new bindings, use the format::
> +  When adding new compatibles in new bindings, use the format:
>      qcom,SoC-IP
>  
> -  For example::
> +  For example:
>     qcom,sdm845-llcc-bwmon
>  
>    When adding new compatibles to existing bindings, use the format in the
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 50cc18a6ec5e..667607ae2c32 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -1215,7 +1215,7 @@ properties:
>      items:
>        items:
>          - description: |
> -            MSM chipset ID - an exact match value consisting of two bitfields::
> +            MSM chipset ID - an exact match value consisting of two bitfields:
>               - bits 0-15  - The unique MSM chipset ID
>               - bits 16-31 - Reserved; should be 0
>          - description: |
> @@ -1241,7 +1241,7 @@ properties:
>        - items:
>            - items:
>                - description: |
> -                  Board ID consisting of three bitfields::
> +                  Board ID consisting of three bitfields:
>                      - bits 31-24 - Unused
>                      - bits 23-16 - Platform Version Major
>                      - bits 15-8  - Platform Version Minor
> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml
> index 653f85997643..ab000befe76d 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml
> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml
> @@ -11,10 +11,10 @@ maintainers:
>  
>  description: |
>    Guidelines for new compatibles for SoC blocks/components.
> -  When adding new compatibles in new bindings, use the format::
> +  When adding new compatibles in new bindings, use the format:
>      samsung,SoC-IP
>  
> -  For example::
> +  For example:
>      samsung,exynos5433-cmu-isp
>  
>  select:
> diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> index dbc0613e427e..395425a70db8 100644
> --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> @@ -73,16 +73,16 @@ properties:
>  
>    clocks:
>      description: |
> -      Several clocks are used, depending on the variant. Typical ones are::
> -       - bus:: Display AHB clock.
> -       - byte:: Display byte clock.
> -       - byte_intf:: Display byte interface clock.
> -       - core:: Display core clock.
> -       - core_mss:: Core MultiMedia SubSystem clock.
> -       - iface:: Display AXI clock.
> -       - mdp_core:: MDP Core clock.
> -       - mnoc:: MNOC clock
> -       - pixel:: Display pixel clock.
> +      Several clocks are used, depending on the variant. Typical ones are:
> +       - bus: Display AHB clock.
> +       - byte: Display byte clock.
> +       - byte_intf: Display byte interface clock.
> +       - core: Display core clock.
> +       - core_mss: Core MultiMedia SubSystem clock.
> +       - iface: Display AXI clock.
> +       - mdp_core: MDP Core clock.
> +       - mnoc: MNOC clock
> +       - pixel: Display pixel clock.
>      minItems: 3
>      maxItems: 12
>  
> diff --git a/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml b/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
> index ff685031bb2c..729705f419bb 100644
> --- a/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
> +++ b/Documentation/devicetree/bindings/display/samsung/samsung,fimd.yaml
> @@ -41,7 +41,7 @@ properties:
>      additionalProperties: false
>      description: |
>        Timing configuration for lcd i80 interface support.
> -      The parameters are defined as::
> +      The parameters are defined as:
>        VCLK(internal)  __|??????|_____|??????|_____|??????|_____|??????|_____|??
>                          :            :            :            :            :
>        Address Output  --:<XXXXXXXXXXX:XXXXXXXXXXXX:XXXXXXXXXXXX:XXXXXXXXXXXX:XX
> @@ -132,7 +132,7 @@ patternProperties:
>    "^port@[0-4]+$":
>      $ref: /schemas/graph.yaml#/properties/port
>      description: |
> -      Contains ports with port with index::
> +      Contains ports with port with index:
>         0 - for CAMIF0 input,
>         1 - for CAMIF1 input,
>         2 - for CAMIF2 input,
> diff --git a/Documentation/devicetree/bindings/i2c/samsung,s3c2410-i2c.yaml b/Documentation/devicetree/bindings/i2c/samsung,s3c2410-i2c.yaml
> index a2ddc6803617..07600b49f2f9 100644
> --- a/Documentation/devicetree/bindings/i2c/samsung,s3c2410-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/samsung,s3c2410-i2c.yaml
> @@ -35,7 +35,7 @@ properties:
>  
>    gpios:
>      description: |
> -      The order of the GPIOs should be the following:: <SDA, SCL>.  The GPIO
> +      The order of the GPIOs should be the following: <SDA, SCL>.  The GPIO
>        specifier depends on the gpio controller. Required in all cases except
>        for "samsung,s3c2440-hdmiphy-i2c" whose input/output lines are
>        permanently wired to the respective client.
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> index ff64225e8281..e002e70580f9 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> @@ -13,7 +13,7 @@ description: |
>    Bandwidth Monitor measures current throughput on buses between various NoC
>    fabrics and provides information when it crosses configured thresholds.
>  
> -  Certain SoCs might have more than one Bandwidth Monitors, for example on SDM845::
> +  Certain SoCs might have more than one Bandwidth Monitors, for example on SDM845:
>     - Measuring the bandwidth between CPUs and Last Level Cache Controller -
>       called just BWMON,
>     - Measuring the bandwidth between Last Level Cache Controller and memory
> diff --git a/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml b/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml
> index 5e26e48c7217..0203959c8995 100644
> --- a/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml
> @@ -23,7 +23,7 @@ description: |
>    The each AXI bus has the owned source clock but, has not the only owned power
>    line. The power line might be shared among one more sub-blocks.  So, we can
>    divide into two type of device as the role of each sub-block.  There are two
> -  type of bus devices as following::
> +  type of bus devices as following:
>     - parent bus device
>     - passive bus device
>  
> @@ -44,8 +44,8 @@ description: |
>    able to support the bus frequency for all Exynos SoCs.
>  
>    Detailed correlation between sub-blocks and power line according
> -  to Exynos SoC::
> -   - In case of Exynos3250, there are two power line as following::
> +  to Exynos SoC:
> +   - In case of Exynos3250, there are two power line as following:
>       VDD_MIF |--- DMC (Dynamic Memory Controller)
>  
>       VDD_INT |--- LEFTBUS (parent device)
> @@ -89,7 +89,7 @@ description: |
>         |L5   |200000 |200000  |400000 |300000 |       ||1000000 |
>         ----------------------------------------------------------
>  
> -   - In case of Exynos4210, there is one power line as following::
> +   - In case of Exynos4210, there is one power line as following:
>       VDD_INT |--- DMC (parent device, Dynamic Memory Controller)
>         |--- LEFTBUS
>         |--- PERIL
> @@ -106,7 +106,7 @@ description: |
>         |--- LCD0
>         |--- LCD1
>  
> -   - In case of Exynos4x12, there are two power line as following::
> +   - In case of Exynos4x12, there are two power line as following:
>       VDD_MIF |--- DMC (Dynamic Memory Controller)
>  
>       VDD_INT |--- LEFTBUS (parent device)
> @@ -124,7 +124,7 @@ description: |
>         |--- LCD0
>         |--- ISP
>  
> -   - In case of Exynos5422, there are two power line as following::
> +   - In case of Exynos5422, there are two power line as following:
>       VDD_MIF |--- DREX 0 (parent device, DRAM EXpress controller)
>               |--- DREX 1
>  
> @@ -143,7 +143,7 @@ description: |
>         |--- FSYS
>         |--- FSYS2
>  
> -   - In case of Exynos5433, there is VDD_INT power line as following::
> +   - In case of Exynos5433, there is VDD_INT power line as following:
>       VDD_INT |--- G2D (parent device)
>         |--- MSCL
>         |--- GSCL
> diff --git a/Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml b/Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml
> index b409b2a8b5c5..5165bfddcd54 100644
> --- a/Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml
> +++ b/Documentation/devicetree/bindings/leds/qcom,pm8058-led.yaml
> @@ -10,10 +10,10 @@ maintainers:
>    - Krzysztof Kozlowski <krzk@kernel.org>
>  
>  description: |
> -  The Qualcomm PM8058 contains an LED block for up to six LEDs:: three normal
> +  The Qualcomm PM8058 contains an LED block for up to six LEDs: three normal
>    LEDs, two "flash" LEDs and one "keypad backlight" LED. The names are quoted
>    because sometimes these LED drivers are used for wildly different things than
> -  flash or keypad backlight:: their names are more of a suggestion than a
> +  flash or keypad backlight: their names are more of a suggestion than a
>    hard-wired usecase.
>  
>    Hardware-wise the different LEDs support slightly different output currents.
> diff --git a/Documentation/devicetree/bindings/leds/skyworks,aat1290.yaml b/Documentation/devicetree/bindings/leds/skyworks,aat1290.yaml
> index a6aaa92dbccd..65576dfdca11 100644
> --- a/Documentation/devicetree/bindings/leds/skyworks,aat1290.yaml
> +++ b/Documentation/devicetree/bindings/leds/skyworks,aat1290.yaml
> @@ -11,7 +11,7 @@ maintainers:
>    - Krzysztof Kozlowski <krzk@kernel.org>
>  
>  description: |
> -  The device is controlled through two pins:: FL_EN and EN_SET. The pins when,
> +  The device is controlled through two pins: FL_EN and EN_SET. The pins when,
>    asserted high, enable flash strobe and movie mode (max 1/2 of flash current)
>    respectively. In order to add a capability of selecting the strobe signal
>    source (e.g. CPU or camera sensor) there is an additional switch required,
> @@ -39,11 +39,11 @@ properties:
>        flash-max-microamp:
>          description: |
>            Maximum flash LED supply current can be calculated using following
> -          formula:: I = 1A * 162 kOhm / Rset.
> +          formula: I = 1A * 162 kOhm / Rset.
>  
>        flash-max-timeout-us:
>          description: |
> -          Maximum flash timeout can be calculated using following formula::
> +          Maximum flash timeout can be calculated using following formula:
>              T = 8.82 * 10^9 * Ct.
>  
>      required:
> diff --git a/Documentation/devicetree/bindings/media/cec/cec-gpio.yaml b/Documentation/devicetree/bindings/media/cec/cec-gpio.yaml
> index 582c6c9cae48..21118e4bae0f 100644
> --- a/Documentation/devicetree/bindings/media/cec/cec-gpio.yaml
> +++ b/Documentation/devicetree/bindings/media/cec/cec-gpio.yaml
> @@ -14,7 +14,7 @@ description: |
>    hooked up to a pull-up GPIO line and - optionally - the HPD line is hooked up
>    to another GPIO line.
>  
> -  Please note:: the maximum voltage for the CEC line is 3.63V, for the HPD and
> +  Please note: the maximum voltage for the CEC line is 3.63V, for the HPD and
>    5V lines it is 5.3V. So you may need some sort of level conversion
>    circuitry when connecting them to a GPIO line.
>  
> diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> index 27c4060f2f91..223fcc9f651f 100644
> --- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> @@ -85,7 +85,7 @@ properties:
>      description: |
>        The value of CIU TX and RX clock phase shift value for HS400 mode
>        operation.
> -      Valid values for SDR and DDR CIU clock timing::
> +      Valid values for SDR and DDR CIU clock timing:
>          - valid value for tx phase shift and rx phase shift is 0 to 7.
>          - when CIU clock divider value is set to 3, all possible 8 phase shift
>            values can be used.
> diff --git a/Documentation/devicetree/bindings/mux/mux-consumer.yaml b/Documentation/devicetree/bindings/mux/mux-consumer.yaml
> index 9e2d78a78e40..769243a2bf04 100644
> --- a/Documentation/devicetree/bindings/mux/mux-consumer.yaml
> +++ b/Documentation/devicetree/bindings/mux/mux-consumer.yaml
> @@ -13,8 +13,8 @@ description: |
>    Mux controller consumers should specify a list of mux controllers that they
>    want to use with a property containing a 'mux-ctrl-list':
>  
> -    mux-ctrl-list ::= <single-mux-ctrl> [mux-ctrl-list]
> -    single-mux-ctrl ::= <mux-ctrl-phandle> [mux-ctrl-specifier]
> +    mux-ctrl-list := <single-mux-ctrl> [mux-ctrl-list]
> +    single-mux-ctrl := <mux-ctrl-phandle> [mux-ctrl-specifier]
>      mux-ctrl-phandle : phandle to mux controller node
>      mux-ctrl-specifier : array of #mux-control-cells specifying the
>                           given mux controller (controller specific)
> diff --git a/Documentation/devicetree/bindings/phy/samsung,mipi-video-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,mipi-video-phy.yaml
> index 16967ef8e9ec..87b6a35b2626 100644
> --- a/Documentation/devicetree/bindings/phy/samsung,mipi-video-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/samsung,mipi-video-phy.yaml
> @@ -13,14 +13,14 @@ maintainers:
>  
>  description: |
>    For samsung,s5pv210-mipi-video-phy compatible PHYs the second cell in the
> -  PHY specifier identifies the PHY and its meaning is as follows::
> +  PHY specifier identifies the PHY and its meaning is as follows:
>      0 - MIPI CSIS 0,
>      1 - MIPI DSIM 0,
>      2 - MIPI CSIS 1,
>      3 - MIPI DSIM 1.
>  
>    samsung,exynos5420-mipi-video-phy and samsung,exynos5433-mipi-video-phy
> -  support additional fifth PHY::
> +  support additional fifth PHY:
>      4 - MIPI CSIS 2.
>  
>  properties:
> diff --git a/Documentation/devicetree/bindings/phy/samsung,usb2-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb2-phy.yaml
> index d9f22a801cbf..7db7605a82e2 100644
> --- a/Documentation/devicetree/bindings/phy/samsung,usb2-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/samsung,usb2-phy.yaml
> @@ -14,7 +14,7 @@ maintainers:
>  description: |
>    The first phandle argument in the PHY specifier identifies the PHY, its
>    meaning is compatible dependent. For the currently supported SoCs (Exynos4210
> -  and Exynos4212) it is as follows::
> +  and Exynos4212) it is as follows:
>      0 - USB device ("device"),
>      1 - USB host ("host"),
>      2 - HSIC0 ("hsic0"),
> diff --git a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
> index 4562e0468f4f..a1b3d9e6a094 100644
> --- a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
> @@ -14,7 +14,7 @@ maintainers:
>  description: |
>    For samsung,exynos5250-usbdrd-phy and samsung,exynos5420-usbdrd-phy
>    compatible PHYs, the second cell in the PHY specifier identifies the
> -  PHY id, which is interpreted as follows::
> +  PHY id, which is interpreted as follows:
>      0 - UTMI+ type phy,
>      1 - PIPE3 type phy.
>  
> diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
> index 7b006009ca0e..5e35686eeed3 100644
> --- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
> @@ -18,7 +18,7 @@ description: |
>    All the pin controller nodes should be represented in the aliases node using
>    the following format 'pinctrl{n}' where n is a unique number for the alias.
>  
> -  The controller supports three types of interrupts::
> +  The controller supports three types of interrupts:
>     - External GPIO interrupts (see interrupts property in pin controller node);
>  
>     - External wake-up interrupts - multiplexed (capable of waking up the system
> diff --git a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
> index 347571e2545a..b67aa170b2c1 100644
> --- a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
> +++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
> @@ -13,7 +13,7 @@ maintainers:
>  description: |
>    The R-Car (RZ/G) System Controller provides power management for the CPU
>    cores and various coprocessors.
> -  The power domain IDs for consumers are defined in header files::
> +  The power domain IDs for consumers are defined in header files:
>    include/dt-bindings/power/r8*-sysc.h
>  
>  properties:
> diff --git a/Documentation/devicetree/bindings/power/reset/restart-handler.yaml b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
> index 965a834a3dbe..00c00ec5ec81 100644
> --- a/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
> +++ b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
> @@ -18,12 +18,12 @@ properties:
>    priority:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: |
> -      A priority ranging from 0 to 255 according to the following guidelines::
> -        0::   Restart handler of last resort, with limited restart capabilities.
> -        128:: Typical, default restart handler; use if no other restart handler
> +      A priority ranging from 0 to 255 according to the following guidelines:
> +        0:   Restart handler of last resort, with limited restart capabilities.
> +        128: Typical, default restart handler; use if no other restart handler
>                is expected to be available, and/or if restart functionality is
>                sufficient to restart the entire system.
> -        255:: Highest priority restart handler, will preempt all other restart handlers.
> +        255: Highest priority restart handler, will preempt all other restart handlers.
>      minimum: 0
>      maximum: 255
>  
> diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
> index b704f05ea454..b886495c1396 100644
> --- a/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
> +++ b/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
> @@ -22,13 +22,13 @@ description: |
>  
>    Certain regulators support "regulator-initial-mode" and "regulator-mode".
>    The valid modes list is defined in the dt-bindings/regulator/maxim,max77802.h
> -  and their meaning is::
> +  and their meaning is:
>      1 - Normal regulator voltage output mode.
>      3 - Low Power which reduces the quiescent current down to only 1uA
>  
>    The standard "regulator-mode" property can only be used for regulators that
>    support changing their mode to Low Power Mode during suspend. These
> -  regulators are:: bucks 2-4 and LDOs 1-35. Also, it only takes effect if the
> +  regulators are: bucks 2-4 and LDOs 1-35. Also, it only takes effect if the
>    regulator has been enabled for the given suspend state using
>    "regulator-on-in-suspend" and has not been disabled for that state using
>    "regulator-off-in-suspend".
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
> index 022c1f197364..b0aa38edf8c2 100644
> --- a/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rtq2208.yaml
> @@ -21,7 +21,7 @@ description: |
>    conduction mode (FCCM).
>  
>    The definition of modes is in the datasheet which is available in below link
> -  and their meaning is::
> +  and their meaning is:
>      0 - Auto mode for power saving, which reducing the switching frequency at light load condition
>      to maintain high frequency.
>      1 - FCCM to meet the strict voltage regulation accuracy, which keeping constant switching frequency.
> diff --git a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml
> index 788ef5c1c446..bc967ead2350 100644
> --- a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml
> +++ b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.yaml
> @@ -17,7 +17,7 @@ description: |
>    software perspective it's mostly compatible with the MSM serial UART except
>    that it supports reading and writing multiple characters at a time.
>  
> -  Note:: Aliases may be defined to ensure the correct ordering of the UARTs.
> +  Note: Aliases may be defined to ensure the correct ordering of the UARTs.
>    The alias serialN will result in the UART being assigned port N.  If any
>    serialN alias exists, then an alias must exist for each enabled UART.  The
>    serialN aliases should be in a .dts file instead of in a .dtsi file.
> diff --git a/Documentation/devicetree/bindings/slimbus/slimbus.yaml b/Documentation/devicetree/bindings/slimbus/slimbus.yaml
> index 5a941610ce4e..3910327c8ded 100644
> --- a/Documentation/devicetree/bindings/slimbus/slimbus.yaml
> +++ b/Documentation/devicetree/bindings/slimbus/slimbus.yaml
> @@ -29,7 +29,7 @@ patternProperties:
>      description: |
>        Every SLIMbus controller node can contain zero or more child nodes
>        representing slave devices on the bus. Every SLIMbus slave device is
> -      uniquely determined by the enumeration address containing 4 fields::
> +      uniquely determined by the enumeration address containing 4 fields:
>        Manufacturer ID, Product code, Device index, and Instance value for the
>        device.
>  
> @@ -48,7 +48,7 @@ patternProperties:
>        reg:
>          maxItems: 1
>          description: |
> -          Pair of (device index, instande ID), where::
> +          Pair of (device index, instande ID), where:
>             - Device index, which uniquely identifies multiple devices within a
>               single component.
>             - Instance ID, can be used for the cases where multiple devices of
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,apr-services.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,apr-services.yaml
> index bdf482db32aa..b663be3ea5a1 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,apr-services.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,apr-services.yaml
> @@ -40,7 +40,7 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/string-array
>      description: |
>        Protection domain service name and path for APR service (if supported).
> -      Possible values are::
> +      Possible values are:
>        "avs/audio", "msm/adsp/audio_pd".
>        "kernel/elf_loader", "msm/modem/wlan_pd".
>        "tms/servreg", "msm/adsp/audio_pd".
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
> index 26d9bc773ec5..1889139a3f7a 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
> @@ -23,7 +23,7 @@ description: |
>    with a few variations that are captured by the properties here.
>  
>    A TCS may be triggered from Linux or triggered by the F/W after all the CPUs
> -  have powered off to facilitate idle power saving. TCS could be classified as::
> +  have powered off to facilitate idle power saving. TCS could be classified as:
>      ACTIVE  - Triggered by Linux
>      SLEEP   - Triggered by F/W
>      WAKE    - Triggered by F/W
> @@ -76,7 +76,7 @@ properties:
>      items:
>        items:
>          - description: |
> -            TCS type::
> +            TCS type:
>               - ACTIVE_TCS
>               - SLEEP_TCS
>               - WAKE_TCS
> @@ -152,7 +152,7 @@ examples:
>    - |
>      // For a TCS whose RSC base address is 0x179C0000 and is at a DRV id of
>      // 2, the register offsets for DRV2 start at 0D00, the register
> -    // calculations are like this::
> +    // calculations are like this:
>      // DRV0: 0x179C0000
>      // DRV2: 0x179C0000 + 0x10000 = 0x179D0000
>      // DRV2: 0x179C0000 + 0x10000 * 2 = 0x179E0000
> @@ -182,7 +182,7 @@ examples:
>    - |
>      // For a TCS whose RSC base address is 0xAF20000 and is at DRV id of 0, the
>      // register offsets for DRV0 start at 01C00, the register calculations are
> -    // like this::
> +    // like this:
>      // DRV0: 0xAF20000
>      // TCS-OFFSET: 0x1C00
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml
> index 4fcae6bedfff..72a7f8cb09ba 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml
> @@ -28,7 +28,7 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description: |
>        Reference to a node specifying the wcnss "ccu" and "dxe" register blocks.
> -      The node must be compatible with one of the following::
> +      The node must be compatible with one of the following:
>             - qcom,riva"
>             - qcom,pronto"
>  
> diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas-soc.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas-soc.yaml
> index 5ddd31f30f26..57c9d3c57021 100644
> --- a/Documentation/devicetree/bindings/soc/renesas/renesas-soc.yaml
> +++ b/Documentation/devicetree/bindings/soc/renesas/renesas-soc.yaml
> @@ -12,10 +12,10 @@ maintainers:
>  
>  description: |
>    Guidelines for new compatibles for SoC blocks/components.
> -  When adding new compatibles in new bindings, use the format::
> +  When adding new compatibles in new bindings, use the format:
>      renesas,SoC-IP
>  
> -  For example::
> +  For example:
>     renesas,r8a77965-csi2
>  
>    When adding new compatibles to existing bindings, use the format in the
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml b/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml
> index 47a105a97ecf..bc8c8ba24f9c 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6asm-dais.yaml
> @@ -45,7 +45,7 @@ patternProperties:
>          $ref: /schemas/types.yaml#/definitions/uint32
>          enum: [0, 1, 2]
>          description: |
> -          The direction of the dai stream::
> +          The direction of the dai stream:
>             - Q6ASM_DAI_TX_RX (0) for both tx and rx
>             - Q6ASM_DAI_TX (1) for only tx (Capture/Encode)
>             - Q6ASM_DAI_RX (2) for only rx (Playback/Decode)
> diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
> index 29a08b0729ee..3f333db72a71 100644
> --- a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.yaml
> @@ -40,7 +40,7 @@ properties:
>      description: |
>        The Exynos TMU supports generating interrupts when reaching given
>        temperature thresholds. Number of supported thermal trip points depends
> -      on the SoC (only first trip points defined in DT will be configured)::
> +      on the SoC (only first trip points defined in DT will be configured):
>         - most of SoC: 4
>         - samsung,exynos5433-tmu: 8
>         - samsung,exynos7-tmu: 8
> @@ -52,7 +52,7 @@ properties:
>        - description: |
>            Shared TMU registers.
>  
> -          Note:: On Exynos5420, the TRIMINFO register is misplaced for TMU
> +          Note: On Exynos5420, the TRIMINFO register is misplaced for TMU
>            channels 2, 3 and 4 Use "samsung,exynos5420-tmu-ext-triminfo" in
>            cases, there is a misplaced register, also provide clock to access
>            that base.
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> index a7f58114c02e..90daee616880 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -92,14 +92,14 @@ properties:
>  
>    clocks:
>      description: |
> -      Several clocks are used, depending on the variant. Typical ones are::
> -       - cfg_noc:: System Config NOC clock.
> -       - core:: Master/Core clock, has to be >= 125 MHz for SS operation and >=
> +      Several clocks are used, depending on the variant. Typical ones are:
> +       - cfg_noc: System Config NOC clock.
> +       - core: Master/Core clock, has to be >= 125 MHz for SS operation and >=
>                  60MHz for HS operation.
> -       - iface:: System bus AXI clock.
> -       - sleep:: Sleep clock, used for wakeup when USB3 core goes into low
> +       - iface: System bus AXI clock.
> +       - sleep: Sleep clock, used for wakeup when USB3 core goes into low
>                   power mode (U3).
> -       - mock_utmi:: Mock utmi clock needed for ITP/SOF generation in host
> +       - mock_utmi: Mock utmi clock needed for ITP/SOF generation in host
>                       mode. Its frequency should be 19.2MHz.
>      minItems: 1
>      maxItems: 9
> diff --git a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
> index 8201656b41ed..d99af9f413d0 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
> @@ -87,14 +87,14 @@ properties:
>  
>    clocks:
>      description: |
> -      Several clocks are used, depending on the variant. Typical ones are::
> -       - cfg_noc:: System Config NOC clock.
> -       - core:: Master/Core clock, has to be >= 125 MHz for SS operation and >=
> +      Several clocks are used, depending on the variant. Typical ones are:
> +       - cfg_noc: System Config NOC clock.
> +       - core: Master/Core clock, has to be >= 125 MHz for SS operation and >=
>                  60MHz for HS operation.
> -       - iface:: System bus AXI clock.
> -       - sleep:: Sleep clock, used for wakeup when USB3 core goes into low
> +       - iface: System bus AXI clock.
> +       - sleep: Sleep clock, used for wakeup when USB3 core goes into low
>                   power mode (U3).
> -       - mock_utmi:: Mock utmi clock needed for ITP/SOF generation in host
> +       - mock_utmi: Mock utmi clock needed for ITP/SOF generation in host
>                       mode. Its frequency should be 19.2MHz.
>      minItems: 1
>      maxItems: 9
> -- 
> 2.53.0
> 

-- 
Kind Regards,
Niklas Söderlund
