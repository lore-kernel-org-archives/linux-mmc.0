Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A684C433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Mar 2022 15:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240607AbiCKPnW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Mar 2022 10:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244664AbiCKPnV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Mar 2022 10:43:21 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9748D1C665F
        for <linux-mmc@vger.kernel.org>; Fri, 11 Mar 2022 07:42:18 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bu29so15808751lfb.0
        for <linux-mmc@vger.kernel.org>; Fri, 11 Mar 2022 07:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YEdqLPEI2AXx+itJdHGX41gc8vi6n5cOXM43vTubJaU=;
        b=YmtDSruBKV4oOpGvsN08lxa7fwgYlY4XC/CEpQ4NDqF1WhQKz/D7opPlzGD1d35lK0
         41DbzsjiyMUBvP3s1b/l9TedySpokIoyjMa//GicR3u/vOsLzSn1mpuzRKrNSnSzVjJP
         EdWORRwfVYD/WT1ToNr9ckPVpY0Q6HQ5FvtGYz4QWpjmTDmFn+LT39EXLmbZivSCAd/9
         gwzkM2YX5H8kax/jsADAeX8LRc9uv+p5Dq1+9EI9iJ/T1w3H8ig0X2hGbiOxC0ZKIGDl
         LOQMe6zqpHYLxO4tIEFLYMoqc/QDGOJsxbgXZY3VyVJvn4AM+KR9EUS+G51g8Chp/vbp
         gTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YEdqLPEI2AXx+itJdHGX41gc8vi6n5cOXM43vTubJaU=;
        b=CPjmzMXgzSJjcrVROv5Ga69I3HULzXst0W05PKK2owPwptYCNu7HIChBHylRn2K7Mj
         cknLOa+O4rWhJs47CVnu4TQkXg+lGhDC4uhznRzA9fQcZUdnrOxYlvwY4DElywd5svaL
         nmyCB+14Nsw1B+oSfaKY488xhkSJXRjbu1PvDKeUrKOYIcWTwYehAd1ZYVXIjRqJ2IN1
         BLqdNDi/dQahHh8yut03aHWqG72/GDc1fn/EgErVgdfGs14QNz7gF7uAsg0YVbKERUWI
         D9wzL5gzJHyPebmdLXx7+URn7o5YZfeWLPl6cnHbhkBne3YaBil3e7s2+7dc4F6+Q4mX
         uwYw==
X-Gm-Message-State: AOAM530ozuQTFrYjmuE/Xi8YeyIE3I6gjDR1GKx02n1KgHSbXz3HuXw3
        Xgd/PS/is3dEEpSQO/MIinhKeNRbNzIw+FK/kMr/2A==
X-Google-Smtp-Source: ABdhPJxvSkQW1ExcoHOJfIPOxdpXlTzooEuOowmiFyfyqfj1CMd2uuW4o9aFa/ViLsaVrUCXzwMkyUzRlvlQ2xtX/Qs=
X-Received: by 2002:a05:6512:308e:b0:448:3826:6d68 with SMTP id
 z14-20020a056512308e00b0044838266d68mr6105279lfd.184.1647013335908; Fri, 11
 Mar 2022 07:42:15 -0800 (PST)
MIME-Version: 1.0
References: <20220307143421.1106209-1-andre.przywara@arm.com> <20220307143421.1106209-8-andre.przywara@arm.com>
In-Reply-To: <20220307143421.1106209-8-andre.przywara@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 11 Mar 2022 16:41:39 +0100
Message-ID: <CAPDyKFrNGMd7MRAuM+4oHB9pBjA569Hbzz0BJOxcNk_2KOYwVg@mail.gmail.com>
Subject: Re: [PATCH 07/14] dt-bindings: mmc: sunxi: add Allwinner F1c100s compatible
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mesih Kilinc <mesihkilinc@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        George Hilliard <thirtythreeforty@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 7 Mar 2022 at 15:34, Andre Przywara <andre.przywara@arm.com> wrote:
>
> From: Jesse Taube <mr.bossman075@gmail.com>
>
> The Allwinner F1C100 series contains two MMC controller blocks. From
> comparing the data sheets, they seem to be compatible with the one used
> in the Allwinner A20: the register layout is the same, and they use the
> same separate sample and output clocks design.
> The only difference is the missing reset line in the A20 version, but
> both the binding and the Linux driver make this optional, so it's still
> a fit.
>
> Add the new SoC specific name and require it to be paired with the A20
> fallback name, as this is all the driver needs to care about.
>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> index 4f62ad6ce50c..76137132500d 100644
> --- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> @@ -55,6 +55,9 @@ properties:
>        - items:
>            - const: allwinner,sun50i-h616-mmc
>            - const: allwinner,sun50i-a100-mmc
> +      - items:
> +          - const: allwinner,suniv-f1c100s-mmc
> +          - const: allwinner,sun7i-a20-mmc
>
>    reg:
>      maxItems: 1
> --
> 2.25.1
>
