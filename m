Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCDEC7618A
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Mar 2023 07:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjCTH2F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Mar 2023 03:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCTH2D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Mar 2023 03:28:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFFB12850;
        Mon, 20 Mar 2023 00:28:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0E37B80CAC;
        Mon, 20 Mar 2023 07:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88523C433EF;
        Mon, 20 Mar 2023 07:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679297279;
        bh=QDq3psYYPI1XmtNVdVpK0cyJmaeS12aYbyEfukWS36E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BotSU8JsYWZMkmed2Eyx1uRwkR5NlQK8ZiLMYnKAI5Tl8y7sozsS7QFjZ1IOxSC7L
         NCqkNUl+7DA99rMmM2BEjYhbuq0j5DJOQmJFbDkkm2Kl3DBQxEpsuJwqIwPLVMWHEf
         TVyjAV4GLBQ1cOlQjsWvUp2gzmr1yZsdkjCSl2oLFmHLo2CD6Wmc3SyuWwJwfXahMj
         4DAK09jpF/Wvpr7iPhEI+RXkVWxdNondkbhZX45vCWRANdiDrFl0/i2Q5R0J3LoOmy
         hxB0aSI29OtWlZLkIMHAe5FqwuO2cOdnu2UmN+sUA5YsXsxOA90TQ0Nixcg1qb7/Kt
         /0Irh87lLmYsA==
Date:   Mon, 20 Mar 2023 12:57:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     rashmi.a@intel.com
Cc:     ulf.hansson@linaro.org, michal.simek@xilinx.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kishon@kernel.org,
        yuancan@huawei.com, andriy.shevchenko@linux.intel.com,
        linux-phy@lists.infradead.org, mgross@linux.intel.com,
        kris.pan@linux.intel.com, adrian.hunter@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        vasavi.v.itha@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com
Subject: Re: [PATCH v2 3/4] phy: intel: Remove Thunder Bay eMMC PHY support
Message-ID: <ZBgK+pd9hfaRFk4S@matsya>
References: <20230316120549.21486-1-rashmi.a@intel.com>
 <20230316120549.21486-4-rashmi.a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316120549.21486-4-rashmi.a@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16-03-23, 17:35, rashmi.a@intel.com wrote:
> From: "A, Rashmi" <rashmi.a@intel.com>
> 
> Remove Thunder Bay specific code as the product got cancelled
> and there are no end customers or users.

Applied, thanks

-- 
~Vinod
