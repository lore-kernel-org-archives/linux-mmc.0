Return-Path: <SRS0=SgEP=CU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC21C43461
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 02:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9488A21582
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 02:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Yl5F6v3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725355AbgIKCEN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Sep 2020 22:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKCEM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Sep 2020 22:04:12 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8255BC061573;
        Thu, 10 Sep 2020 19:04:12 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n13so8321328edo.10;
        Thu, 10 Sep 2020 19:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4z2pqEFQc/fD65ZOsXerYiEysQgGTg32CxOqPq6IBO8=;
        b=Yl5F6v3Gb5Wf97Fk7b6hKKBWyB2sKMDsS9bWOdXzZtR/tMKrYB/h+bw6QqR+eMEQ4r
         o/+POFn2MJ3SMxzYnmuA9W829P1AFOY0/A3iUAQmW/UINSWM35kGr6p6E43PRX+jsdBq
         J7DnkofDASefYBN6LZYnoXbgvdBmUKSFYQBkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4z2pqEFQc/fD65ZOsXerYiEysQgGTg32CxOqPq6IBO8=;
        b=qk3yOKElNn5GQT9UZ1txbBC14/gE/R7BuXPUl6VQV/t8ixjMhPvuD8sy7pYfoskwzz
         LEJTS2ixxt/h47Duuohsg5DCtqCpLA0pO/RroyKNQFDUZnc5wPtIQcv0EyHdpx3xBNqH
         bzdBg0onk3SLGJ/Aw8T7OkpT/t8SGx90jkfKFIl6RSFRRasTbStWiKORDojRoMt999ks
         DOspg5HyZRGxlkLxfTbTMFs9X5uF3gPzUEgN6Ur8Mod8ydqOc6HkgcLHRx9ih9K0Glhf
         NSNWeZ0CzKQFE3NL+KxCN6t7E0yFI4PfJVcy3QbVC6ZYEdNCxZ0A3EIMBLyUJCfdjtgo
         99jA==
X-Gm-Message-State: AOAM532qaUixav9aXvy8Z6cQ2w+WZjHhv9KbKoB5LsnFMI44wUVH4knY
        bj+mSpMRCzcOUiwJKt4F/7pChNzZ3BwBbH5J0Wo=
X-Google-Smtp-Source: ABdhPJwVxLGtPmCtwE8CRX/qzbghy6V4fqt4VrSZ878trNfxo80v6AVlUc0HYi6YzOE52WWzoFiNpsiDSSYsKtZ0A0U=
X-Received: by 2002:a50:fb0e:: with SMTP id d14mr13074812edq.172.1599789851191;
 Thu, 10 Sep 2020 19:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200910105440.3087723-1-andrew@aj.id.au> <20200910105440.3087723-4-andrew@aj.id.au>
In-Reply-To: <20200910105440.3087723-4-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 11 Sep 2020 02:03:58 +0000
Message-ID: <CACPK8XcR72zuVTJXC840oYW9M1a=tKpn5z-4qJbv00LaA1qrqA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: tacoma: Add data sample phase delay for eMMC
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 10 Sep 2020 at 10:55, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Adjust the phase delay to avoid data timeout splats like the following:
>
> [  731.368601] mmc0: Timeout waiting for hardware interrupt.
> [  731.374644] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> [  731.381828] mmc0: sdhci: Sys addr:  0x00000020 | Version:  0x00000002
> [  731.389012] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000020
> [  731.396194] mmc0: sdhci: Argument:  0x00462a18 | Trn mode: 0x0000002b
> [  731.403377] mmc0: sdhci: Present:   0x01f70106 | Host ctl: 0x00000017
> [  731.410559] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> [  731.417733] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
> [  731.424915] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
> [  731.432098] mmc0: sdhci: Int enab:  0x03ff008b | Sig enab: 0x03ff008b
> [  731.439282] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> [  731.446464] mmc0: sdhci: Caps:      0x01f80080 | Caps_1:   0x00000007
> [  731.453647] mmc0: sdhci: Cmd:       0x0000193a | Max curr: 0x001f0f08
> [  731.460829] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffff
> [  731.468013] mmc0: sdhci: Resp[2]:   0x320f5913 | Resp[3]:  0x00000900
> [  731.475195] mmc0: sdhci: Host ctl2: 0x0000008b
> [  731.480139] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xbe040200
> [  731.487321] mmc0: sdhci: ============================================
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Acked-by: Joel Stanley <joel@jms.id.au>

> ---
>  arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> index 5f4ee67ac787..94ec301ceb73 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts
> @@ -179,6 +179,8 @@ &emmc_controller {
>
>  &emmc {
>         status = "okay";
> +       aspeed,input-phase = <0x7>;
> +       aspeed,output-phase = <0x1f>;
>  };
>
>  &fsim0 {
> --
> 2.25.1
>
