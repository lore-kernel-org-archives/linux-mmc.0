Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D5EEE7FED
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Sep 2023 13:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjIHNdB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 Sep 2023 09:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjIHNdB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Sep 2023 09:33:01 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E381F1BF4
        for <linux-mmc@vger.kernel.org>; Fri,  8 Sep 2023 06:32:56 -0700 (PDT)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 453703F643
        for <linux-mmc@vger.kernel.org>; Fri,  8 Sep 2023 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694179975;
        bh=zqnhyZNLywg0xbvkm1uHFRR58gPTiCIAHqj9eCxtNas=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=BJmzg6gqb4xdCFPf66KJ5zA0DVa1J93f36n3R8YYwuTqtPoGujipJVsFxVmQPa0wi
         MqiN/eND0MbB+OCGczluTN6EzNSIAf2FXOiJzzQgvkM0bAaQzeDw2P0vIrHU+WkFSS
         DnJ8I19zWA7fJQmlmdG9l+xn4uiKC+qcwldHjckmUCc+h+jKa8cR/cKLfW5Jzxn8cU
         V0jZcsLB91ERt6JY2YlOyU3OkaC8S8UmsE0orBGhUtVP8X0qOHbuu9LlEwW/3HxYqA
         nJugVVdF2OCDqKJnBIvdfOSGWAooEbcZKa1YnXTv+UFU94VQrhGT08a7GdpO/WJTeS
         ETNNFvmuRPWcA==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-502a52cae6bso142870e87.1
        for <linux-mmc@vger.kernel.org>; Fri, 08 Sep 2023 06:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694179974; x=1694784774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqnhyZNLywg0xbvkm1uHFRR58gPTiCIAHqj9eCxtNas=;
        b=L+/gkBzSNrxmY+oBgwvakG1HP6lQbAEdG/mAITcd8g8st/tz4dlLmbxNR8CrdHKc6h
         UuSrifLFL2q2rYdrT6UX9sxQwLRVOhrYk+xxSAfu4WHGQ2V5GiEv1RGMxOxm4XqvhfMz
         Wu6Y5YX4dwC9RgtHFUPIUzfsk3QtYTtrTHa0Ckn68aBHRWap0uFI4OKxCCi2t+JvDtpG
         O+poFyw5X1fw7Bubtw2aB+FkfdGnkj7uqMeslStpo2Ijch7LkVH8Axhj5X9ghnCrm87v
         857SjjTpD5po447Cr/yvzR7ChV/zQhxDW4Nv7xOneAaUJ1SIsndImJ2nFeYux+5zpv0m
         7YyA==
X-Gm-Message-State: AOJu0Yy2A1vNO3jaEPaQy5Cw7gYfhFM9X63Y3Eohk1O1SPeyLLuEqwxI
        AgrqRmK3aEu1+sWRd+9JN33GJkxR1HKSKgKCzyiAnYlRmgT4uPA07mBS2anMq71uF8Z9nrh31rL
        7yVHg1SJy1zuJm/I61K9S6KoRu+F8FmLDl2CSSi5Dd8HJ9Z6b6ueaMnkkOO+O4V+E
X-Received: by 2002:a05:6512:3082:b0:4f9:586b:dba1 with SMTP id z2-20020a056512308200b004f9586bdba1mr2492962lfd.4.1694179973654;
        Fri, 08 Sep 2023 06:32:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQebtOEBXNF4XxOrD/m0xqiyvOa6CRhaA5PweNX/oEc3iI8U1qvOKmWus5LBiJh9SF87AJkxS4IXLdALU1FgM=
X-Received: by 2002:a05:6512:3082:b0:4f9:586b:dba1 with SMTP id
 z2-20020a056512308200b004f9586bdba1mr2492928lfd.4.1694179973237; Fri, 08 Sep
 2023 06:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230830031846.127957-1-william.qiu@starfivetech.com>
 <20230830031846.127957-2-william.qiu@starfivetech.com> <20230830-commence-trickery-40eaa193cb15@wendy>
 <b375b88c-0d9c-30a9-21f6-283083cf3880@linaro.org> <20230830-procedure-frostbite-56c751f7c276@wendy>
 <efab6f52-4d7f-ea3c-0fc3-4e3ad03c14c7@starfivetech.com> <20230901-remold-sublease-a1ddb1fc6348@spud>
 <9EF26965-10E5-4BCA-AC5E-93C5AA55A0DF@jrtc27.com> <20230901-affected-wanting-ab517791a870@spud>
 <dd63bb4f-a59b-0323-08fb-03f8cc048b6e@starfivetech.com>
