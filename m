Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7133B3B42D6;
	Thu, 17 Sep 2026 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789631908; cv=none; b=kdGt+VHRy+bnNbZDpw8PixNU5SxsoXl/OtenVQBMe3rXesGKpj84zLeCcwiLV6CV4tmzdPn+6EF/hnA99ShYAM6IEd+iqy1aSZDVuNOfgZjP50TNUOgASYp6dQWRkINFUbXod9Oia8O/jS6viRJi/LtqDh9PDuZamEzwZOwkxzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789631908; c=relaxed/simple;
	bh=8c+92Jd/gm+FWqvIgfkDHVoxph3tLgrEuSoKU/ASSho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYtmSd3q0nETbUDnfS0XHOK1hk82SS/z/jcflb8dBZJIQoDhnaRy6XaPZ+0xOxhqp5GN8bJpvJ6anY2OWYpJsjIT49UD/jte9jKUNQmCE5DYz9xViHIkQq1/qfA9NKxudy/IsIxmw2MATnnzBJ3QTeWzh2j+OUF5DFBdFBn8Pu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQqv+3/E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQqv+3/E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C871F000FF;
	Thu, 17 Sep 2026 07:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789631907;
	bh=9++Cplf6jCa1OoloXqzPgof2bhpi5ETowpfawlNDVm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mQqv+3/E7QwJcb0I5Ns0cHgT8TTuV/nvp/UzSP3aseIZ+h48q2X2iWXzXAqCm8xIy
	 NNAxtyOIealg1sDOn2n4q5J1VGiyPlKPoZfSxB57VcZLO9K/5W3pa3WTYwxdTMZ65k
	 BF60DZTolqzOQWzc6uo8yC17InS408oLsQI+21ddgFjlZmhQswejBFrX7fNtJnnmh4
	 Na3k04bfVhZqYec/EiIkgrUsjGQr/nbk4XRgI4xHxA1wHcyRm7KuoEk0s2/6/Fluia
	 Yxu3JjFahJsqA97hVkOqhrsMOGcTOHoz8dAfx2CdzMTq61JAsxmaA2m5We3hSfCxTo
	 UaS+a5q2wZ+SA==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1x770i-00000006OfM-23F8;
	Thu, 17 Sep 2026 09:58:24 +0200
Date: Thu, 17 Sep 2026 09:58:24 +0200
From: Johan Hovold <johan@kernel.org>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: core: Turn mmc_alloc|free_host() into static
 functions
Message-ID: <aqudoCAtZTgq_31Y@hovoldconsulting.com>
References: <20260915132052.273212-1-ulf.hansson@oss.qualcomm.com>
 <20260915132052.273212-3-ulf.hansson@oss.qualcomm.com>
 <aqpIl5NWCFiuKy9b@hovoldconsulting.com>
 <CAPx+jO86Sy+of41dw3Gi5CNfyc5+iOyDU4CZypz4YGzG27QW0A@mail.gmail.com>
 <aqpovla0rTDnmwRh@hovoldconsulting.com>
 <CAPx+jO8WS3MqzS3txy1B3FnQ9OzRjDGzxMLLZ+Mys-jqego3_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx+jO8WS3MqzS3txy1B3FnQ9OzRjDGzxMLLZ+Mys-jqego3_w@mail.gmail.com>

On Wed, Sep 16, 2026 at 04:12:10PM +0200, Ulf Hansson wrote:
> On Wed, Sep 16, 2026 at 12:00 PM Johan Hovold <johan@kernel.org> wrote:

> > Devres generally only works when all resources are device managed.
> > Therefore you should always provide the underlying non-devres manages
> > interface as well so that you don't force devres on drivers where it
> > could cause trouble.
> >
> > > > Especially with the work cancellations present in mmc_free_host() (which
> > > > I have pointed out elsewhere should not be there), a driver may need to
> > > > free the host before tearing down other non-devres managed resources
> > > > during unbind.
> > >
> > > Can you please point me to such an example so I can try to understand better?
> >
> > We just discussed the renesas driver which can schedule rescan work
> > before registering the host controller. [1]
> 
> That isn't a problem, but it's not the right thing to do as
> host->rescan_disable is set.

Ok, good, I see now that you also cancel the rescan work when the host
is stopped so that seems fine even if the second cancel when freeing the
host is unexpected and bit misleading (as it was added to work around a
driver doing something it should not have).

> > If such a driver also has non-devres managed resources that are freed
> > before the work is cancelled you have a use-after-free.
> 
> If you are referring to the mmc rescan work; mmc_rescan() will just
> bail out as host->rescan_disable has been set as soon as
> mmc_remove_host() is called (see mmc_stop_host()). In other words, I
> don't see how a use-after-free would be possible in this regard.

Looks like you also recently fixed a related issue with sdio interrupt
work which also wasn't stopped (see commit 6feadbecdae6 ("mmc: core:
Cancel SDIO IRQ work before freeing host")).

So I was referring to all work which may still be running after
mmc_remove_host() and potentially call back into the driver being
unbound.

A quick look at a driver using sdio_signal_irq() indicates that this may
still be racy. In dw_mci_remove() the host is removed and clocks
disabled before freeing the host and cancelling the sdio work. A racing
interrupt could have scheduled work that may result in MMIO accesses
with clocks disabled.

> > I only pointed at greybus as an example of a driver which has non-devres
> > managed resources. If there is (rescan) work still scheduled after
> > probe() or remove() returns, there's a potential use-after-free.
> 
> See above. This should not be an issue, at least it has nothing to do
> whether we are using managed resources or not.

Sure, if mmc core guarantees that no callbacks are made despite the work
being left running it should be fine. But that does not seem to be the
case with sdio interrupts currently.

But regardless of any potential races in mmc core, my devres comment is
a more general one: subsystems should not force devres on anyone.

Johan
