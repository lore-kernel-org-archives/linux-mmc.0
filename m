Return-Path: <SRS0=IHUQ=Z7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85438C2D0C0
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Dec 2019 05:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F36420721
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Dec 2019 05:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="sHrlam1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfLIFNO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Dec 2019 00:13:14 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:24579 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfLIFNO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Dec 2019 00:13:14 -0500
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id xB95D6eM022154;
        Mon, 9 Dec 2019 14:13:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com xB95D6eM022154
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1575868387;
        bh=GTF6UD3GYv8Er8qBdaQM26T7zUbSphvd8n0MGPxzJy4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sHrlam1ug+XAKmOiNnNH/w6Or1cM00bqCTkagGuzUv6ScGFyttQqv0gz4REQJi61h
         xZ7BfgjymEWbPXCrQzRwkMJiOLddyGob9av0XeLp+0OMlBTskiwb49roDU2ScpZ/jA
         MelRvM9B2Biy5PlO4RLGrA2Q22vwlxejgycY3ATLABZclN27MbK9tCV9vliuhRdU8/
         m2EwjsfZvGg2wwe4ohayPYXBfOBUUp2vzud27TM0wJkHCgH7RyydACM00vCNQlgw5t
         rfsALfCtrBG+TvyXbwiCHCWjx3BNSGAxZE0OJzEaatXr7L8sGzxEAIBWh8m6324wNO
         50ckqM4tiha4w==
X-Nifty-SrcIP: [209.85.221.169]
Received: by mail-vk1-f169.google.com with SMTP id i4so4003434vkc.3;
        Sun, 08 Dec 2019 21:13:07 -0800 (PST)
X-Gm-Message-State: APjAAAVUpzz5r7A4rY5/0oYNz9LaHy2Z9RK2qswZiBM7lm++ux4Lyu/d
        Qd14211qpStZbrHtrWiFJH9Rtv8kFhbMeWYzDBs=
X-Google-Smtp-Source: APXvYqwu3z97Xto7Aw0zyY0/OicAagBB5SATn47eMNkysBLPaW+ssK6AAwzTGNMGpF5rJIohxNVjtU/p/k1cW8thYVk=
X-Received: by 2002:a1f:6344:: with SMTP id x65mr11641934vkb.26.1575868386201;
 Sun, 08 Dec 2019 21:13:06 -0800 (PST)
MIME-Version: 1.0
References: <20191206170821.29711-1-ulf.hansson@linaro.org> <20191206170821.29711-10-ulf.hansson@linaro.org>
In-Reply-To: <20191206170821.29711-10-ulf.hansson@linaro.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 9 Dec 2019 14:12:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQF3VeQz67tAxtRXX3VYoCJSNc+xLTu9Pn331kJXVB+QQ@mail.gmail.com>
Message-ID: <CAK7LNAQF3VeQz67tAxtRXX3VYoCJSNc+xLTu9Pn331kJXVB+QQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] mmc: uniphier-sd: Convert to pinctrl_select_default_state()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, Dec 7, 2019 at 2:08 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Let's drop the boilerplate code for managing the default pinctrl state and
> convert into using the new pinctrl_select_default_state().
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>



-- 
Best Regards
Masahiro Yamada
