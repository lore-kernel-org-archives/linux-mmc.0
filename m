Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A496E7109E
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Sep 2023 22:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjI0WTa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Sep 2023 18:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjI0WT3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Sep 2023 18:19:29 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90008FC
        for <linux-mmc@vger.kernel.org>; Wed, 27 Sep 2023 15:19:28 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59e88a28b98so171153367b3.1
        for <linux-mmc@vger.kernel.org>; Wed, 27 Sep 2023 15:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695853168; x=1696457968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNPNE6ZI/33m69iO4nrfDEaqDNZF0EXoDxHt8Xj7A5c=;
        b=FeHcP/gO+8Bonp3CPcPTqmJ+xd6MdRKL2Lw12hk9zL0ZPDV2lG6J3/4XK59SagjRwL
         rZXSvAnViKW4fJgAy7HUYipSjJsJa0SxQbr7S4EFfmJmOIiA542MXFCdewUlZ8I6a3YR
         /8gv4EUuIBGingpX8zJg1ZRKfzXTsDbBg+SPS76Wlaew6rWzPAETdxf/bjvJdHPIZiC6
         9B/8StSEhVholkJdx731l1724ku0/EqrmdOOJXDdi+GB42s/Lfh7bTFPgouUweq3HPQi
         YDZvP8VmdZtK0qLlmIyVdbRf49nO3t7OtOF43kURaYpF8Pomk7sotVBibM1lq9+NSuDz
         uWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695853168; x=1696457968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNPNE6ZI/33m69iO4nrfDEaqDNZF0EXoDxHt8Xj7A5c=;
        b=bRyGDkSfphin84mxiGt0uHmefcH81nvewpes8R97IkU98QKZfIW1aLIMUiPcTxFVh8
         zv646vmUgIPbs1Q6GszBejPVYNEFBQdV1CQGQGWVGSLTNgCoQB1JUVREtg3yBkjM+Fe2
         lmnDg9Ot/ZJ4Fqi9VY+UgqFQ2Uqp7UUL5agIH0HPduo5f89F51QUlY2wLLQAZYxXYL58
         DsQ8GrjfMk1dHNCt6zWkuDI24MLCj++lY1nK84WQhw0oMKB4NkoiIelOfKnqT4crFYtU
         Bsn2mT+Tn/X8YfeGLeB0J3DdKgtM50/EBXMXrRMFT3FIHc8kpzyyGm1DfIQqcyym8ovg
         VUHA==
X-Gm-Message-State: AOJu0YyGEvIEIVPH0wnDPotLqhvSjbSDHrj720EoSfSX5gmP5cot0mXd
        cXAMRBwD9wgwbd3z6D2QmqUL3VN4d4puTvTOKyD9iH9ETJrxRvqy
X-Google-Smtp-Source: AGHT+IGOFDBVqzOLee/sxAR9iGgK1IsrGDxg0u9N7DeadlJtHUbFJGeHuARY+QXmXwqa6r7dlyDUMkozYOV9NkpmD3M=
X-Received: by 2002:a0d:dd47:0:b0:59b:e743:630 with SMTP id
 g68-20020a0ddd47000000b0059be7430630mr5040982ywe.22.1695853167792; Wed, 27
 Sep 2023 15:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230927184556.1422122-1-ben.wolsieffer@hefring.com>
In-Reply-To: <20230927184556.1422122-1-ben.wolsieffer@hefring.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Sep 2023 00:19:16 +0200
Message-ID: <CACRpkdY=kuwiBb965Q7cwu4AeGaG2j0UQ=SOVEZAu=Nq+U265g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: use peripheral flow control for STM32
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ben,

thanks for your patch!

On Wed, Sep 27, 2023 at 8:47=E2=80=AFPM Ben Wolsieffer
<ben.wolsieffer@hefring.com> wrote:

> @@ -378,6 +379,7 @@ struct variant_data {
>         u8                      dma_lli:1;
>         u32                     stm32_idmabsize_mask;
>         u32                     stm32_idmabsize_align;
> +       u8                      dma_flow_controller:1;

I've insisted that we use bool rather than u8:1, ut admittedly it is
nitpicking.

Either way:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
