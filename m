Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9D5C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Nov 2022 15:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbiK2PhG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Nov 2022 10:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbiK2Pgu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2022 10:36:50 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59AF60EBF
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 07:36:49 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 9so14028607pfx.11
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 07:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YVjeqEOt1uKO0fVFfLxF44bKzsvKclfsU9AzXKW3c3Y=;
        b=beMW+SI7oOgmJGbCjj7Bxk1LS9BrR+MvJ658Se5N/XREofxhwXaADk4K2CA9RIz8pH
         AwhMcm2auc3bCAnSJpA4aQmaeM59NOOxPduigwneVklYFfK2v5E4HHOj1fD3R9DW6ybC
         a9x5ciouVNjcgfptRXeFWlp249xPDokOdq4vssQGJFJ1d45X+FNnfD/7VqPUtq7cMuIw
         CJuFK+hEFBH3TLhIX1UkP955rxMKmBHzS0VXK7OlyWZ1AI9h56xIRXg8zBeu/BPd/hXk
         j/zXNK36fXzWo6gzgDOfVUbpIspKtyTO/dFj+7gqHkS+KCVaPjgF8i3lOI2igKRJapX6
         9KBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVjeqEOt1uKO0fVFfLxF44bKzsvKclfsU9AzXKW3c3Y=;
        b=GceqIuTQE8Qrlnx8M23iboyxX9FqFWVGZAl73fv/2OgGaKloW1blacTGTtebR2EhlP
         BfISuSmt8GpUweY6PQ3Vdr0sPI+MW3ekpbUopxkJhziZ+v/DN3k5Yi3k0Ydbcm5BRrW0
         HQV6tg1fIONTlswbF1oQqoMWxdZTfQYRtHg7xEwUQJUAO318/OhWUfZpelJJp03XDKnK
         oLI0NWL/gH4QRR5NuctxXX2/g6Fhhtma3dDltn2LZGfIeKs91jxE4aYmwuWjIQWWlXf6
         mVFda+j4EaKzduDlvqDwisbkNwdlYOMzeKnrmIKw8q7XtGPzRLaZJ2HY0kYBFc5EGTlu
         wAbw==
X-Gm-Message-State: ANoB5pmM+cS4Dns0rtVnawKZ7ZkcowhJccwhC+vAJ0SEobaP8vp6xxhh
        X7gBY8Ey4D3T1/GxhtvShRcP+gevpaP7lPIsLPPaZw==
X-Google-Smtp-Source: AA0mqf7froo7BM2V39H4mA4ts98jNKFidGAUCMXpcNyqvZEIutH9+jNbI8a4WYJUwWugQJ8GQalL/L8GDhz+7FXlcEA=
X-Received: by 2002:a63:501c:0:b0:477:650a:c29a with SMTP id
 e28-20020a63501c000000b00477650ac29amr31737987pgb.541.1669736209444; Tue, 29
 Nov 2022 07:36:49 -0800 (PST)
MIME-Version: 1.0
References: <20221128133259.38305-1-adrian.hunter@intel.com>
In-Reply-To: <20221128133259.38305-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Nov 2022 16:36:12 +0100
Message-ID: <CAPDyKFovTwNgMceMy=PZkWAdomiKRB2ioWvkwjNgbDBqUdNJfw@mail.gmail.com>
Subject: Re: [PATCH V2 0/4] mmc: sdhci: Fix voltage switch delay
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Sarthak Garg <quic_sartgarg@quicinc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Prabu Thangamuthu <prabu.t@synopsys.com>,
        Manjunath M B <manjumb@synopsys.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Brian Norris <briannorris@chromium.org>,
        Wenchao Chen <wenchao.chen@unisoc.com>,
        Chevron Li <chevron.li@bayhubtech.com>,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 28 Nov 2022 at 14:33, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> Here is a fix for the voltage switch delay issue raised here:
>
>   https://lore.kernel.org/linux-mmc/20221117094859.20582-1-quic_sartgarg@quicinc.com/
>
> Plus some subsequent tidy-ups.
>
>
> Changes in V2:
>
>     mmc: sdhci: Fix voltage switch delay
>         Tidy messy if-condition a bit
>
>
> Adrian Hunter (4):
>       mmc: sdhci: Fix voltage switch delay
>       mmc: sdhci: Avoid unnecessary re-configuration
>       mmc: sdhci: Avoid unnecessary ->set_clock()
>       mmc: sdhci: Enable card clock instead of ->set_clock()
>
>  drivers/mmc/host/sdhci.c | 101 ++++++++++++++++++++++++++++++++---------------
>  drivers/mmc/host/sdhci.h |   2 +
>  2 files changed, 71 insertions(+), 32 deletions(-)
>
>
> Regards
> Adrian

Patch 1 applied for fixes, the three others for next, thanks!

Kind regards
Uffe
