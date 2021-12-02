Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1FBC433EF
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Dec 2021 01:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344355AbhLBBhC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Dec 2021 20:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344316AbhLBBfX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Dec 2021 20:35:23 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866AEC061756
        for <linux-mmc@vger.kernel.org>; Wed,  1 Dec 2021 17:32:01 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso37808347ots.6
        for <linux-mmc@vger.kernel.org>; Wed, 01 Dec 2021 17:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eVbRuKvcYz8AuHjLMnmwWWcthb2yF6TQ0KJocuhiso8=;
        b=GrJrq18VwUkgj1pL7epo3ZZ6SnuAd05gDtoKKnKYDh+F6AbvfjS0qATlGPqZ6/ZVRc
         mAzJyJuFMgLLlAUyw/zGeGHyDcWBU4ILxwB1Go1Q1vsKXp1b7nXAUSqgKw1tvhGAt9f3
         skzgj4QTppkSffVCxJ814cm7m0sWH/4PP9Ek4cHZrE9lfj1Vpt0QZVyh2KMZrkToCSEu
         4wPfF6esot0G+kNWfZN87L9205PfEjJ8617b0KRuMWmwuqifVPxJzY4LBCUEDMG3Qyin
         /ZHjiuaRnhsfGm2nITYQc0A0R+OqJdOe/vhE7bB/fnjPgIl/8QV6/oJMM9xwl27adyAA
         OfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVbRuKvcYz8AuHjLMnmwWWcthb2yF6TQ0KJocuhiso8=;
        b=aqsk3pLe9uDJHkZ3DXJ6RsiwoZIMZIP1bzwkK9eXVucPfWOHNNLsFM9eKwXyXAVmNW
         C6a7AEdZGCU5xwSiwm3D+L4qTKtfXa9K70qVZrdN4LsHLKm9Y4FhSXj9dXVYHGa8kVsk
         SgJZkammD5tn+7+rL9ZI06RzngUgPLqefko5Vwqlpu+UB6jpWXpzjBQur3y3I+UdzRgC
         J/8f9QF7Pb3sCfP0OM4DQhFwa7TE5Wk4qILqh1Vs8vx6evur57KJn8kbJquBTPJGmrBw
         4YV9IWaVgqiczITSq3fe4JAy32GRvbCrJ3M8pvF6PxEes2npz5fcsijCP4qKK0Piq4Eg
         b56A==
X-Gm-Message-State: AOAM530k/sEbn4+N351+cQBpOM8lG9cdDucmMf2LvuCB+SfE1nIhfcSo
        mKGfwAos+IgxSW6qQEW8910ATVbx5/wB3Y6+gH5few==
X-Google-Smtp-Source: ABdhPJwyLdZ/F6szrsoT0MsoHuDbALu4MPwuISdCMt7O2AkJiofhGn6t9NOXmZkAcyUEGrTCiSAE7G6YB4B+QiEYdGA=
X-Received: by 2002:a9d:ed6:: with SMTP id 80mr9048514otj.35.1638408720916;
 Wed, 01 Dec 2021 17:32:00 -0800 (PST)
MIME-Version: 1.0
References: <20211125211443.1150135-1-Mr.Bossman075@gmail.com> <20211125211443.1150135-4-Mr.Bossman075@gmail.com>
In-Reply-To: <20211125211443.1150135-4-Mr.Bossman075@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Dec 2021 02:31:49 +0100
Message-ID: <CACRpkdab25qv+NQj9oSxHX2W+dWNWMzWXJjg97Qmci23CM0RMw@mail.gmail.com>
Subject: Re: [PATCH v3 03/13] ARM: dts: imxrt1050-pinfunc: Add pinctrl binding header
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-imx@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, ulf.hansson@linaro.org,
        aisheng.dong@nxp.com, stefan@agner.ch, gregkh@linuxfoundation.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, adrian.hunter@intel.com,
        jirislaby@kernel.org, giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Nov 25, 2021 at 10:14 PM Jesse Taube <mr.bossman075@gmail.com> wrote:

> From: Jesse Taube <mr.bossman075@gmail.com>
>
> Add binding header for i.MXRT1050 pinctrl device tree.
>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> [Jesse: move pinfunc from dt-bindings to dts folder]

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please apply this to the ARM SoC tree.

Yours,
Linus Walleij
