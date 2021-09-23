Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25439C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 18:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E4256121F
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 18:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242823AbhIWSwM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Sep 2021 14:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242812AbhIWSwJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2021 14:52:09 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4755C061756
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 11:50:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p29so29451089lfa.11
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 11:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8xSJAgeNdOuQkASPp4auEM5KTYjlWHqIVKzsoZjoOt8=;
        b=vQtXKI6RHomntOLOj6nWJV3oR50KPljfRSeNUSGusrAyfYvcgGbHE0XB6xSl8uhWM2
         a6/pzasQdKjemyul5AsDaB52WIRAYqbY5bmfC654wwia8rozFfAQW7i/9WCcpgqMw1CA
         GEA24b0rgVsfk7XRjNg6udGRsfxciKUXBleKt2GDWFBO3+Dj2r8+O8VxMrygGb7E9GLG
         dMqSXvb8NMlcTEGW/gSt/Vyeijstdw9FcGKM5dL4Nwt8Z7YYdXqiSJf7LuMlO89uyLFF
         LJrhm4Eg0OVaX3bWhkdmZM4RG996VsAteDiSI/F3pFFKCSH1HHwJUS+xDdfvo77g12Q0
         n7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8xSJAgeNdOuQkASPp4auEM5KTYjlWHqIVKzsoZjoOt8=;
        b=VUliVWaMsvVRm6EHDwAVOk/BoIdtRJxm1yoIdf0RCiq0aW4ZVFoNriF0ouZbN5VL1I
         cai9wzE9JLaeDbOthps/5/Ez8X2Zi4GBg76bfNNRYGWgPZd4ncDi5mJZ0BWH0O7kqOkZ
         H5oEpYFtKLtpHpoNAilVdKo0K+sz1PMjv66+UmFhD+ZrbETGSwg0UHQgndAq9/ipYHM7
         mPEzgD0d4Z7TVyFeoWuItD2sxzjRwMwBcqpjUp5l5xGt4XSL7ByBE56Zu+y6Emfk+Kbk
         aRdzWzVNPRWOA15laVy2aQZyz/7R8sZADAEmFKohQAuzVxhEPXhx2qKmoj4NL71UNyfb
         zY4Q==
X-Gm-Message-State: AOAM532v8n1V+7C8wO+Ica63IPXDxJ8TLBmL0eyPPZCm3IddYbFQ1Xn6
        SOSAzkI3lngpwLTPAf2NH1GW+1w9Lex8dtdfaSgDAcTgOXc=
X-Google-Smtp-Source: ABdhPJznCmhAkWAgbT8MmO9s1KfwUTmLsZGUeCdK6M4kftzH5lpK6NuLakPJcL32CDjqyq5Id6Z8D13MImBPVxm4ni0=
X-Received: by 2002:a2e:a288:: with SMTP id k8mr6794314lja.229.1632423036129;
 Thu, 23 Sep 2021 11:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210921110029.21944-1-tony@atomide.com>
In-Reply-To: <20210921110029.21944-1-tony@atomide.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Sep 2021 20:50:00 +0200
Message-ID: <CAPDyKFqeCzjjWgM-A8QEQKvGcadB0nQXLQb0ZfFbRRqB29B7pA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Prepare sdhci-omap to support more SoCs
To:     Tony Lindgren <tony@atomide.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 21 Sept 2021 at 13:00, Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> Here are changes to prepare to add support for more SoCs to start
> deprecating the old omap_hsmmc driver. I'll send another series
> of changes to add support for more SoCs.
>
> Regards,
>
> Tony
>
>
> Tony Lindgren (5):
>   mmc: sdhci-omap: Fix NULL pointer exception if regulator is not
>     configured
>   mmc: sdhci-omap: Fix context restore
>   mmc: sdhci-omap: Restore sysconfig after reset
>   mmc: sdhci-omap: Parse legacy ti,non-removable property
>   mmc: sdhci-omap: Check MMCHS_HL_HWINFO register for ADMA
>
>  drivers/mmc/host/sdhci-omap.c | 61 ++++++++++++++++++++++++++++++++---
>  1 file changed, 56 insertions(+), 5 deletions(-)
>
> --
> 2.33.0

Applied for next, thanks!

Please tell me, if there are any of these changes that you think
deserves to be tagged for stable kernels.

Kind regards
Uffe
