Return-Path: <SRS0=4vPn=2G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D7AC43603
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Dec 2019 08:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CC8206CB
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Dec 2019 08:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qwt0z/LD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLPIDI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:03:08 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40813 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfLPIDI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2019 03:03:08 -0500
Received: by mail-vs1-f67.google.com with SMTP id g23so3554021vsr.7
        for <linux-mmc@vger.kernel.org>; Mon, 16 Dec 2019 00:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=djH4P6rJZ29fmLrYIiEBXgddCiM+F+NpoLnU2C5W0ic=;
        b=qwt0z/LDUa3VNvkNIdC/63tkbfoyK0jXZJvA/wiLJjxOR3b5qhc6JaodJj9bOkRKwG
         g3eBpO1p+ioTRY7g6pGvNoi6BdBzScu+cvGTBIK/k0R1xWxQaqr1UweirkYWeNcQDXti
         aakgl0uwXh/ejXm76Y7SABdLL286aMbpCEU+qlGpGrvxRVd2s99obiVu9NY/qXHBc+Fo
         +Z21ccz5GZZNU6mhaj0JFdUyGsw5esbcSgLLn+tCDLsAfXO57NE1zVZkfARXL6i5x3Zu
         1ekV7sQAUUzqKdGXqgzjeLa4HQKpmw8mqc3DfA0WMyHxK3f2EMsA6OodJSfbY5IEXoyM
         vJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=djH4P6rJZ29fmLrYIiEBXgddCiM+F+NpoLnU2C5W0ic=;
        b=ZkW3TSczL6soA2kvQVveXGqme/bpsyZRqAtlxRZcTrzfn9vdwHhMx23ZP5U0+2d5W2
         Hq1IHu/7IiTV6PX30MmYLtJzkUYWs8TKEcCYz5tVLc68Ydj1GlqNAGupLS3mlUtHC7n4
         A9sddIjCwY3tEg/doBXVM31eB4WQhNpFj+CQUdCmZtmfgmHDXY1gvSPPVSEfXd28jQu+
         hyTELzJJDhw9AVEs86CQVjkuijiYlcoga0D1r6I7p9uOnzt3ttv6wXtjoMrrppWrWg/O
         xAREbmTY6fuFK9PHIWHy60DQua2Ck+q334zB2CYsFhdIXpThstdY67J620aKl0ro+da4
         LTQA==
X-Gm-Message-State: APjAAAWrCrhtx5uOgL2JS2+qSSgpuhqPn624Oot4+WAztgLFPbGXnAv8
        i8swYIRLPlLSmIron6GPb+yAG8LMGiGpmf0duVBrsQ==
X-Google-Smtp-Source: APXvYqxZxtF9uyW/0SNV6/rz9rMvjg9NIlP6IK+cGDZLXzWXTlUoLJrRiVnQ98z3asU2QxPF43pmYU0H04Ya09B4Yv4=
X-Received: by 2002:a67:1447:: with SMTP id 68mr171823vsu.115.1576483387832;
 Mon, 16 Dec 2019 00:03:07 -0800 (PST)
MIME-Version: 1.0
References: <20191206170821.29711-1-ulf.hansson@linaro.org>
In-Reply-To: <20191206170821.29711-1-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Dec 2019 09:02:56 +0100
Message-ID: <CACRpkdYsVBdbNQg=T94=HJUfJwcoMeeK=9Q_Dac18n3ae-K4sA@mail.gmail.com>
Subject: Re: [PATCH 0/9] pinctrl: Consolidate some pinctrl code for mmc
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Dec 6, 2019 at 6:08 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Ulf Hansson (9):
>   pinctrl: core: Add pinctrl_select_default_state() and export it
>   mmc: meson-gx: Convert to pinctrl_select_default_state()
>   mmc: mmci: Convert to pinctrl_select_default_state()
>   mmc: usdhi6rol0: Convert to pinctrl_select_default_state()
>   mmc: omap_hsmmc: Convert to pinctrl_select_default_state()
>   mmc: sdhci-esdhc-imx: Convert to pinctrl_select_default_state()
>   mmc: atmel-mci: Convert to pinctrl_select_default_state()
>   mmc: jz4740: Convert to pinctrl_select_default_state()
>   mmc: uniphier-sd: Convert to pinctrl_select_default_state()

For patches 2-9:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
