Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282CCC7EE31
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Feb 2023 15:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjB1PAh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Feb 2023 10:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjB1PAg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Feb 2023 10:00:36 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E38A22020
        for <linux-mmc@vger.kernel.org>; Tue, 28 Feb 2023 06:59:56 -0800 (PST)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A867C3F468
        for <linux-mmc@vger.kernel.org>; Tue, 28 Feb 2023 14:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677596393;
        bh=sR9+TU4QdZ6QdtGKERfD8tPs5IwyEG556JdFrx7slTk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=pZlgK4PpQoIMDfeVGxlXnb/dNYwbQNKsipiy71/OPBtWtJzWsKLgSf+NxrJjVJXGJ
         pDPNtBTHR2kVDSDDN65ZA7deTtJf1gCSbQZzVFLS7ei+mF+33vpc7cJ8YvL+jUxUNe
         2fYJTuu+BA0fYDcetZ6t+qkwjj6QgkgUASvNK0Z+SaRVYDIK6H4pX9AbeUqtRKLIuA
         bvKOltpfxGSN76GPvOVyfE6tBujtys/DdQIN5tJfvha4JSCf2+csneDhQi+RJJTGTp
         ZFmIvN7N98DF/sgkGlFOFXumiXZ3tAMLXzfHSvyu8C4PqxlH0h2nXAC7A1DeXdRvEb
         +QlWfIEVOufTw==
Received: by mail-qt1-f198.google.com with SMTP id g11-20020ac8774b000000b003bfa92f56cbso4713967qtu.3
        for <linux-mmc@vger.kernel.org>; Tue, 28 Feb 2023 06:59:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sR9+TU4QdZ6QdtGKERfD8tPs5IwyEG556JdFrx7slTk=;
        b=5s03g9ezovJTOW3YWLX3g2f/MYZfV6NR8cWCitIP8EyRvYXTwEc0s6l1kT2gUN5rYY
         lqhTniinITsZzuTR7qrKO6kCkpM7i32xr5CJ9fejGeZXbf8KgnlYfEEIJEovCTWXRkKb
         3qbaVovXvxkBUAoVnCpRHOX1Mp2j2I25eRNAo1iTgrQi9dIxoqdWsxf5prpq7YYWNgRE
         CTNAuIbdqopEnCNk4tG7Rjdhen4EoBQWExQsUXxIAr5UptljrWDGw40bvL8olE2Jpyo6
         BWDqmizEKk11Hr+C/b0jTy6Hq25RZMRyyX0jqauT31vkMyiIez7fi1zj4P7RbbdCY36P
         lbaA==
X-Gm-Message-State: AO0yUKUOv9ZSkWRbJPEpyEdRVAiG7xb3eycE6lkSnrGfq7rDG3zuCgFE
        GTr6+k6C0U0TpH9BK/8u1+tPfJICyrr72UpeWe8ud3V2lonHeAOp41eGiGF+w4V6vvPtedjKdUN
        sUnQZfjLV9Dre6hRq7mmOj+gxKKR9bYK2YD4GnK+0s/PKVtGgrJwBtQ==
X-Received: by 2002:a05:6214:1907:b0:56e:fbea:9e9a with SMTP id er7-20020a056214190700b0056efbea9e9amr883157qvb.0.1677596392455;
        Tue, 28 Feb 2023 06:59:52 -0800 (PST)
X-Google-Smtp-Source: AK7set98OeQlNbOvVCz2xGtQT7yvm5Bp1FcodjBI6u1K21A/NvB5+qKnCOMGlj1gPexULiX05yQ8xWlgU7ItfF52m8w=
X-Received: by 2002:a05:6214:1907:b0:56e:fbea:9e9a with SMTP id
 er7-20020a056214190700b0056efbea9e9amr883147qvb.0.1677596392033; Tue, 28 Feb
 2023 06:59:52 -0800 (PST)
MIME-Version: 1.0
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-5-william.qiu@starfivetech.com> <20230220234335.GA615198-robh@kernel.org>
 <348796cc-72d9-4dcf-9f09-4c2aa55cb858@starfivetech.com> <20230227222904.GC1048218-robh@kernel.org>
 <f8d2b665-ce5d-81f8-8c55-81f1a4cb62b9@starfivetech.com> <54f51fa0-7821-b67b-b782-eb9a35b7bba9@linaro.org>
 <CAJM55Z85fitjBOcCLqad9W-a7h3iN9bxtctVGzPgqCbf5fWobw@mail.gmail.com> <a0168d89-3c30-55e1-cf4c-37f7fe90aae4@linaro.org>
In-Reply-To: <a0168d89-3c30-55e1-cf4c-37f7fe90aae4@linaro.org>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Tue, 28 Feb 2023 15:59:25 +0100
Message-ID: <CAJM55Z8dR4TDJNeO-qiS9CurfCWM1ccNigOA1fDb7S1VKCxv2Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] dt-bindings: syscon: Add StarFive syscon doc
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     William Qiu <william.qiu@starfivetech.com>,
        Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 28 Feb 2023 at 12:28, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 28/02/2023 12:02, Emil Renner Berthing wrote:
