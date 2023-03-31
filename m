Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25E0C76196
	for <linux-mmc@archiver.kernel.org>; Fri, 31 Mar 2023 07:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCaHaR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 31 Mar 2023 03:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaHaR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Mar 2023 03:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D100768B;
        Fri, 31 Mar 2023 00:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 026AF623EB;
        Fri, 31 Mar 2023 07:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B6FC433EF;
        Fri, 31 Mar 2023 07:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680247815;
        bh=zXw6u1EURy0w/G8+aTN3bFZY3VPBIAO84MiEoOwOeoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0eDMujfzGZl/a/qQcu/oXOkm8+AdridpQm92a6IcGD0dvb3iwN5DeyVgwzFMflbd
         hdM5mIitXezpKMM70JE2iP+StMHwP8+u5A/eRVNN/QQTlff4Yl4gQ311AzN3Y83/o4
         bT2MMtIoLIl0N4dudexssqUrnlNmSWEB4q2zO5Fs=
Date:   Fri, 31 Mar 2023 09:30:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: allow mmc to block wait_for_device_probe()
Message-ID: <ZCaMBEDaISmajPRj@kroah.com>
References: <20230328223740.69446-1-dennis@kernel.org>
 <ZCPEcxueuGUaRNOP@kroah.com>
 <ZCSfwBiponFGFXlN@snowbird>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCSfwBiponFGFXlN@snowbird>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Mar 29, 2023 at 01:29:52PM -0700, Dennis Zhou wrote:
> On Wed, Mar 29, 2023 at 06:54:11AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Mar 28, 2023 at 03:37:40PM -0700, Dennis Zhou wrote:
> > > I've been hitting a failed data device lookup when using dm-verity and a
> > > root device on an emmc partition. This is because there is a race where
> > > dm-verity is looking for a data device, but the partitions on the emmc
> > > device haven't been probed yet.
> > > 
> > > Initially I looked at solving this by changing devt_from_devname() to
> > > look for partitions, but it seems there is legacy reasons and issues due
> > > to dm.
> > > 
> > > MMC uses 2 levels of probing. The first to handle initializing the
> > > host and the second to iterate attached devices. The second is done by
> > > a workqueue item. However, this paradigm makes wait_for_device_probe()
> > > useless as a barrier for when we can assume attached devices have been
> > > probed.
> > > 
> > > This patch fixes this by exposing 2 methods inc/dec_probe_count() to
> > > allow device drivers that do asynchronous probing to delay waiters on
> > > wait_for_device_probe() so that when they are released, they can assume
> > > attached devices have been probed.
> > 
> 
> Thanks for the quick reply.
> 
> > Please no.  For 2 reasons:
> >   - the api names you picked here do not make much sense from a global
> >     namespace standpoint.  Always try to do "noun/verb" as well, so if
> >     we really wanted to do this it would be "driver_probe_incrememt()"
> >     or something like that.
> 
> Yeah that is a bit of a blunder on my part...
> 
> >  - drivers and subsystems should not be messing around with the probe
> >    count as it's a hack in the first place to get around other issues.
> >    Please let's not make it worse and make a formal api for it and allow
> >    anyone to mess with it.
> > 
> 
> That's fair.
> 
> > Why can't you just use normal deferred probing for this?
> > 
> 
> I'm not familiar with why mmc is written the way it is, but probing
> creates a notion of the host whereas the devices attached are probed
> later via a work item.
> 
> Examining it a bit closer, inlining the first discovery call
> avoids all of this mess. I sent that out just now in [1]. Hopefully
> that'll be fine.
> 
> [1] https://lore.kernel.org/lkml/20230329202148.71107-1-dennis@kernel.org/T/#u

Looks much better, except for the kernel test bot issues...

thanks,

greg k-h
