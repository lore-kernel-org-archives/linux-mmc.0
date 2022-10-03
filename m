Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39525C433FE
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Oct 2022 21:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiJCVtI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 Oct 2022 17:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiJCVsc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Oct 2022 17:48:32 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD202AE13
        for <linux-mmc@vger.kernel.org>; Mon,  3 Oct 2022 14:47:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lc7so25020575ejb.0
        for <linux-mmc@vger.kernel.org>; Mon, 03 Oct 2022 14:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zAYgLaSnCGfa8SU+NH6gwotTtGoSsucybfqj2dUgdAM=;
        b=YlWmmsM7lTJJGalVIwZ9dwi8cj/06pB914EX3vdbkQ3SAmGQFMmvAyIvLc21049fjQ
         Fq4dKUjUbDjZniZlY+L9WcljP/jjGnSu+cSYmxose2/WpSOLsoawP4Xcl7VZ6ORwWEoF
         C3Bm+q2lDDpi+O+luWwuJNztaWEEKEUIqvOTlR2FGWc+GjaEqy8Tf+PD1fH2Bksm1u1N
         kNOMMRVretuRpg00tiGhLEiW9PJpMer6GqP1jMFj7UytD2kTeRekHkkcIZziOMcQqgpK
         /cL+BT1r1aDm9dKSjGNFD7mE3FO/0nSJLXHCOmup6GEsWJoWrrZ6zmx0lM1ACD0HX4uP
         iPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zAYgLaSnCGfa8SU+NH6gwotTtGoSsucybfqj2dUgdAM=;
        b=n8inplPpbPTzGj54MJrwniGTx30O0LsY77ajHBooJnLdI1BGira3XgioKehrYEEtHe
         XQef/Ofy/gwLuDv+Yx73RWIJzWsnvdfUidJKmuHfBwEuV8oYW8PLvluBKpNFT0EMokbl
         EkBUT9oA1wg177UtdifLhygjJD43Hxk3husXhhirUgoFXzh2lk1mM0Qrz6e+Y3wI2oz5
         BYBZnS5VSr4aMu+VQMWt3/j0zOe6+XqecSKrT25ocrfXsfhKJzsauuIdq1aN3CBMWDk2
         ZU/XUqF8JHZgWcw0Ign2rBQVWK5TTUA5sP+etqITpPMSRI99Eq7HmW59Y2OQCAtDLel0
         2Weg==
X-Gm-Message-State: ACrzQf2PiCNGmRklMW60o8VZ7YIaucIUiUVS+3FG+oVqfQDwcs3M5Tfi
        jE3sKTts2NrT+2A8p+AeJ06mkYcj0rdLS0uAp4ZPbg==
X-Google-Smtp-Source: AMsMyM6hJR0vYBEC7jTZoz6vd6S+i+o5RvWHLL1I4lSo6pa/Vl3uXej9EsG3CXyFZAW/4PjitKY0liOJGmvl0h0VKM0=
X-Received: by 2002:a17:906:8a46:b0:781:71fc:d23f with SMTP id
 gx6-20020a1709068a4600b0078171fcd23fmr16909585ejc.500.1664833634721; Mon, 03
 Oct 2022 14:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220927191736.299702-1-marex@denx.de> <20220927191736.299702-3-marex@denx.de>
In-Reply-To: <20220927191736.299702-3-marex@denx.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 3 Oct 2022 23:47:03 +0200
Message-ID: <CACRpkdZwaHJUd4DEOiKXQ96x3UJfQSCz0oxr5d0QpBCnvEydYA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: stm32: Drop MMCI interrupt-names
To:     Marek Vasut <marex@denx.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yann Gautier <yann.gautier@foss.st.com>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Sep 27, 2022 at 9:17 PM Marek Vasut <marex@denx.de> wrote:

> The pl18x MMCI driver does not use the interrupt-names property,
> the binding document has been updated to recommend this property
> be unused, remove it.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
