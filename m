Return-Path: <SRS0=HGUj=6G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B70AC54FCB
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 18:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C922082E
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 18:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mltae6nP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgDVSRe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgDVSRd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Apr 2020 14:17:33 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A89C03C1A9;
        Wed, 22 Apr 2020 11:17:33 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id p10so3444073ioh.7;
        Wed, 22 Apr 2020 11:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/O8wxkOyz2zqjTvXW5zmlSLKb1rtq1CNhNBPyoq68Ms=;
        b=Mltae6nP2Mbpr8cAm/sWdOn8rNtI/OcVNw/eOS5AvECfCyKKYKWRzhTgMTN3KuMQ12
         YDZoIz+eiUNnrsrOWB2JwH2pSNIf90p+8OyeWU0Zl7mGFkke8HotD8oCtnI8IyC7s2OT
         WljR0uyIlHxHgxXMprKYW+Y+Zhsdv2uCsFJBsAHwIRdNQRPbbICBZCLMf4xL0yRNKKoy
         QNAg2vy5mimsD9CYhdFH5ROCZSZa1vBEE4Sy7gEXrM1IUiWxScpvUbbtMpx5iUjz2gXa
         0bCQd9lcEQC6Q6rAyVfn3Ne/HQ4hceLPJOyjh2LqYZR5BDbcoTqmup1GpQXmronZ/dww
         h0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/O8wxkOyz2zqjTvXW5zmlSLKb1rtq1CNhNBPyoq68Ms=;
        b=Pv7v5E2HlUikZh0GGGY9UpIsoph57zKHbOdPU+mlRpc8fOv3kb+DtuectQNM/Qkn9I
         auvIHDquGObt54Dwz6bM4O+cxe8xXEFNCrENiO5oZiZFCyIQcya5ZD5vPTdE8K6WZJ62
         LFssKZUjc7De59DPFeFJr0oxabILKO8IYHwn1g9aK/F6tQjIRVN2G/8eh7+cDrZpun6Y
         ZIf7MAURIazYrSe9CCw5nNWOVccSfPBWYnPsYx/FRlXgE2X6XesFrPNKK0ihazSaifWv
         x0R4agoVR3Cupg/s1rkBE4HUYCK4g1vJC2OgqcmYuAu3Sp9Ct4DwVYe3k4v1pdUOMVSu
         UsYg==
X-Gm-Message-State: AGi0PubhAxeee1zy7SNsayKZ8qcY6TQTxWzx+rlNIidJUYDUMV5levWd
        fqhnGpKFZsXhsJRafaQAWsVUtd/PW52yLn7SxZs=
X-Google-Smtp-Source: APiQypLi5JAfufXmUiHGVYgFDJyCS0FH1GWVjaU1HKRYJC6SB/+hStZS40jpXRvlDRPyXafhRd4YtWORgk95NeW/zck=
X-Received: by 2002:a6b:e802:: with SMTP id f2mr26865444ioh.128.1587579452616;
 Wed, 22 Apr 2020 11:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200328003249.1248978-1-martin.blumenstingl@googlemail.com> <20200328003249.1248978-4-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200328003249.1248978-4-martin.blumenstingl@googlemail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 22 Apr 2020 23:47:21 +0530
Message-ID: <CANAwSgTYgDDodsTbWsuWSgxh7vhci7PLKa14iz-7gF1BuRdgjQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mmc: host: meson-mx-sdhc: new driver for the
 Amlogic Meson SDHC host
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, jianxin.pan@amlogic.com,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        yinxin_1989@aliyun.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lnykww@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Martin,

On Sat, 28 Mar 2020 at 06:04, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> The SDHC MMC host controller on Amlogic SoCs provides an eMMC and MMC
> card interface with 1/4/8-bit bus width.
> It supports eMMC spec 4.4x/4.5x including HS200 (up to 100MHz clock).
>
> The public S805 datasheet [0] contains a short documentation about the
> registers. Unfortunately it does not describe how to use the registers
> to make the hardware work. Thus this driver is based on reading (and
> understanding) the Amlogic 3.10 GPL kernel code.
>
> Some hardware details are not easy to see. Jianxin Pan was kind enough
> to answer my questions:
> The hardware has built-in busy timeout support. The maximum timeout is
> 30 seconds. This is only documented in Amlogic's internal
> documentation.
>
> The controller only works with very specific clock configurations. The
> details are not part of the public datasheet. In my own words the
> supported configurations are:
> - 399.812kHz:   clkin =  850MHz div = 2126 sd_rx_phase = 63
> - 1MHz:         clkin =  850MHz div = 850  sd_rx_phase = 55
> - 5.986MHz:     clkin =  850MHz div = 142  sd_rx_phase = 24
> - 25MHz:        clkin =  850MHz div = 34   sd_rx_phase = 15
> - 47.222MHz:    clkin =  850MHz div = 18   sd_rx_phase = 11/15 (SDR50/HS)
> - 53.125MHz:    clkin =  850MHz div = 16   sd_rx_phase = (tuning)
> - 70.833MHz:    clkin =  850MHz div = 12   sd_rx_phase = (tuning)
> - 85MHz:        clkin =  850MHz div = 10   sd_rx_phase = (tuning)
> - 94.44MHz:     clkin =  850MHz div = 9    sd_rx_phase = (tuning)
> - 106.25MHz:    clkin =  850MHz div = 8    sd_rx_phase = (tuning)
> - 127.5MHz:     clkin = 1275MHz div = 10   sd_rx_phase = (tuning)
> - 141.667MHz:   clkin =  850MHz div = 6    sd_rx_phase = (tuning)
> - 159.375MHz:   clkin = 1275MHz div = 8    sd_rx_phase = (tuning)
> - 212.5MHz:     clkin = 1275MHz div = 6    sd_rx_phase = (tuning)
> - (sd_tx_phase is always 1, 94.44MHz is not listed in the datasheet
>    but this is what the 3.10 BSP kernel on Odroid-C1 actually uses)
>
> NOTE: CMD23 support is disabled for now because it results in command
> timeouts and thus decreases read performance.
>
> Tested-by: Wei Wang <lnykww@gmail.com>
> Tested-by: Xin Yin <yinxin_1989@aliyun.com>
> Reviewed-by: Xin Yin <yinxin_1989@aliyun.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Please add my tested on Odroid C1+

Tested-by: Anand Moon <linux.amoon@gmail.com>

Best Regards
-Anand
