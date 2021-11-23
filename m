Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE906C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Nov 2021 07:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbhKWHp0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Nov 2021 02:45:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234063AbhKWHpZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 23 Nov 2021 02:45:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D22560E94;
        Tue, 23 Nov 2021 07:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637653338;
        bh=TbYdLFnqcgIXjTzcGnFmxKgBN6m6L2wwXqicA4xY4V8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cJftIbTfBmKJXlMCLrNa00rm63AJmqdB8IvmcPWW+/Te7iAVxKHkknVEPkKJTWn8K
         DpetsTa7h20T0OPgNiZnAe+1iAQEBGkPN9KyVSroto+fw/3vmtBiOIDFc8nb7o76Wo
         caysg3jsgfAH/O0lUvLgDy4XxYFY6O6Kjst3VY4cuBKgUKR5Kxh0e8PjiQ12LNs8cq
         SrVMdHQsPMiMwQ1aY5EQw7l4sF+78bJ6P7BedVKJ9rRj0vB6JKuy10FsU5K4I21Raw
         +mofe7xTaNJ6AYVhu2P5Ts6RCtxTjukBk2L4AxIGp7mJ3t2hly7uS1COCnGVVGvy1P
         rEjwwWfevSS/Q==
Date:   Tue, 23 Nov 2021 13:12:14 +0530
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
Subject: Re: [RESEND PATCH v2 4/4] phy: intel: Add Thunder Bay eMMC PHY
 support
Message-ID: <YZybVkfMCI1durcN@matsya>
References: <20211027115516.4475-1-rashmi.a@intel.com>
 <20211027115516.4475-5-rashmi.a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027115516.4475-5-rashmi.a@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 27-10-21, 17:25, rashmi.a@intel.com wrote:
> From: Rashmi A <rashmi.a@intel.com>
> 
> Add support of eMMC PHY for Intel Thunder Bay SoC,
> uses the Arasan eMMC phy

Applied, thanks

-- 
~Vinod