In-Reply-To: <dd63bb4f-a59b-0323-08fb-03f8cc048b6e@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 8 Sep 2023 15:32:36 +0200
Message-ID: <CAJM55Z8XowmB-Hfzr+hBtWu+SGL2v7jya6Nx5_rATf8=5qA4Fg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: Drop unused properties
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-mmc@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 8 Sept 2023 at 12:03, William Qiu <william.qiu@starfivetech.com> wr=
ote:
> On 2023/9/2 1:43, Conor Dooley wrote:
> > On Fri, Sep 01, 2023 at 06:20:38PM +0100, Jessica Clarke wrote:
> >> On 1 Sep 2023, at 16:42, Conor Dooley <conor@kernel.org> wrote:
> >> >
> >> > On Fri, Sep 01, 2023 at 10:33:13AM +0800, William Qiu wrote:
> >> >>
> >> >>
> >> >> On 2023/8/30 16:34, Conor Dooley wrote:
> >> >>> On Wed, Aug 30, 2023 at 09:29:20AM +0200, Krzysztof Kozlowski wrot=
e:
> >> >>>> On 30/08/2023 08:50, Conor Dooley wrote:
> >> >>>>> On Wed, Aug 30, 2023 at 11:18:44AM +0800, William Qiu wrote:
> >> >>>>>> Due to the change of tuning implementation, it's no longer nece=
ssary to
> >> >>>>>> use the "starfive,sysreg" property in dts, so drop the relevant
> >> >>>>>> description in dt-bindings here.
> >> >>>>>
> >> >>>>> How does changing your software implantation invalidate a descri=
ption of
> >> >>>>> the hardware?
> >> >>>>>
> >> >>>>
> >> >>>> Which is kind of proof that this syscon was just to substitute
> >> >>>> incomplete hardware description (e.g. missing clocks and phys). W=
e
> >> >>>> should have rejected it. Just like we should reject them in the f=
uture.
> >> >>>
> >> >>> :s I dunno what to do with this... I'm inclined to say not to remo=
ve it
> >> >>> from the binding or dts at all & only change the software.
> >> >>>
> >> >>>> There are just few cases where syscon is reasonable. All others i=
s just
> >> >>>> laziness. It's not only starfivetech, of course. Several other
> >> >>>> contributors do the same.
> >> >>>
> >> >>> I'm not sure if laziness is fair, lack of understanding is usually=
 more
> >> >>> likely.
> >> >>
> >> >> For this, I tend to keep it in binding, but remove it from required=
. Because
> >> >> we only modify the tuning implementation, it doesn't mean that this=
 property
> >> >> need to be removed, it's just no longer be the required one.
> >> >
> >> > Please only remove it from required if the current driver doesn't br=
eak
> >> > if the regmap is removed.
> >>
> >> Either way please make sure the documentation clearly states =E2=80=9C=
never use
> >> this, if you=E2=80=99re using it you=E2=80=99re doing it wrong, this o=
nly exists
> >> because it was wrongly used in the past=E2=80=9D. Otherwise people wri=
ting
> >> drivers for other OSes will probably use it too thinking they need to.
> >
> > Maybe we should just delete it if the impact is going to be negligible,
> > sounds like you're not using it in FreeBSD, which was part of what I wa=
s
> > worried about. Guess it depends on what Emil & the distro heads think.
> Hi Conor,
>
> After discussing it with our colleagues, we decided that deleting it was =
the best
> course of action. Since there will no longer be a related implementation =
of
> "starfive,sysreg" in future drivers, even if the dt-binding is described,=
 it will
> be "never use", so I think it should be deleted.
>
> What do you think?

The device tree should be a description of the hardware and there
really is a 'u0_sdio_data_strobe_phase_ctrl' field in the sysreg
registers[1] on the JH7110 that seems to do _something_ related to the
sdio interface. So I don't think the fact that the Linux driver no
longer uses it is a good reason to remove it, but if there are some
other pragmatic reasons to do so then I'm fine with it. Removing it
from the list of required properties should be fine though.

/Emil

[1]: https://doc-en.rvspace.org/JH7110/TRM/JH7110_TRM/sys_syscon.html
