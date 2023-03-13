Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBEDC6FD19
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Mar 2023 20:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjCMUDp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Mar 2023 16:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjCMUDe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Mar 2023 16:03:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25B386151
        for <linux-mmc@vger.kernel.org>; Mon, 13 Mar 2023 13:03:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94D22B8110A
        for <linux-mmc@vger.kernel.org>; Mon, 13 Mar 2023 20:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3AFC433D2;
        Mon, 13 Mar 2023 20:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678737783;
        bh=PgSjK0CmEVbalBsBkX+I2OvY/W8g5uDi4H0o1SnczxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f9TLYa96f09SsT2FkKxURMZhkgUpJQMJdBy+x1oPLgcqxVhGpW/OhSL/mW7NZP6bQ
         ZKWsNqxsWLEDOLJYCzjga+LvYeozfJdzTaXwCgzgUiNyRj/g9rmkwDgYFBOy54n2wf
         RvZmqFU0D1E1TBbzakKVXUslTjuqOfpkDt2JY/6cZLRFUfCdB++B9kB18ojvrKq8Ba
         W2vKIgc1M50jvVQPRLZjnZGBtj1Xzhj6dke8gtSACts13b1RnA/yqNNsGTWTt6xxiX
         TWc9+AWE2H6yMyZl1Ov1miq899HLj6RTOkdDLQ62iWHpzITWQy5QE1qsHEND6uIgI2
         H0yaojHhXVzzw==
Received: by pali.im (Postfix)
        id 37CFC777; Mon, 13 Mar 2023 21:03:00 +0100 (CET)
Date:   Mon, 13 Mar 2023 21:03:00 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org
Subject: Re: Announce: sdioutils (lssdio & sdioids)
Message-ID: <20230313200300.erl3trnwtnsmhhn5@pali>
References: <20230214195702.ungo5roxliq7pjas@pali>
 <CAPDyKFptvcm=Co1JVKAtB6dqzbxvoRzAbn=b76iwgZxgdMSjmg@mail.gmail.com>
 <20230215190551.g7oeohrjm3nmz3h7@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230215190551.g7oeohrjm3nmz3h7@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wednesday 15 February 2023 20:05:51 Pali Rohár wrote:
> On Wednesday 15 February 2023 14:15:21 Ulf Hansson wrote:
> > On Tue, 14 Feb 2023 at 20:57, Pali Rohár <pali@kernel.org> wrote:
> > >
> > > Hello! I would like to inform about new (or rather old) sdioutils
> > > project, which is on github: https://github.com/sdioutils/
> > >
> > > It aimed to be collection of SDIO programs for Linux systems.
> > >
> > > Currently it contains two things which can be useful for both users and
> > > developers:
> > >
> > > * lssdio - https://github.com/sdioutils/lssdio - tool which prints all
> > >   connected and registered SDIO devices in similar format than lspci or
> > >   lsusb, including tree and verbose formats (Linux v5.10+ required for
> > >   printing all information)
> > >
> > > * sdioids - https://github.com/sdioutils/sdioids - database file
> > >   sdio.ids of known SDIO devices, in format inspired by pci.ids and
> > >   which is already used by lssdio
> > >
> > > This new sdioids contains updated and imported database file from the
> > > old udev project (which seems to not be updated anymore).
> > >
> > > If you look into the repository, both parts are more than year old and
> > > I did not announced it before because more people promised to test or
> > > improve database... but nothing happened, only promises. So I decided to
> > > announce it now at least in this state. I think that it can be useful
> > > even in the current state.
> > >
> > > So if you want to improve it or add new SDIO cards into database, feel
> > > free to open a pull request on project page. I think that having some
> > > central point of sdio.ids database can be useful also for other
> > > projects.
> > 
> > Thanks for sharing the news, it looks like a useful tool to me!
> 
> I'm happy if it is useful for somebody :-)

Anyway, if you or anybody else on the list has some other SDIO card
which is not in sdio.ids database then fill free to send a pull request
to project page with adding it.

> > One thing I wonder though, is why you didn't consider extending
> > "mmc-utils" with these new cool things instead? In particular, we have
> > "lsmmc" in there for MMC and SD cards - and since these have a lot in
> > common with the SDIO cards, I believe it would make sense to extend it
> > (in some way or the other).
> 
> It is more than year old... but what I remember is that I was thinking
> about it but I realized that SDIO devices and SD/MMC cards are too
> different. Also linux kernel provides for them different sysfs nodes
> (which mimics what these type of devices provides). So SDIO (for
> userspace) does not share too much code with SD/MMC.
> 
> > Note that, if you are willing to help with maintenance of mmc-utils
> > around this, what would certainly be appreciated too. :-)
> > 
> > Kind regards
> > Uffe
> 
> I do not have time for this project. This is also why I was waiting more
> than year with sdioutils for testing/improving...
