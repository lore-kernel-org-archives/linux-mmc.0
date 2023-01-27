Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16397C54EAA
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Jan 2023 08:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjA0IvG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 27 Jan 2023 03:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbjA0IvD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Jan 2023 03:51:03 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91B62331C
        for <linux-mmc@vger.kernel.org>; Fri, 27 Jan 2023 00:51:00 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-501c3a414acso58164567b3.7
        for <linux-mmc@vger.kernel.org>; Fri, 27 Jan 2023 00:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ust5T1dOQ0zL+HLLGTDn3zdUYMh/5770ZElRgQ3sPDg=;
        b=obzjvlT1y9jt6kSminE3izVC8zsG+ufoMFpKAz7oy4XW4QKmvCOTcTHXpYMVmCmgdx
         fWsV39ysAELR3n/hY0ldJBfN5QUGlIpo1YvPn0O3IUMBLAQ8gycCUwKtgOJYneCL2kpB
         n6kkcVRyGl3ystC0vK5VQb9YZpsfYah8wElQpMH5ZoQw9lMipH4AWZ+yuEC2LEcnq+U6
         sH1blQqVQU790uWxsio6IAePBfsKDhlgmQtTGXjBwQjTwkwvoSifmup3B+6NntVoovoH
         K6PtteRwWGzWKmqKkMSV7uFK+0ubQthmhBIwC3dkdhda/yxh9gcWLRo+yAQuEr86HRiZ
         bXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ust5T1dOQ0zL+HLLGTDn3zdUYMh/5770ZElRgQ3sPDg=;
        b=d7BbVuIoL20GuMt5OWbwf6BgJn/q7wgUWWae5QKv66+g3ZpqGoIe5Mc9y1rQQYaMVL
         Fr3LeZksbT/GtApgrl3vq3FFijm2VUoiiObNInV5FbGzm1oulZDZUsU5z4gnkxFxxIFx
         5xSbg6NuPS2lEiMeWIvl3BV2qjD5im2zrrDf+PLMzltcHK8siO2BmXVHb6/KdtgonJdn
         lgVAZuWAG852aIxKy6LAnz8mNUmJQsVNtWbXz+P2mUFJ7IYf3q2wJ7/xqXcS7ctvKNOz
         P4pL3sgs/PK/boz5yh/4J5suC2wnTEm5kIXMIS28E3PQyZQe6oFvveXsAzOOZN+EPq8i
         AK+g==
X-Gm-Message-State: AFqh2kqdivjgsb4D8RqEyxrmzC/3paArb+plndHfk2wsqpHkc66bszcX
        3sQj/Pozyv3Ml5wPUdBH59laOClZbsP/165aPMLLxX0CA6uhjg==
X-Google-Smtp-Source: AMrXdXsm/Hv7McSrHeZXMfE8TeNjNxQAnkGxQwfCfkr1WBI7rjZDVKp4ILbZt75wR8jNHQ/kqB6Fpz/eHIeitvmf610=
X-Received: by 2002:a81:6842:0:b0:4ff:e4bc:b56f with SMTP id
 d63-20020a816842000000b004ffe4bcb56fmr3524838ywc.488.1674809460124; Fri, 27
 Jan 2023 00:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20230124141541.8290-1-quic_devipriy@quicinc.com> <20230124141541.8290-7-quic_devipriy@quicinc.com>
In-Reply-To: <20230124141541.8290-7-quic_devipriy@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Jan 2023 09:50:49 +0100
Message-ID: <CACRpkdZTMdK06jfuydwSpwMXLAeoL45EL4z2Msn-po+MjUZxNA@mail.gmail.com>
Subject: Re: [PATCH V1 6/8] dt-bindings: mmc: sdhci-msm: Document the IPQ9574 compatible
To:     devi priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, tdas@codeaurora.org, bhupesh.sharma@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_srichara@quicinc.com,
        quic_gokulsri@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_poovendh@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 24, 2023 at 3:17 PM devi priya <quic_devipriy@quicinc.com> wrote:

> Document the compatible for SDHCI on IPQ9574.
>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
