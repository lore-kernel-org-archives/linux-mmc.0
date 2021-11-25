Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D160C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Nov 2021 11:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbhKYL5E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 25 Nov 2021 06:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbhKYLzB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Nov 2021 06:55:01 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B694C0613A1;
        Thu, 25 Nov 2021 03:48:49 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id j3so11063098wrp.1;
        Thu, 25 Nov 2021 03:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zGTZSlpnGm2n22lxkSJEMVFE+t4NAH4c6Xl/p/baCNU=;
        b=ggxDlHYdO+nCmw8YUmoTmFXUdtbKl0mS9AliK8qS1pDShNbNhw4sCm8M7F+WbLrHrR
         QjTnc3i0ghnf46wkkbFOyw9SIiOr656jb8zkJ60WYFAdg2gT+laqeCk9gHAFSaS44Fww
         Auxyyi63Uo4FKYqTOrabXLVQOlng6hAdeMofcFiUlgVf6f4fRzfdVlqQbcy7g6uKpWin
         1Nq//GBDfbtiBr3xAVJnJ7qdcBc2y0uw1x6ywo8UGrpYUDhz+SfSq0YQxSHiZDUp3Vf0
         CPR57y+lqyYN5O27weZ9v7GO0YynKW9NOKDrc0p0w/T1A3RYt8K3Ncj/s1ukEB7+d3hQ
         5cUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zGTZSlpnGm2n22lxkSJEMVFE+t4NAH4c6Xl/p/baCNU=;
        b=shfytW1y91NWUQr0ruftIeGlSXoYwRWH9s3FZbQ3g7qZ4L2reGOOW5epthZedb0t3Z
         EEoQenJhtX341aQRCui8f9irJCjYfoi76JPDASTEftHixu2e2KU/DNfWpmwiNO1HTH0z
         aMBlHMyDOxfMXLpKCCvvoGCUgxKrEz8gC4xTpIA/DSXskhGDQMzmGO2OUBP5cRHsUrR6
         tU5dq9twXDSFnOup+vlNsyaS+Enom927P2/5nQwmdRI5LaVJ4+r923U35Yeyj/XsqgDT
         JINAUUR7FU+VRbzcEYzKC71KJo3qg7sbGCwhPfraEottyFeHqYuzBJcB75/YKlCilwDt
         GeYA==
X-Gm-Message-State: AOAM530kg1csmHvG6IWmV+pAvGLRRo0f/d0n/9yVd3NBNmP/1VLbbimB
        b5GsloP+axc85zecyjVrwQtpn/DYxmM=
X-Google-Smtp-Source: ABdhPJwGaIlEzWSzYkOIFmFGYLa8i4k+7ojXDZzjuWLF9TI9gTOa0UaEeu8MeB+7/DzoNwcWBPOppw==
X-Received: by 2002:a5d:64c4:: with SMTP id f4mr5748349wri.6.1637840928209;
        Thu, 25 Nov 2021 03:48:48 -0800 (PST)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id o10sm3285079wri.15.2021.11.25.03.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 03:48:47 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     linux-mmc@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     John Keeping <john@metanate.com>, Heiko Stuebner <heiko@sntech.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Keeping <john@metanate.com>
Subject: Re: [PATCH 0/4] mmc: dw_mmc: start deprecating mshcN aliases
Date:   Thu, 25 Nov 2021 12:48:46 +0100
Message-ID: <1727408.1NuWAi7hEM@archbook>
In-Reply-To: <20211124184603.3897245-1-john@metanate.com>
References: <20211124184603.3897245-1-john@metanate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mittwoch, 24. November 2021 19:45:58 CET John Keeping wrote:
> This series is prompted by discussion on a previous patch set [1] but is
> a totally different approach and only a partial solution.
> 
> With these patches, the dependency on the mshcN alias is totally removed
> from dw_mmc-hi3798cv200 and dw_mmc-rockchip and dw_mmc-exynos moves
> towards being able to consider the mshcN aliases deprecated.
> 
> I haven't changed dw_mci_hi6220_caps here, although it looks like it's
> possible to apply MMC_CAP_CMD23 to all controllers there with no change
> in behaviour as the final entry is SDIO for which CMD23 is not
> applicable IIUC.  But I'm not familiar with that hardware and don't feel
> confident making that change.
> 
> [1] https://lore.kernel.org/all/20211116190244.1417591-1-john@metanate.com/
> 
> John Keeping (4):
>   mmc: dw_mmc: add common capabilities to replace caps
>   mmc: dw_mmc: hi3798cv200: use common_caps
>   mmc: dw_mmc: rockchip: use common_caps
>   mmc: dw_mmc: exynos: use common_caps
> 
>  drivers/mmc/host/dw_mmc-exynos.c      |  9 +++++----
>  drivers/mmc/host/dw_mmc-hi3798cv200.c |  9 +--------
>  drivers/mmc/host/dw_mmc-rockchip.c    | 11 +----------
>  drivers/mmc/host/dw_mmc.c             |  3 +++
>  drivers/mmc/host/dw_mmc.h             |  3 +++
>  5 files changed, 13 insertions(+), 22 deletions(-)
> 
> 

For rockchip:

Tested-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>

Tested on a rk3566 with no obvious issues arising.

Regards,
Nicolas Frattaroli


