Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ED1C77B7A
	for <linux-mmc@archiver.kernel.org>; Wed, 31 May 2023 10:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbjEaKYZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 May 2023 06:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235079AbjEaKYR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 May 2023 06:24:17 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64975E4A
        for <linux-mmc@vger.kernel.org>; Wed, 31 May 2023 03:23:53 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-5555765c6d3so3558495eaf.1
        for <linux-mmc@vger.kernel.org>; Wed, 31 May 2023 03:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685528632; x=1688120632;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4KXSQQ/9ar4MzESgExahvhVjXiG8Va2wwqkfhkK8QA=;
        b=LZunoV/4iuQ04byrQIITaeaDa+d8du9w6ROnmymFx5ySjRY5wMFJ+I91XyV0fb+Afe
         tKeSHF59duQ4MBnNYQrhOoby9VoAZggAvR9h0KFFBrzfR7qlSw9Ow824lWiq1pFr+zvG
         ZAOCjmFgcizlumIn3+COmR6CP1hWcAhPgPrYyhlUEYyPDgarbaspqXW306YcP2AE29Ui
         ekwbQ7Rk1W0aSfJKEpC4AKP4G5UTdBU+e1/PqcJxHIwBf22SpIrJuF1qB2WLTaMzLHUO
         FTq10wobuPrBnpC2PbMElUYXE12iY4vIi5mqPgJdoHzFMINUTzvR6y38TEkyW5cdq3w+
         E92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685528632; x=1688120632;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4KXSQQ/9ar4MzESgExahvhVjXiG8Va2wwqkfhkK8QA=;
        b=Y0yf9lJBLWIJffYsO8MH+ho/m+xkTPcSij7FEg5DeTy4PQ5lHHtouE+v9VwBy0FnCJ
         CxJm7G/4IRfsw8ru1OJM8EfuZrGrFfzt5FthBvNmp86FdqDAdfYz1ZAI7urDMrFUJpRu
         5Xo09MpA56xKaGb20arDrriDTbgFEmHg2irgoChzhxdMLr7kfB61uRTw7/wH3wDD3F3C
         3zLGxQLKeq+cK+G6SmGzzjk4h1ovZ9F39UevG5K3uT9joyMPa/Q/8GIrEDav0NRBxvcW
         gwzCmk1aqDIu1M5SHUmO2V8Oa82biQ15URtA8X34YufEsXYKaC4sSBF7nlQ6qcSowI02
         /ZcQ==
X-Gm-Message-State: AC+VfDxiFhXPyDUMJjLzTs2/sNEul5X4VDN6vmvN/O3socKROJ/PG3sP
        s4CCcD+H1sce6lGMXgYiKpfw9AOcF4rNqjxu72w=
X-Google-Smtp-Source: ACHHUZ66Ws6QKclwXzUr58vGKC24vbY+2jDov9ptYDI/XbKUi795g7dTSeVLUt2ltkF/IMy2sbhWxXwKIEUrJbrcG5Y=
X-Received: by 2002:a05:6358:52cf:b0:125:6f8e:ca6e with SMTP id
 z15-20020a05635852cf00b001256f8eca6emr2199922rwz.21.1685528632324; Wed, 31
 May 2023 03:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xK_fr_gREVsOzN=atcS08mwufr-=7q1JAN=CCyVk_k-dA@mail.gmail.com>
 <YlR9TCeV8FJVu38U@ninjato> <CAHCN7xLso6kwWxeT3VuRQBcs9oKZMctGbsWmd1T=mwgHx0T+SA@mail.gmail.com>
 <YlVApjtNOBLgA0hy@ninjato> <YlWUV1SW4lVLjIZi@shikoro> <CAHCN7xLLsXikG=8zSM=udqnqwvbkqkSLH8iYcuLiLVvHa=LPPQ@mail.gmail.com>
 <ZHbuZyuQ+uZKul+c@ninjato>
In-Reply-To: <ZHbuZyuQ+uZKul+c@ninjato>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 31 May 2023 05:23:40 -0500
Message-ID: <CAHCN7xKwkjb_qfY2K=c2nBFvD9vxRh9_-YZO2OwoLaG-VGwTpw@mail.gmail.com>
Subject: Re: RZ/G2M Hangs when booting some SD cards
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adam Ford <aford173@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, May 31, 2023 at 1:51=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Hi Adam,
>
> I am very sorry that it took so long until I am now able to respond.
> First, too many other duties with higher priority came in. Second, the
> card didn't fail 100% for me after all which made debugging still
> challenging. But it failed often enough, so I at least have a pointer
> now.

I totally understand that it's an open source effort, and we have have
duties to perform. I do appreciate the help.

>
> > From what I have been able to determine, the U-Boot code explicitly
> > disables DMA during the tuning phase:
>
> ...
>
> > However, Linux does not disable the DMA, and the value of taps is zero
> > and the tuning ultimately fails.
>
> I disabled DMA while tuning but it did not help. It finally turns out
> that adding a delay after each tuning command seems to help. U-Boot does
> this but Marek (the driver author for U-Boot) cannot recall why he added
> the delay. I'll send a patch in some minutes.

I'll give them a try today.

adam
>
> All the best,
>
>    Wolfram
>
