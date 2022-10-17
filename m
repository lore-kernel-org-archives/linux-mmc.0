Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85748C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Oct 2022 11:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJQLdB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Oct 2022 07:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiJQLcy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2022 07:32:54 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6347FFCC
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 04:32:53 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h185so10167885pgc.10
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 04:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rrl2OknZsaWiUDo+xm2A7h8HEBYe0c3y7aA5IiC4CCA=;
        b=jhB+41Qw6gWGX6XVB2dXsAneYHLfN2fk727EVAP3U7CqiRrLU+78WvWnC02wXgVI2x
         QCEXvet4qoPcNEeKNwdc18k2GuUUt2yP0pBZzeXchAUTMUKld+B7eTzu8mrOrPwcTYxv
         cNsgRFAASvvzKaCYnEPIF3/ZJoB2k4SYWRfSuVB8R3XijpixCcTD4g9ID0hVXFes96ag
         Vu4mx0aE7pE/w2E6WwhTz4UEh36a87HUspEwUsXsFMfN0xUlCcIp60zPfuyNVUQ3g2BC
         SPQrpyckwMQMAm2PenZLHQZOFhgma9QHqPQFS3T89DlrzwFJSQgLQaUKJzI9yyBWiGO0
         2TSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rrl2OknZsaWiUDo+xm2A7h8HEBYe0c3y7aA5IiC4CCA=;
        b=mjStWF1sgMu1K8DtEesoulqejBcPHGrwHNyVotLFMp8vwIj3TLki8E9JAoTsBMWxYu
         fqkDvLrRwG26ifjZvjG+OmxbxlO4wsDAxbOkaQyB7rHq6vDPLf2+CQnOuGCcrXo5q4sn
         dLERDa/ou0ryhFVKdHtUQ+qveQgP3/9nQLCMxsn0zcxFzi9SsNwQoOTiD1DVJgQDRtSZ
         DVvXjvAO6R8Jh8oozYGgmUDd6IG6H98Sx5ASgbzqiw8H89kvpnB7ohQRot1hmgu3L+9p
         4lfsDCJ33NL6bwvcbhUr01K9JbPrBrFJI9P/7QEMaHp7lscFZZy3fzz7T4KBrVskS411
         TzYA==
X-Gm-Message-State: ACrzQf0V+sF0kNoMs0HPiOlvL2Pm/L7vsO0aZOQUUMG+z8nxB91TmzZA
        84JU0Pjf43yNgdAqxuev0AqTBgbm4KLDsktpEdRINg==
X-Google-Smtp-Source: AMsMyM4OqEFxEYjNvU2z31snfcvpPzLkTeQxsTaaLdl0ZuMkoL07Y1cJeXe9yI6lV13pcRZ5g3xtZBX5Oyvl+6U7d6E=
X-Received: by 2002:a63:1612:0:b0:461:4180:d88b with SMTP id
 w18-20020a631612000000b004614180d88bmr10597542pgl.434.1666006372909; Mon, 17
 Oct 2022 04:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <7ee7fdb6a46fc9f0e50c2b803ede6b4b2fdfa450.1665558324.git.geert+renesas@glider.be>
In-Reply-To: <7ee7fdb6a46fc9f0e50c2b803ede6b4b2fdfa450.1665558324.git.geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Oct 2022 13:32:15 +0200
Message-ID: <CAPDyKFqjq5YwXwxmvyOWwqiXYPrfBgp-yBOVLH1ekF86fihZXA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Document R-Car V4H support
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 12 Oct 2022 at 09:06, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Document support for the SD Card/MMC Interface on the Renesas R-Car V4H
> (R8A779G0) SoC.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index 0424b06cb6551e00..7bfb10c6256602e2 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -64,6 +64,7 @@ properties:
>            - enum:
>                - renesas,sdhi-r8a779a0  # R-Car V3U
>                - renesas,sdhi-r8a779f0  # R-Car S4-8
> +              - renesas,sdhi-r8a779g0  # R-Car V4H
>            - const: renesas,rcar-gen4-sdhi # R-Car Gen4
>
>    reg:
> --
> 2.25.1
>
