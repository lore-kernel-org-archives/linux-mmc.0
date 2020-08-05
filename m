Return-Path: <SRS0=eJC8=BP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4F1C433E0
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 07:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CCE621744
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 07:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v+JgvnM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgHEHuq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgHEHuo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2020 03:50:44 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85A3C06179E
        for <linux-mmc@vger.kernel.org>; Wed,  5 Aug 2020 00:50:43 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id g11so1105947ual.2
        for <linux-mmc@vger.kernel.org>; Wed, 05 Aug 2020 00:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gj5SkepGEW+lETvyOPuyK01bP55UQABNwY/RW5WoiJM=;
        b=v+JgvnM94+n4xy56dO+7zH4S6cRMiq122hMjDr16960VGLHmZ9x7hZt+xMACqjtMBw
         4YWQB/add8XR6DKbGkgxwf4IeWSfvDG97fXYpjsv6s8kkrCBjyk36UeyreoVlzByW5xo
         iuZgIy2LwS1heLM36TwLZzcz/31dH6/hWP9MEi+k1Ls/0EqN5O34n3CRJX8Ocvy/lFRs
         HXTyHJf8W2/InzSr1U/KB2k4Nlf6OkK27DZms+wt7Y/T20lVJycCuoHncYEVJkzfUzU0
         KI1sxOOGmXICSsOF/eSse9NpXubA5u2xbfFPxElvM0HLwNwQySZOx2YM3JofFvAq//wo
         qb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gj5SkepGEW+lETvyOPuyK01bP55UQABNwY/RW5WoiJM=;
        b=uaUxMQiwp2M+OkASzpsYFuDZxOPgzB4IQbljO3N64kJPyuawzqaI60UV6T7jpiaHjP
         Kfx1Nv6VhjM2QPFQfRs7CLKnMVzOTkDhLA1+KObZrUtUmRsqt168d41uUx4roiyQQCug
         915Ac8b25H+a+ANfue+hUsBYphmv9cR7KNqy8BUrL6GZVpO+iOll62zE/ygCUtn1QgBg
         W0OOdcDKSoD3dp8DSbIhRRHuSePdtaYXjOz8CKJLvrAWp3L1EJTBk30s8NfUnsTVxN6p
         ay0RWA/tATI9E2nLzJwfLcOm+GrqaK+H+8/zLxb1UC6mWpBX7ZlNc2g6Bvy2m8EMrTYI
         yOLA==
X-Gm-Message-State: AOAM533o0n34Px+u6/KOufSHh3ZrJchkvqJcqQZ+jpL3fApCtnX+KFJN
        s9bs0zXJVzo+v+f8sNLeH/k+1bVdNZ/hRPDA0Lmqjg==
X-Google-Smtp-Source: ABdhPJxm66X3L3voqWv9Ix6YPW9OpTesj8g5n5syrl9ILyTi/zoy67G4hOSghhH2CNbeyn7o+bmQAWuLETdubR/svf8=
X-Received: by 2002:ab0:1c14:: with SMTP id a20mr1150946uaj.129.1596613842255;
 Wed, 05 Aug 2020 00:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <fb0340aaf273be84e915214a3d8bae4ac85d7c0b.camel@ew.tq-group.com>
 <CAPDyKFq+RiwbDj+58+W5GTcT7=ZOpZFmc02+FxjRGYwbBgA8oQ@mail.gmail.com>
 <cfcec3df57e6dd5ef353ef3a5b4b9793c28eb401.camel@ew.tq-group.com>
 <CAPDyKFptySRTbWto9QYWZ-feL51JvPkZDGsETJ4svz0VbV31Bw@mail.gmail.com> <4ecc41303f9232319cedf414fc466a8c4c0c6dc6.camel@ew.tq-group.com>
