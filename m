Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FC4C25B06
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Aug 2022 08:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiHNIWQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 14 Aug 2022 04:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiHNIWQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Aug 2022 04:22:16 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB65017A9B;
        Sun, 14 Aug 2022 01:22:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r4so6149666edi.8;
        Sun, 14 Aug 2022 01:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=TNUwlG9nzp/Ftl8DzRydchfqZilNnNf9wCNcd4Axyyc=;
        b=AsEa44Yc9lPon5nq4b7t2lUsgYwtl38nBM80b4OEIXUmDvPFUK3Ea6watTDnpUP//5
         Rb98C1RrEplCcahkDx0onVcQi+FRIR7igDeitUo5JDX7ticQ9DMh7lcgWORZeQp91drj
         R24codiDwS6kHVQjc9ersi82pyV7oarHgP1ciRxLTG7A55VD5YeP5DOLk+/A9fjJ4t8I
         k7TabjpB8lNP/QZNXWjBh8i7keS9+fd3eZktH4i4fGTOuIExnwWyj4ph0qQ7EC1CG/mF
         L2EjVFwHKrGF6fC+F47yDlL5eM03xDo7ILVRxOiyuOgRrUjC9cl+mdOTtDzK86BkhhhH
         GFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=TNUwlG9nzp/Ftl8DzRydchfqZilNnNf9wCNcd4Axyyc=;
        b=gCXkE6TfNRs6Ih6bSoochZZ3H4vCoAfj+L54ce9U8YGe228biHbKlHcay2Wqk/n1JI
         Ms+NyiM/lzPe8VlTOA4dpO+KCMwZxBeIYcexeZFRDeQ5i0dHpMTOAzRqVpDOnW/3r6Ee
         Hmv9AV29M+Hz+K4Ll4C2zz3EAt3TdLLGRQ6e9xgb/urt7TAGAHY622vpVyi8w8X7JfIb
         PttjPX/UhIiwTOQ37lwydomGvaTMlBLBRKWOpy+ralQtlnOW/yprJjlASS8tlawSPVa1
         S7/poCFCQGhZxaEeJIza0KIcq04gGSPSnCK+og5D4XDgD25OgNaAuWdVfvL11l8AdkpJ
         PhEg==
X-Gm-Message-State: ACgBeo2DXxiRbA5cOd2o5axvUCIy3ANYBuwbOQQrLuuEWCZSBOaHJT5b
        MieFz5C9lawAwc6XODTOSeQ=
X-Google-Smtp-Source: AA6agR7CV8kNq1XXv7XP88MrV1HeSYkUOz8GKDEpxx8jnl28DpZxeL/ERxuzAJd0fcrNHGowxnjkng==
X-Received: by 2002:aa7:d795:0:b0:43c:eb00:fc77 with SMTP id s21-20020aa7d795000000b0043ceb00fc77mr9816545edq.284.1660465333601;
        Sun, 14 Aug 2022 01:22:13 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709063ac500b007306df330e5sm2774748ejd.12.2022.08.14.01.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 01:22:13 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] mmc: sunxi-mmc: Fix clock refcount imbalance during unbind
Date:   Sun, 14 Aug 2022 10:22:11 +0200
Message-ID: <21565294.EfDdHjke4D@jernej-laptop>
In-Reply-To: <20220810022509.43743-1-samuel@sholland.org>
References: <20220810022509.43743-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Dne sreda, 10. avgust 2022 ob 04:25:09 CEST je Samuel Holland napisal(a):
> If the controller is suspended by runtime PM, the clock is already
> disabled, so do not try to disable it again during removal. Use
> pm_runtime_disable() to flush any pending runtime PM transitions.
> 
> Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Did you get any warnings for unbalanced disable calls?

Anyway:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


