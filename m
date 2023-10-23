Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0F1C25B45
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Oct 2023 21:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjJWVQW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Oct 2023 17:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjJWVQV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Oct 2023 17:16:21 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3328F198D
        for <linux-mmc@vger.kernel.org>; Mon, 23 Oct 2023 14:16:18 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b36e1fcee9so3105631b3a.3
        for <linux-mmc@vger.kernel.org>; Mon, 23 Oct 2023 14:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698095777; x=1698700577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zvhazaZM9RfI4iJsfgktcPhLE+7qHteXIMbKad1YWwM=;
        b=Hadr64NjKF49gGJbppffIuqkb8sCVABGLrfesp/6s16qECmQrvim4ZwJGzYzoswSGg
         k39QwS6dqO5TdLhQDBwg93bZ3sJzXLDV7uloKtPxh3ozMx6KodM74EzQyFm5+ZyOkxNB
         Bgl0N8QZWkd7zN1bkqy4R9SXhc0RIzECCTYMhxn7d+PgN3Qc5ZZF30VUZHrX5dOulKEi
         yCAIuUHgif1RFrFuFByTc9I/9+f4LXCXehnk4DCl0zcO8ttSGRDRyFQrS8Zd2AGxGVLs
         5Nvn/2UM5Ssm1YmDMoqyi4hA6F3oqDdbHx/arZvlpEA2rQS2Wiv+IguDCx1e5RVjqr9L
         +Y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698095777; x=1698700577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvhazaZM9RfI4iJsfgktcPhLE+7qHteXIMbKad1YWwM=;
        b=cNkV7UHOLTv36sQkc0Oj4Hphfmdat0WFHXONlYVtsAwQyBT/OPDGMh+T+qc4gGfXA/
         G3rC4nC/bAm3cMpSe+TqMQpgnm4aZFBSQoM/EOPLD+8bdSZPmEYrc4g/HmBSQo+Q9r2O
         UPWcl9jHW2AQJrtvsOHaZeHlR+DEhlFOaFRzWpkOKRTl+rjOd2ofXKHw5Wn7O4NW6BYP
         kVK+oOQCpbOiVXkz145WXunHBY8J9nrUo7z2T0euY4YLpXoBsJKFL1lwFY7RBFIb6qyU
         OFPuP8fWR6fguzQvqHD25XkcYNidX3U100QbHFjK+og9WY4wj7qyhyKID7ZAiPq6PeVP
         xN6Q==
X-Gm-Message-State: AOJu0YyF0MphHbUvkxeF2i91+7ZDs/Jtyx9350fI40qRUchJHv+m4MwA
        3PoXLzAlmRvpjw+HUDDkafVzcw==
X-Google-Smtp-Source: AGHT+IHHOa6b8isYHkqmJjQq3xCd6kvCalcUdzFL2r7jyGX64Eq4yPLeQJvZ+MMD0KyWAU4/1ldzgw==
X-Received: by 2002:a05:6a00:a0b:b0:6bd:9281:9453 with SMTP id p11-20020a056a000a0b00b006bd92819453mr9522592pfh.9.1698095777579;
        Mon, 23 Oct 2023 14:16:17 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:b9a0:8714:407c:4146])
        by smtp.gmail.com with ESMTPSA id f18-20020aa79692000000b00690c52267easm6535133pfk.40.2023.10.23.14.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:16:17 -0700 (PDT)
Date:   Mon, 23 Oct 2023 14:16:14 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>
Cc:     Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/7] RISC-V: Add MMC support for TH1520 boards
Message-ID: <ZTbini/VyDxHMyrm@x1>
References: <20231023-th1520-mmc-v3-0-23850668d208@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-th1520-mmc-v3-0-23850668d208@baylibre.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Oct 23, 2023 at 01:33:02PM -0700, Drew Fustini wrote:
> This series adds support for the MMC controller in the T-Head TH1520
> SoC, and it enables the eMMC and microSD slot on both the BeagleV
> Ahead and the Sipeed LicheePi 4A.
> 
> I tested on top of v6.6-rc6 with riscv defconfig. I was able to boot
> both the Ahead [1] and LPi4a [2] from eMMC. The following prerequisites
> are required:
> 
>   [PATCH v2] riscv: dts: thead: set dma-noncoherent to soc bus [3]
> 
> I pushed a branch [4] with this patch series and the above patch for
> those that find a git branch easier to test.
> 
> Note: I have only tested eMMC and microSD. I have not yet configured
> or tested the mmc controller used for SDIO WiFi yet.
> 
> References:
> [1] https://gist.github.com/pdp7/7850027e8d256b6fd9cd53080240f0f6
> [2] https://gist.github.com/pdp7/fae4637378426723508b679420a0a5a1
> [3] https://lore.kernel.org/linux-riscv/20230912072232.2455-1-jszhang@kernel.org/
> [4] https://github.com/pdp7/linux/tree/b4/th1520-mmc
> 
> Changes in PATCH v3:
> - always call th1520_sdhci_set_phy() in th1520_set_uhs_signaling()
>   and not only when timing is MMC_TIMING_MMC_HS400. This allows the
>   microSD slot to work as th1520_phy_3_3v_init() is called from
>   th1520_sdhci_set_phy().
> - add mmc1 node for mmc controller connected to the microSD slot
> - add enable mmc1 and add properties for microSD on the Ahead and LPi4A

My apologies for sending this v3 series prematurely. I wanted to send
out the fix above that enabled microSD to work but I failed to address
the feedback from Adrian and Jisheng on v2 [1] and I also failed to
applied the tags from v2. I will address those in a v4 but I'll wait a
few days in case there is any feedback on the th1520_set_uhs_signaling()
change above.

Thank you,
Drew

[1] https://lore.kernel.org/r/20231017-th1520-mmc-v2-0-4678c8cc4048@baylibre.com
