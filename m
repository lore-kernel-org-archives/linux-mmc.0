Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A2EC32771
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Aug 2022 14:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349579AbiHSOuX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Aug 2022 10:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349209AbiHSOuX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Aug 2022 10:50:23 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAA0EE6B0
        for <linux-mmc@vger.kernel.org>; Fri, 19 Aug 2022 07:50:22 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id v10so4726111ljh.9
        for <linux-mmc@vger.kernel.org>; Fri, 19 Aug 2022 07:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1FWqXs5Wx4+ii9O0yTd+UOY7aeTlUNQo9eTTQ/Pwdds=;
        b=poRali4aA0RFjxnsLM4MDdbP8SK0CzFqhbyi6jGdr+yyiY2sWoSF98X5g46gY1fbfo
         VoliPo0+7dxiqlUQ4TVosiPcNExGO3oLOAtVdCuhxWZ3BOiglKLATjhS1U16rEEMynSO
         eWH1iHe6mzbhYOTMI2CWDDm9qYie5ITwuPZFeKciadE2U+x+0zd0jD+mblc3/+qd8ZVU
         eakvGmGXhDJ3DA7KAoG5o259GfxxBKFRNxlQ7nOAq1QF6et44ReEEF9w1tEY1+d2IoWV
         JPijZ1bmNDtrp3XXW5m5sgEiY3W91TT2VYKI7vINCYQqynI4wEIwT57dyzX39Hix8RSA
         y74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1FWqXs5Wx4+ii9O0yTd+UOY7aeTlUNQo9eTTQ/Pwdds=;
        b=4ZH9Rzj0T+jnHN5XDs8Y9AWy8vL/XWZxgSoKUm3hyzd8QcKz/kJ64Q84+Tc/DIQGg2
         PCfZjspQxRipsFwKKF9dGi1I1IQlNbtCeamFuf3PzyLMtqj/xybH1HiaJPLejPDTMiFe
         Ud+xEfmhOnXpeIfv58XzMHCfbwZdYhSBgO6bLVsPCYuu9u/CTY5nd8ia4D1EXdDZFJqV
         mX/mNA4U9MUgywZhmN1jZwZD5cro2W005liAwLLIP2tI64bj3ZSe9vRDHBha5p9T+wRS
         57w+0pBWSW0Ej3Dj27IzescsbK00wDbfdNlFpKkGLys6QJZVDqrTx0/frXVxXkQeHvyo
         +1ag==
X-Gm-Message-State: ACgBeo282+cnDNUa7GuJbFLFW41PU07NQYJXQ/N8bhCZvA91A6xCkIso
        dYqOt/SchIfBR5XrBJvRYAizwaWRE/QoQq5hwyQ+Pg==
X-Google-Smtp-Source: AA6agR7XJ8a3HtJDoNBCaaLBYEfMgT4vAkCc1/WPMfnv+63vIloLV5zzdxlcjGHLjdaR4WDsbzkARFw/43qVs6xgTm0=
X-Received: by 2002:a2e:a409:0:b0:25e:724a:f788 with SMTP id
 p9-20020a2ea409000000b0025e724af788mr2135653ljn.300.1660920620344; Fri, 19
 Aug 2022 07:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220815073321.63382-1-adrian.hunter@intel.com>
In-Reply-To: <20220815073321.63382-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 19 Aug 2022 16:49:43 +0200
Message-ID: <CAPDyKFovPD_VdZqedzF8AX6i0DHFk0O2=6FcsRwxvYTwzfeZiQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: sd: Fix inconsistent sd3_bus_mode with failed
 voltage switch
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Seunghui Lee <sh043.lee@samsung.com>,
        DooHyun Hwang <dh0421.hwang@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 15 Aug 2022 at 09:33, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> Here are 2 SD card fixes prompted by the following email thread:
>
>         https://lore.kernel.org/linux-mmc/20220721055924.9043-1-sh043.lee@samsung.com/T/#u
>
>
> Adrian Hunter (2):
>       mmc: sd: Fix 1.8V workaround branch
>       mmc: sd: Fix inconsistent sd3_bus_mode with failed voltage switch
>
>  drivers/mmc/core/sd.c | 46 ++++++++++++++++++----------------------------
>  1 file changed, 18 insertions(+), 28 deletions(-)
>
>

Applied for fixes and by adding stable tags to both the patches, thanks!

Kind regards
Uffe
