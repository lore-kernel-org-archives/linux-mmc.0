Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00AEC33CB6
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7823207E0
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 14:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579185224;
	bh=zCTzRzpxW45hf9zhu97cl/HH/TkaKoXKxG33ubUlcis=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=N6JF6aoujDNfs/EEb14JCn6k+a1WaFPqHqoYcLNi7ntPNU3+R4jwcOUGkrT59cws1
	 Fa3daCqUegYa4TT5N7XFyWYKvrHUaFqhZHzdj6f5Ta4x5eJDBGeGcFESSg1SUtG+1L
	 L3XMv40lD5iMy1IzCczKRWZOZdv8kbiTnxnoYIIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgAPOdo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:33:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgAPOdo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 16 Jan 2020 09:33:44 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 197A62051A;
        Thu, 16 Jan 2020 14:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579185223;
        bh=zCTzRzpxW45hf9zhu97cl/HH/TkaKoXKxG33ubUlcis=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lzvmVPxC0YoX1GCXF9xUvPrjSs4rABccejlMEYJBJejJBHBYBFbLHbl9I1uSYPV0s
         3EY+xd0XAuDU9RZq3eOwaUXPY3w86rI2ei6fInbAhyjKcskoR3Ss6JG1AD0V/OTu72
         nbcIyHgK5xQvFUJjrWjxwTqxbhEM7tjwPVQtLOqo=
Received: by mail-qv1-f46.google.com with SMTP id z3so9148661qvn.0;
        Thu, 16 Jan 2020 06:33:43 -0800 (PST)
X-Gm-Message-State: APjAAAUZf5JvTMUXWA4g4UdcXB4lVoK+7DPigTkv2Py4mEspQFKkbJ/2
        P/VVfo4mqlhpeHtKffVLuqg6aioAepSjzS66vQ==
X-Google-Smtp-Source: APXvYqxpzOz30rqleYyMHf6/FcDEmshzxEl/xINJJW+FtV85eSNgGaPEZdKTK/HozyW+hT6davB/mrOR0U63bbSIPFg=
X-Received: by 2002:ad4:450a:: with SMTP id k10mr2710244qvu.136.1579185222222;
 Thu, 16 Jan 2020 06:33:42 -0800 (PST)
MIME-Version: 1.0
References: <20200110134823.14882-1-ludovic.barre@st.com> <20200110134823.14882-6-ludovic.barre@st.com>
 <20200115145645.GA599@bogus> <2ce63f11-8b0c-8261-63fa-cd19e874c537@st.com>
In-Reply-To: <2ce63f11-8b0c-8261-63fa-cd19e874c537@st.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 16 Jan 2020 08:33:30 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJMGY-n07e81iAsj+P7wPHFojBerNnjx8vtvqLTDA7yEw@mail.gmail.com>
Message-ID: <CAL_JsqJMGY-n07e81iAsj+P7wPHFojBerNnjx8vtvqLTDA7yEw@mail.gmail.com>
Subject: Re: [PATCH 5/9] dt-bindings: mmc: mmci: add delay block base register
 for sdmmc
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jan 16, 2020 at 3:21 AM Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> Hi Rob
>
> Le 1/15/20 =C3=A0 3:56 PM, Rob Herring a =C3=A9crit :
> > On Fri, Jan 10, 2020 at 02:48:19PM +0100, Ludovic Barre wrote:
> >> To support the sdr104 mode, the sdmmc variant has a
> >> hardware delay block to manage the clock phase when sampling
> >> data received by the card.
> >>
> >> This patch adds a second base register (optional) for
> >> sdmmc delay block.
> >>
> >> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> >> ---
> >>   Documentation/devicetree/bindings/mmc/mmci.txt | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Document=
ation/devicetree/bindings/mmc/mmci.txt
> >> index 6d3c626e017d..4ec921e4bf34 100644
> >> --- a/Documentation/devicetree/bindings/mmc/mmci.txt
> >> +++ b/Documentation/devicetree/bindings/mmc/mmci.txt
> >> @@ -28,6 +28,8 @@ specific for ux500 variant:
> >>   - st,sig-pin-fbclk       : feedback clock signal pin used.
> >>
> >>   specific for sdmmc variant:
> >> +- reg                        : a second base register may be defined =
if a delay
> >> +                           block is present and used for tuning.
> >
> > Which compatibles have a 2nd reg entry?
>
> In fact, mmci driver is ARM Amba driver (arm,primecell) and has only one
> compatible "arm,pl18x".
> The variants are identified by primecell-periphid property
> (discovered at runtime with HW block register or defined by
> device tree property "arm,primecell-periphid").
>
> The defaults "arm,pl18x" variants have only one base register,
> but the SDMMC need a second base register for these
> delay block registers.
>
> example of sdmmc node:
>         sdmmc1: sdmmc@58005000 {
>                 compatible =3D "arm,pl18x", "arm,primecell";
>                 arm,primecell-periphid =3D <0x00253180>;
>                 reg =3D <0x58005000 0x1000>, <0x58006000 0x1000>;
>         };
>
> what do you advise?

I missed that this is a primecell block. Just give some indication
which variants have this 2nd range.

Rob
