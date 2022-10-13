Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD38C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Oct 2022 13:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJMNn7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Oct 2022 09:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJMNn7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2022 09:43:59 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804A0115C38
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2022 06:43:57 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cl1so1931831pjb.1
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2022 06:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O81+P58FUqUzFvyhgNRSmI+OPkunmpM/swl0Z9C3YBg=;
        b=ioli8x3yHwDJN+q9To8poYslymiA7VxYi3Vcv85dQquOoUzOU/2j0K+Kf2Xm4ZZtNR
         8D6d8etpktGLMcSegOxQ44t05jwy4RhL4K99PLeSJpPLfdkHrIf9LD6351WljHQnGt0C
         MFhidHsfCw0XJue8oOiAO1lu1DLfkCyKZP1fY/yVSJGCOH6lHoTbZ0REtbExaDkOXotk
         8cGVtPC/Ezmyv76OCZUKrUSk9u6URw5Souuv0wjyM8Sfbqiz0YANIlD7tFRizm4pbCdL
         2Fzb70j48sC4xtdTi8rOIuniTFGudO7T6CZkoZsht9vosfI1Wfxuxm42VrBHx7SKQlEa
         5gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O81+P58FUqUzFvyhgNRSmI+OPkunmpM/swl0Z9C3YBg=;
        b=779wD7UmOmwlSQFPGAe74YGhKui3TK8MzZZuxnE+Mx5RGt+ch2sU42xgin1x8yK64b
         6pVRYrTOuhrZnOW8HU4IlsqVAZDSboLUJr5eL2ZY8klskJRaonsbuAyW/QpUATWXs01B
         c+pdObzLsj726dgDFvYtwbDFrMbMLcN7r/lzOH/sA2TTTlLuu5MMYcyqgCfS7TFf/pOq
         LNM9aTdss07bbMYqTzhDVL6PVdsLT5hLxINCKbRadjcXnfcsLzKZ8dI/IXzybsFQa1iU
         Inx1PaGhSwWydqORsFsYrb5TanM68aJV4ilV+P5iznXJJNGve7ZBlKYtEZgYwbotOflV
         AB2A==
X-Gm-Message-State: ACrzQf3h5vh5kyafc6+N4ekvt/1f5EQ1O+V+cUvZG5YKijKpqBcWMKgk
        FfdMHvv/LXa7SyAUlcHiwtq5srRM4DElVPnAy2huPmX8PjY5nw==
X-Google-Smtp-Source: AMsMyM5iw0c63ZR4dpISN3UmFSzHp5mi5fer3iRlq8DDZ7XJmTyUQktu+UCO6+i1ktquI1thkVrEtWSlAnxyQ9zbA20=
X-Received: by 2002:a17:90a:7b8c:b0:20b:1f3b:f6fd with SMTP id
 z12-20020a17090a7b8c00b0020b1f3bf6fdmr11160768pjc.202.1665668635466; Thu, 13
 Oct 2022 06:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <Yz6zfrVq9cP/wrJb@orome> <20221006130622.22900-1-pshete@nvidia.com>
 <20221006130622.22900-2-pshete@nvidia.com> <CAPDyKFr_Yi2EgrBUzsORnM4mOkf25WR8+7_dfF2h4XzRDPm9-w@mail.gmail.com>
 <DM5PR12MB2406610AB26183BACB19EED6B7239@DM5PR12MB2406.namprd12.prod.outlook.com>
 <CAPDyKFqn2jMVQ5BAOZPFx2OOyMRQvsQ1E7mGAQp82x5+v6aSGQ@mail.gmail.com> <DM5PR12MB2406405CE44A7606B5A28203B7259@DM5PR12MB2406.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2406405CE44A7606B5A28203B7259@DM5PR12MB2406.namprd12.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Oct 2022 15:43:18 +0200
Message-ID: <CAPDyKFq5hNTdwT7CMvsxG=_5u+xvG2k3-PfbGhAbHfHbGqK81w@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] mmc: sdhci-tegra: Add support to program MC stream ID
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Suresh Mangipudi <smangipudi@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 13 Oct 2022 at 08:33, Prathamesh Shete <pshete@nvidia.com> wrote:
>
> Hi Ulf,
>
> >> In that case, perhaps we can add a "depends on IOMMU_API" in the Kconfig
> >> instead? Or is the tegra driver used on platforms where IOMMU_API could be
> >> unset?
> Yes it can/will work with IOMMU disabled so its not recommended to add a "depends on" condition in Kconfig.

Alright, in that case it looks to me that there are two other options
to move forward.

1) Add proper definitions of the struct iommu_fwspec in
include/linux/iommu.h even when CONFIG_IOMMU_API is unset. In a way it
seems a bit silly to me, to have the iommu stubs around, unless those
can be used for cases like this, right!?

2) Move the code within the "ifdef CONFIG_IOMMU_API" sections into
separate functions - and add stubs for these functions too. In this
way the functions can be called, independently of whether
CONFIG_IOMMU_API is set/unse, which would make the code in
drivers/mmc/host/sdhci-tegra.c cleaner and thus easier to maintain.


>
> Thanks
> Prathamesh
>
> > -----Original Message-----
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> > Sent: Tuesday, October 11, 2022 6:04 PM
> > To: Prathamesh Shete <pshete@nvidia.com>
> > Cc: adrian.hunter@intel.com; thierry.reding@gmail.com; Jonathan Hunter
> > <jonathanh@nvidia.com>; p.zabel@pengutronix.de; linux-
> > mmc@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Aniruddha Tvs Rao <anrao@nvidia.com>; Suresh
> > Mangipudi <smangipudi@nvidia.com>; Krishna Yarlagadda
> > <kyarlagadda@nvidia.com>
> > Subject: Re: [PATCH v7 2/4] mmc: sdhci-tegra: Add support to program MC
> > stream ID
> >
> > External email: Use caution opening links or attachments
> >
> >
> > On Tue, 11 Oct 2022 at 13:44, Prathamesh Shete <pshete@nvidia.com> wrote:
> > >
> > > Hi Ulf
> > >
> > > The initial patches were without the #ifdef. #ifdef is being added as per review
> > comments and kernel robot errors.
> > > Following error was detected by kernel robot
> > > >>
> > > All errors (new ones prefixed by >>):
> > >
> > >    drivers/mmc/host/sdhci-tegra.c: In function 'sdhci_tegra_probe':
> > > >> drivers/mmc/host/sdhci-tegra.c:1794:54: error: 'struct iommu_fwspec' has
> > no member named 'ids'
> > >     1794 |                         tegra_host->streamid = fwspec->ids[0] & 0xffff;
> > >          |                                                      ^~
> > >
> > >
> > > vim +1794 drivers/mmc/host/sdhci-tegra.c
> > > >>
> > > Adrian also pointed out this issue so to address these issues #ifdef
> > > was added
> >
> > I see!
> >
> > In that case, perhaps we can add a "depends on IOMMU_API" in the Kconfig
> > instead? Or is the tegra driver used on platforms where IOMMU_API could be
> > unset?
> >
> > [...]

Kind regards
Uffe
