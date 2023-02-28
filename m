Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54695C7EE2E
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Feb 2023 11:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjB1LDD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Feb 2023 06:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjB1LDC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Feb 2023 06:03:02 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E2528D0C
        for <linux-mmc@vger.kernel.org>; Tue, 28 Feb 2023 03:02:41 -0800 (PST)
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7FFB43F468
        for <linux-mmc@vger.kernel.org>; Tue, 28 Feb 2023 11:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677582160;
        bh=whVHBfeNmd48/Mtd8KK1rHa96pedE0BT/IGoZMz9JD4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=WZ1ruGWMNQy8M99yrTIIGLqzGwPx3c6TSwpDDzYiWXEalhI+rOoOTACF3gNs6fM06
         J/hCQjFvPDn5RmKg1wmyB9Y+j9QEtQlubzBcLX/vOK8gIu6NQr9/I3d0R08bD6UrLE
         dUwpRLWiXKoQnxGBcdctDDLbJXKUUHvEEIWCQ/mVlyqMsC/YOi344iPvCA80sfMObp
         8BrqDtRThGeYW9Gf6GI1ziV8+X1k//P9sJSSatvGvl1rfDVKcYTi2qJU1DHw3S0SDn
         agkFrDa8XuXCebI5s6uV/GGNYKVVlK/KWyD4H2/wW4xRy09M9BZeyY/1rB3f2G8+l3
         zAD9psFkwqFag==
Received: by mail-qv1-f72.google.com with SMTP id pz4-20020ad45504000000b0056f060452adso4882323qvb.6
        for <linux-mmc@vger.kernel.org>; Tue, 28 Feb 2023 03:02:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whVHBfeNmd48/Mtd8KK1rHa96pedE0BT/IGoZMz9JD4=;
        b=0Pf0XalCVsDo5FBCIozlsm7Fh8PfEsAnJiVje7ppfr0V2tNojpMmuOHsQtnuZG0a+o
         iPkLc5iRU/RB6osaxUKZQvZINUEqGoNlkgMtCQXWarGht1wip4PhzRFRksMroyTE0nOi
         VOcITWjkvMP3shSjWR5dVKAQ5FwFUcELeKtFLdZxb5sct5eV/4nHIoXxjTiuv3wgRPiK
         YQWIqZG4ljMUOW/+0vCxsH6sEWDXGfyXhMihpnKdMoFfs68ymlJgNDgwrnWya30S8S49
         4AhO+ZDjIb6eAMVs48j8936YuGIyuCxLFJH6xZgcvwEcodlZaidnAW2RhN0ZU/RSK/nD
         EE4Q==
X-Gm-Message-State: AO0yUKWSaYcNRKSCNw19uNMxbCEAMDbDMNmod5HHa7ARq7egL2XyMBlc
        Hf1ng1/gpfpkq47KYAQakVaJX1NiRq8EYX5eRMxzSk/u11IYLk4PjAnjl2sp1r4Zq7h8lLDsKZg
        +IKVvekqSCopm8GSEooP5vBM0FozIPLlzJSjcv3KzKXDRMH1Mcap8mg==
X-Received: by 2002:ac8:56e8:0:b0:3bd:1fb6:c67a with SMTP id 8-20020ac856e8000000b003bd1fb6c67amr553383qtu.3.1677582159403;
        Tue, 28 Feb 2023 03:02:39 -0800 (PST)
X-Google-Smtp-Source: AK7set8FR64yuzbIcs6D/WmwZMDZz31/kKp6+pin5PnwYtz+dLmWYPMDS6NzC6y0YpP+iqeWB1QMFW3KNM1UQsJutms=
X-Received: by 2002:ac8:56e8:0:b0:3bd:1fb6:c67a with SMTP id
 8-20020ac856e8000000b003bd1fb6c67amr553374qtu.3.1677582159145; Tue, 28 Feb
 2023 03:02:39 -0800 (PST)
MIME-Version: 1.0
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-5-william.qiu@starfivetech.com> <20230220234335.GA615198-robh@kernel.org>
 <348796cc-72d9-4dcf-9f09-4c2aa55cb858@starfivetech.com> <20230227222904.GC1048218-robh@kernel.org>
 <f8d2b665-ce5d-81f8-8c55-81f1a4cb62b9@starfivetech.com> <54f51fa0-7821-b67b-b782-eb9a35b7bba9@linaro.org>
