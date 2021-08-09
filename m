Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D38C4320A
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Aug 2021 08:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA3F60462
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Aug 2021 08:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhHIImD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Aug 2021 04:42:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234033AbhHIImC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 9 Aug 2021 04:42:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEA2161004;
        Mon,  9 Aug 2021 08:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628498502;
        bh=Qxd4HYvX3aRfn/wmAN7Ne2jEEMh5o0SV/36EibPAnPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B8S4Qpo77i5TDVAurBFxqMaItyoZUC3owyuZmIDcI4bKn+iVlAFekR0R9wQdIZTno
         g7q9uD/CDmM6AHnyhmWaT9Ob/v/v7ntpJJLrD6135P3VF4irhsUrZTMIR4YbGVPDpX
         yGmvnSyWCqT2CaiEq5N9VVCz0nzZJgoBP+3b2pcpIXM3+r6w6U9Pe5xEvJEEmLX3Gv
         p154BkNk4BYYomDrgCoWOCnder/9kjJqNZiXUsBhGpUOBKgebVkHej7nLTt10e82t7
         ugCj8qR1sxI9yxN+ka90R6vWHV26jtuUx+R6Dm6KgzN29kuv0dVE5EzTLC69ANhQg4
         D1BLa66ioqshA==
Date:   Mon, 9 Aug 2021 14:11:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "A, Rashmi" <rashmi.a@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
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
Subject: Re: [PATCH 2/3] mmc: sdhci-of-arasan: Add intel Thunder Bay SOC
 support to the arasan eMMC driver
Message-ID: <YRDqQvKQ71/824Lu@matsya>
References: <20210730063309.8194-1-rashmi.a@intel.com>
 <20210730063309.8194-3-rashmi.a@intel.com>
 <CAPDyKFqZ-H3+OnYyyY7y611YrRAAMFq+W65DMfM4wSNvY_fzjA@mail.gmail.com>
 <MWHPR11MB17891909766F5295AF34B0578CF69@MWHPR11MB1789.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB17891909766F5295AF34B0578CF69@MWHPR11MB1789.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 09-08-21, 05:16, A, Rashmi wrote:

> > 
> > Rashmi, is it safe to apply this separately from the phy driver/dt changes?
> > Then I can queue this via my mmc tree, if you like.
> No, the phy driver/dt changes must go together with "mmc: sdhci-of-arasan: Add intel Thunder Bay SOC support to the arasan eMMC driver" patch.

Why is that?

What could happen, emmc driver will complain about phy not found and
bail right?

-- 
~Vinod
