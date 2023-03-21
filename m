Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFD2C761A6
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Mar 2023 10:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjCUKwK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Mar 2023 06:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjCUKwH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Mar 2023 06:52:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B35A93C0
        for <linux-mmc@vger.kernel.org>; Tue, 21 Mar 2023 03:52:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o7so13174981wrg.5
        for <linux-mmc@vger.kernel.org>; Tue, 21 Mar 2023 03:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1679395923;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=K68XFluEkJ4EyRHJihXO8/AhJVwZseuuuSGDSObQY3Q=;
        b=fpY2Lc/LNVH4063nraiPu6JJwbMVe7kciEmg4YMy729ZFshtgzOmhChumgtEIdVQtN
         YHHfEN4Ftgu5pSNSZuF0qvoDPopC6ThvEmU3DSUpZd5UU4rXczI/alLwGe4mfT3KulQq
         br7dB0Gqixii/Nix6fcsD42k/bgP9SdBIRY4X2BXrqVvFKtzxXUbuX68ZXVEkpc4ace+
         mSSXKwX3or4PVABNmH0mc5BABVq/MR+4d0pgeq+NZU3NQYq+sbCeuc+7MdxrX14GBcqm
         6FTy/tg6an6FpCjJSB5XmtA+E4AUoYpKR6af4quxuslqXeikSEXo/XjBm//+JrcCX2ep
         Ty0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679395923;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K68XFluEkJ4EyRHJihXO8/AhJVwZseuuuSGDSObQY3Q=;
        b=HTuvCoXby79B6t2X0uhmLPfzsT8lN40hCs3mKIjxk9qfMSdI+kMRyIyHeF6PnYI4op
         vZubPJs7W+CVowyDaatEU73HawIPy3NmWPBZeudpUSxuToH+t8huq/hSBd/3Z2+e4PmB
         UIVtQkgwbA9JhXQqozPLCx5QV7bjwaO3FW37/Aog4l2xHLV+AgKX308sZhSrP1FFUA2n
         quUTBed3kEdTU5NzSzLLiCj1bNeYCzX6CP3yRoVEoUh3+0/0WqqnPtuhRlhqwqbl3fRc
         Tituwd3ieOyQcdVvWG1E9S3IEAeRscjPl9IHlZ5tm2RVlTEV6K8xLuV711neVKKNzzJd
         TLTQ==
X-Gm-Message-State: AO0yUKUnBMLQhbpQaw0qNS1j56L5G3g7zHqcAyn3nf17L8SgdBQOlfbZ
        gBXTDnQgzIPcdGneqj3TdChHkw==
X-Google-Smtp-Source: AK7set868qGoElUpfskvJ9bfPpYZPqFEK55esIAH/gTwGF/+V98A4OOLYzWOB74M6NG2BH6E97IH2A==
X-Received: by 2002:adf:ec8e:0:b0:2d9:10e7:57e8 with SMTP id z14-20020adfec8e000000b002d910e757e8mr1312758wrn.16.1679395923106;
        Tue, 21 Mar 2023 03:52:03 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b18-20020adff912000000b002c567881dbcsm10944294wrr.48.2023.03.21.03.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 03:52:02 -0700 (PDT)
References: <b9bd16cb-f1fa-34b7-d599-8637cbe5032b@free.fr>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        linux-wireless@vger.kernel.org, MMC <linux-mmc@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Pierre-Hugues Husson <phh@phh.me>
Subject: Re: [Performance regression] BCM4359/9 on S905X2
Date:   Tue, 21 Mar 2023 11:46:57 +0100
In-reply-to: <b9bd16cb-f1fa-34b7-d599-8637cbe5032b@free.fr>
Message-ID: <1jh6ue74x9.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Tue 21 Mar 2023 at 11:40, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:

> Hello everyone,
>
> I've been benchmarking an Amlogic S905X2 board.
> It provides a BCM4359/9 WiFi chip connected through SDIO.
>
> There's a large performance gap between vendor kernel and mainline.
> (Downloading a 1GB file to /dev/null from a device inches away)

The title is misleading. You are comparing different sources. This is
not a regression. This is merely a difference.

If we are talking about mainline, then which board is it ? What is the
corresponding DT ? What is the MMC configuration in both case ? Have
you checked you are running with the same clock configuration to begin
with ?

>
> # curl -o /dev/null http://192.168.1.254:8095/fixed/1G
>   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
>                                  Dload  Upload   Total   Spent    Left  Speed
> 100 1024M  100 1024M    0     0  27.5M      0  0:00:37  0:00:37 --:--:-- 28.6M
> vs
> 100 1024M  100 1024M    0     0  11.0M      0  0:01:32  0:01:32 --:--:-- 11.0M
>
> Line 1 = vendor kernel (4.9.180 amlogic android)

This cannot help indentify a downstream kernel, and the infinite number
of forks and patches associated with it.

> Line 2 = mainline kernel (6.2.0-rc8)
>
> Why is the vendor kernel 2.5 times faster?
>
> (I'm using the same firmware files, but it seems the vendor kernel reads
> an additional configuration file that the mainline vendor seems to ignore.)
>
> Regards

