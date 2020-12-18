Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D891C4361B
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 03:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6CB623A68
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Dec 2020 03:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgLRDo2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Dec 2020 22:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgLRDo1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Dec 2020 22:44:27 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2A7C0617A7
        for <linux-mmc@vger.kernel.org>; Thu, 17 Dec 2020 19:43:47 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id b64so880301qkc.12
        for <linux-mmc@vger.kernel.org>; Thu, 17 Dec 2020 19:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IttzuJobOjlLN9bP4nU93NgoLAoxeB0BbJYAKz583g4=;
        b=1AO2Qkp8fbdQrG3/Cs7PnCs3VDLImVXziJzO+6oR2k6Ek/wf59TKBbnjulXyKxh/8Z
         p4oerKMBwnNWvrF3oRbs0v5DcEB9D2mctD31rRbBPU/QeucTyExLbUgWp0Jt0oYMm7+q
         ua5DFCubnfvTAq4LV/6scR6V5/TE6whjnnBXpEs7ntZTZt791oPZEWI5AKPVP+7+iKIx
         CfBGQC8Kpuy3z0WTob1xCoPP0DtWSPPQD2W0La4yxSnk86/WjBEuejITKAJtZJh1MbiP
         SV4qWxblF9TVsG0oicsdVJH5ZMXRePzUJzt5GrKxHywJRlQSLM5jsWCo6f5xUKuxT4s4
         d4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IttzuJobOjlLN9bP4nU93NgoLAoxeB0BbJYAKz583g4=;
        b=lY66c8FZ7+ysJ9wPAhXVaW9Nk/zcKIIEl2foSqVkAPRRnplZzwN1vy1JajsDqGonwr
         26142Lcde3T73U+VcDSeIAE8BoeoG8An0XSgWKhqtKFfNWDuJBNCoaL90BZOu8u8cSeY
         SisNjAtuwihmF2ZQppbBjREg2Py8Ykg51dIpHzLtfcie49THzUhYD15E4q5DmGOIE+l3
         VGxqP5d5KZpM4ip/dTpHrm29ipXp6vnf2Z5RMDjDIW5Yc0iv586XNTnZJuNejn1rxSCP
         XzvJpc0rIJEdWOMJC8SwStdvqzHVKJKkdvQvnTgqMj5x1vHe9i/02qeXO1M9Q6bWb6yk
         0LXw==
X-Gm-Message-State: AOAM532w25vKm417QhmCrlj4lPMLfxSSeKnXA9kzkckUvM3nC5Ov3K5M
        KxHXq+lRFYU+F8K32XviPUPn6B1mGj7+GXWYxRKGRA==
X-Google-Smtp-Source: ABdhPJzxrMnIp9AzfrKNngvNzWuYEkuSEsXXnArgtdbUjO+rWMIidQm0gxjI6Nfg2go9MXfTqGqIwHocwgCa/SBXNws=
X-Received: by 2002:a37:2cc4:: with SMTP id s187mr2762834qkh.385.1608263026560;
 Thu, 17 Dec 2020 19:43:46 -0800 (PST)
MIME-Version: 1.0
References: <20201216074540.30616-1-kostap@marvell.com> <20201216074540.30616-4-kostap@marvell.com>
In-Reply-To: <20201216074540.30616-4-kostap@marvell.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 18 Dec 2020 04:43:35 +0100
Message-ID: <CAPv3WKcjtrj=yMXj7pncJJNES8U1HFhbgBe8=8E6xYmO_3YVvg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: cn913x-db: enable MMC HS400
To:     Kostya Porotchkin <kostap@marvell.com>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

=C5=9Br., 16 gru 2020 o 08:46 <kostap@marvell.com> napisa=C5=82(a):
>
> From: Marcin Wojtas <mw@semihalf.com>
>
> This patch adds necessary flags in the device tree
> which enable HS400 mode on AP807 MMC controller
> on the CN913x-DB board.
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> ---
>  arch/arm64/boot/dts/marvell/cn9130-db.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/cn9130-db.dts b/arch/arm64/boot/=
dts/marvell/cn9130-db.dts
> index ce49a70d88a0..79020e6d2792 100644
> --- a/arch/arm64/boot/dts/marvell/cn9130-db.dts
> +++ b/arch/arm64/boot/dts/marvell/cn9130-db.dts
> @@ -113,6 +113,8 @@
>  &ap_sdhci0 {
>         pinctrl-names =3D "default";
>         bus-width =3D <8>;
> +       mmc-ddr-1_8v;
> +       mmc-hs400-1_8v;
>         vqmmc-supply =3D <&ap0_reg_sd_vccq>;
>         status =3D "okay";
>  };

I can confirm all works fine on top of the mmc next branch:
[    3.591989] mmc0: new HS400 MMC card at address 0001

Best regards,
Marcin
