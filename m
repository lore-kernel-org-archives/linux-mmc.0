Return-Path: <SRS0=h0nN=A7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E20EC433E1
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 19:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64EBD206F2
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 19:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595272998;
	bh=OG807ODkDc+UslV3c1htiVIC+k2FKFpXJrGduL+WAM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gBLPm3W5jjl7d9cu4nDdtBm2Uuu6PzU7FlpucYvZI6a306G+G2w+6YWSML6JaQHbY
	 WLt0mIZsEClo4nweenT8Hfc5M6EeL8dvoQPMFCVM9g/YUNuJrrowq95aiUYWUiLw+Z
	 hneouB/849I87LiAmTelXoTTLlji3v5Vfv3NzNN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgGTTXR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:23:17 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41688 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgGTTXR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jul 2020 15:23:17 -0400
Received: by mail-io1-f68.google.com with SMTP id p205so18794030iod.8;
        Mon, 20 Jul 2020 12:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EcW34XVMNwPSgRnBgMH5wzY65jiGbMY2EMKCOkIXLW8=;
        b=HhjAYrYN+ViOa+r5A1X3VP/a559r1O9VrTj0m9/e4YPQFvslxC4QWLctxrtdudL2cM
         3rHxGFOvAqeprVWf+6SJ5D39alGoGDc48k4qq5zBPTcxtPHaGnLnQ5v3e5Fno9KycI/4
         DGb8605+EnrU11Bg3fmYSJDbevD9UzsxKonEa3N1D9nMYObUCL1WEKp54qnIKN6qubPp
         Yw6KHt8xsGn8wyxjv8GaroH/7q78ol/MXffKMuoz/N2hO2GnXl/XPZyJ9lKrfS3wI8hr
         TdhvgvxoRiSvExVWl1i02eSSE2skgMFcb0HnYDrcZ73fEVlx7kyBf+JBTpJsjx6Z/4BJ
         HOOw==
X-Gm-Message-State: AOAM533vPkVNasoh/jTP72Y2/u1SU2dMLxXtk6YoPcxlIZE4dEh92v9m
        jjP+CuTd/rFlEwq1q7OyPw==
X-Google-Smtp-Source: ABdhPJz65ED9MYDnMU5Ns3NAnZDXigOQgsr0OxS+BbVEoRiWKSeOFuzrYsYmhOos0feUdhR2SM95Mg==
X-Received: by 2002:a02:908f:: with SMTP id x15mr26751369jaf.12.1595272996277;
        Mon, 20 Jul 2020 12:23:16 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id d6sm9305202ioo.9.2020.07.20.12.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 12:23:14 -0700 (PDT)
Received: (nullmailer pid 2854945 invoked by uid 1000);
        Mon, 20 Jul 2020 19:23:12 -0000
Date:   Mon, 20 Jul 2020 13:23:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chun-Hung Wu <chun-hung.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, mirq-linux@rere.qmqm.pl,
        Andy Gross <agross@kernel.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, wsd_upstream@mediatek.com,
        linux-arm-msm@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Pan Bian <bianpan2016@163.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-tegra@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        kernel-team@android.com, Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH v7 4/4] dt-bindings: mmc: mediatek: Add document for
 mt6779
Message-ID: <20200720192312.GA2854898@bogus>
References: <1595205759-5825-1-git-send-email-chun-hung.wu@mediatek.com>
 <1595205759-5825-5-git-send-email-chun-hung.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595205759-5825-5-git-send-email-chun-hung.wu@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 20 Jul 2020 08:42:39 +0800, Chun-Hung Wu wrote:
> Add compatible node for mt6779 mmc.
> 
> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
