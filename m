Return-Path: <SRS0=6IoW=5D=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE12C5ACD6
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Mar 2020 11:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CAB52076D
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Mar 2020 11:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ULz4sod6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgCRLIp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:08:45 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34320 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgCRLIp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Mar 2020 07:08:45 -0400
Received: by mail-vs1-f65.google.com with SMTP id t10so16143530vsp.1
        for <linux-mmc@vger.kernel.org>; Wed, 18 Mar 2020 04:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9frSoSYLFCu0A/Mh7LPuKatr2O8xik/d01v55VOnyP4=;
        b=ULz4sod6I+eklVNwP7hqM50Hd4vBJUS+Bpu5i+ryBoBCsPblh/ogw7XkFNmBbag3pM
         H9UCyEd7er7GDNZk9U2VHBwy9SBc3G3Qo09kpO4/1Qzy4FGeu7WeyJcgSVbZYe1mCliZ
         qHCXZKSOjuaq2zWNzBvcKuDAahQPSbz+Iacq5FcZD4T9xJgukS2Kk7IZe9Qp6ABIVa2A
         +yc+0sidH02WbhvVA/Qp0EP184GW+NhZVCbdXXtnHtbEtw0bp4MiHoL7WLU0JtiVH+YV
         +gcPxMhrL7qpZR/Kte1KBosjvuB2bpid4B7DY2r+I0Atb8lhNn3E3VLqSo3alkh2sBDA
         4j4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9frSoSYLFCu0A/Mh7LPuKatr2O8xik/d01v55VOnyP4=;
        b=DMwqSMOlyfz/slFOH35uZdS7HqhhTheyxml/7QN/0hT0md95swXI8MRC+3s6t7bjZC
         DCFoTmZ3OQQIPE5FAYZaIHwB46IZTvq6bf+nM9nb7bidmgHyu+sv8oaHFFEZho9eZi0t
         samMN6gmQv2U5CHCe6+Zg3KFbaPwAw7pmD/xX7gO+BbhmWJiwqhAh4M6efIvA4Bp/bAN
         Wt3lrIEgT56jDhv5V6bNQ4myqDOL10yXq2ir8wuVlsiXQHSXs9gt1sx5tjHuKTgItOuR
         6mFqEjjRXtMnFR0114lKrdIifnoSBj30apYF1LaAl16px+KZmLC0W3t/Z9oHT+ru6yY/
         e4/w==
X-Gm-Message-State: ANhLgQ2/0zVNfmZzF8YNHDgizGoMnTKkGIjaQ51C+ZDBbmZkgriMRcU0
        HR7ff0iPfcl0DykpYyUmpOM1z/thMiUsdolZaacWNg==
X-Google-Smtp-Source: ADFU+vu2FC4mlTKSIEnZM8U/cxLci0q+mKGTSglQiVCEp3b3EISiorDyV2HOqWCmtAvl8B9z9jqXDCDKTBu1B75xgwU=
X-Received: by 2002:a67:646:: with SMTP id 67mr2511025vsg.34.1584529724216;
 Wed, 18 Mar 2020 04:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200316091324.15968-1-wan.ahmad.zainie.wan.mohamad@intel.com> <20200316091324.15968-2-wan.ahmad.zainie.wan.mohamad@intel.com>
In-Reply-To: <20200316091324.15968-2-wan.ahmad.zainie.wan.mohamad@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Mar 2020 12:08:08 +0100
Message-ID: <CAPDyKFqpeCXqbMZi7cffKEQ1=2xZnUT4Jpi85Fqyfk2eaTU1gQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: arasan: Add compatible strings for
 Intel Keem Bay
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Mar 2020 at 10:13, Wan Ahmad Zainie
<wan.ahmad.zainie.wan.mohamad@intel.com> wrote:
>
> Add new compatible strings in sdhci-of-arasan.c to support Intel Keem Bay
> eMMC/SD/SDIO controller, based on Arasan SDHCI 5.1.
>
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt  | 39 +++++++++++++++++++

We are starting to reach a point were I want to see people converting
bindings into the yaml format, rather than extending the existing text
based ones.

Can you please have a look at the sdhci common bindings and the sdhci
arasan variant, that would be a good start.

Kind regards
Uffe

>  1 file changed, 39 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 428685eb2ded..50f9cc0eff2a 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -24,6 +24,10 @@ Required Properties:
>        For this device it is strongly suggested to include arasan,soc-ctl-syscon.
>      - "intel,lgm-sdhci-5.1-sdxc", "arasan,sdhci-5.1": Intel LGM SDXC PHY
>        For this device it is strongly suggested to include arasan,soc-ctl-syscon.
> +    - "intel,keembay-sdhci-5.1-emmc", "arasan,sdhci-5.1": Keem Bay eMMC PHY
> +      For this device it is strongly suggested to include arasan,soc-ctl-syscon.
> +    - "intel,keembay-sdhci-5.1-sd": Keem Bay SD controller
> +    - "intel,keembay-sdhci-5.1-sdio": Keem Bay SDIO controller
>
>    [5] Documentation/devicetree/bindings/mmc/sdhci-am654.txt
>
> @@ -133,3 +137,38 @@ Example:
>                 phy-names = "phy_arasan";
>                 arasan,soc-ctl-syscon = <&sysconf>;
>         };
> +
> +       mmc: mmc@33000000 {
> +               compatible = "intel,keembay-sdhci-5.1-emmc", "arasan,sdhci-5.1";
> +               interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> +               reg = <0x0 0x33000000 0x0 0x300>;
> +               clock-names = "clk_xin", "clk_ahb";
> +               clocks = <&scmi_clk KEEM_BAY_PSS_AUX_EMMC>,
> +                        <&scmi_clk KEEM_BAY_PSS_EMMC>;
> +               phys = <&emmc_phy>;
> +               phy-names = "phy_arasan";
> +               assigned-clocks = <&scmi_clk KEEM_BAY_PSS_AUX_EMMC>;
> +               clock-output-names = "emmc_cardclock";
> +               #clock-cells = <0>;
> +               arasan,soc-ctl-syscon = <&mmc_phy_syscon>;
> +       };
> +
> +       sd0: sdhci@31000000 {
> +               compatible = "intel,keembay-sdhci-5.1-sd";
> +               interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +               reg = <0x0 0x31000000 0x0 0x300>;
> +               clock-names = "clk_xin", "clk_ahb";
> +               clocks = <&scmi_clk KEEM_BAY_PSS_AUX_SD0>,
> +                        <&scmi_clk KEEM_BAY_PSS_SD0>;
> +               arasan,soc-ctl-syscon = <&sd0_phy_syscon>;
> +       };
> +
> +       sd1: sdhci@32000000 {
> +               compatible = "intel,keembay-sdhci-5.1-sdio";
> +               interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> +               reg = <0x0 0x32000000 0x0 0x300>;
> +               clock-names = "clk_xin", "clk_ahb";
> +               clocks = <&scmi_clk KEEM_BAY_PSS_AUX_SD1>,
> +                        <&scmi_clk KEEM_BAY_PSS_SD1>;
> +               arasan,soc-ctl-syscon = <&sd1_phy_syscon>;
> +       };
> --
> 2.17.1
>
