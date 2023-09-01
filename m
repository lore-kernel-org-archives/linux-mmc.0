Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD43CCA0FEE
	for <linux-mmc@archiver.kernel.org>; Fri,  1 Sep 2023 17:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350322AbjIARUz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 1 Sep 2023 13:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348916AbjIARUy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Sep 2023 13:20:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2995B10F5
        for <linux-mmc@vger.kernel.org>; Fri,  1 Sep 2023 10:20:51 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31c6d17aec4so1834973f8f.1
        for <linux-mmc@vger.kernel.org>; Fri, 01 Sep 2023 10:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1693588849; x=1694193649; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDaCSxGqWC92if0Z6Klm60VC2KBJe3DiYPIYkSgGiOQ=;
        b=LV9rplRo+fdO0GuXMn79uyEwjrwKLTOJdAsTbxSXeEujgg63A2oBpjWlrJEECgU+oX
         poHoMqg6hR9pmPUhCrF0IUkLRMR1Q+LeW0t/xYPxI65nORoeYmqxdvQBkPb4QXazWFBY
         EARRtPkLu3OYze1BuHHs/OlaAxKS/5HPOwLeDtcwfiUP8JRxa0Nh6Q6Oc39oLhG5ZZQd
         9q3uMMmD0qUAYa4Buutmw/PBrUTuLi3chsKdsYTz5jvm/tc5GnXWdi90CHAjY0XzghU2
         VTQIwgCKPcB2vtisthMYxG+1mol/KVAJ5fED4eloYHEqNblNUfQkI9bOyUQeArpYPoDk
         8mnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693588849; x=1694193649;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDaCSxGqWC92if0Z6Klm60VC2KBJe3DiYPIYkSgGiOQ=;
        b=KZXVyedlHJVh7XYVy3qxT5auY0cx3wGTU/4l/WG7hPBX1mxCjPYPySpQxkGhvyd6YD
         akVnKdOMdPxcaNJa0vXCnAXtIUVvpu/y6g/X/ozX4jTm1Kovjf3WAW0wleUpljQwAy06
         yKtcsZ2QwLeBdE1q3MtkETkhQ7tkK6M0dYDz0SGVOFU09v+tNO34RuT1yePbBr3BeTcB
         Ly5FbvRYORTjSxaIuc1epYVUnjtDGqmDLFce+5Wc62gfB2kf3ukHbPQPCF9YqDCpEynW
         WSPDag3DIW6lSuQrxOaIIUeC/n5rNbQVb9UpN3FSGeGB1x3ZrzTSFZL8WXPCjm90GFZB
         0cAA==
X-Gm-Message-State: AOJu0YxxvhmCmNKPVmDIrcRGGJ+a54T/ybVlJnp8koXnC/+9PQkIJMcd
        bv05s6uBGuN9DoITHeWOa2Zo7Q==
X-Google-Smtp-Source: AGHT+IECMKtsA+xfilTzTOfsxwiwD+SvpSlL+xDbbYz66S7ZDqBzHrbSSow55DnE6Tmpy7BohAAzHQ==
X-Received: by 2002:a5d:69c5:0:b0:317:e1a2:dccf with SMTP id s5-20020a5d69c5000000b00317e1a2dccfmr2843222wrw.62.1693588849653;
        Fri, 01 Sep 2023 10:20:49 -0700 (PDT)
Received: from smtpclient.apple ([131.111.5.246])
        by smtp.gmail.com with ESMTPSA id m12-20020adff38c000000b0031ad5fb5a0fsm5780460wro.58.2023.09.01.10.20.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Sep 2023 10:20:49 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: Drop unused properties
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20230901-remold-sublease-a1ddb1fc6348@spud>
Date:   Fri, 1 Sep 2023 18:20:38 +0100
Cc:     William Qiu <william.qiu@starfivetech.com>,
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <9EF26965-10E5-4BCA-AC5E-93C5AA55A0DF@jrtc27.com>
References: <20230830031846.127957-1-william.qiu@starfivetech.com>
 <20230830031846.127957-2-william.qiu@starfivetech.com>
 <20230830-commence-trickery-40eaa193cb15@wendy>
 <b375b88c-0d9c-30a9-21f6-283083cf3880@linaro.org>
 <20230830-procedure-frostbite-56c751f7c276@wendy>
 <efab6f52-4d7f-ea3c-0fc3-4e3ad03c14c7@starfivetech.com>
 <20230901-remold-sublease-a1ddb1fc6348@spud>
To:     Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3731.600.7)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 1 Sep 2023, at 16:42, Conor Dooley <conor@kernel.org> wrote:
>=20
> On Fri, Sep 01, 2023 at 10:33:13AM +0800, William Qiu wrote:
>>=20
>>=20
>> On 2023/8/30 16:34, Conor Dooley wrote:
>>> On Wed, Aug 30, 2023 at 09:29:20AM +0200, Krzysztof Kozlowski wrote:
>>>> On 30/08/2023 08:50, Conor Dooley wrote:
>>>>> On Wed, Aug 30, 2023 at 11:18:44AM +0800, William Qiu wrote:
>>>>>> Due to the change of tuning implementation, it's no longer =
necessary to
>>>>>> use the "starfive,sysreg" property in dts, so drop the relevant
>>>>>> description in dt-bindings here.
>>>>>=20
>>>>> How does changing your software implantation invalidate a =
description of
>>>>> the hardware?
>>>>>=20
>>>>=20
>>>> Which is kind of proof that this syscon was just to substitute
>>>> incomplete hardware description (e.g. missing clocks and phys). We
>>>> should have rejected it. Just like we should reject them in the =
future.
>>>=20
>>> :s I dunno what to do with this... I'm inclined to say not to remove =
it
>>> from the binding or dts at all & only change the software.
>>>=20
>>>> There are just few cases where syscon is reasonable. All others is =
just
>>>> laziness. It's not only starfivetech, of course. Several other
>>>> contributors do the same.
>>>=20
>>> I'm not sure if laziness is fair, lack of understanding is usually =
more
>>> likely.
>>=20
>> For this, I tend to keep it in binding, but remove it from required. =
Because
>> we only modify the tuning implementation, it doesn't mean that this =
property
>> need to be removed, it's just no longer be the required one.
>=20
> Please only remove it from required if the current driver doesn't =
break
> if the regmap is removed.

Either way please make sure the documentation clearly states =E2=80=9Cneve=
r use
this, if you=E2=80=99re using it you=E2=80=99re doing it wrong, this =
only exists
because it was wrongly used in the past=E2=80=9D. Otherwise people =
writing
drivers for other OSes will probably use it too thinking they need to.

Jess

