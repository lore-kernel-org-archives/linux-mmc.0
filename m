Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B114C433EF
	for <linux-mmc@archiver.kernel.org>; Sun,  3 Jul 2022 23:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiGCXJJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 3 Jul 2022 19:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiGCXJI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Jul 2022 19:09:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DEC2AD3
        for <linux-mmc@vger.kernel.org>; Sun,  3 Jul 2022 16:09:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id cl1so11026067wrb.4
        for <linux-mmc@vger.kernel.org>; Sun, 03 Jul 2022 16:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYkFjGhU57DIzMeerOpUZbWcAqQ0kLDWHxaSYSuF4tU=;
        b=K/YblOz7W4sldc4jTWM2nFjvromJ2JaPqsNCavhFMaaAnBR530NedeLhKQXy3p/LKW
         8flQiM8s5IRTXHq3gs71kAsL1Ta/IyxWqgf7nylGAD8aXNeXIkieU0Meou9vCkfWLqK8
         t3OhoEwNPvc2UerI0r2h0fAOXqUQRh7Vn3XH1mjTJuuzUHvfRwsa7qXg0GeKepdJdA/t
         IJnlIPhJQ5OQ3YNxMe+XuG+h9mrW1ApKKI6KG76xptbByA2+SIZunwcbS4rskbiuSYO0
         1tdLrCYfJ+rJZypOKTnf3djTjGvkw/11FObzDC6olUVkYCh5sns3iuGcON/NAy8XQmjb
         e3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYkFjGhU57DIzMeerOpUZbWcAqQ0kLDWHxaSYSuF4tU=;
        b=0hMruY/1JVioVfVqR8GaqbXF1zfJ/T0hgdbSeIvZxmpWosu1fLRbrylSQv3t8ccho6
         wWdN4hYxmLpBhZ3TBLke8TnP5VDuEZgbesflRvg0BFGE3RJinsjM/akmWXUvz65ZYxXs
         3lYmtbZdeDItdqPw92JMXOGKTYn6Vx0QJpQ2n579z4AJg1L7WzdB8LyAMYelTmurffd9
         qct7EYvTvC4z4LTHphPmCoZNaMTLLHsuYY4/EN9ELG1RLQyddCmNObdoLQqQcR6evYfu
         /XhXtlJ4U0EzYOQYjVZFf77W7Emeu6/P6YMR/L0XkUJvPoUPJg60Df1RdUUjl3PSisu5
         K5bw==
X-Gm-Message-State: AJIora8FSjmuIuJjT+5pNY0K/zpOjj9V6VKFUgaBkn3JJaYQWELgCM5I
        Au1xpjUELX9NODOmvLMHDE6pJBNiJ14jVRXPdL7W4w==
X-Google-Smtp-Source: AGRyM1v3yDcM9EqrgyJfntIxPlZpqlSO0dzROF5IVr32eY016O3FEzWA0ZNwodqlYylmilwgKijofUYXzrI3Psdt5J8=
X-Received: by 2002:a05:6000:192:b0:21a:3c91:df05 with SMTP id
 p18-20020a056000019200b0021a3c91df05mr25268858wrx.655.1656889744572; Sun, 03
 Jul 2022 16:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-3-brad@pensando.io>
 <20220614212215.GA2627610-robh@kernel.org>
