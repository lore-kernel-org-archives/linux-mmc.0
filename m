Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E4AC433E7
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 08:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2734A20897
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 08:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599121708;
	bh=JhGgBN212oQdocLFQd1GIoMAcjo2XnC8T3B/5UMegcI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wFfRzxO+WTgjCvYVL+CZBbpYxNDtOw/sPT5WlsafVbC8V4uktYP8bbNj5bq72iSdM
	 /AVCI66bcsHEoi0WG72xOGDepKJy/GAQ3CIJ5QO8HrAmfUiOj4/TLX0FX4FortdCUA
	 wwd6fy/iRSFDDkIMUdt5B+l5a7uAsRDsBkWuS+6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgICI2Y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:28:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbgICI2W (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 3 Sep 2020 04:28:22 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03F212100A;
        Thu,  3 Sep 2020 08:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599121702;
        bh=JhGgBN212oQdocLFQd1GIoMAcjo2XnC8T3B/5UMegcI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OhKL4JCKxO8wkJt3BpKgpeyR+xjKvGd+Jf6f9ApeUsNsOOd5pYsVjoWwx/MzQ3fDu
         TxSC6OtqCCQhokskh5ao0/2qcWh1FfbNbiFsuG3Ezp+Rj7E30aFR+CslSXna1cCYUI
         qkNEvD4QyK0JaNubUIKAvR6L2eyA0GKTQoebitHY=
Received: by mail-ej1-f44.google.com with SMTP id a26so2659448ejc.2;
        Thu, 03 Sep 2020 01:28:21 -0700 (PDT)
X-Gm-Message-State: AOAM533MKmQtDqpwN25mLKbhXBqeaEuOgky9bHW65BlUw96Dzfql5Z65
        QZJ5/T6XhlNCMSlClhR2ijPjtLx8aeII+/ULFLc=
X-Google-Smtp-Source: ABdhPJzSfQ5TJipTleRhjOrSLdyfMN0JGOZNyUW65jvCo0Y05w2r706QOVOn6IspjV+kQPykXsQI90zE8KU4nNs6Fm8=
X-Received: by 2002:a17:906:af53:: with SMTP id ly19mr908583ejb.503.1599121700549;
 Thu, 03 Sep 2020 01:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200902193658.20539-1-krzk@kernel.org> <CAPDyKFqBS-ws6fkirDQL8EEqh9At88K2vrG5fc8K5_JiXsmfyg@mail.gmail.com>
In-Reply-To: <CAPDyKFqBS-ws6fkirDQL8EEqh9At88K2vrG5fc8K5_JiXsmfyg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 3 Sep 2020 10:28:09 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeLMvaZPvyyh+embqzhHPDRfWcDF9_LxCJn3PqMP+8mfQ@mail.gmail.com>
Message-ID: <CAJKOXPeLMvaZPvyyh+embqzhHPDRfWcDF9_LxCJn3PqMP+8mfQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] mmc: Minor cleanups and compile test
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 3 Sep 2020 at 10:10, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Series applied for next, except 11, thanks!

Thanks. I will fix pointed compile-test issues and send later a follow
up, also removing the MMC dependency as pointed by Micha=C5=82.

Best regards,
Krzysztof
