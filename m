Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C068394475;
	Sun,  8 Mar 2026 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772993035; cv=none; b=pctkQp1MCwjx/lVNqxUVLp3PyjXcvAgzNMj+BeRhHQ7t1RMvdl05btZ9uIJpC0J4j/4Iad2+Pkj/wkexJe8DCGHeI0nxglXmlZ7+wxH4i3L0dhNvTiHbD6qu+rObzUAbuhPRvvCIpQxZCOOYMWs8Eq+7ibS0ZDwbwaZJj7qP8PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772993035; c=relaxed/simple;
	bh=raJyAKd9DB04tg4UijsRSgizzZQ/s0bJRBxh7VHeHOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPC9MALbcPbBlDfgA3dL9qb86Pf1+zXNWmbQ3TqjXx17kkhvZX0ET7UMh7m1Kz7B/iZa7KJ9TB2wTJNm5DR+5qYCibzsSse0Jv94f2BTz+IRyvglIumtscIxq9C4v/yiyDxPezHlPPvUDP6WVv8ZZb2snZpPWQq5CzVLlOr2MFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GMZODyKc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GMZODyKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67898C2BC86;
	Sun,  8 Mar 2026 18:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772993034;
	bh=raJyAKd9DB04tg4UijsRSgizzZQ/s0bJRBxh7VHeHOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMZODyKcY6gXy9V2x9lr9Zn+T8qzbzDyBIbyK4RshDfNH6wQ+xA7SsjC9VR8XAhlo
	 nvdo46Ex6UpsDu8V4OLKCLV5y2SmSGtYeJuxPX6qxXiSiw9t2vAXzn9Y6PExty3OKj
	 olPl15Kol/aDa6jSSDLCyMXwrDen6URAvOUMuEk0=
Date: Sun, 8 Mar 2026 19:03:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable <stable@kernel.org>
Subject: Re: [PATCH] mmc: moxart: fix potential use-after-free on remove path.
Message-ID: <2026030816-womb-recollect-bdb4@gregkh>
References: <2026022351-badness-custody-28ad@gregkh>
 <CAPDyKFp=9qL2XROcTXDsv106FdoFwzziFU6YpBCB85aQ5ZFZRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFp=9qL2XROcTXDsv106FdoFwzziFU6YpBCB85aQ5ZFZRA@mail.gmail.com>

On Wed, Mar 04, 2026 at 05:25:25PM +0100, Ulf Hansson wrote:
> On Mon, 23 Feb 2026 at 14:48, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Just like in commit bd2db32e7c3e ("moxart: fix potential use-after-free
> > on remove path"), we should wait until after we are finished writing to
> > the mmc host device before removing it, otherwise it could have been
> > already freed.
> 
> mmc_remove_host() doesn't actually free the host, but it reverses what
> mmc_add_host() did during probe.
> 
> Since the moxart driver uses devm_mmc_alloc_host() the last reference
> to the host will be dropped after ->remove() completes, leading to
> mmc_free_host() to be called for it.

Then how did commit bd2db32e7c3e ("moxart: fix potential use-after-free
on remove path") do anything?  It really wasn't needed either?  And so
the CVE related to it should be rejected?

> However, improvements can still be made in the ->remove() callback. See below.
> 
> >
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: stable <stable@kernel.org>
> > Assisted-by: gkh_clanker_2000
> 
> What's this?

My assorted hacks of scripts that found this issue.

> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/mmc/host/moxart-mmc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> > index 3dd8f232052f..256e16390ef3 100644
> > --- a/drivers/mmc/host/moxart-mmc.c
> > +++ b/drivers/mmc/host/moxart-mmc.c
> > @@ -690,12 +690,12 @@ static void moxart_remove(struct platform_device *pdev)
> >                 dma_release_channel(host->dma_chan_tx);
> >         if (!IS_ERR_OR_NULL(host->dma_chan_rx))
> >                 dma_release_channel(host->dma_chan_rx);
> > -       mmc_remove_host(mmc);
> >
> >         writel(0, host->base + REG_INTERRUPT_MASK);
> >         writel(0, host->base + REG_POWER_CONTROL);
> >         writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
> >                host->base + REG_CLOCK_CONTROL);
> > +       mmc_remove_host(mmc);
> 
> Rather than moving this to the bottom of the function, it would be
> more correct to move it to the beginning.
> 
> This way, we ensure things have been closed down properly before
> releasing the dma channels.

Ok, but I was just trying to follow the same pattern in the above
mentioned commit.  If that pattern was not actually fixing something,
then this change also doesn't do anything, so it's not needed either.

thanks,

greg k-h