In-Reply-To: <54f51fa0-7821-b67b-b782-eb9a35b7bba9@linaro.org>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Tue, 28 Feb 2023 12:02:21 +0100
Message-ID: <CAJM55Z85fitjBOcCLqad9W-a7h3iN9bxtctVGzPgqCbf5fWobw@mail.gmail.com>
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

On Tue, 28 Feb 2023 at 11:40, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 28/02/2023 10:05, William Qiu wrote:
> >
> >
> > On 2023/2/28 6:29, Rob Herring wrote:
> >> On Tue, Feb 21, 2023 at 10:44:02AM +0800, William Qiu wrote:
> >>>
> >>>
> >>> On 2023/2/21 7:43, Rob Herring wrote:
> >>>> On Wed, Feb 15, 2023 at 07:32:49PM +0800, William Qiu wrote:
> >>>>> Add documentation to describe StarFive System Controller Registers.
> >>>>>
> >>>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> >>>>> ---
> >>>>>  .../bindings/soc/starfive/jh7110-syscon.yaml  | 51 +++++++++++++++++++
> >>>>>  MAINTAINERS                                   |  5 ++
> >>>>>  2 files changed, 56 insertions(+)
> >>>>>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
> >>>>> new file mode 100644
> >>>>> index 000000000000..fa4d8522a454
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
> >>>>> @@ -0,0 +1,51 @@
> >>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>>>> +%YAML 1.2
> >>>>> +---
> >>>>> +$id: http://devicetree.org/schemas/soc/starfive/jh7110-syscon.yaml#
> >>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>> +
> >>>>> +title: StarFive JH7110 SoC system controller
> >>>>> +
> >>>>> +maintainers:
> >>>>> +  - William Qiu <william.qiu@starfivetech.com>
> >>>>> +
> >>>>> +description: |
> >>>>> +  The StarFive JH7110 SoC system controller provides register information such
> >>>>> +  as offset, mask and shift to configure related modules such as MMC and PCIe.
> >>>>> +
> >>>>> +properties:
> >>>>> +  compatible:
> >>>>> +    items:
> >>>>> +      - enum:
> >>>>> +          - starfive,jh7110-stg-syscon
> >>>>> +          - starfive,jh7110-sys-syscon
> >>>>> +          - starfive,jh7110-aon-syscon
> >>>>
> >>>> Is 'syscon' really part of what the blocks are called? Is just 'stg',
> >>>> 'sys' and 'aon' not unique enough?
> >>>>
> >>>> Rob
> >>> Hi Rob,
> >>>
> >>> In StarFive SoC, we do have syscrg/aoncrg/stgcrg, which is uesd to be the clock
> >>> controller, so 'syscon' is added to avoid confusion.
> >>
> >> You've only added to my confusion. 'syscrg' and 'sys-syscon' are 2
> >> different h/w blocks and unrelated to each other? Or 'syscrg' is the
> >> clock portion of 'sys-syscon'? In that case, 'syscrg' should be a child
> >> of 'sys-syscon' or possibly just all one node. Please provide details on
> >> the entire h/w block so we can provide better input on the bindings.
> >>
> >> Rob
> >
> > Hi Rob,
> >
> > It's my description that's problematic.'syscon' here refers to the hardware module
> > inside our JH7110, which is different from the syscon interface in linux. The syscon
> > I added now uses the syscon interface of linux to read and write the syscon register
> > in our JH7110. So we decided to name it that way.
>
> You didn't really answer Rob's questions.
>
> Also, syscon is Linux term, so are you sure hardware module is called
> like this? Hardware engineers took pure Linux name and used it?

Yes, from the documentation I could find[1] there are CRG blocks
(Clock and Reset Generator) and SYSCON blocks:
SYS CRG
STG CRG
AON CRG
SYS SYSCON
STG SYSCON
AON SYSCON

The CRG blocks contain registers to control clocks and resets that
follow a pattern used by the clock and reset drivers. The SYSCON
blocks just seem to contain registers to control whatever didn't fit
in any other blocks, but might be vaguely related to the peripherals
that run off clocks controlled by the corresponding CRG block.

[1]: https://doc-en.rvspace.org/JH7110/TRM/JH7110_TRM/system_control_registers.html

/Emil

> Best regards,
> Krzysztof
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
