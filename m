Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21FEC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Oct 2021 07:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB4006008E
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Oct 2021 07:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhJYHFp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Oct 2021 03:05:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230451AbhJYHFo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 25 Oct 2021 03:05:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D7276023E;
        Mon, 25 Oct 2021 07:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635145402;
        bh=b2ZKJTUdVCkQS98YgaVFDNlMI1qmq4hVxYpwYJLnGtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MzOchr4576iqwit9K0Ldca9+pYoKpfyGuYszBN92hzVgeAumWYcSkFFNzHUHnR9t8
         IFdhS78dCOmgDw1v+9PDUa2IQyTZ4n11kTg86BDVQPWRosFvPtYjqkjgxC+wFTHpBz
         clQ9QwAOGF9xZIGk81HvKHYiMrjdyIXGyIo7jLluoE551DFabHl4Lin66wy6Q3mWx4
         csSwDEowZiD4D/4CAsApmtVBIE9Mfs3hwapL7Pg6EUrlFmFbg/LBfEfGXGICg6Lqec
         8gDzG0jqMmTGMMpLnAQjBO2u1kDGdE4OaVWBUxRPTYEKEHeK6NG5X1lyFryg2ZwvPk
         ePKY37PeR+c5A==
Date:   Mon, 25 Oct 2021 12:33:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "A, Rashmi" <rashmi.a@intel.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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
        "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
Subject: Re: [PATCH v2 0/4] Add support of eMMC PHY for Intel Thunder Bay
Message-ID: <YXZWt6vGIVqOhgt1@matsya>
References: <20210829182443.30802-1-rashmi.a@intel.com>
 <CAPDyKFq2VQ=khYnmfsQGPPcpRnxyATVSpwKSZ4MTbKn64rthVA@mail.gmail.com>
 <DM6PR11MB306560AE06F83FC56B9F89988CAE9@DM6PR11MB3065.namprd11.prod.outlook.com>
 <YVwqVRkwAYnoJR6x@matsya>
 <DM6PR11MB30651D5F6C252EA70BAA43CE8C839@DM6PR11MB3065.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB30651D5F6C252EA70BAA43CE8C839@DM6PR11MB3065.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25-10-21, 05:46, A, Rashmi wrote:
> 
> 
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: Tuesday, October 5, 2021 4:05 PM
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
> > <nandhini.srikandan@intel.com>
> > Subject: Re: [PATCH v2 0/4] Add support of eMMC PHY for Intel Thunder Bay
> > 
> > On 04-10-21, 06:04, A, Rashmi wrote:
> > 
> > > Applied patch1 and patch2 for next, thus leaving the phy changes in
> > > patch3 and patch 4 for Kishon/Vinod to pick up.
> > >
> > > Thanks and kind regards
> > > Uffe
> > >
> > >
> > > Thanks Uffe,
> > > Hi Kishon/Vinod,
> > > 	Please let me know if you have any comments
> > 
> > Need ack from Rob on binding patch
> > 
> > --
> > ~Vinod
> 
> Hi Rob Herring,
> 	Please help to review the eMMC dt-binding patches

Just realised, neither Rob nor the DT list is in CC, ofcourse he would
not have seen this.

Please rebase and repost with Rob and DT list in CC!

-- 
~Vinod
