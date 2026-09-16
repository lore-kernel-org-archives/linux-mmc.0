Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736194BA1CB;
	Wed, 16 Sep 2026 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552841; cv=none; b=umwdq07mbCcsfaJ8b9XtHlrVRo2sMfvflp+nf2bTJlwySVNgjhCm8qLfVFiNbfCPv0L+JPPnUX0ZPzSXZVBQDNKpZ4ujLZTIWq+hv/JGimCBJhuR16mn9nQo64/mYFs9tqcvrSm+Sex00A7Md1yV4v4MHCAlXONOeJQ+QKzvxoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552841; c=relaxed/simple;
	bh=+nK4k+1goCBNjpzTIg7o/ztLdauBhMZrhU2wAOgEQgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXPkZxmdxU/x357sjh2m+52jRmJF33vqs8dt0xjHQwezQIx+LRzoDxuN8PxWfVkP4kaejWAxYC0i8/GodY/afng+9MZgMgS4nQT2FFUagYceDXNhTArYbGPTa1f17Dpi+0Gq9MqKnNV7nXF1NRGfnGtyI/MnEoxngSzFiWmB+RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRot0Cv2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRot0Cv2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBF11F000FF;
	Wed, 16 Sep 2026 10:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789552832;
	bh=XpZeO+osP/whGnfGamFG3+0s00oTS61O1oLg2UFOI1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aRot0Cv23tFEIWyS81ZU1wq0DVWBgUQzl5zSU0RpNdAGfRV3ZSX/hM59incusCxaI
	 0v7slX5dJsLGdW+DeQjTaahNoUUBKW/NBIZgMdQv1+rH9f68v07oSpt38pIEqURQD4
	 aOV7/PCeufbdqkkGeqAWmIymrMauOxtkQXUgqzKz6B+fyeK5adx80OzNq273WAYFAx
	 OEJu5GcbXTXKqHet8n71WViRsNfEJxldKRHLwtvIlKbdg0WPOABmGdN6FqiVBMhm1w
	 kq6l4ZAOFmbRSgj0PHgWeeVQ2kc04z1wRGMI9bpVCG3PQ5crNujfrSBa4GXnP3ieYF
	 9fCuvJykuTODw==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1x6mRK-00000005yOD-1h4Q;
	Wed, 16 Sep 2026 12:00:30 +0200
Date: Wed, 16 Sep 2026 12:00:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: core: Turn mmc_alloc|free_host() into static
 functions
Message-ID: <aqpovla0rTDnmwRh@hovoldconsulting.com>
References: <20260915132052.273212-1-ulf.hansson@oss.qualcomm.com>
 <20260915132052.273212-3-ulf.hansson@oss.qualcomm.com>
 <aqpIl5NWCFiuKy9b@hovoldconsulting.com>
 <CAPx+jO86Sy+of41dw3Gi5CNfyc5+iOyDU4CZypz4YGzG27QW0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx+jO86Sy+of41dw3Gi5CNfyc5+iOyDU4CZypz4YGzG27QW0A@mail.gmail.com>

On Wed, Sep 16, 2026 at 11:36:25AM +0200, Ulf Hansson wrote:
> On Wed, Sep 16, 2026 at 9:43 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Tue, Sep 15, 2026 at 03:20:46PM +0200, Ulf Hansson wrote:
> > > From: Ulf Hansson <ulfh@kernel.org>
> > >
> > > As there are no longer any users of these functions, let's make them
> > > internal to the mmc core.
> >
> > Why would you want to do that? The devres helpers should just be simple
> > wrappers around these and sometimes devres just isn't a good fit.
> 
> At the moment there seems to be no need for them. I would rather keep
> API/interfaces as simple as possible, so I prefer to remove them at
> this point.
> 
> If we see a need for them, we can always add them back.

Devres generally only works when all resources are device managed.
Therefore you should always provide the underlying non-devres manages
interface as well so that you don't force devres on drivers where it
could cause trouble.
 
> > Especially with the work cancellations present in mmc_free_host() (which
> > I have pointed out elsewhere should not be there), a driver may need to
> > free the host before tearing down other non-devres managed resources
> > during unbind.
> 
> Can you please point me to such an example so I can try to understand better?

We just discussed the renesas driver which can schedule rescan work
before registering the host controller. [1]

If such a driver also has non-devres managed resources that are freed
before the work is cancelled you have a use-after-free.

> > This may even be needed for greybus which currently destroys the
> > connection before freeing the host.
> 
> I looked closer at gb_sdio_remove() (the greybus sdio driver's
> ->remove() callback) and I think the problem isn't about freeing the
> host.
> 
> Instead it seems like the call to mmc_remove_host() is done too late.
> To me it looks like when the mmc core tries to power off the card
> gracefully, through mmc_remove_host() the driver has already moved
> into a state where it no longer accepts any requests.

Yes, that looks wrong, but that's a separate issue.

I only pointed at greybus as an example of a driver which has non-devres
managed resources. If there is (rescan) work still scheduled after
probe() or remove() returns, there's a potential use-after-free.

Johan


[1] https://lore.kernel.org/lkml/ap7CaVj82BJZgjf6@hovoldconsulting.com/
