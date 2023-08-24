Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A8EC3DA6F
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Aug 2023 10:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbjHXKAY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Aug 2023 06:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240905AbjHXKAP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Aug 2023 06:00:15 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1921BEF
        for <linux-mmc@vger.kernel.org>; Thu, 24 Aug 2023 03:00:03 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-58fb8963617so53718617b3.3
        for <linux-mmc@vger.kernel.org>; Thu, 24 Aug 2023 03:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692871203; x=1693476003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g5rBPrC0vQuMcmp4DDXqhGWwYLuvH0qXFYCzdTPwswc=;
        b=UvHbie/8LWoOd9pmsDUaYRgDhjjMFGDF1C3OOlCJ5qJ2CvjeQUuaV2iX/fcxhlVXg1
         txgK80KGJJY33qF2q8Y5tGr+k9h/HzuX2NDw2x8vk37SYnNAsXc0GEJ2Vp9RPrr4seZ9
         vatxLLtKsnxhb21G4mZZRAD8WmfUcWQ3Eq+SUe/6DwEv/TNp4h224VUnibnPAVj9kGFw
         +4HQRuFlmF5BjyBjswmH4RRvRPWW04XnmYYAXPylv2fxSJYKA95oQvGesF0t9yQ6ttLG
         EbyQhIVz8m3e+4p5VLqmbX+Kutok5QytFDrrltEwBSkpLu79JsS2Oj/doGQ+UzqnBScp
         qDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692871203; x=1693476003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5rBPrC0vQuMcmp4DDXqhGWwYLuvH0qXFYCzdTPwswc=;
        b=ElnzpWAk93IMOZ7CgM34zGfqzEZgdju7fGY0O4P85oc1UIxVko60uAu7qPqxe7yBjI
         wHvBpf3+lbVPbMkHH57Ct+dMVjTFwQ4a56v6SNg3p6zS4foOKqGMQ20nwdmS80G7TAQs
         VBjc/VlRDWgUdYvm6nL4fL9Dz/ZI4rUPSlv65BZnV5DnyEgGLTLJ0Uey7CpYym1cFL88
         5WAmOm6Zee3YaqAtUcafca424U5VBu4swPFie4MG8416XuWtaV5LH2VM4dG3KQDf/Na6
         R/KbHxJbfX4qzpyDIpKCs928KdA0VAWBmL5uJpieqK/WY7OS3yrDXplKIQ516Jq7JOXD
         LitA==
X-Gm-Message-State: AOJu0YxHFAmm0CpCKSzhR2vK1JCTopuDiHvEfSwA/idsYRPE++zG8/Bl
        4IuM7il/9vWbyiDRpctEEAZFOCkVXD4RBbmgOtM+qg==
X-Google-Smtp-Source: AGHT+IFCajrkQF9SFLOKPslL3gpX83VYgr+19SYAR8dR/LwPG2vSDJtUovktxg/kfqHey2hK+xu2RcKp9dNsJTnze8I=
X-Received: by 2002:a81:8882:0:b0:55a:3ce9:dc3d with SMTP id
 y124-20020a818882000000b0055a3ce9dc3dmr14818684ywf.13.1692871203062; Thu, 24
 Aug 2023 03:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230815014057.13589-1-wenchao.chen@unisoc.com> <20230815014057.13589-3-wenchao.chen@unisoc.com>
In-Reply-To: <20230815014057.13589-3-wenchao.chen@unisoc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Aug 2023 11:59:26 +0200
Message-ID: <CAPDyKFoMR_rX5O6rmp94SsBZL0=VeCgtanZzGVmTHcUihmHyKA@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] mmc: sdhci-sprd: Add SD HS mode online tuning
To:     Wenchao Chen <wenchao.chen@unisoc.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenchao.chen666@gmail.com,
        zhenxiong.lai@unisoc.com, chunyan.zhang@unisoc.com,
        yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 15 Aug 2023 at 03:41, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> First of all, Unisoc's IC provides cmd delay and read delay to ensure
> that the host can get the correct data. However, according to SD Spec,
> there is no need to do tuning in high speed mode, but with the
> development of chip processes, it is more and more difficult to find
> a suitable delay to cover all the chips. Therefore, we need SD high
> speed mode online tuning.
>
> In addition, we added mmc_sd_switch() and mmc_send_status() to the
> header file to allow it to be usable by the drive
>
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> ---
>  drivers/mmc/core/sd_ops.c     |   1 +
>  drivers/mmc/host/sdhci-sprd.c | 152 ++++++++++++++++++++++++++++++++++
>  include/linux/mmc/host.h      |   2 +
>  3 files changed, 155 insertions(+)
>
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index ef8d1dce5af1..a59cd592f06e 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -323,6 +323,7 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int group,
>         return mmc_send_adtc_data(card, card->host, SD_SWITCH, cmd_args, resp,
>                                   64);
>  }
> +EXPORT_SYMBOL_GPL(mmc_sd_switch);

Please move changes in include/linux/mmc/host.h and
drivers/mmc/core/sd_ops.c into patch1. When doing that, please update
the commit messages too.

[...]

Other than the above, this looks okay to me!

Kind regards
Uffe