In-Reply-To: <20220614212215.GA2627610-robh@kernel.org>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 16:08:53 -0700
Message-ID: <CAK9rFnyH1aNSnSRZkRt_F1sh8Wy+3c-VLgB=z3Zjdpweq0FoSw@mail.gmail.com>
Subject: Re: [PATCH v5 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba
 SoC binding
To:     Rob Herring <robh@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, blarson@amd.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gabriel Somlo <gsomlo@gmail.com>, gerg@linux-m68k.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Rob,

On Tue, Jun 14, 2022 at 2:22 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jun 13, 2022 at 12:56:45PM -0700, Brad Larson wrote:
> > From: Brad Larson <blarson@amd.com>
> >
> > AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
> > explicitly controls byte-lane enables.
> >
> > Signed-off-by: Brad Larson <blarson@amd.com>
> > ---
> >  .../devicetree/bindings/mmc/cdns,sdhci.yaml        | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > index 4207fed62dfe..35bc4cf6f214 100644
> > --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> > @@ -13,10 +13,24 @@ maintainers:
> >  allOf:
> >    - $ref: mmc-controller.yaml
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          enum:
> > +            - amd,pensando-elba-sd4hc
> > +    then:
> > +      properties:
> > +        reg:
> > +          items:
> > +            - description: Cadence host controller registers
> > +            - description: Byte-lane control register
> > +          minItems: 2
>
> This doesn't work. The if/then is additional constraints on the main
> section which says there is only 1 register region. The main section
> needs the above, but with 'minItems: 1'. Then the if/then should be:
>
> if:
>   properties:
>     compatible:
>       const: amd,pensando-elba-sd4hc
> then:
>   properties:
>     reg:
>       minItems: 2
> else:
>   properties:
>     reg:
>       maxItems: 1
> ...

The proposed change to current version throws dtbs_check error below:

--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -13,19 +13,6 @@ maintainers:
 allOf:
   - $ref: mmc-controller.yaml

-  - if:
-      properties:
-        compatible:
-          enum:
-            - amd,pensando-elba-sd4hc
-    then:
-      properties:
-        reg:
-          items:
-            - description: Cadence host controller registers
-            - description: Byte-lane control register
-          minItems: 2
-
 properties:
   compatible:
     items:
@@ -36,7 +23,7 @@ properties:
       - const: cdns,sd4hc

   reg:
-    maxItems: 1
+    minItems: 1

   interrupts:
     maxItems: 1
@@ -132,6 +119,19 @@ required:
   - interrupts
   - clocks

+if:
+  properties:
+    compatible:
+      const: amd,pensando-elba-sd4hc
+then:
+  properties:
+    reg:
+      minItems: 2
+else:
+  properties:
+    reg:
+      maxItems: 1
+
 unevaluatedProperties: false

results in

$ make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/home/brad/linux-next/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml:
ignoring, error in schema:
/home/brad/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml:
ignoring, error in schema:
  DTC     arch/arm64/boot/dts/amd/elba-asic.dtb
  CHECK   arch/arm64/boot/dts/amd/elba-asic.dtb
/home/brad/linux-next/arch/arm64/boot/dts/amd/elba-asic.dtb:
mmc@30440000: reg: [[0, 809762816, 0, 65536], [0, 810025028, 0, 4]] is
too long
        From schema:
/home/brad/linux-next/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
/home/brad/linux-next/arch/arm64/boot/dts/amd/elba-asic.dtb:
mmc@30440000: reg: [[0, 809762816, 0, 65536], [0, 810025028, 0, 4]] is
too long
        From schema:
/home/brad/linux-next/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml

Below modification to proposed change passes dtbs_check:

--- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -13,19 +13,6 @@ maintainers:
 allOf:
   - $ref: mmc-controller.yaml

-  - if:
-      properties:
-        compatible:
-          enum:
-            - amd,pensando-elba-sd4hc
-    then:
-      properties:
-        reg:
-          items:
-            - description: Cadence host controller registers
-            - description: Byte-lane control register
-          minItems: 2
-
 properties:
   compatible:
     items:
@@ -36,7 +23,8 @@ properties:
       - const: cdns,sd4hc

   reg:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2

   interrupts:
     maxItems: 1
@@ -132,6 +120,15 @@ required:
   - interrupts
   - clocks

+if:
+  properties:
+    compatible:
+      const: amd,pensando-elba-sd4hc
+then:
+  properties:
+    reg:
+      minItems: 2
+
 unevaluatedProperties: false

Regards,
Brad
