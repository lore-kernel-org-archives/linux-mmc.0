Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95173C276D;
	Tue, 31 Mar 2026 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955793; cv=none; b=mlMeXI1YEsj87P+UXobe+rQucpCeMK7kP3/9cEV8JorhLTj5y/jelUhoJ3O8sxBj8sIZlZnnfmpQGr20p8bOq+uqZnVjKaCIyR3siN4/lbFi9mns6VIfyqFn3rP5apL22KFVlUdPR9mMuzEWvLCls+L71i2N7Qc3+Kg1EP7GHO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955793; c=relaxed/simple;
	bh=g7V653Z3+W27IBQC4uaRsno5n6wKfRS+8Q49+lDclzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwBHcCMKbWwlYh45iDy8FaZEijzyBJNIfCG1g6bF4tu3C7ItI+uaGJFarzRXhOVeWqnXQrssiTr0jcz2o88igvtofJl12cjBNO9Ipqmm2pWuJToqYW4Hpg2vdJ3D7sRzjZVwfSVhASc6nOb2ZBVwVWtNHFtO6mVjh0FTYLuomVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=az6FC5Mg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="az6FC5Mg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BB3C2BCB1;
	Tue, 31 Mar 2026 11:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774955793;
	bh=g7V653Z3+W27IBQC4uaRsno5n6wKfRS+8Q49+lDclzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=az6FC5MgYXEBZIpdZ5TVqDghvpGpR3yToioYKg5i7d/Px334RmHBa0yOTffwQgtgU
	 9ezIYvtQzYbQ8T70oPywpzpqDLsubtRjB68CRNKZu6KnNKaN8P1ZxfA83jku7MfDMj
	 bpfWjBupaZe0+X1KzLKbHOQBOaO58I48pVOteJjC1n3LfmZhXKMGwiNZc2DqnGxEG6
	 dz+Nv9icRV1amKxnxlh+5+l15R5J2rvO8OIdFvUX8vmgyf0/FL20UFH9cf6+DQ+Tlw
	 kYNRuhAE1Dxt+dC8LNo6OLnBCfkFrzAyNusaGHj8oJ0bmA+b695aizTKZRangNmFnk
	 Sw9491Av+BlzQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w7X5D-00000008REw-0L0s;
	Tue, 31 Mar 2026 13:16:31 +0200
Date: Tue, 31 Mar 2026 13:16:31 +0200
From: Johan Hovold <johan@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tony Olech <tony.olech@elandigitalsystems.com>
Subject: Re: [PATCH 1/4] mmc: vub300: fix NULL-deref on disconnect
Message-ID: <acutD9XSXP-vrU2E@hovoldconsulting.com>
References: <20260327105208.1310739-1-johan@kernel.org>
 <20260327105208.1310739-2-johan@kernel.org>
 <CAPDyKFp1DbRufpro86fXi9xXnJGbWW=NrD3Q0NFQ+aHxhxogLg@mail.gmail.com>
 <acuiz2y0pIdEwlB4@hovoldconsulting.com>
 <CAPDyKFpbcn3SJrZP1SE5VPw4nxk7ct=B80=nD9k2gBdEo6EBCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpbcn3SJrZP1SE5VPw4nxk7ct=B80=nD9k2gBdEo6EBCw@mail.gmail.com>

On Tue, Mar 31, 2026 at 01:03:39PM +0200, Ulf Hansson wrote:
> On Tue, 31 Mar 2026 at 12:32, Johan Hovold <johan@kernel.org> wrote:

> > > > @@ -2365,8 +2365,8 @@ static void vub300_disconnect(struct usb_interface *interface)
> > > >                         usb_set_intfdata(interface, NULL);
> > > >                         /* prevent more I/O from starting */
> > > >                         vub300->interface = NULL;
> > > > -                       kref_put(&vub300->kref, vub300_delete);
> > > >                         mmc_remove_host(mmc);
> > > > +                       kref_put(&vub300->kref, vub300_delete);
> > >
> > > While this seems like a step in the right direction, I don't see why
> > > calling usb_set_intfdata(interface, NULL)
> >
> > The interface data is only used in the USB bus callbacks and is not
> > needed after disconnect().
> >
> > > and assigning
> > > vub300->interface = NULL is safe.
> > >
> > > For example, some of the workqueues might be running a work that uses
> > > the vub300->interface, isn't that a problem too?
> >
> > The driver uses this pointer to indicate that the device has been
> > disconnected. That doesn't mean that the implementation is correct (e.g.
> > the check in vub300_pollwork_thread() should use some locking) but that
> > would be pre-existing issues.
> 
> Right, that was my thinking as well.
> 
> Out of curiosity, are you planning on fixing these issues too or is
> that left for later?

No, sorry, this was just something I stumbled over when addressing USB
devres issues tree wide.

Johan
