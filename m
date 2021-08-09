Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C30DC4320A
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Aug 2021 12:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2185660F35
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Aug 2021 12:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbhHIMOV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Aug 2021 08:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbhHIMOQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Aug 2021 08:14:16 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDE0C061796
        for <linux-mmc@vger.kernel.org>; Mon,  9 Aug 2021 05:13:55 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id 67so6898211uaq.4
        for <linux-mmc@vger.kernel.org>; Mon, 09 Aug 2021 05:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0zVmmfKjsh0O6iTcBeLVuCbww8hMd82b9Le3k2jDVtU=;
        b=IeN4102EglVq6qp9hh2HqtonBYVIky9VwVBQB6Gvbk+p1dYiI/3JCTZFyt6RjAOCVv
         SqVs6vpO9EUQgvDdFVlfIjUDD8jC9JEHJ0k6yvutzVOurcWoI/mtDoElrZnSG6JWdYeq
         OsIuCcaSyg1a4ujJK5zzLSSHRi3Ybw8Pv50hFnG9kLxd9oEq/cs984/0nNA3VJnGH4w0
         +ikRhA9yD6YgAOxn2aGfVdKuastyUfRBd215VG7V9YBL3ivYajvZSTNHdD8y6ZKW3J+U
         ZPIjod43oKSb14ICuisE/yhq+7hHgX0/Hcns0tK7u2E45Uk8dDBL2btJraHiPbaGp/EV
         sIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0zVmmfKjsh0O6iTcBeLVuCbww8hMd82b9Le3k2jDVtU=;
        b=Nh9KiJZ8MVwHL1cXzTrfUk+rzL+VXS9fwfwmRj9zqg26fMkb4t29EPrG3K590kwd1R
         yUIM+1sw5LOhwNbxWl5El3vqMCKCsjdsauM0ILgasOi64CUc3PiMWoLYGEZd/AGTnTre
         dGEa95n4sDTfrv5+nrq980QkLZRSPq5eZB6DWsv5wyhIi6qZQM5g9GcM0ODjyOn6QlvM
         4tCjHv6Fc2k7/Jc33dQ53LSCNWlFiu+iUABtDxvrXLd503sJzcWx8DuoYsDmEzPOJmgy
         bpjpmrGE/0Go+41IWyBTajVq1Pm7e000UqWcVBwa14/653l+TPkRNQ5/gdmPAw9q79lF
         nP8Q==
X-Gm-Message-State: AOAM530og0NkWVF0jYxmBPbRmFcqgLlFt2thpk/NB9YJ+G+SImGwqErT
        7yI2HX5RqGu7x0Yx69ylXh1xrl6cONeDXrzdZw6f6Q==
X-Google-Smtp-Source: ABdhPJyEN/N8WiArAmLbZiGvWNJvbwnRfJLMyXEkrASw8j5gZV6393JjHpibblCKurC+9vhkAUpbaDe81QmpxRZ+PiE=
X-Received: by 2002:a9f:25a7:: with SMTP id 36mr14751050uaf.129.1628511234750;
 Mon, 09 Aug 2021 05:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210730063309.8194-1-rashmi.a@intel.com> <20210730063309.8194-3-rashmi.a@intel.com>
 <CAPDyKFqZ-H3+OnYyyY7y611YrRAAMFq+W65DMfM4wSNvY_fzjA@mail.gmail.com>
 <MWHPR11MB17891909766F5295AF34B0578CF69@MWHPR11MB1789.namprd11.prod.outlook.com>
 <YRDqQvKQ71/824Lu@matsya> <MWHPR11MB1789D2B707B39CB42322C73A8CF69@MWHPR11MB1789.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB1789D2B707B39CB42322C73A8CF69@MWHPR11MB1789.namprd11.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 9 Aug 2021 14:13:18 +0200
Message-ID: <CAPDyKFp5HcCfsoLgBc=D9RKOrVY2SuV3FKsFCVT2=WaxZBsNiA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: sdhci-of-arasan: Add intel Thunder Bay SOC
 support to the arasan eMMC driver
To:     "A, Rashmi" <rashmi.a@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon <kishon@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "Srikandan, Nandhini" <nandhini.srikandan@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 9 Aug 2021 at 13:17, A, Rashmi <rashmi.a@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: Monday, August 9, 2021 2:12 PM
> > To: A, Rashmi <rashmi.a@intel.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>; Michal Simek
> > <michal.simek@xilinx.com>; linux-mmc <linux-mmc@vger.kernel.org>; Linux
> > ARM <linux-arm-kernel@lists.infradead.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; Kishon <kishon@ti.com>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; linux-phy@lists.infradead.org; Mark
> > Gross <mgross@linux.intel.com>; kris.pan@linux.intel.com; Zhou, Furong
> > <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> > <mallikarjunappa.sangannavar@intel.com>; Hunter, Adrian
> > <adrian.hunter@intel.com>; Vaidya, Mahesh R
> > <mahesh.r.vaidya@intel.com>; Srikandan, Nandhini
> > <nandhini.srikandan@intel.com>; Demakkanavar, Kenchappa
> > <kenchappa.demakkanavar@intel.com>
> > Subject: Re: [PATCH 2/3] mmc: sdhci-of-arasan: Add intel Thunder Bay SOC
> > support to the arasan eMMC driver
> >
> > On 09-08-21, 05:16, A, Rashmi wrote:
> >
> > > >
> > > > Rashmi, is it safe to apply this separately from the phy driver/dt changes?
> > > > Then I can queue this via my mmc tree, if you like.
> > > No, the phy driver/dt changes must go together with "mmc: sdhci-of-
> > arasan: Add intel Thunder Bay SOC support to the arasan eMMC driver"
> > patch.
> >
> > Why is that?
> >
> > What could happen, emmc driver will complain about phy not found and bail
> > right?
> This is right, but ideally both mmc:phy and mmc: sdhci-of-arasan driver code changes should go together

If patches are well written and can be standalone, we (maintainers)
ideally prefer to queue things on a per subsystem basis, because it's
just easier.

That said, I also noticed that a new compatible string was added,
"intel,thunderbay-sdhci-5.1". This needs to be documented in
Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml, in a separate
patch, preceding $subject patch.

Kind regards
Uffe
