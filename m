Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FB7C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Nov 2021 07:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbhKWHpO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Nov 2021 02:45:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:54744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234063AbhKWHpN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 23 Nov 2021 02:45:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 164016008E;
        Tue, 23 Nov 2021 07:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637653326;
        bh=5YgIFjfpg5vULlmgcdxg7GkWRqrmKmms46EiNLgenCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AaQQXBPvoqz7ayuyT/f+LTzFzcOy9HCyQ8qwJpBjYYayUlaSTnFNPMcf9OVsgiaHf
         yrkZypTtm1wur2ta8jlOK2+JKKweaoEsFsxrz5SHcllS7DXLpoVWBpIS2Axs1ZsjX2
         lCrHjkhV+xipMK15iSJPwZmdLpoube0n2patE4SAqZzUFMn/a/OYORSoCTZO7qz+V0
         DyLAF+5LS/CTxxpDk5XCQv/NG7UapgD7eBaKtjszd99Y7mStqYvWV2RDTGs6hrHLm9
         EwOv9ZbpF3Q7qYNJHKTAewzr/ibIXX5bF88qNL6ba8cuKZqoVLcCOJBxPUEd1aSQu2
         VWgob7HadgfoQ==
Date:   Tue, 23 Nov 2021 13:12:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     rashmi.a@intel.com
Cc:     michal.simek@xilinx.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@ti.com,
        andriy.shevchenko@linux.intel.com, linux-phy@lists.infradead.org,
        mgross@linux.intel.com, kris.pan@linux.intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        adrian.hunter@intel.com, mahesh.r.vaidya@intel.com,
        nandhini.srikandan@intel.com
Subject: Re: [RESEND PATCH v2 3/4] dt-bindings: phy: intel: Add Thunder Bay
 eMMC PHY bindings
Message-ID: <YZybSTsMRKkOyfC5@matsya>
References: <20211027115516.4475-1-rashmi.a@intel.com>
 <20211027115516.4475-4-rashmi.a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027115516.4475-4-rashmi.a@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27-10-21, 17:25, rashmi.a@intel.com wrote:
> From: Rashmi A <rashmi.a@intel.com>
> 
> Binding description for Intel Thunder Bay eMMC PHY.
> Added the newly introduced files into MAINTAINERS file-list

Applied, thanks

-- 
~Vinod
