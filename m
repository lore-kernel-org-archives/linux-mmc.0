Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5538CC41513
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Aug 2023 22:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346885AbjHPW0d (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Aug 2023 18:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346899AbjHPW0S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Aug 2023 18:26:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ADDE56
        for <linux-mmc@vger.kernel.org>; Wed, 16 Aug 2023 15:26:15 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc0d39b52cso45455385ad.2
        for <linux-mmc@vger.kernel.org>; Wed, 16 Aug 2023 15:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692224774; x=1692829574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u7uQIIcrOFzc49aqvUkRDZzFxEz4KqT+ICR1+8quc8w=;
        b=nLsRg3gBX8FVyACCctF8pWA6iGOG69Klww5ee5m0rSCjDQ1YLbML1J9hVFaaA/yc9K
         gN9B0kRZxzGXG+oIrQ5rA1nGd7nw9fPduPa7qWfDgaCOjGkrRtjnoY0zWtWMnjO5OfuE
         wrITOm5wFbE09oL+nq29oWN/YMWC9K8uX2wnG/v4lufrI7J/4fdhx5rHfVfy0+MIfrBV
         kYdgPBB6pyhLfrZsrgkO4wFXcLZKDIrfwa9UeGzJjd1FiwQ78IfmcX0smW7FoLFVRma8
         47XJ32lOwHSSKwLlIyrf46dCG7xiLL4bl1FLaFz8N8GyW6pXusCNIP6nrAt+1g8yoJm7
         2OHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692224774; x=1692829574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7uQIIcrOFzc49aqvUkRDZzFxEz4KqT+ICR1+8quc8w=;
        b=mB+Ng2tviPqJhkx2f8p4zTNAOuxcLE/34WIzX51y8QWQSxdWAQMPcghXqjtZxp46o5
         PhSlIktEIC2Xy59bAQcatrtou9eTKNMQhAfZXXyfGJnojyPWoIlhQzE/4jag2oAP0cN0
         7fbcTFQLTZ7qzJcbb/ZciPzhWz1cIKBPnbSjtwHc2bJNe2LlE2sJ9LTKypMvTbKLIqJW
         uM9D4jApBv704Jk5D32BmQvAfLNAzN+Vazuy60uVm1kT5CEHniAQ+IfieePAWdCnE8NH
         tcqHrV5z/QkpIiW89/8rzaF9HfV2tegm94m8GOrpK8dQwUgJETzJTGFp6mKzC2jotHCx
         y7Bg==
X-Gm-Message-State: AOJu0YwUaZPQqLhEawzQ+6aHdQc5Bq+o5bpuK57PYYHhlyPwDGcdwfgU
        xPnCeOaYjVUqk7bjPieVO+KgJw==
X-Google-Smtp-Source: AGHT+IGkgRJCXIVVufTd3KRR6mXCo4jmAJTUdqHRVFHuFCpLRjBwYq8DpHYyhSTWPV9UPPmJYCZB9w==
X-Received: by 2002:a17:902:d2c7:b0:1b2:5d5b:e871 with SMTP id n7-20020a170902d2c700b001b25d5be871mr3674598plc.59.1692224774508;
        Wed, 16 Aug 2023 15:26:14 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:ad77:24cb:c068:c5e6])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001bdcd4b1616sm8966890plg.260.2023.08.16.15.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 15:26:14 -0700 (PDT)
Date:   Wed, 16 Aug 2023 15:26:12 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>
Subject: Re: [PATCH RFC v2 1/4] dt-bindings: mmc: sdhci-of-dwcmhsc: Add
 T-Head TH1520 support
Message-ID: <ZN1NBE2+HHfatQ/T@x1>
References: <20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com>
 <20230724-th1520-emmc-v2-1-132ed2e2171e@baylibre.com>
 <ca0b9a19-d7d7-80e5-f47e-f74615cdac86@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca0b9a19-d7d7-80e5-f47e-f74615cdac86@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Aug 07, 2023 at 08:29:21AM +0200, Krzysztof Kozlowski wrote:
> On 05/08/2023 05:14, Drew Fustini wrote:
> > Add compatible value for the T-Head TH1520 dwcmshc controller and
> > thead,io-fixed-1v8 and thead,pull-up properties.
> > 
> > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > index a43eb837f8da..57602c345cab 100644
> > --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > @@ -19,6 +19,7 @@ properties:
> >        - rockchip,rk3568-dwcmshc
> >        - rockchip,rk3588-dwcmshc
> >        - snps,dwcmshc-sdhci
> > +      - thead,th1520-dwcmshc
> >  
> >    reg:
> >      maxItems: 1
> > @@ -60,6 +61,14 @@ properties:
> >      description: Specify the number of delay for tx sampling.
> >      $ref: /schemas/types.yaml#/definitions/uint8
> >  
> > +  thead,io-fixed-1v8:
> > +    description: SoC PHY pad is fixed 1.8V
> > +    type: boolean
> 
> Isn't this duplicating existing properties for MMC modes with 1.8 V?

Thank you for reviewing. Yes, now that you mention it, I do see those
properties now in mmc-controller.yaml. It seems like the existing
mmc-ddr-1_8v property would be appropriate.

> 
> > +
> > +  thead,pull-up:
> > +    description: True if pull-up, false if pull-down
> 
> This explains me nothing. No clue what you are pulling and why do you
> need it. Pin pulls should be done via pin controller, not MMC.

Good point that my description is not helpful. The pull-up property
determines whether certain phy registers are written to. I need to try
to can get documentation on the phy so that I can better understand the
details of the pull-up configuration in the phy registers.

> 
> Anyway you should have here allOf:if:then (move the allOf: from top to
> behind "required:") which will disallow these properties for other variants.

I noticed that nvidia,tegra20-sdhci.yaml has several lines related to
pull-up/down configuration:

218   - if:
219       properties:
220         compatible:
221           contains:
222             const: nvidia,tegra210-sdhci
223     then:
224       properties:
225         pinctrl-names:
226           oneOf:
227             - items:
228                 - const: sdmmc-3v3
229                   description: pad configuration for 3.3 V
230                 - const: sdmmc-1v8
231                   description: pad configuration for 1.8 V
232                 - const: sdmmc-3v3-drv
233                   description: pull-up/down configuration for 3.3 V
234                 - const: sdmmc-1v8-drv
235                   description: pull-up/down configuration for 1.8 V
236             - items:
237                 - const: sdmmc-3v3-drv
238                   description: pull-up/down configuration for 3.3 V
239                 - const: sdmmc-1v8-drv
240                   description: pull-up/down configuration for 1.8 V
241             - items:
242                 - const: sdmmc-1v8-drv
243                   description: pull-up/down configuration for 1.8 V

Do you think creating something like that would be a good approach?

Thank you,
Drew
