Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC614C3F6B0
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jul 2022 15:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiGZPBT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Jul 2022 11:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238746AbiGZPBT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jul 2022 11:01:19 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51694248E4
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jul 2022 08:01:18 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id b16so10543225lfb.7
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jul 2022 08:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Abp4O2phjlQwqXSiq9vrzI7rfG09ZHavgh2SmBCZxI=;
        b=FNgYeohdCATVAP7X2iU36R9MeHDqIbl1lqmT50Bo1fwMpKLGUi26xD8u7IdsBxpDNr
         Wr66GNWgOu5zxSsqL/8P7lyTUyVZ+aN6us+npUllII5a1OB0/qOkaX0t0gy3zcEySwFo
         DEYukwmIhobCcct4j6e0Lrn58FTitKxBfWgQSw8pxQWFmS9BhxdRdaMI8cm618dc3rVK
         4Ok/3YT3C3L6Fs1CIH0OYz201C/kLUg3DUrQDRzMAvm7aB/iA2Dcp7LrIIugeGyjSVW2
         NSitrE1iGO764X6mIHq1mZDJXJgWIGdMbAEcP8YIoidic1iUBcteMr6K8ie06+8OsP3r
         ah9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Abp4O2phjlQwqXSiq9vrzI7rfG09ZHavgh2SmBCZxI=;
        b=s6RdbYSpSf/hkGltJBMkBnQVaM/cNLFQQ/8h0JU6vLWKqAO/6XVt68AT7p2suGL6+k
         HXIG4t13sfhMHs8S6naK7k3+925sB5foKxsb2CneFAGmdRDlzhAL3VEuTUX01VnmXSB+
         QQP6dd/Ff8V1HfGO/QvAFeZBo20WFmphg3FSQLDbTyxZW0EaJ7hSUWXpZUCg7TNcKHRn
         mPoZt3tYvK1Tlu3SkaVaNv/3ijGcHaB6QhcJehu//yZ/HwoJuyV7id/zMH9rDg6t1hbh
         n7P9//5Bu/wsDheRNouvbnwwBIix8bLXDZTlXBK4XD+93WSys5sEQ2/H/0JeVHkEGoFy
         xaKA==
X-Gm-Message-State: AJIora/V8ktdtgSPAqDN0mGZhwXXd7ZQQ0VJHPLcACvEaisGHNxTutfm
        wBAEGnGpOY+zmxyp8tIlsduNezoWyUarW75nO8NRuA==
X-Google-Smtp-Source: AGRyM1tWqxY9BYKQk44juX1eKWFfDs070weNDGQdXByMLPBbsJzkZx2RmQqqnjwR5M0SiaGb9Mt98TJpDepqL0XK05E=
X-Received: by 2002:ac2:4249:0:b0:48a:9f05:776a with SMTP id
 m9-20020ac24249000000b0048a9f05776amr1542411lfl.184.1658847676121; Tue, 26
 Jul 2022 08:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220723204335.750095-1-jagan@edgeble.ai> <20220723204335.750095-12-jagan@edgeble.ai>
In-Reply-To: <20220723204335.750095-12-jagan@edgeble.ai>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Jul 2022 17:00:38 +0200
Message-ID: <CAPDyKFp0bqiAnvQpNwD5JzKe4vUAGe7RH6Gog6VScqbea376iw@mail.gmail.com>
Subject: Re: [PATCH 11/22] dt-bindings: mmc: rockchip-dw-mshc: Document
 Rockchip RV1126
To:     Jagan Teki <jagan@edgeble.ai>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 23 Jul 2022 at 22:44, Jagan Teki <jagan@edgeble.ai> wrote:
>
> Add a compatible string for Rockchip RV1126 SoC.
>
> Cc: linux-mmc@vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Jagan Teki <jagan@edgeble.ai>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> index 54fb59820d2b..8d888b435817 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -39,6 +39,7 @@ properties:
>                - rockchip,rk3399-dw-mshc
>                - rockchip,rk3568-dw-mshc
>                - rockchip,rv1108-dw-mshc
> +              - rockchip,rv1126-dw-mshc
>            - const: rockchip,rk3288-dw-mshc
>
>    reg:
> --
> 2.25.1
>
