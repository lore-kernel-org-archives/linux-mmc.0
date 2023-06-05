Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B73FC7EE23
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Jun 2023 21:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbjFEVCB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Jun 2023 17:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjFEVBu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jun 2023 17:01:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F60197
        for <linux-mmc@vger.kernel.org>; Mon,  5 Jun 2023 14:01:44 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-977d0ee1736so284894766b.0
        for <linux-mmc@vger.kernel.org>; Mon, 05 Jun 2023 14:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685998903; x=1688590903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEXZS1gc/9CsxEjn+8XGH2gyH4ZVDUPfm5WrWxbF+bY=;
        b=VCRszmJRUeSJ4wuYJqTGvGjobddCFTTNmzO4q/XTgCmEtOaN4ZBJqfkDt1Vt2YVeY4
         xRdjXfpleFTSxezDy2wuqFa9iUtc1QBhLzVC3PvxpG1f2zxrhoi8IzCAdDvHYyrDY3nf
         XSP63yjBHu6UFAR8nmufd6UdfaYM4bY6rEg42qlHvZ+fxrFAhDyffXqDy6wF1nDipDC2
         Q/Q5oSchMTsFX6txNA4f6jVkDwBwFTC9esVlP1spg/kCSkL4FaY9ffqi8JLxDuqF2oaG
         2qK6e8WAvBP/P+vlRiwz95XmIO1xex7vTzuCbTVj8WMsJN0b7HkbXLIoCjCB3ZgfAaKy
         Ol5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685998903; x=1688590903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEXZS1gc/9CsxEjn+8XGH2gyH4ZVDUPfm5WrWxbF+bY=;
        b=Ks40u4vFQbDoRHZzB06nZ1DxyVbsLn1wSK7IDipBusflJNzitlXjV2H+wY8qnETfQa
         4EImODwBLcBB1Vir0UdcuMsDLpfQgWBkfAS7erSIZp+cPjrp22wEr3YZYBQYM33zjIVP
         +KjT9+GFlFeMruZw5bTAYuPigLtxQdcoMuG8D8+ZPFlVN9X87IFLONCaZFh8X5gLaYam
         X6pAYMAHX/Wq/E4D1K2OblwnNE2nI8IA+jyVuBbI84spNqGx+E+vc4dGWpDcjo9CVGG3
         fjkcLM1p3iHt550itZmryRrXUnMv397P+qYRprwLM4lYeAFaumQIhYxrTLmVBsoNSRew
         c6Rw==
X-Gm-Message-State: AC+VfDxYJjmiEDLMAj/4RekIxgRjQ02eF5+8Wrf5YVUQ/oCD4mBPirVt
        HwOp1RTQm24RLQe32HfA+Y5v/aWVW/EK7cJExEA=
X-Google-Smtp-Source: ACHHUZ5muLUUggQcuPVEGkHZGvsnmvfw8pWrKXboQdeoETB8cltqkt7Ji1lOr4ZEv0d9L+FWrIhKDNSiroLSY94B/SA=
X-Received: by 2002:a17:907:3f1f:b0:96f:f451:187f with SMTP id
 hq31-20020a1709073f1f00b0096ff451187fmr89868ejc.7.1685998903000; Mon, 05 Jun
 2023 14:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com>
 <CAPDyKFqgYnBfm-NespEZF8AJ5Ou4Bya8jLfVEnfyZvfAZ05Q7Q@mail.gmail.com>
 <CAFBinCDjPJHEhN-Jx3DhhhHJ3yi8oEoW7u4-Ld6Rd1+W826ttA@mail.gmail.com>
 <CAPDyKFqKSWJkJwgCO89jgKQ6AB==P9BWkuX6XtKj=ASOH15y9g@mail.gmail.com>
 <CAFBinCDwgYw3v31hP4AtV3+Z1o+esDqMKugRwMMMLqSX0Acjzw@mail.gmail.com>
 <CAPDyKFr+hQo+N31r=3f58taf9sYW0UF0ApCJhwz9vRsyNizcvg@mail.gmail.com>
 <CAFBinCDSv_vdu5887vveotvaOGFrZvaSX4jM+7Q3QvDhTdazzw@mail.gmail.com> <5eb7694f-8c45-bab8-4d4c-2852f125f0eb@leemhuis.info>
In-Reply-To: <5eb7694f-8c45-bab8-4d4c-2852f125f0eb@leemhuis.info>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 5 Jun 2023 23:01:31 +0200
Message-ID: <CAFBinCAh3s6pHa6q20=cB86qJCaYRq3bKwZtwah2_DGLcGFB6g@mail.gmail.com>
Subject: Re: Odroid-C1 regression with commit 4bc31edebde5 ("mmc: core: Set HS
 clock speed before sending HS CMD13")
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Luca Weiss <luca@z3ntu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Thorsten,

On Fri, Jun 2, 2023 at 3:17=E2=80=AFPM Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
>
> Ulf, Martin, what happened to this? It looks like we didn't get any
> closer to fixing this regression in the last two weeks. Did it fall
> through the cracks? Or was progress made and I just missed it?
Life got in the way so there's no progress on my end.
I'm hoping that Ulf has some more ideas that I can work with though.


Best regards,
Martin
