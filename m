Return-Path: <SRS0=HGUj=6G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27327C55189
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 11:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D53E320784
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 11:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="r3V2XHXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgDVLgv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726517AbgDVLgv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Apr 2020 07:36:51 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B5FC03C1A8
        for <linux-mmc@vger.kernel.org>; Wed, 22 Apr 2020 04:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DChLa/dPBSszzKMIV61f+9s61HKeSO67ObxSI6JlPU8=; b=r3V2XHXqI6RG5O+1BgLr3gSap
        hyx2fsVOKps1Kn2fQjSbmo468UxGjQJ4dawkeVHzd7n7L/8nzG+iCSYFPjFKoV0f63v29Us0zsCjb
        u+BJN0M6ZyRmCMRNyUpvgb/i/xsDx43MWMIhkYljBf+qp2z/QMZsMluPIU3ad/8r5280VCDNCrKTi
        XVLGe7JZ9g7ZsXOqPDdHX+QSahrkWfr2UkXNloROBhvzFgRc4JX5o5WzteVpFqY/atfW/pRhW0JWV
        VILml7ApKHZqKf/Rf6YIthDZRJ+OiBPw6cMzPfDlORcL4HunRPnJF/GdJponAnKmADiJQvTG0nZVK
        vU3uTfqAQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:49576)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jRDgF-0007qA-Ao; Wed, 22 Apr 2020 12:36:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jRDg7-00087J-L4; Wed, 22 Apr 2020 12:36:31 +0100
Date:   Wed, 22 Apr 2020 12:36:31 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     alpha_one_x86 <alpha_one_x86@first-world.info>, huziji@marvell.com,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-arm-kernel@lists.infradead.org
Subject: Re: 2 bug repport
Message-ID: <20200422113631.GN25745@shell.armlinux.org.uk>
References: <408ebea1-725d-2f8e-7d26-a2cb4d7754d3@first-world.info>
 <20200422082836.GL25745@shell.armlinux.org.uk>
 <5a67104f-1286-2cb0-d01e-8aa61c9f7e48@first-world.info>
 <20200422111025.GM25745@shell.armlinux.org.uk>
 <50004568-09e5-719b-ec4a-c09882767a6a@first-world.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50004568-09e5-719b-ec4a-c09882767a6a@first-world.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Adding back those who *need* to be copied.  Please be more careful
with your replies.  As I said, those others are for your benefit,
not for mine, as they are more likely going to be able to help you.

Thanks for confirming that it is indeed a regression with 5.6
kernels.

Over to the Adrian/Ulf/others now...

On Wed, Apr 22, 2020 at 07:15:18AM -0400, alpha_one_x86 wrote:
> Hi,
> 
> On multiple hardware I had tested 4.20, 5.6.6, again 4.20, 5.6.6, again
> 4.20.
> 
> The problem is only with 5.6.6, never with 4.20
> 
> On 2020-04-22 07:10, Russell King - ARM Linux admin wrote:
> > On Wed, Apr 22, 2020 at 07:00:11AM -0400, alpha_one_x86 wrote:
> > > Hi,
> > > 
> > > It's regression because on the kernel 4.20 all is working.
> > PLEASE do not drop the Cc list.  The Cc list is for YOUR benefit.
> > 
> > You can't say that without going back and checking.
> > 
> > SD cards are flash media, and they fail in weird and stupid ways.
> > Flash media itself only has a limited number of write cycles before
> > the memory irrevocerably fails.  SD cards have firmware on them to
> > manage the flash media to perform wear leveling.  Firmware can be
> > buggy and cause problems.  I've had SD cards become completely
> > inaccessible because of a firmware failure.
> > 
> > So, after finding a problem on a later kernel with SD cards, you
> > need to confirm the regression by checking whether the previously
> > working kernel continues to behave correctly (indicating a kernel
> > regression) or whether it behaves the same (indicating a failure of
> > the SD card.)
> > 
> > If you're not willing to do that, I'm afraid we will have to discount
> > your bug report since it doesn't contain the information necessary to
> > make a proper evaluation of what may be going on.
> > 
> > > Cheers,
> > > 
> > > On 2020-04-22 04:28, Russell King - ARM Linux admin wrote:
> > > > On Wed, Apr 22, 2020 at 03:03:57AM -0400, alpha_one_x86 wrote:
> > > > > Hi,
> > > > > 
> > > > > On mcbin platform I have uSD problem, repported but no reply on linux kernel
> > > > > bugzilla, https://bugzilla.kernel.org/show_bug.cgi?id=207083
> > > > > 
> > > > > Any idea what patch try?
> > > > I think that's a question for the MMC people.
> > > > 
> > > > If you go back to your working 4.20 kernel, does the problem go away?
> > > > If so, it sounds like a regression in the MMC subsystem.  If not, I
> > > > wonder if it could be the uSD card going bad.
> > > > 
> > > > However, I suspect the former.  I've seen one instance here where a
> > > > Clearfog GT8k (Armada 8040 based just like the mcbin) running 5.6 with
> > > > the rootfs on eMMC completely lost the ability to talk to the eMMC to
> > > > the point that the machine had to be power cycled to recover it -
> > > > merely rebooting did not.  I don't know the cause - the initial failure
> > > > had vanished from the kernel logs, and because the eMMC was no longer
> > > > accessible, the rsyslog files did not contain the details either.
> > > > I've since setup remote logging, and I'm currently waiting for it to
> > > > happen again.  I couldn't say if _that_ is a regression because I
> > > > haven't been using the GT8k until very recently, and I tend not to use
> > > > eMMC/uSD on the Macchiatobin that runs 24x7.
> > > > 
> > > -- 
> > > alpha_one_x86/BRULE Herman <alpha_one_x86@first-world.info>
> > > Main developer of Supercopier/Ultracopier/CatchChallenger, Esourcing and server management
> > > IT, OS, technologies, research & development, security and business department
> > > 
> -- 
> alpha_one_x86/BRULE Herman <alpha_one_x86@first-world.info>
> Main developer of Supercopier/Ultracopier/CatchChallenger, Esourcing and server management
> IT, OS, technologies, research & development, security and business department
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
