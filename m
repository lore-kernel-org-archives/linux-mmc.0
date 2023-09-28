Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98973CE7B04
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Sep 2023 07:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjI1HZs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 Sep 2023 03:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjI1HZr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Sep 2023 03:25:47 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2976191;
        Thu, 28 Sep 2023 00:25:46 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5a1d0fee86aso85654267b3.2;
        Thu, 28 Sep 2023 00:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695885945; x=1696490745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNbZ0GOeHkYYiVV5+YvtOG1e74ZHGZHYw1MLYvYebes=;
        b=gNpKxKBda7Qg5s0g1UTxpJA50ha26PQkLEj3MPqfYXzmGa8DRgRTrryBO20Qo3OSzv
         MAhKp/mmbZXGhmtsN1FfIpBLdeNq/XIA4fOd6E0CGTtptdQTCYhA3P6YF/9VjM3Sh8ep
         ZxV9m8pmDv3MmhBOJbN1sDt67x03J1OfhoCQTBSdEeZuENvoFHPqnTlMAJPuSOLZKAJt
         qhcgMi3Pec4k7dXP33g1E/6pODFKu1Q8a2+y246RvrBngJhm6LxgslrSysvXtkwlpft1
         mIjkWa3jJ/6Bin2JK2BSSJt4/n6SVePYUdsyoM3my8c4vAt+A8UOoqy5Np7PunfZimP+
         47AA==
X-Gm-Message-State: AOJu0YwCOvPHWtcs3eUmejUEO/1kUWyiDf9aP7L4yMrxeSV9iTF1mdJQ
        1RkdXcJCG5BzVI+abOz1Uxu8BYcXFS0lDQ==
X-Google-Smtp-Source: AGHT+IGrmBU+7AoECLKdMIYd73ANdOaOLfv9+EjNr3nmhqkwKhIk/37u7sruVa6WtrIK2K7CG2savw==
X-Received: by 2002:a0d:e841:0:b0:59e:afab:d5a5 with SMTP id r62-20020a0de841000000b0059eafabd5a5mr468421ywe.23.1695885945241;
        Thu, 28 Sep 2023 00:25:45 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id n66-20020a817245000000b005704c4d3579sm4375612ywc.40.2023.09.28.00.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 00:25:43 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59f7f2b1036so100479637b3.3;
        Thu, 28 Sep 2023 00:25:42 -0700 (PDT)
X-Received: by 2002:a0d:d041:0:b0:595:80e4:907d with SMTP id
 s62-20020a0dd041000000b0059580e4907dmr367488ywd.32.1695885942137; Thu, 28 Sep
 2023 00:25:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-22-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWc6yy=oJDo4zMdvB-t8pjCuE1oJ_Y6Ck0aX_hPkfhPug@mail.gmail.com> <154b823e-d532-ede7-5ada-08436ec86804@tuxon.dev>
In-Reply-To: <154b823e-d532-ede7-5ada-08436ec86804@tuxon.dev>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Sep 2023 09:25:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVGWNHxjh6o9bWiuLfbCTd41n232Q5p+onHrM5Urm-d2w@mail.gmail.com>
Message-ID: <CAMuHMdVGWNHxjh6o9bWiuLfbCTd41n232Q5p+onHrM5Urm-d2w@mail.gmail.com>
Subject: Re: [PATCH 21/37] dt-bindings: clock: add r9a08g045 CPG clocks and
 resets definitions
To:     claudiu beznea <claudiu.beznea@tuxon.dev>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Claudiu,

On Thu, Sep 28, 2023 at 6:54 AM claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
> On 15.09.2023 14:59, Geert Uytterhoeven wrote:
> > On Tue, Sep 12, 2023 at 6:53 AM Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> Add RZ/G3S (R9A08G045) Clock Pulse Generator (CPG) core clocks, module
> >> clocks and resets.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> >> --- /dev/null
> >> +++ b/include/dt-bindings/clock/r9a08g045-cpg.h
> >
> >> +/* R9A08G045 Module Clocks */
> >
> >> +#define R9A08G045_USB_U2H0_HCLK                65
> >> +#define R9A08G045_USB_U2H1_HCLK                66
> >> +#define R9A08G045_USB_U2P_EXR_CPUCLK   67
> >> +#define R9A08G045_USB_PCLK             68
> >> +#define R9A08G045_USB_SCLK             69
> >
> > There is no USB_SCLK bit in CPG_CLKON_USB, so please drop
> > R9A08G045_USB_SCLK.
> >
> >> +/* R9A08G045 Resets */
> >
> >> +#define R9A08G045_SRAM_ACPU_ARESETN0   11
> >> +#define R9A08G045_SRAM_ACPU_ARESETN1   12
> >> +#define R9A08G045_SRAM_ACPU_ARESETN2   13
> >
> > There is no SRAM_ACPU_ARESETN2 bit in CPG_RST_SRAM_MCPU,
> > so please drop R9A08G045_SRAM_ACPU_ARESETN2.
>
> I see there is SRAM_ACPU_ARESETN2 in CPG_RST_SRAM_*A*CPU register. You are
> actually saying that the documentation might be wrong?

My mistake, I looked at the wrong register.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
