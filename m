Return-Path: <SRS0=iGfF=DP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434B1C4363A
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 11:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D711520714
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 11:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9dBIZeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgJHLLl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Oct 2020 07:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbgJHLLk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Oct 2020 07:11:40 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB0EC061755;
        Thu,  8 Oct 2020 04:11:40 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x16so4009612pgj.3;
        Thu, 08 Oct 2020 04:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TNQsuuPlQCO96OIfCTfqNv2kF5InQ49REdeIqmc413s=;
        b=i9dBIZeQHwJjZ3PbuyRRP/YORFumtZ7Uhto+wuf99+FdCd2vVq4gF9MTdFlbniasTZ
         Ocx+7z/0wd88XpxDoZcFTVMTxZAobauR8L+s4xP8ITsY+Julup33HBh2aPuYv+TZGDHb
         Tfd/+gIrHskVEm5Yv/kxsg4LzPlSgnjhxvWPx2K149MpN46LiOu3FuxvQwMMPcMpuXmZ
         rW2F6500aIbk6A+JOogQgF0vRPZosmG9yWJ2HGjL+og2Npz+PdKNVNoAlQQY78XJ4rO7
         /O8jS97/VadIOH1TkOavHUm0VeD1mySDH9PANmFW6Yf6v60n8jnW2An/62uittjVTH3N
         jpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TNQsuuPlQCO96OIfCTfqNv2kF5InQ49REdeIqmc413s=;
        b=c6msajUw8OxuM3d4YMc/HtXo2kF6+ElzC5HCOxzk1gjNFo0Gv3ywLpADIY99MNEmIM
         7jKos2YJWjUGDSPQWTyB9azgYU3UZwe35NBIgbSJnBJ4RPoWNhMo9CSnxYHYfbS1Kw6L
         QbqGSs9qa49xUyAzXMPl2xJT21jFNDUYI6ePOkKzjyjnAk/7Rltw7ZnxdXIjP1S9JM8y
         wlCbZCA46O9SvInd0nQRbFy9ntrjbl79pmetEQz4foxHdfhEak+tefdBXHGDyjskKY/T
         FP3WU4lGf4aPBiRRLF5aMboGQKLVOkdMnz3X9QUccm0QHvBYkDElaGM83CK63XM1X+Q3
         Jyeg==
X-Gm-Message-State: AOAM533/3gY34USbc1PD2JLY/TmNWkpoh4iClpXZHSInW/KtQ6dAOsWm
        SfwMiCGirEEx8oaSXEjTQtZRMY0nFd3G0w8j7+c=
X-Google-Smtp-Source: ABdhPJx14bisq4nEXCBiAV2U9hGxJ+4wH2W2fk80Cdp6lh+SEgA0gPxfUKpdwiiQtnaohFiHBvWtOsIfR+EL4uW0DUI=
X-Received: by 2002:a65:47c2:: with SMTP id f2mr6925900pgs.4.1602155500218;
 Thu, 08 Oct 2020 04:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
 <20201008020936.19894-4-muhammad.husaini.zulkifli@intel.com>
 <9deff9d8-b8da-7cc2-19f3-e5baab010d92@xilinx.com> <DM6PR11MB28769233CEC9023E3D9720F9B80B0@DM6PR11MB2876.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB28769233CEC9023E3D9720F9B80B0@DM6PR11MB2876.namprd11.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Oct 2020 14:12:29 +0300
Message-ID: <CAHp75VfRF75uCGD3uAuYBvKi1LZOtVDAfiOHKxDhKr=9LP+nEg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] mmc: sdhci-of-arasan: Add structure device pointer
 in probe
To:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Oct 8, 2020 at 1:36 PM Zulkifli, Muhammad Husaini
<muhammad.husaini.zulkifli@intel.com> wrote:
> >From: Michal Simek <michal.simek@xilinx.com>
> >Sent: Thursday, October 8, 2020 3:35 PM
> >On 08. 10. 20 4:09, muhammad.husaini.zulkifli@intel.com wrote:
> >> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>

...

> >> @@ -1521,6 +1521,7 @@ static int sdhci_arasan_probe(struct
> >platform_device *pdev)
> >>      struct sdhci_pltfm_host *pltfm_host;
> >>      struct sdhci_arasan_data *sdhci_arasan;
> >>      struct device_node *np = pdev->dev.of_node;
> >> +    struct device *dev = &pdev->dev;
> >>      const struct sdhci_arasan_of_data *data;
> >>
> >>      match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
> >>
> >
> >This is not what we discussed. You create new variable and you should just use it
> >in that function.
> >
> >s/pdev->dev\./dev->/g
>
> For widely used in future, we plan to put it here and not specific to Keembay function only.
> Any comment on this @Andy Shevchenko?

I'm not sure what comment from me is needed. I'm on the same page with
Michal, i.e. replace current users of &pdev->dev with a new temporary
variable.

-- 
With Best Regards,
Andy Shevchenko
