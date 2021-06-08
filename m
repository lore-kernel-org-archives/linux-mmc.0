Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A2EC4743E
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F5961278
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 13:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhFHNS6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Jun 2021 09:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbhFHNS5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2021 09:18:57 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5C3C06178B
        for <linux-mmc@vger.kernel.org>; Tue,  8 Jun 2021 06:17:04 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id n61so11577894uan.2
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jun 2021 06:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AeJwkXf02FHfkTc2tBhjPcNKSoYfgCe3Kp4yq0sZmLQ=;
        b=rf8YIY99EbZMH7/g12lKGP+/SS1HGQgyS+TwSAWEoUkshR9P9Ec3G/WR5fH6jYhGbN
         bl5LprBy5xsyf0h/IPEzPCJlzOerq5GFGC8npSAHFpt0HgQiGeRy1h90ikX15ib8uCVe
         BSMcQGvJRyTIHbKsWuB39rNXYMN2ogOqjqdhSwRBLpjleKKw5E36j8Jomg9WzHSygfpf
         BB+ZHFK5AHq78zJlPPK1igG5DSdmy2PBnoK9uT6iAXAPuxUA783R5bDjZYH4z51UBrLE
         +TCW7CIO8Osk8FlZeidbHZjQg8zN+3WG1XQtFr4OlHWO1S6v0CUG8s7RwpfirhwtiWWr
         /kcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AeJwkXf02FHfkTc2tBhjPcNKSoYfgCe3Kp4yq0sZmLQ=;
        b=O7Z3Ud5BRJkSwtP6HAOtoC9tC0UvFQr5IbgZymR6P4lPstqN04bdAoRt6PJTyLxmqm
         aQMph58i/5rtH26VAk5i5ka+Zl4fHVPOUSd1qtmElAt13Mpp49vyIj7DfG69k7LrVALw
         JKJn0Z6+Qa3Q8bNVjAK3wu8rewlIxPR47TPSkD1V/nRrByJFbfnC13EdeS/ULbyPVwvt
         jT74BAmQOIipuqWR6iu/ThEJjlxx6pNtj1ZRj37HQ7ZCuaLd/BnMg8mvqrFkRzi6+m89
         0UyNcSaqW9gFSt9J28VFTo6vT/JDv1OaBGbiKkDgzRS08QrFD7/fOc2BtH+OLCSDgNFR
         2oTw==
X-Gm-Message-State: AOAM530OZTT7M1+I+IvOIVHCSYJH3GN9gyZAOOFDP+z0GQA26mqGP0ad
        xp9aUpcBvd/PKuJMze1lYNcSnUNxVa+LvST7dY+2vg==
X-Google-Smtp-Source: ABdhPJyNWit/KMWObghRKbmC6vtI+CqqBIJIhWt5YdpyC0OBpfA57D9EyglRt+y4bBMHLxwHJLZJWt4XwfmLKDDM/Aw=
X-Received: by 2002:ab0:12a:: with SMTP id 39mr12675863uak.19.1623158223925;
 Tue, 08 Jun 2021 06:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <1623002884-57244-1-git-send-email-zhouyanjie@wanyeetech.com> <1623002884-57244-2-git-send-email-zhouyanjie@wanyeetech.com>
In-Reply-To: <1623002884-57244-2-git-send-email-zhouyanjie@wanyeetech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Jun 2021 15:16:26 +0200
Message-ID: <CAPDyKFrHuMZdHJ+KKBffCu+FiOJr14ynBnjYW_oGpNQN8+Hy8A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: JZ4740: Add bindings for JZ4775.
To:     =?UTF-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        sihui.liu@ingenic.com, jun.jiang@ingenic.com,
        sernia.zhou@foxmail.com, Paul Cercueil <paul@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 6 Jun 2021 at 20:08, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie)
<zhouyanjie@wanyeetech.com> wrote:
>
> Add the MMC bindings for the JZ4775 SoC from Ingenic.
>
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wany=
eetech.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml b/Doc=
umentation/devicetree/bindings/mmc/ingenic,mmc.yaml
> index 04ba8b7..546480f 100644
> --- a/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml
> @@ -19,6 +19,7 @@ properties:
>            - ingenic,jz4740-mmc
>            - ingenic,jz4725b-mmc
>            - ingenic,jz4760-mmc
> +          - ingenic,jz4775-mmc
>            - ingenic,jz4780-mmc
>            - ingenic,x1000-mmc
>        - items:
> --
> 2.7.4
>
