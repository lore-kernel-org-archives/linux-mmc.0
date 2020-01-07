Return-Path: <SRS0=8m0a=24=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D21AC33C8C
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jan 2020 12:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4AE2081E
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jan 2020 12:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578401826;
	bh=S6eYAHEAnh56A6/rf0Ao/cnAVOv+g+TUtiatVw4xlbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=odYMrsFtsaQKRpHIKZLmb4MVMBC6PWqLGqEPwfLDGq/AHsoBuQ4z/YXMrw/OTcCkC
	 U8CHBcJkGjJwYrahy1ntvhDyURrfRkiB+MbZZZUjjrDcCMMjDt7ldax72h9otQhBAI
	 0+hRhaA8td6mQ3Xgg0VDnQJrtYLt8yWPdJGjZODs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgAGM5F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:57:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbgAGM5F (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 7 Jan 2020 07:57:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ECAC2080A;
        Tue,  7 Jan 2020 12:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578401823;
        bh=S6eYAHEAnh56A6/rf0Ao/cnAVOv+g+TUtiatVw4xlbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aklwGojMnsmTZt+FSLulrblSYJnFXVxmqgP1t00LJFC5aUw+SVWMxEDZaB7lA7lum
         LR7UiAfwS9IBMk7zcndin8jpfFFeFAa9cyRsjpt4+Chlh/OGDMpXrQLXbCHTjL8aa9
         4LMWu8z31+jZY35hEqtPIWxqU1smPMsgi5oLkZBs=
Date:   Tue, 7 Jan 2020 13:57:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lucas Stach <dev@lynxeye.de>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: tegra: fix SDR50 tuning override
Message-ID: <20200107125700.GA1035344@kroah.com>
References: <245d569e4c258063dbd78bd30c7027638b30f059.1577960737.git.mirq-linux@rere.qmqm.pl>
 <20200106120718.GA1955714@ulmo>
 <20200106122745.GA3414443@kroah.com>
 <20200106133703.GE1955714@ulmo>
 <20200107093715.GB1028311@kroah.com>
 <20200107095359.GA3515@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107095359.GA3515@qmqm.qmqm.pl>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 07, 2020 at 10:53:59AM +0100, Michał Mirosław wrote:
> On Tue, Jan 07, 2020 at 10:37:15AM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Jan 06, 2020 at 02:37:03PM +0100, Thierry Reding wrote:
> > > On Mon, Jan 06, 2020 at 01:27:45PM +0100, Greg Kroah-Hartman wrote:
> > > > On Mon, Jan 06, 2020 at 01:07:18PM +0100, Thierry Reding wrote:
> > > > > On Thu, Jan 02, 2020 at 11:30:50AM +0100, Michał Mirosław wrote:
> > > > > > Commit 7ad2ed1dfcbe inadvertently mixed up a quirk flag's name and
> > > > > > broke SDR50 tuning override. Use correct NVQUIRK_ name.
> > > > > > 
> > > > > > Fixes: 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes")
> > > > > > Depends-on: 4f6aa3264af4 ("mmc: tegra: Only advertise UHS modes if IO regulator is present")
> > > > > > Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > > > > > ---
> > > > > >  drivers/mmc/host/sdhci-tegra.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > Oh my... good catch!
> > > > > 
> > > > > Reviewed-by: Thierry Reding <treding@nvidia.com>
> > > > > 
> > > > > I also ran this through our internal test system and all tests pass, so
> > > > > also:
> > > > > 
> > > > > Tested-by: Thierry Reding <treding@nvidia.com>
> > > > > 
> > > > > I'm not sure if that "Depends-on:" tag is anything that's recognized
> > > > > anywhere. It might be better to turn that into an additional "Fixes:"
> > > > > line. Adding Greg to see if he has a standard way of dealing with this
> > > > > kind of dependency.
> > > > > 
> > > > > Greg, what's your preferred way to handle these situations? I think the
> > > > > intention here was to describe that the original error was introduced by
> > > > > commit 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes"), but then commit
> > > > > 4f6aa3264af4 ("mmc: tegra: Only advertise UHS modes if IO regulator is
> > > > > present") moved that code around, so this patch here will only be back-
> > > > > portable until the latter commit, but should be backported until the
> > > > > former.
> > > > 
> > > > The stable kernel rules document says how to handle this, but the
> > > > "depends on" commit id in the comment to the right of the stable@k.o cc:
> > > > line in the changelog area.
> > > 
> > > That only mentions "static" prerequisites needed by the patch, but what
> > > if the prerequisites change depending on version?
> > > 
> > > Could I do something like this:
> > > 
> > > 	Cc: <stable@vger.kernel.org> # 4.4.x: abcdef: ...
> > > 	Cc: <stable@vger.kernel.org> # 4.9.x: bcdefa: ...
> > > 	Cc: <stable@vger.kernel.org>
> > 
> > Yes.
> > 
> > > Would that mean that the patch is selected for all stable releases
> > > (because of the last line with no version prerequisite) but when applied
> > > for stable-4.4 the abcdef patch gets pulled in and for stable-4.9 the
> > > bcdefa dependency is applied before the patch?
> > 
> > Yes.
> > 
> > > I suppose this is perhaps a bit of an exotic case, but it might be good
> > > to document it specifically because it might be fairly rare. I can draft
> > > a change if you think this is useful to add.
> > 
> > I thought this was already in there, as others have done it in the past.
> > 
> > It's a _very_ exotic case, I wouldn't worry about it, just document it
> > like this, and if I have problems applying the patches to stable I'll be
> > sure to let you know and you can always tell me then.  That's usually
> > the easiest thing to do anyway :)
> 
> I understood the wording in stable-kernel-rules.rst as meaning that
> comments on Cc: lines make mentioned commit pulled in (cherry-picked).
> In this case I think this is ok, but in case the pulled-in patch changes
> something else (the dependency is only because of touching nearby code),
> how would I specify this and avoid the hint to include the other patch?

I really do not understand what you are asking for here.

Worst case, just say:
	cc: stable... # 4.4.x

and if you know that fails to apply or build, then just wait for my
email saying something failed and then respond with the needed commit
ids or backported patches.

It's not rocket science, and this isn't all that automated, I _can_
handle free-form text :)

thanks,

greg k-h
