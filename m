Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E007C05027
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Feb 2023 12:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjBBMwE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Feb 2023 07:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBBMwE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Feb 2023 07:52:04 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790D63AA8
        for <linux-mmc@vger.kernel.org>; Thu,  2 Feb 2023 04:52:03 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id t16so2029545ybk.2
        for <linux-mmc@vger.kernel.org>; Thu, 02 Feb 2023 04:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iTEsYvNbhZUvr3t5FDyaBPDIayK5soN0V1YA6KoE95Q=;
        b=PPfSS12X5711vg3bhuNrJmUVkzvhGet/0lNfQTXDPw/wtNntkEWqMG9cO2+AQaapQi
         MZJcaRC71fY2ZMHLvVtk19QBWC1mCJPijp0uWxSPYRqKKnRf1wK8sVEE8LuBsjsuG+5t
         x1Qfdfr93US48KlEdOPNzlN6NNSHJoWxD+ccOAxBTB+PoK6YHr6Fn8j8ialUwaevYP2c
         aixY6bNdQwbQ+vFjTT8ZPOtdFdyJvVNLLrIZFSz/pqtkbGzYjg1HuIz6De2bTmz4GpwA
         Qam0sl8kV1yAtcdu12tzoopbHGDis2sPmqKBDume7Nod8LxoXbavP03tvajPG2IFZ/lT
         sPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTEsYvNbhZUvr3t5FDyaBPDIayK5soN0V1YA6KoE95Q=;
        b=3z+mV5EZ6pwe7DP84DVRf7lmRkpQypSKdXsHbIXXhThswVPtMTQgmJV726x22oow60
         23/DQ0oI8iTe4UyEVNmFlCuCVdleioY9qWN6kvmyaXylZoalCpoQCGyeXUakjzaAAmo5
         9/gkESvuQnRa33Ky31JMqzZUvl5I+I7+0Vh14RpRMMXUFDb6KR3pZZF6TMpKzn9BVM4D
         MtcMsD/c+fe8bhP/l/3rjmc7Z6diMEbZA5nhvE/gvCVTI5lbeRqJvJI5XgIRVI3FKDb0
         UqYe8co6NTPI6FspgI2pDj5o62KFfF/ix0LsAipLkKpXAsXze893C3rWLv5V0hfVfan1
         oijg==
X-Gm-Message-State: AO0yUKV+PiJA5gJDmAOlx+ZTRkV00+/euOMqfJ7fzBg/rLbCAK7b+BgQ
        RPKcKjzpOS0Umlm8PKhuMOYw55cq2hciSwlM8dGWPA==
X-Google-Smtp-Source: AK7set/IzybDVeByN7olzBbtRq2zPCd8ReB2ZColcl64XBQe7/HYO17UuFBtuhM1xYbR1EXmfXF7asG9PYGE8qn+MFw=
X-Received: by 2002:a25:fe0a:0:b0:7ca:9b40:72a7 with SMTP id
 k10-20020a25fe0a000000b007ca9b4072a7mr435003ybe.130.1675342322566; Thu, 02
 Feb 2023 04:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20221207131731.1291517-1-william.qiu@starfivetech.com>
 <20221207131731.1291517-3-william.qiu@starfivetech.com> <CACRpkdYP7MokLdRtxX9w7p80c=wHDHsoTYWrU53CnpsZ7o6aGg@mail.gmail.com>
 <4529a646-1faf-c858-cfbe-1560ebeb1fba@starfivetech.com>
In-Reply-To: <4529a646-1faf-c858-cfbe-1560ebeb1fba@starfivetech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Feb 2023 13:51:51 +0100
Message-ID: <CACRpkdYAP_WYwfiFxXybqqa8OJw98cxUwJgW0RUCgLLGaV+LJQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mmc: starfive: Add sdio/emmc driver support
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Feb 2, 2023 at 12:10 PM William Qiu
<william.qiu@starfivetech.com> wrote:
> On 2022/12/9 5:09, Linus Walleij wrote:

> >> +       priv->syscon_offset = args.args[0];
> >> +       priv->syscon_shift  = args.args[1];
> >> +       priv->syscon_mask   = args.args[2];
> >
> > Why should these three things be in the device tree instead of being derived
> > from the compatible-string or just plain hard-coded as #defines?
> > I don't get it.
> >
> Hi Linus,
>
> I'm sorry to bother you, but as for the definition of syscon, after discussing with
> my colleagues, we think it is easier to distinguish SDIO0 and SDIO1 by defining it in
> the device tree, and the code compatibility is better.

OK sounds good looking forward to seeing the result :)

Yours,
Linus Walleij
