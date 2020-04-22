Return-Path: <SRS0=HGUj=6G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B2CC55186
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 08:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805B22074F
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 08:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bv6Qu4/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgDVI3I (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725899AbgDVI3H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Apr 2020 04:29:07 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E336C03C1A6
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2020 01:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+ivArRasmeQ/1D4gO3xUY41NoR2M7AcukNVOVwoI4Uw=; b=bv6Qu4/uYlTVGkj2KsQVP5HbU
        K8Upgd2VaDcuo7DbL259K5XX584gebayiLkvzJWP6ZYkkuka9spothAkXHZqUSfvJpHIrxfxVlszH
        SiHdTIlKWprPE8glfaO3PICJza+Zx5HmMysY+NgdzN1jwMGax7VD8myQsG15yGbcG6oHts7jK+rQS
        PcOYoqVbh+KPCs69mH+Y3wF6NkT0SDs5aU24HR5ejP2Z69ku7Ff4c2vLrr77X2h82JQfhyfeA3yNq
        +U6OBu7IMtr/xBzhrk4Hgkx6k0uecGfUi3M72tYvtrzC4JhHx11T+hAdYbSDBOfdb6YRAyUpY+otE
        HxpFeIl+g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53664)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jRAkX-0006v6-3L; Wed, 22 Apr 2020 09:28:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jRAkG-0007zo-QQ; Wed, 22 Apr 2020 09:28:36 +0100
Date:   Wed, 22 Apr 2020 09:28:36 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     alpha_one_x86 <alpha_one_x86@first-world.info>,
        Hu Ziji <huziji@marvell.com>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-arm-kernel@lists.infradead.org
Subject: Re: 2 bug repport
Message-ID: <20200422082836.GL25745@shell.armlinux.org.uk>
References: <408ebea1-725d-2f8e-7d26-a2cb4d7754d3@first-world.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408ebea1-725d-2f8e-7d26-a2cb4d7754d3@first-world.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Apr 22, 2020 at 03:03:57AM -0400, alpha_one_x86 wrote:
> Hi,
> 
> On mcbin platform I have uSD problem, repported but no reply on linux kernel
> bugzilla, https://bugzilla.kernel.org/show_bug.cgi?id=207083
> 
> Any idea what patch try?

I think that's a question for the MMC people.

If you go back to your working 4.20 kernel, does the problem go away?
If so, it sounds like a regression in the MMC subsystem.  If not, I
wonder if it could be the uSD card going bad.

However, I suspect the former.  I've seen one instance here where a
Clearfog GT8k (Armada 8040 based just like the mcbin) running 5.6 with
the rootfs on eMMC completely lost the ability to talk to the eMMC to
the point that the machine had to be power cycled to recover it -
merely rebooting did not.  I don't know the cause - the initial failure
had vanished from the kernel logs, and because the eMMC was no longer
accessible, the rsyslog files did not contain the details either.
I've since setup remote logging, and I'm currently waiting for it to
happen again.  I couldn't say if _that_ is a regression because I
haven't been using the GT8k until very recently, and I tend not to use
eMMC/uSD on the Macchiatobin that runs 24x7.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
