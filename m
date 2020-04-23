Return-Path: <SRS0=Q/yj=6H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09142C2BA19
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Apr 2020 06:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9AFF21582
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Apr 2020 06:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587624248;
	bh=863mETzaq75o/iPk8dqOZNMgv+NHhYcqlH4fv5yor2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0QxKhFxSeBSaE5BjAqYYDjqHeIZ6U4OODSS+y9amSnsgwJQatUO1YFM328h1eXhjL
	 G1FOjx1FHgQSzvF/r/u+iQMglB+aA5glrdACs5DEEg3HBmq6EZnonI9Lkk55hQQ0c/
	 X0eFWQsbNukqY2E9fV8KMEo2+cSYkCLeNtELWZQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgDWGoH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Apr 2020 02:44:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgDWGoH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 23 Apr 2020 02:44:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF6E20736;
        Thu, 23 Apr 2020 06:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587624245;
        bh=863mETzaq75o/iPk8dqOZNMgv+NHhYcqlH4fv5yor2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BWnhBRXgYWOkwJC6pJrNels+6EEqh9wgRjiTmxrPbErr9x0vGUMYeJqG00BX8YoF9
         gOzE6u893FcIKArZRQeJ4WV2F5LYJBoPUEo6P746+WnNerdVOaGqzNf0GOMW94LcSf
         BSNVuErXumYeDZ8WjH/wez7SIA0Wa4UGg1YAFCmo=
Date:   Thu, 23 Apr 2020 08:44:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        baolin.wang@linaro.org, kstewart@linuxfoundation.org,
        tglx@linutronix.de, bradleybolen@gmail.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH 5.5.18 0/2] Fix for long operation cmds busy detection
Message-ID: <20200423064403.GB3488526@kroah.com>
References: <1587573178-30326-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587573178-30326-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Apr 22, 2020 at 09:32:56AM -0700, Sowjanya Komatineni wrote:
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

5.5.y is end-of-life, no one should be using it anymore, nor can I add
any more patches to it, sorry.

greg k-h
