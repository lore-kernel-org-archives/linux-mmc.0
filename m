Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61773A5428;
	Tue, 31 Mar 2026 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953170; cv=none; b=ZhVurJHIkBE8hB4pR/5L02UVNj9ZzgscqjU3fYc1Ah0qjDMOD+QWBNEdL+i1OVYgWzG4TxA4KyLe2oX2HbLuIZTsUgR8X3828/Re/9R5tSzVbDycRHb2JbpfBKMoFABq4IBnfh1g7d1qVFn/GZEcvbVCloPBThmwryCHZh02IaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953170; c=relaxed/simple;
	bh=qJc5PuREPBTu4Wdi5PAFDNcZUwIIeo6M8iuzTeH9Unc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyZQd9hlXbTpg8J18M/tN6maPuorGHN0Ie9oRiv8mUPxB3Ei2L6Rhi7s7ekLdCxW3gZ6FmTFAsz5Z7/+G+6+gZcZIullQhg8rKoAcxu2og+iFnooYZMKMTfPpOL2DW4FEa5eER8NBUVnslEzUr7IMbnA5tY0SyzoMI+1ao7oDoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAOaD+IJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAOaD+IJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B55C19423;
	Tue, 31 Mar 2026 10:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774953169;
	bh=qJc5PuREPBTu4Wdi5PAFDNcZUwIIeo6M8iuzTeH9Unc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cAOaD+IJqoq4BGsUkB0c45E2kZ6ukn47bHwnIsC2zGFNmNm4EyghMwJypPAn8wQ7D
	 df7D/hoPAkG+Cy+M8SCxIJpAcYtpldx9s0+VSBhrQdB6C8XOT1+kGR1QxAvdH6mWuA
	 /YsY340SvgJjD9SYU0FiGCk1lTU/8H2QcS/44MtWWnFLu8YXAL8tCYxGgMOPsMGzSP
	 E2uY0gocEGBFGDVchfB1npYVuNHFOsZ0Ehw7txNLsvE4yargBoi8qd0nbE6+vovYPe
	 tOEGrOZq6AkxwpKBhmwL3JKGe+9Ub6qUoAAACpZ/geQJ1vGjAjQtUeHGI83anhhPx0
	 MCM1Qxl/CJpxw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w7WOt-00000007vm3-1kyA;
	Tue, 31 Mar 2026 12:32:47 +0200
Date: Tue, 31 Mar 2026 12:32:47 +0200
From: Johan Hovold <johan@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tony Olech <tony.olech@elandigitalsystems.com>
Subject: Re: [PATCH 1/4] mmc: vub300: fix NULL-deref on disconnect
Message-ID: <acuiz2y0pIdEwlB4@hovoldconsulting.com>
References: <20260327105208.1310739-1-johan@kernel.org>
 <20260327105208.1310739-2-johan@kernel.org>
 <CAPDyKFp1DbRufpro86fXi9xXnJGbWW=NrD3Q0NFQ+aHxhxogLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFp1DbRufpro86fXi9xXnJGbWW=NrD3Q0NFQ+aHxhxogLg@mail.gmail.com>

On Tue, Mar 31, 2026 at 12:13:41PM +0200, Ulf Hansson wrote:
> On Fri, 27 Mar 2026 at 11:52, Johan Hovold <johan@kernel.org> wrote:
> >
> > Make sure to deregister the controller before dropping the reference to
> > the driver data on disconnect to avoid NULL-pointer dereferences or
> > use-after-free.
> >
> > Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
> > Cc: stable@vger.kernel.org      # 3.0
> > Cc: Tony Olech <tony.olech@elandigitalsystems.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/mmc/host/vub300.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> > index ff49d0770506..f173c7cf4e1a 100644
> > --- a/drivers/mmc/host/vub300.c
> > +++ b/drivers/mmc/host/vub300.c
> > @@ -2365,8 +2365,8 @@ static void vub300_disconnect(struct usb_interface *interface)
> >                         usb_set_intfdata(interface, NULL);
> >                         /* prevent more I/O from starting */
> >                         vub300->interface = NULL;
> > -                       kref_put(&vub300->kref, vub300_delete);
> >                         mmc_remove_host(mmc);
> > +                       kref_put(&vub300->kref, vub300_delete);
> 
> While this seems like a step in the right direction, I don't see why
> calling usb_set_intfdata(interface, NULL)

The interface data is only used in the USB bus callbacks and is not
needed after disconnect().

> and assigning
> vub300->interface = NULL is safe.
>
> For example, some of the workqueues might be running a work that uses
> the vub300->interface, isn't that a problem too?

The driver uses this pointer to indicate that the device has been
disconnected. That doesn't mean that the implementation is correct (e.g.
the check in vub300_pollwork_thread() should use some locking) but that
would be pre-existing issues.

Johan
