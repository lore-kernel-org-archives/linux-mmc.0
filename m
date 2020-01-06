Return-Path: <SRS0=NLoK=23=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FCBC33C8C
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jan 2020 12:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDDB207FF
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jan 2020 12:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578313676;
	bh=clouiNKPozJbzl+cLuzS/XRHq+Lyf1dDHc3esJcePWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g308Vl63/lJaN8G9efi88nAiyFWiJELMe7/HP4Y/VF2pu4TOXNIsRUgWrHRofZXiy
	 ln480pKV5Hy686UUiopVLc2G6i4MMNJHnqBYYoYMbXqpXsCaCXYDGRm7I1UKF84A4o
	 Wkv26VF8CgKS3LvDEHcjgH6rzS93DU4PHBSgNOpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgAFM1w (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jan 2020 07:27:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgAFM1v (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 6 Jan 2020 07:27:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F7342071A;
        Mon,  6 Jan 2020 12:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578313670;
        bh=clouiNKPozJbzl+cLuzS/XRHq+Lyf1dDHc3esJcePWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RnaB8GukECekcfPfugsEAULLMDowkyQmsRQjiTuw7PtYMarp/ZmhtU/0fGb4wqRfQ
         ZIGH6uM3XEsPvZfBhXkiJbAzP/eLb09L82IanFJ7pCAHh9B9gzq3bKvmq6RIZh3MVU
         RUYluJ/YnmHkAfq5azZm10zajZGP7+9HHGQnVwdM=
Date:   Mon, 6 Jan 2020 13:27:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lucas Stach <dev@lynxeye.de>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: tegra: fix SDR50 tuning override
Message-ID: <20200106122745.GA3414443@kroah.com>
References: <245d569e4c258063dbd78bd30c7027638b30f059.1577960737.git.mirq-linux@rere.qmqm.pl>
 <20200106120718.GA1955714@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200106120718.GA1955714@ulmo>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Jan 06, 2020 at 01:07:18PM +0100, Thierry Reding wrote:
> On Thu, Jan 02, 2020 at 11:30:50AM +0100, Michał Mirosław wrote:
> > Commit 7ad2ed1dfcbe inadvertently mixed up a quirk flag's name and
> > broke SDR50 tuning override. Use correct NVQUIRK_ name.
> > 
> > Fixes: 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes")
> > Depends-on: 4f6aa3264af4 ("mmc: tegra: Only advertise UHS modes if IO regulator is present")
> > Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > ---
> >  drivers/mmc/host/sdhci-tegra.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Oh my... good catch!
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> 
> I also ran this through our internal test system and all tests pass, so
> also:
> 
> Tested-by: Thierry Reding <treding@nvidia.com>
> 
> I'm not sure if that "Depends-on:" tag is anything that's recognized
> anywhere. It might be better to turn that into an additional "Fixes:"
> line. Adding Greg to see if he has a standard way of dealing with this
> kind of dependency.
> 
> Greg, what's your preferred way to handle these situations? I think the
> intention here was to describe that the original error was introduced by
> commit 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes"), but then commit
> 4f6aa3264af4 ("mmc: tegra: Only advertise UHS modes if IO regulator is
> present") moved that code around, so this patch here will only be back-
> portable until the latter commit, but should be backported until the
> former.

The stable kernel rules document says how to handle this, but the
"depends on" commit id in the comment to the right of the stable@k.o cc:
line in the changelog area.

thanks,

greg k-h
