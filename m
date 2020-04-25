Return-Path: <SRS0=TOBz=6J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18080C55191
	for <linux-mmc@archiver.kernel.org>; Sat, 25 Apr 2020 01:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE1AD20857
	for <linux-mmc@archiver.kernel.org>; Sat, 25 Apr 2020 01:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587779162;
	bh=Bsxnl2K3A5XAIn6prZzLDll+iJkvSiJDNO68VKWaOG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qQ9/sfLL1mQiR6jhb6zkfqQ0D9qpYy9wOXL/ApOay5Fg+3S2CeyoepE+mHGypWxWF
	 dtXqgHJBb8yeLiw+8/LS6/X2FJc9/yrgVnjwe+5c3ClKRuqp9IKvkSLVLtPwb+DTVB
	 +8LfnL+HL9D2+8UylyR5wk8FL/8GYpmCTRjLWaP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgDYBp6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Apr 2020 21:45:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgDYBp6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 24 Apr 2020 21:45:58 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8FC720776;
        Sat, 25 Apr 2020 01:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587779158;
        bh=Bsxnl2K3A5XAIn6prZzLDll+iJkvSiJDNO68VKWaOG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A6xJQGCHctBWbt0qg3tmipfzwSFl/LhY1h9HmPFtN+AURFrQ0SuKuJGoudCbVcPB2
         +Lr7mG/FrKTLe528cp/UlqzbmYrrefFomy99fIorAT2Z8tkjQnXTuCbp5HLw/BfGmm
         0XkxjTWUqVwn09sbQGA0wcCH/AsJDtbk1qt6NhMc=
Date:   Fri, 24 Apr 2020 21:45:56 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        baolin.wang@linaro.org, kstewart@linuxfoundation.org,
        tglx@linutronix.de, bradleybolen@gmail.com,
        gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, anrao@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.4.33 0/2] Fix for long operation cmds busy detection
Message-ID: <20200425014556.GD13035@sasha-vm>
References: <1587758766-3274-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1587758766-3274-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Apr 24, 2020 at 01:06:04PM -0700, Sowjanya Komatineni wrote:
>This series is to backport the upstream patches that fixes busy detection
>for long operation mmc commands by implementing Tegra specific timeout
>callback to switch between finite and infinite HW busy detection wait
>modes.
>
>
>Sowjanya Komatineni (2):
>  sdhci: tegra: Implement Tegra specific set_timeout callback
>  sdhci: tegra: Enable MMC_CAP_WAIT_WHILE_BUSY host capability

What regression do these patches fix?

-- 
Thanks,
Sasha
