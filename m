Return-Path: <SRS0=y6Wy=5L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE0FC2D0E9
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Mar 2020 02:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D2020848
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Mar 2020 02:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585191095;
	bh=Iu7+xDWDoLVdsd1ppzOXMLR8k29tmopY2kgWRyEAHPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PvPwGjrqpcEywpGImDhPO+S/VleqTdgbBgSzF//nBdAsQxWQArAdImxrCRgJIRWlh
	 83KzVJUyPE6m/JkqaHi7T55L9H1pWNg7mepXcidGBkETqWS5HOD4iEdR5GO4ISINls
	 ORJqWY3+6uzlHUFjV6ilHXMHZsrkAEVt77IebMTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgCZCve (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Mar 2020 22:51:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbgCZCve (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 25 Mar 2020 22:51:34 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6AFB20714;
        Thu, 26 Mar 2020 02:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585191094;
        bh=Iu7+xDWDoLVdsd1ppzOXMLR8k29tmopY2kgWRyEAHPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bld6BNoDm1c8nJOOI26T1394lM9BClvMSqupCVSD9KJ4Fx9ThniFApY2ML4Lu8SnF
         d1AVlTeM32QlRJqNw/XRMW663sguMXjKqvQGufx+IgJ2v/vECHHxRfhUOzItDyJqdr
         5psPRJN1hLV/LDaU7AU8hy05/xl2cC3OrOJQORmM=
Date:   Wed, 25 Mar 2020 22:51:32 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-mmc@vger.kernel.org,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH 5.5.12 0/5] mmc: Fix some busy detect problems
Message-ID: <20200326025132.GA4189@sasha-vm>
References: <20200324180650.28819-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200324180650.28819-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Mar 24, 2020 at 07:06:45PM +0100, Ulf Hansson wrote:
>This series provides a couple of manually backported mmc changes that fixes some
>busy detect issues, for a couple of mmc host drivers (sdhci-tegra|omap).
>
>Ulf Hansson (5):
>  mmc: core: Allow host controllers to require R1B for CMD6
>  mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for erase/trim/discard
>  mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for eMMC sleep command
>  mmc: sdhci-omap: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY
>  mmc: sdhci-tegra: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY
>
> drivers/mmc/core/core.c        | 5 ++++-
> drivers/mmc/core/mmc.c         | 7 +++++--
> drivers/mmc/core/mmc_ops.c     | 8 +++++---
> drivers/mmc/host/sdhci-omap.c  | 3 +++
> drivers/mmc/host/sdhci-tegra.c | 3 +++
> include/linux/mmc/host.h       | 1 +
> 6 files changed, 21 insertions(+), 6 deletions(-)

I've queued this, the 5.4, and the 4.19 series. Thanks!

-- 
Thanks,
Sasha
