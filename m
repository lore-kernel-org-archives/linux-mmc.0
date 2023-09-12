Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D94ACA0ECA
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Sep 2023 09:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjILJHA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Sep 2023 05:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjILJGe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Sep 2023 05:06:34 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1131710
        for <linux-mmc@vger.kernel.org>; Tue, 12 Sep 2023 02:06:01 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d7e387c33f3so4660629276.1
        for <linux-mmc@vger.kernel.org>; Tue, 12 Sep 2023 02:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694509561; x=1695114361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/RE43x8EDqZSOQNHhRIsDHTJXqVvnyoJP3udIAKpDM=;
        b=ZnYoi0MmyioHP0+0VJZvzerrFl9t1+9ECdLK8+nzmm5AdjnTBNTR/mjZIUdNZegwiZ
         csfOJXKF9GaGcbQfM1WL3I/OhlmLkqqlHPb4dJ140Rmf32Fp2Qyqhgc4zgot71SPDQcw
         A3AObdxwHCIAI4/gkQvQBocYkIk73garAfp/F3TfM86EMc3otOHOUGWIoR95sEydQ7Aq
         4f7bROqVZokQ2OMu5nfH9Y+6IxWqjSrpbcKK8+r51oYsXTO1kqlIhw//f6TQpH1RS4DS
         qT1meFZTPuUx1N42aV4FVLRJCJNO5VRPz8phaTSsaor1xoqOPCbX+/KQ2eT8I1rL3hoA
         VC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509561; x=1695114361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/RE43x8EDqZSOQNHhRIsDHTJXqVvnyoJP3udIAKpDM=;
        b=I6XTf+sXTNF2nt8EPqpLKQouqlAopxx+YZGl11AUB5N6M8uZ4tkY1NLMvIZhKxZbXI
         a3UwAVUC8WbUw087BOJR/0Bztz76O4S7tlTzRWCl+tG3Bk3koOi91mHnfvueDj/rl/Y+
         Lq8TCP885OFdOWtp4AfnGIwSQvwPX+HErXRYS+gUaTtxWo405EBoSETH+40UnS5ATa+m
         N9NlghPvbLlKYcKwwDu2WgkN/fJtIvqZM6NIxMYZDEPRO0vloX36tulRzMG91T2o6VgO
         Ij0ubMolCDNaRSRGaZhlsjJXNB/eulHK3ybRoaPJ2uy1LaWxHauSt7Gmrpofwy24OulS
         gUdQ==
X-Gm-Message-State: AOJu0YxvzKP0kylzqpC4g5I4Lvu78WuzMm8bGdCqmSl8e0FzUPMOMXy8
        T+a8n+lQ7SHE2LKnAYQpCD0hn0y26jEWc4RMrbqRXg==
X-Google-Smtp-Source: AGHT+IGyj7jaQxIgh9sNw+w5/RpN1cpBHRGqXrkDxOGkZbGhxpB/d00UnSBnb3Z8rrosW8TN+PXvwFbRuvBLrcIWGs0=
X-Received: by 2002:a25:d20d:0:b0:d78:441d:4d62 with SMTP id
 j13-20020a25d20d000000b00d78441d4d62mr11118777ybg.22.1694509561156; Tue, 12
 Sep 2023 02:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <CACRpkdYL46wY_4dm2w45kdPqOJ8zU9X=SSAXv_K=9wfBZFqyDQ@mail.gmail.com> <CAMuHMdXi6PPFqgjvr6tBXQnXqNb3YL=87JeSiGN0+QqkAvziAA@mail.gmail.com>
In-Reply-To: <CAMuHMdXi6PPFqgjvr6tBXQnXqNb3YL=87JeSiGN0+QqkAvziAA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 11:05:50 +0200
Message-ID: <CACRpkdYFzJD+F4v0DTfppGv39guL6YbeA=5aByxuu3u8Jp7u6A@mail.gmail.com>
Subject: Re: [PATCH 00/37] Add new Renesas RZ/G3S SoC and RZ/G3S SMARC EVK
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Claudiu <claudiu.beznea@tuxon.dev>, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, magnus.damm@gmail.com,
        catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Ulrich Hecht <uli@fpond.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 12, 2023 at 11:03=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Sep 12, 2023 at 10:55=E2=80=AFAM Linus Walleij <linus.walleij@lin=
aro.org> wrote:

> > For new code try to use <linux/cleanup.h>.
> > Or if you prefer take a sweep and introduce scoped guards
> > everywhere (for spinlocks, mutexes..).
>
> Hmmm, <linux/cleanup.h> is only available in v6.5 and later.
> I don't know whether the CiP machinery is planning to backport
> <linux/cleanup.h> to e.g. v6.1 LTS...

Only for new code! (for-v6.7+)

Yours,
Linus Walleij
