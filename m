Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBF8C433E9
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 03:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF87364FF4
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 03:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhCJDAq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Mar 2021 22:00:46 -0500
Received: from mail-io1-f53.google.com ([209.85.166.53]:42071 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhCJDAd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Mar 2021 22:00:33 -0500
Received: by mail-io1-f53.google.com with SMTP id u20so16315279iot.9;
        Tue, 09 Mar 2021 19:00:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LfhlochrZTWGK80UR6RfSyTUFWd+yCoZ99GJcthSJuU=;
        b=NoMifoGeloZP4POJHCcUNa/CfluXvLg5jsN1aYKrk9PVq0W0JlooEcVT46S09DpR43
         +UXAF5NjVIzujgQIQbXp2D9CgC4UirB7WeNMcR10aEE5K9UP6xiBej22LCXow8I70wIw
         msu4Z8gWVS3RKp922SdENPAxAH4RRmCoH4nekclt4NK0yHtXe4vUeczr+Sx1RZiD1eNS
         so94oaC6Mb3bQNsMa1BQ4xqbfLZVjae7BU1F7jbSPz1fyru3QSt2oQeXxnCqC1QaGiVb
         fStffa1iYSV7B+82KLXwsogLSvpm0oGBhXwVPaIP9H/ZkiBUQRRdv0iL/V+j1ouqlmXm
         abjQ==
X-Gm-Message-State: AOAM531JNSY2Dyje37FxvU6g7uEDwFsE5Z0mYnWngNm9CvcMx+5fSDuw
        JVyqKv65KkxfOX3KrEZwoQ==
X-Google-Smtp-Source: ABdhPJzTN7TyhY1opAmGZ9GDZCdtC36F56Xyywem07xi/n5y0tpqt1VNNsj/4JdYC4OnXlQ30SfAZA==
X-Received: by 2002:a5d:9510:: with SMTP id d16mr992361iom.81.1615345233390;
        Tue, 09 Mar 2021 19:00:33 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id r15sm8474952iot.5.2021.03.09.19.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 19:00:32 -0800 (PST)
Received: (nullmailer pid 1664120 invoked by uid 1000);
        Wed, 10 Mar 2021 03:00:31 -0000
Date:   Tue, 9 Mar 2021 20:00:31 -0700
From:   Rob Herring <robh@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: mmc: sdhci-of-dwcmhsc: Convert to
 yaml file
Message-ID: <20210310030031.GA1664061@robh.at.kernel.org>
References: <1615254990-192784-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615254990-192784-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 09 Mar 2021 09:56:28 +0800, Shawn Lin wrote:
> This patch converts sdhci-of-dwcmshc.txt to sdhci-of-dwcmshc.yaml
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v3:
> - fix filename and other improvments suggested by Rob
> 
>  .../devicetree/bindings/mmc/sdhci-of-dwcmshc.txt   | 20 -------
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml           | 63 ++++++++++++++++++++++
>  2 files changed, 63 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
