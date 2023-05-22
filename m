Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17B3C77B75
	for <linux-mmc@archiver.kernel.org>; Mon, 22 May 2023 07:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjEVHcc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 May 2023 03:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjEVHca (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2023 03:32:30 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E909E
        for <linux-mmc@vger.kernel.org>; Mon, 22 May 2023 00:32:29 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-ba841216e92so8296802276.1
        for <linux-mmc@vger.kernel.org>; Mon, 22 May 2023 00:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684740748; x=1687332748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3nKRFXxsoHjfjdv323ChY4z/ZbZPhs8kEfFA/b0p14=;
        b=ZQBKBNbhyGusoEZNZncEPEovCz9ZtzvSsUhyhSUHyzXTHxM4pTaAFa4m9WSjXG3JtY
         Cpp4VN1YENR0DDoAf99GIkp0+KSSIAUV1PwqgbOIsE9KP7QESHwE7bijzkNwtxOt8/jn
         SRTJr71ARxr7S7iyMsJ3cjvugn0Cz9iFXxkA3+AHQ3tea9YqTKuKM1srZu4dZuuH81d8
         +x9dVC95WW8NMbrLtdS5OzsQAQmLeaHPPYQe5WZ7mtTE3QqkdIlUDVHfXjPa53ZHk7iw
         HFOT6bsAmfR1jYA1L3yy1st3FFa8IuXPvy9PeMAo1IzzdUKSAE1R6PFef1EYITbTHGpO
         Ka/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684740748; x=1687332748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3nKRFXxsoHjfjdv323ChY4z/ZbZPhs8kEfFA/b0p14=;
        b=a9bAIZWmiH1tQphwd9kod0g6iTTtQy3DIcVsATGYmH1FgX3heBRgTLxQbgt/9CVbD2
         1BMOmOSXfa770cITli8C2JnHhXiu6URtPFEqqF8mAQSVEhaJ6tdqqw0cU71xkkBGgf9e
         EyxdDnDgUhNmdhfxt4vLNb6b5wy7VG5Pc4R4G7V/Q0jSCtnw77e/4qr4RlZvkq2xETkz
         hhR3sgwwZGnWvSi1yreS26EF4Wm2NS46ss0NoyCLyeDB7ePg4yCLkyFTE6WU+KCzy4mf
         fG9eSfKv6MumlVQj4Q2lAKwkHPr295r5gsespuy98iiu8G0wCZefWnkhJynWnXDIEWMi
         y5xQ==
X-Gm-Message-State: AC+VfDwsbuJfaMpuWYon6q8Wggz5Yw1rkGqjbXLT6zsP8eDkFeV2QTyh
        NQd4jiM9GCbEizdSpeG4F7FAddgtrCi9ExfE4UHCKg==
X-Google-Smtp-Source: ACHHUZ4FkKkNnOjIqxj6cR6guYodDfCoBUf70rR+UN4AF9syzuN5i3kPXu5WUGJ7anEuu333nuhHkKPkvWZV8hR5tx8=
X-Received: by 2002:a0d:d595:0:b0:561:e910:52f5 with SMTP id
 x143-20020a0dd595000000b00561e91052f5mr12470156ywd.27.1684740748447; Mon, 22
 May 2023 00:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125409.497439-1-quic_srichara@quicinc.com> <20230519125409.497439-5-quic_srichara@quicinc.com>
In-Reply-To: <20230519125409.497439-5-quic_srichara@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 May 2023 09:32:17 +0200
Message-ID: <CACRpkdaX3i-O3=8XbLYJ1hXT8dOE7WJUUT6JxOKmWTJwru_24Q@mail.gmail.com>
Subject: Re: [PATCH V7 4/8] pinctrl: qcom: Add IPQ5018 pinctrl driver
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robimarko@gmail.com, andy.shevchenko@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, May 19, 2023 at 2:55=E2=80=AFPM Sricharan Ramabadhran
<quic_srichara@quicinc.com> wrote:

> Add pinctrl definitions for the TLMM of IPQ5018.
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Co-developed-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [v7] No change

This looks mostly fine, but I want you to consider Andy's remarks.
With those addressed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Can this file and the bindings be applied independently of the rest
of the patches? In that case I can apply v8 bindings+this patch to
the pinctrl tree.

Yours,
Linus Walleij
