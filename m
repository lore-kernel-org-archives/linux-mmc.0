Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFF4C77B70
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Apr 2023 14:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjDQOy2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Apr 2023 10:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQOy1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Apr 2023 10:54:27 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F0C1A8
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 07:54:26 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id n193so3621361ybf.12
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681743266; x=1684335266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eCLJYKkdZxZvbI7eE0QQ/0jCg51WhHA8Mmj4rIg827c=;
        b=gSdxnk59aux9Ks7t+xTDiNlOocn2reV6xOQDmdlSTJ43vxmrppndG6NLbFaRjAqblF
         QdXA/0y52JznSDRWedK0EUpxoJogE+Yb990EzRImzifDmxUUa5DHEvyYOoQjeXmXzSrF
         U/C6pbOQIJlFenz9HL9MVrIw+gAt2ewhkKYy1bQ+p3aZ7cDg4AZOPdWLvNJwa+4C9m3e
         N5uRQKuVmGONeNLd+zPpLCXn4Oad95sUKufBoWPRfZ5RHVBPZ8+p/EHhGXE1cUTD0EO+
         MhAtZcLnKt8ewEZse9phadvXm0570iM3fdcDVjk1ZrjGfaB72jdYZnLU9yXy6EWKb1tH
         J15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681743266; x=1684335266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCLJYKkdZxZvbI7eE0QQ/0jCg51WhHA8Mmj4rIg827c=;
        b=VQXGirp0m6K9QrT6JKCTc5eSJMb1VpGJcmiStm5xbDitfIYaT/KTdUgHlft34LYCzt
         z2H2+YIHHtR0/RRM82OmZWqsSKp+le3k3h0fSyR7EDoiQHX7tZN6LcnbIOMDPtXl1SZU
         LmMMMtQA3HPdtEvX5GWFx34qA99xkN5CWqpPWSP9SimBIe2kz9nhT4dI2scWpNP3CRFt
         vezdmXJUGVYgbRmZPdQchBg0I3qPBQltktyc1YAitEE+/ZPka1yWpXkZHfmBkrAo33N0
         cbcUpP4Xs10h5+jf1e5YRhMerF7WZGwjjMzCFhq4R6t6UzP5KmoavDYB7mHsDhtdpuq0
         trKw==
X-Gm-Message-State: AAQBX9erxxVFgDrGfJiRIDMAtR/oLiKhG8QJ4ESAUAg/n6jHuD5GEaOH
        6cqCgXy68+srHA3Z9E8IyCGYhMJJEl9/9VnNuaV9V8NgGyHZiXOeAGM=
X-Google-Smtp-Source: AKy350aRfdxFGvawukgX7i/LFvrRsMe0l7qZMZiU+wDAWzqRJaSyyPr+2CaHJzCh1RfFqYONRoPpitwVxufbScucEh8=
X-Received: by 2002:a25:ca83:0:b0:b8f:6944:afeb with SMTP id
 a125-20020a25ca83000000b00b8f6944afebmr6538932ybg.3.1681743266074; Mon, 17
 Apr 2023 07:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230403102551.3763054-1-sai.krishna.potthuri@amd.com>
In-Reply-To: <20230403102551.3763054-1-sai.krishna.potthuri@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Apr 2023 16:53:50 +0200
Message-ID: <CAPDyKFp9vX+P2eqW+MAB8RbhNgP+ZhYRuWcow4AWrL-psLnbmg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] mmc: sdhci-of-arasan: Add eMMC5.1 support for
 Xilinx Versal Net
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@amd.com, saikrishna12468@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 3 Apr 2023 at 12:26, Sai Krishna Potthuri
<sai.krishna.potthuri@amd.com> wrote:
>
> Add eMMC5.1 support for Xilinx Versal Net platform which has PHY within
> the Host Controller space.
> Also, add Xilinx Versal Net compatible for eMMC5.1 in DT binding.
>
> changes in v3:
> -> Split the 2/2 patch into two, created separate patch(3/3) to skip the
> clock delay setting for 400KHz as suggested by Adrian Hunter.
>
> changes in v2:
> -> 1/2 - Removed v5.1 from compatible string as suggested by Krzysztof.
>
> Sai Krishna Potthuri (2):
>   dt-bindings: mmc: arasan,sdci: Add Xilinx Versal Net compatible
>   mmc: sdhci-of-arasan: Skip setting clock delay for 400KHz
>
> Swati Agarwal (1):
>   mmc: sdhci-of-arasan: Add support for eMMC5.1 on Xilinx Versal Net
>     platform
>
>  .../devicetree/bindings/mmc/arasan,sdhci.yaml |   5 +
>  drivers/mmc/host/sdhci-of-arasan.c            | 237 +++++++++++++++++-
>  2 files changed, 241 insertions(+), 1 deletion(-)
>

Applied for next, thanks!

Kind regards
Uffe