In-Reply-To: <4ecc41303f9232319cedf414fc466a8c4c0c6dc6.camel@ew.tq-group.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Aug 2020 09:50:06 +0200
Message-ID: <CAPDyKFrA+P=G+LQLSJXZhPyAn_jUzv7tSfaphiKVMuenmKEs+w@mail.gmail.com>
Subject: Re: (EXT) Re: (EXT) Re: Consistent block device references for root= cmdline
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 29 Jul 2020 at 10:43, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> On Tue, 2020-07-07 at 16:14 +0200, Ulf Hansson wrote:
> > On Thu, 11 Jun 2020 at 13:20, Matthias Schiffer
> > <matthias.schiffer@ew.tq-group.com> wrote:
> > >
> > > On Wed, 2020-06-10 at 16:52 +0200, Ulf Hansson wrote:
> > > > On Wed, 10 Jun 2020 at 15:15, Matthias Schiffer
> > > > <matthias.schiffer@ew.tq-group.com> wrote:
> > > > >
> > > > > Hello all,
> > > > >
> > > > > there have been numerous attempts to make the numbering of
> > > > > mmcblk
> > > > > devices consistent, mostly by using aliases from the DTS ([1],
> > > > > [2],
> > > > > [3]), but all have been (rightfully) rejected. Unless I have
> > > > > overlooked
> > > > > a more recent development, no attempts for a different solution
> > > > > were
> > > > > made.
> > > >
> > > > According to aliases attempts, I think those have failed, mainly
> > > > because of two reasons.
> > > >
> > > > 1. Arguments stating that LABELs/UUIDs are variable alternatives.
> > > > This
> > > > isn't the case, which I think was also concluded from the several
> > > > earlier discussions.
> > > > 2. Patches that tried adding support for mmc aliases, were not
> > > > correctly coded. More precisely, what needs to be addressed is
> > > > that
> > > > the mmc core also preserves the same ids to be set for the host
> > > > class
> > > > as the block device, mmc[n] must correspond to mmcblk[n].
> > > >
> > > > >
> > > > > As far as I can tell, the core of the issue seems to be the
> > > > > following:
> > > > >
> > > > > The existing solutions like LABELs and UUIDs are viable
> > > > > alternatives in
> > > > > many cases, but in particular on embedded systems, this is not
> > > > > quite
> > > > > sufficient: In addition to the problem that more knowledge
> > > > > about
> > > > > the
> > > > > system to boot is required in the bootloader, this approach
> > > > > fails
> > > > > completely when the same firmware image exists on multiple
> > > > > devices,
> > > > > for
> > > > > example on an eMMC and an SD card - not an entirely uncommon
> > > > > situation
> > > > > during the development of embedded systems.
> > > > >
> > > > > With udev, I can refer to a specific partition using a path
> > > > > like
> > > > > /dev/disk/by-path/platform-2194000.usdhc-part2. In [4] it was
> > > > > proposed
> > > > > to add a way to refer to a device path/phandle from the kernel
> > > > > command
> > > > > line. Has there been any progress on this proposal?
> > > >
> > > > Lots of time during the years I have been approached, both
> > > > publicly
> > > > and offlist, about whether it would be possible to add support
> > > > for
> > > > "consistent" mmcblk devices. To me, I am fine with the aliases
> > > > approach, as long as it gets implemented correctly.
> > >
> > >
> > > It seems the principal technical problem is the one described here:
> > >
> > > https://www.spinics.net/lists/linux-mmc/msg26602.html
> > >
> > > I don't see any way to solve this completely, as there seem to be
> > > two
> > > fundamentally conflicting requirements:
> > >
> > > 1) If a mounted SD card is replaced, it must be assigned a new
> > > /dev/mmcblkN
> > > 2) /dev/mmcblkN should always match the configured alias IDs
> > >
> > > What is the reason we need 1) - is it possible to have multiple
> > > eMMCs
> > > or SD cards on a single bus, with detection at runtime?
> >
> > Yes. The mmc_bus_type holds all cards - all discovered at runtime.
> >
> > > Otherwise I'd
> > > expect this to be handled like other drives with removable media
> > > (CD,
> > > floppy), with static device assignment.
> > >
> > > If we can't give up on 1) for some reason, we'll have to accept
> > > that we
> > > can't guarantee 2) unconditionally. As far as I can tell, the
> > > patches
> > > provided by Sascha and others did that in a reasonable way: The
> > > aliases
> > > would work in most cases - in particular for the first assignment
> > > on
> > > boot, which is required to find the correct rootfs.
> >
> > Well, if we would pre-parse the DTB to look for all "mmc block
> > aliases" and keep a mark of those ids as being reserved, then we
> > should be able to cope with both 1) and 2).
>
> Hello Ulf,
>
> it seems to me like Sascha's patches from 2014 do precisely that:
>
> https://www.spinics.net/lists/linux-mmc/msg26587.html
> https://www.spinics.net/lists/linux-mmc/msg26588.html
>
> I haven't looked into porting this to a modern kernel yet, but do you
> think that the approach is sound?

Yes, something along those lines.

Kind regards
Uffe
