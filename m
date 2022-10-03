Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9560C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Oct 2022 21:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJCVsd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 Oct 2022 17:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiJCVsA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Oct 2022 17:48:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F28F28E25
        for <linux-mmc@vger.kernel.org>; Mon,  3 Oct 2022 14:46:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y100so15880423ede.6
        for <linux-mmc@vger.kernel.org>; Mon, 03 Oct 2022 14:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zAYgLaSnCGfa8SU+NH6gwotTtGoSsucybfqj2dUgdAM=;
        b=RVCHdxanJVyFUUSS93q51N8+I1tKBI9oAEVRe7ilmYWZ9MVp144gXBv1kYTZdfHXIo
         9lc93g5a6zAwnxi+IvV2eQNDN8yVYIRsARw/tGeVX/FTGHISN76GQUHSB3tL9GTLt00u
         eaJXvON2TmHWt2QX/iHVvDkb5d9bfrmez1YjXEUlbBiEdj27TfLdfIFFL5y6gpQ+HB9g
         6Kokd8mvIrOqXQULEHmMy46RbGcqbunOiWoiW2Wx86hYFaA4BXH7JGY8TsdecRAaO+fZ
         zdlQsot4zbqHoFw4uG+RwUovIZPv27RaBx1HSDOxt7kpH+qPCULMl4xg+lh8TgQkDJci
         hOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zAYgLaSnCGfa8SU+NH6gwotTtGoSsucybfqj2dUgdAM=;
        b=cWHQYpFxXXHBDEFdkgDXze7+/QTJd274sq2f6Fr4FSadSqZFvD0o7eF5zayXkt6qC/
         c+yqua6L4hl+mY0AN4PS5AZncqi2J/8uKpjBMoayOxxDrLF5cYIOS0ZPiDZHIwUTYcqz
         zhXGG2bYXYbyQ0ySh+QEgcDgSW5ZFvt8I7wJCYQwhGNbxOqKLT24SN0SUVd9hOToVfvy
         2EqPDc1e1B7Z6umXMXiUKn6WrgHDWWMqpwsu25uxzaMd9js+XvQEiL5jlG73mNklbRy4
         j9d7fYNGf6LzSgOKx5LQoscsxtYm60FJFKlIL57pwSb4MQSve0dPEdBvHB7MgTNCcTnu
         w3LA==
X-Gm-Message-State: ACrzQf2c2pPu1cgFythVvsjkQBXxEylnWgH9U+J9s4WHHhN7gRwyWyjd
        kS1jq9Nmgme8DPjjJ3yP1Uxht0RV5qUQHaSTfI293w==
X-Google-Smtp-Source: AMsMyM5UrjbvOzcq6FmvgXykvlePJByBD7ZIVQlTnIbpQrim0/itLwb6Rh67og69RE+wWbcGISW74QVzBjgoCyQJcgw=
X-Received: by 2002:a05:6402:2690:b0:452:3a85:8b28 with SMTP id
 w16-20020a056402269000b004523a858b28mr20040077edd.158.1664833616720; Mon, 03
 Oct 2022 14:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220927191736.299702-1-marex@denx.de> <20220927191736.299702-2-marex@denx.de>
In-Reply-To: <20220927191736.299702-2-marex@denx.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 3 Oct 2022 23:46:45 +0200
Message-ID: <CACRpkdZRq0oOXfn0-SHG5Rv0=f_Lb=-+Yy0ST_tY9+JPqxwV6Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: qcom: Drop MMCI interrupt-names
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
