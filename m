Return-Path: <SRS0=Q/yj=6H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EA9C54FD0
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Apr 2020 06:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D1D12173E
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Apr 2020 06:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587624478;
	bh=1fX8v4N0PkP4eNJRpcnHIcL9VvFjrsxEqRD/cF0O/xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JJUztTRaLPeV1kCaaercvikMlmswD9ztxDViIuEx9zFRqjmxKyN7WxcaZsBc91eXO
	 i13VD1IKCag9tNUB5OSO2npxTTj6koe1kAVVQg2VGPYcWxfmdad63XJyTy70mSonb/
	 Lx43SEAIXvxevoIgMUMrA4RH9ntVUwFHfk6Ge/tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgDWGr6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Apr 2020 02:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbgDWGr5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 23 Apr 2020 02:47:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7795214AF;
        Thu, 23 Apr 2020 06:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587624477;
        bh=1fX8v4N0PkP4eNJRpcnHIcL9VvFjrsxEqRD/cF0O/xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kqlJBb5nK0wgzdu8R+qF8uSaTuQ8Q1vDm+IT5Tlea0zAYDYL8Mr3KfFbyeh8QuigH
         cGD3suMkCVNfZz04V2QuzFuehX6MjI8FZ6vhijJvn1YetJ0VtOYQW/ITysN3lnHK7D
         gVCb+XBuLOew3xYXVmJz9HBSByIXZlJffxq/dP3A=
Date:   Thu, 23 Apr 2020 08:47:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        baolin.wang@linaro.org, kstewart@linuxfoundation.org,
        tglx@linutronix.de, bradleybolen@gmail.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 5.4.33 0/2] Fix for long operation cmds busy detection
Message-ID: <20200423064755.GA3491005@kroah.com>
References: <1587573149-30269-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587573149-30269-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Apr 22, 2020 at 09:32:27AM -0700, Sowjanya Komatineni wrote:
> This series is to backport the upstream patches that fixes busy detection
> for long operation mmc commands by implementing Tegra specific timeout
> callback to switch between finite and infinite HW busy detection wait
> modes.
> 
> 
> Sowjanya Komatineni (2):
>   sdhci: tegra: Implement Tegra specific set_timeout callback
>   sdhci: tegra: Enable MMC_CAP_WAIT_WHILE_BUSY host capability
> 
>  drivers/mmc/host/sdhci-tegra.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Any specific reason you did not cc: the stable@vger list when asking for
stable patches to be merged?