> > On Tue, 28 Feb 2023 at 11:40, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 28/02/2023 10:05, William Qiu wrote:
> >>>
> >>>
> >>> On 2023/2/28 6:29, Rob Herring wrote:
> >>>> On Tue, Feb 21, 2023 at 10:44:02AM +0800, William Qiu wrote:
> >>>>>
> >>>>>
> >>>>> On 2023/2/21 7:43, Rob Herring wrote:
> >>>>>> On Wed, Feb 15, 2023 at 07:32:49PM +0800, William Qiu wrote:
> >>>>>>> Add documentation to describe StarFive System Controller Registers.
> >>>>>>>
> >>>>>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> >>>>>>> ---
> >>>>>>>  .../bindings/soc/starfive/jh7110-syscon.yaml  | 51 +++++++++++++++++++
> >>>>>>>  MAINTAINERS                                   |  5 ++
> >>>>>>>  2 files changed, 56 insertions(+)
> >>>>>>>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
> >>>>>>>
> >>>>>>> diff --git a/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
> >>>>>>> new file mode 100644
> >>>>>>> index 000000000000..fa4d8522a454
> >>>>>>> --- /dev/null
> >>>>>>> +++ b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
> >>>>>>> @@ -0,0 +1,51 @@
> >>>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>>>>>> +%YAML 1.2
> >>>>>>> +---
> >>>>>>> +$id: http://devicetree.org/schemas/soc/starfive/jh7110-syscon.yaml#
> >>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>>>> +
> >>>>>>> +title: StarFive JH7110 SoC system controller
> >>>>>>> +
> >>>>>>> +maintainers:
> >>>>>>> +  - William Qiu <william.qiu@starfivetech.com>
> >>>>>>> +
> >>>>>>> +description: |
> >>>>>>> +  The StarFive JH7110 SoC system controller provides register information such
> >>>>>>> +  as offset, mask and shift to configure related modules such as MMC and PCIe.
> >>>>>>> +
> >>>>>>> +properties:
> >>>>>>> +  compatible:
> >>>>>>> +    items:
> >>>>>>> +      - enum:
> >>>>>>> +          - starfive,jh7110-stg-syscon
> >>>>>>> +          - starfive,jh7110-sys-syscon
> >>>>>>> +          - starfive,jh7110-aon-syscon
> >>>>>>
> >>>>>> Is 'syscon' really part of what the blocks are called? Is just 'stg',
> >>>>>> 'sys' and 'aon' not unique enough?
> >>>>>>
> >>>>>> Rob
> >>>>> Hi Rob,
> >>>>>
> >>>>> In StarFive SoC, we do have syscrg/aoncrg/stgcrg, which is uesd to be the clock
> >>>>> controller, so 'syscon' is added to avoid confusion.
> >>>>
> >>>> You've only added to my confusion. 'syscrg' and 'sys-syscon' are 2
> >>>> different h/w blocks and unrelated to each other? Or 'syscrg' is the
> >>>> clock portion of 'sys-syscon'? In that case, 'syscrg' should be a child
> >>>> of 'sys-syscon' or possibly just all one node. Please provide details on
> >>>> the entire h/w block so we can provide better input on the bindings.
> >>>>
> >>>> Rob
> >>>
> >>> Hi Rob,
> >>>
> >>> It's my description that's problematic.'syscon' here refers to the hardware module
> >>> inside our JH7110, which is different from the syscon interface in linux. The syscon
> >>> I added now uses the syscon interface of linux to read and write the syscon register
> >>> in our JH7110. So we decided to name it that way.
> >>
> >> You didn't really answer Rob's questions.
> >>
> >> Also, syscon is Linux term, so are you sure hardware module is called
> >> like this? Hardware engineers took pure Linux name and used it?
> >
> > Yes, from the documentation I could find[1] there are CRG blocks
> > (Clock and Reset Generator) and SYSCON blocks:
> > SYS CRG
> > STG CRG
> > AON CRG
> > SYS SYSCON
> > STG SYSCON
> > AON SYSCON
> >
> > The CRG blocks contain registers to control clocks and resets that
> > follow a pattern used by the clock and reset drivers. The SYSCON
> > blocks just seem to contain registers to control whatever didn't fit
> > in any other blocks, but might be vaguely related to the peripherals
> > that run off clocks controlled by the corresponding CRG block.
>
> The memory map [1] suggests these are indeed separate address spaces,
> e.g. AON CRG, AON SYSCON and AON GPIO, but now I would argue that this
> might be still one device - AON (or STG, SYS). Just like PCIE0 has four
> address spaces, it does not mean you have four separate PCIE0 devices.
> You have only one PCIE0, just like you have only one AON, one STG and
> one SYS (System).

I see what you mean, but if you look into what the registers in the
SYSCON blocks actually do it's not clear to me that they should be
grouped with the clocks/resets any more than say the pinctrl/GPIO
node. Maybe it's my fault for not giving you the full picture. Eg. for
"system" and "always-on" there are blocks:

SYS CRG
SYS SYSCON
SYS IOMUX
AON CRG
AON SYSCON
AON IOMUX

..and it really don't see why eg. SYS CRG and SYS SYSCON should be
thought of as one device, but not include SYS IOMUX then.

As an examly the SYS SYSCON includes registers to control:
- remapping of different peripherals from SD controller to video encoders
- voltage select for certain GPIO pins
- phy interface selection for ethernet and CAN
- QuadSPI delay chain and SRAM configuration
- PLL configuration
- endian selection for the SD controller

To me this is pretty much exactly described by the syscon device tree binding:
"System controller node represents a register region containing a set
of miscellaneous registers. The registers are not cohesive enough to
represent as any specific type of device. [..]"
In any case it's clear that however the SYSCON blocks are represented
in the device tree, a driver for it would need to export registers in
the SYSCON block for other drivers to use.

/Emil



> [1] https://doc-en.rvspace.org/JH7110/TRM/JH7110_TRM/system_memory_map.html
>
>
> Best regards,
> Krzysztof
>
