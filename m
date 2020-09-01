Return-Path: <SRS0=T3o1=CK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97A2C433E2
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 13:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C51D207D3
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 13:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598968492;
	bh=fgdQbvNKfrT9RQxxwbrS+G3c51w2CaurFPEVweTkSFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V1wdPk2dfLjOgW/Bj5AMMoloJd3idBlLTsVUIvkan6OfWGLQI+1mM/XJfxfaE8PT9
	 2krg/IKRJCeEwp7B4UqFDtdRIStIbRKSRTTB3TwYVgVHuSjgcEest2TRaZYqOZQHxg
	 QMQzBJ2EvSyPAEUZ4O7A/x9YJGP1XPPI94qceRUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgIANyv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbgIANyq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 1 Sep 2020 09:54:46 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21121206EF;
        Tue,  1 Sep 2020 13:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598968485;
        bh=fgdQbvNKfrT9RQxxwbrS+G3c51w2CaurFPEVweTkSFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=foEI5kCGhAdHd4Lc751iDhiFVCWbPPfNcIr92QxDyn3UHDswkD+id1vtNBkV1y7Cy
         WfRn3Dz3pzF+lfzQ60RdprxObBsaeOpcqgut597Zbdm26EejvLtQh58icB6LxAWsau
         sUd7M0EMs0QUirzh+WA6y4pe1Yl9VE4Du6yiE8+k=
Date:   Tue, 1 Sep 2020 15:55:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Sasha Levin <sashal@kernel.org>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 1/7] sdhci: tegra: Remove
 SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra210
Message-ID: <20200901135513.GA397411@kroah.com>
References: <1598653517-13658-1-git-send-email-skomatineni@nvidia.com>
 <1598653517-13658-2-git-send-email-skomatineni@nvidia.com>
 <20200828231536.GU8670@sasha-vm>
 <dc6bfd08-baaf-e1ad-6b3f-77ff82d110bb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc6bfd08-baaf-e1ad-6b3f-77ff82d110bb@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Aug 28, 2020 at 04:23:48PM -0700, Sowjanya Komatineni wrote:
> 
> On 8/28/20 4:15 PM, Sasha Levin wrote:
> > On Fri, Aug 28, 2020 at 03:25:11PM -0700, Sowjanya Komatineni wrote:
> > > commit b5a84ecf025a ("mmc: tegra: Add Tegra210 support")
> > 
> > What does this line above represent?
> > 
> SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK is set incorrectly in above commit
> 
> when Tegra210 support was added.

Odd, that's a new format to send to us to apply :)

Can you please provide the git commit id of the original commit in
Linus's tree, as per the documentation, so we know what this is, and can
document that?

Look at all of the commits in the stable trees for examples of how to do
this.

Can y ou fix that up and resend this whole series?

thanks,

greg k-h
