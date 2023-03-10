Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05036C64EC4
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Mar 2023 15:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbjCJP1P (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Mar 2023 10:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbjCJP05 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Mar 2023 10:26:57 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EE614ACFF
        for <linux-mmc@vger.kernel.org>; Fri, 10 Mar 2023 07:16:00 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so5493739pjz.1
        for <linux-mmc@vger.kernel.org>; Fri, 10 Mar 2023 07:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678461322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5g8vR07GTWTUVecdpjiYPq809ToUsFQgWiHCdhz5c0E=;
        b=BLqIw4BvC1iedATySI8RkLDa1iN8lrVN6q1548MCHtVfgY2S/U32LS+zave6+iOdRu
         1A9dK8ybmVg7cJNQRULvAn8JkIy87BLMpScULmgPl/SNXLG5juTSDWTYmfJcXrqFU0cd
         uYqbOUZLjS2frQNKhTC+6q/LZqHCRdkXHV5knmV7mjwTGdwV8WgDNl8Jr/GnljBptjHi
         Ah8UQosX11dX80119KvSos53T/Gc9K6BuaTkInYWzNZydxg9Cv9f79DDURj8dOFFbJGQ
         PgsRhUb+5lFwKAUURicL/xJiQ4LgjaoIGM45XJoD+jfT6qf5PEqm1QwCPdp0IyToOpE3
         SRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678461322;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5g8vR07GTWTUVecdpjiYPq809ToUsFQgWiHCdhz5c0E=;
        b=j3nLS2EyfO9eCjd2HKbVZE4BefT+CFY0suarjFvCIiQgrgf/qYpGmyb6PtchVBP092
         GtRwCkGl/efezNqM95ShyRNqXvB2qNWgB7ZmWUMojdK2d/x18gV4OViGeqN0QmdxkJ68
         CuqCVFnDZUeMuWEUlexr55mN8vjcv33JKbWxkgy0q+UZueR3ZQVLqRgReZspPkvp+sYY
         YEB0H4l9t0L4h19kyRgKLIK+eSwC4sHwlxmvqjKYVF1tRMPXDsMoKTE7gcR64sTOSpz2
         t4GQGPszHnk6bRK1c1Hj+qdTQKyxYUz4tyDobDUyjxx7VnoSTTI0w2NxGwF94xWyWGrW
         Qe4Q==
X-Gm-Message-State: AO0yUKWJTSaeUhYoZCR6i3VzSTE+XOyxyi3XBRRlIB7g10+8PLRVSxqJ
        3cstApUj4cZ47Q60VFHGmNUBzBGHRiGyHAyavCeEMHx0Z9iXt66z
X-Google-Smtp-Source: AK7set8XfEUKPvF0aeKfAH+x0DFIfMT8p/xVEeTgibM3QZAdqTaiEh0H9ZQj/m69mh73RyFH8CKsu2Px8LEpKmL50Ro=
X-Received: by 2002:a17:903:2c1:b0:19b:f946:e57d with SMTP id
 s1-20020a17090302c100b0019bf946e57dmr9890237plk.11.1678461322689; Fri, 10 Mar
 2023 07:15:22 -0800 (PST)
MIME-Version: 1.0
References: <20230310144714.1543767-1-robh@kernel.org>
In-Reply-To: <20230310144714.1543767-1-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 10 Mar 2023 16:14:46 +0100
Message-ID: <CAPDyKFr84WTrA8Gw7Jfq9tZGQJ8SXbg1E0gYvQJ9TBx3Qn7fdA@mail.gmail.com>
Subject: Re: [PATCH] mmc: arasan: Use of_property_present() for testing DT
 property presence
To:     Rob Herring <robh@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 10 Mar 2023 at 15:47, Rob Herring <robh@kernel.org> wrote:
>
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 89c431a34c43..415f44bf5ee6 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1434,7 +1434,7 @@ static void sdhci_arasan_unregister_sdclk(struct device *dev)
>  {
>         struct device_node *np = dev->of_node;
>
> -       if (!of_find_property(np, "#clock-cells", NULL))
> +       if (!of_property_present(np, "#clock-cells"))
>                 return;
>
>         of_clk_del_provider(dev->of_node);
> --
> 2.39.2
>
