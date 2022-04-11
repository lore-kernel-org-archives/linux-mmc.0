Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A56C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Apr 2022 15:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiDKPVU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Apr 2022 11:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244274AbiDKPVT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2022 11:21:19 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F8F136;
        Mon, 11 Apr 2022 08:19:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r13so31628537ejd.5;
        Mon, 11 Apr 2022 08:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fej47CfixVgPG/8tAe3B68WAc9QzMj+LhfE1bf6mdHc=;
        b=jD9MaBAIHx7E4aQHXu/BECkBObNtPbqFVEY9DF0mITyo+lkTI/fnGWkGJ/1BL+Gd4V
         +tf/gFyTMBVLefBt+Jiy87iLc/GFyKWbPCvUUfr3YQuY3VHUzoWygchl5F4A2MQh2rZQ
         iEjb7Ud1HMoayECdcHLn/eYbJ/qsaxEvc2kAujKqz2r4aFGF8ubWwUq/JS6QhU08MMmd
         q4tLWyE9vtitTttFJXG6ZjAx9zAt/J4jU9iU0kuSD03+fdPx0AQOI5lTiFzZWwVxwy+E
         xW3YlUSvtXo6zDtTJ0Sf6qNebJgGea2i+8p17GhGb3j2UhmcuVN0nOG7QudVBFIr5pm9
         4AoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fej47CfixVgPG/8tAe3B68WAc9QzMj+LhfE1bf6mdHc=;
        b=aeBxXe9XWC0zwvPc+W3g5uJbMmAp6kF87XjpfoKRGE7SElKrNzv0NVKOso3XHJ+/vX
         KIRA6nvx20hAwus+F16+oZxB2t9YWg7qVTSCgl2dAFcBf9vqDnIReKJ12lm+SOXcLy3U
         /OdHSQXPgcTod/Ey+rXt5u8ZvZubBKrfjDL7fTOez8JEhuo5HQqEmvzW9byKAdCQD3nf
         onUfzxotYwL5/0Q23tWXCz/b68uG9u5hluTdx1O6GytIAda7GcYrZgwMhKEopRGdpKu0
         fwmkMtwU45fgqw6YAX8L3UJolNZZ/nTTnVEL6X51dlg4z0GGwy9FslmFBvGVaBygyt1S
         xtDA==
X-Gm-Message-State: AOAM533wy8Zc4VZ83WFHe/fAPTfWXkNcrjyH5vieN27zD1fdYafCjNpd
        Ah7kwkuKBr7zeJfoAowAFYzCi26wOu9FVDN+dNk6V+xgqXw=
X-Google-Smtp-Source: ABdhPJy+ii2nkk759zthtMe3RU2DqWHDHIqPX16lClgCQ18ZzQ5HFYN8xZzKc4Xaq3XAWkbK9F4qIhNPm6K1PIT6Gs8=
X-Received: by 2002:a17:907:724a:b0:6e8:4f12:b6fd with SMTP id
 ds10-20020a170907724a00b006e84f12b6fdmr14444674ejc.198.1649690340917; Mon, 11
 Apr 2022 08:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220410193544.1745684-1-aford173@gmail.com> <6c4b6eac-86d8-eb93-37a5-d0fa9bf2a7d2@linaro.org>
In-Reply-To: <6c4b6eac-86d8-eb93-37a5-d0fa9bf2a7d2@linaro.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 11 Apr 2022 10:18:49 -0500
Message-ID: <CAHCN7xKpoCrLgFfM30ZgYCgTan7FymhopcMQE0=VkzNuYryu9w@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] dt-bindings: mmc: imx-esdhc: Update compatible fallbacks
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Apr 11, 2022 at 1:42 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 10/04/2022 21:35, Adam Ford wrote:
> > The SDHC controller in the imx8mn and imx8mp have the same controller
> > as the imx8mm which is slightly different than that of the imx7d.
> >
> > Using the fallback of the imx8mm enables the controllers to support
> > HS400-ES which is not available on the imx7d. After discussion with NXP,
> > it turns out that the imx8qm should fall back to the imx8qxp, because
> > those have some additional flags not present in the imx8mm.
> >
> > Mark the current state of the fallbacks as deprecated, and add the
> > proper fallbacks so in the future, the deprecated combination can be
> > removed and prevent any future devices from using the wrong fallback.
> >
> > Suggested-by: haibo.chen@nxp.com
> > Signed-off-by: Adam Ford <aford173@gmail.com>
>
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
Thanks for the help and guidance.  I always seem to struggle with the
YAML syntax.

>
> Best regards,
> Krzysztof
