Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2433633F8C2;
	Wed, 21 Jan 2026 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768991483; cv=none; b=mS7sPGk7MogMiJfVAsMiGEJaoLSFbyNXHpXavYfwzCFdIEPxPe9UZBXhKmpE5mNcB6jB8rzyUvj2UwlAfJdtzePybHJTAGJXs1DnKpMuUKB9zNoZg+wrWHTSgrq1klrrx44eJeGQj7YiGiqNpcvKpgCew1R9dkdFTzx4Ce3C/vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768991483; c=relaxed/simple;
	bh=F6IMZtymsou4/jFhN42/rSlL9NbQaIeYV6dILNk2qZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bM+FxHJaRw4u31BGixxQYDuKFvjbJgZtdRjBXpwtWzoOE0xzVdMMtwcFtJ0qDwU0SsniJcRInBvMkZOVh0HOTcz/K0DEJXK+HddDuHF7dIlemB3v6VB+L5hl9JrSgXdI0OyndsD58NPQY+c3efwQhE0mydHNIG8PCYGcRkiZbYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SKJ5ebwD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SKJ5ebwD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9661EC19422;
	Wed, 21 Jan 2026 10:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768991481;
	bh=F6IMZtymsou4/jFhN42/rSlL9NbQaIeYV6dILNk2qZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SKJ5ebwDxSiz9E1w8Z30OMPMCE9DVmbh9YwskO9cnJckJPeWtiLy7uvBJw/fpoJgl
	 uvP8TjYuyPxqekDVC7pQetP/SJQBPxrxKOsoBAUhiLtvg/5ZylwdEGhgOKq27EQsh4
	 RRs/o7d9iFCX6p0xq+YcsOeZ+uF+zBk0JOmTQ1YI=
Date: Wed, 21 Jan 2026 11:31:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>, Ricky Wu <ricky_wu@realtek.com>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mmc: rtsx: card stuck busy fixes for Realtek PCI SD
 card readers
Message-ID: <2026012150-overreact-cash-bf4d@gregkh>
References: <20260105060236.400366-1-matthew.schwartz@linux.dev>
 <CAPDyKFozgK_W98=-wqE2fxBsSkKvCU=mYH7WkKVXQPiB3+og3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFozgK_W98=-wqE2fxBsSkKvCU=mYH7WkKVXQPiB3+og3w@mail.gmail.com>

On Wed, Jan 21, 2026 at 11:13:03AM +0100, Ulf Hansson wrote:
> On Mon, 5 Jan 2026 at 07:02, Matthew Schwartz
> <matthew.schwartz@linux.dev> wrote:
> >
> > This series fixes some SD card timeout errors that occur after suspend and
> > resume ops on systems with Realtek PCI card readers. These issues occur on
> > my 2 RTS525A card readers and my RTS5261 card reader.
> >
> > As a stress test, I ran the amd-s2idle script from amd-debug-tools to
> > automate s2idle cycles and I launched a visual novel, WITCH ON THE HOLY
> > NIGHT, from the SD card. Visual novels are basically just slideshows, and
> > waiting for 10 seconds without advancing the text is an easy way to
> > trigger rtsx_pci_runtime_suspend/rtsx_pci_runtime_resume. I set amd-s2idle
> > to test with a 10 second long s2idle length with 13 seconds between runs.
> >
> > The main symptom that always shows up is "mmc0: Card stuck being busy!"
> > followed by timeouts and filesystem errors. This can occur during both
> > runtime resume and s2idle resume:
> >
> > [  260.638214] mmc0: error -110 doing runtime resume
> > [  261.054214] mmc0: card d555 removed
> > [  261.054382] Aborting journal on device mmcblk0p1-8.
> > [  261.054386] JBD2: I/O error when updating journal superblock for mmcblk0p1-8.
> > [  261.067729] EXT4-fs (mmcblk0p1): shut down requested (2)
> >
> > Patch 1 adds a power_off callback so rtsx_pcr can notify the sdmmc driver
> > during suspend, allowing it to reset prev_power_state. This ensures
> > sd_power_on properly reinitializes the card on resume. It reduces the
> > failure rate of "mmc0: Card stuck being busy!" after resume from 20% down
> > to 4%.
> >
> > Patch 2 increases the post-power-on settling delay from 1ms to 5ms. The
> > shorter delay seems insufficient for reliable reinitialization after the
> > hardware has been powered off during suspend. Increasing this reduces the
> > failure rate from 4% down to 0%, tested with over 300 s2idle cycles.
> >
> > Matthew Schwartz (2):
> >   mmc: rtsx: reset power state on suspend
> >   mmc: rtsx_pci_sdmmc: increase power-on settling delay to 5ms
> >
> >  drivers/misc/cardreader/rtsx_pcr.c |  9 +++++++++
> >  drivers/mmc/host/rtsx_pci_sdmmc.c  | 24 +++++++++++++++++++++++-
> >  include/linux/rtsx_common.h        |  1 +
> >  3 files changed, 33 insertions(+), 1 deletion(-)
> >
> > --
> > 2.52.0
> >
> 
> Greg, looks like you have queued up these patches via your misc tree,
> can you please drop them? We need a different approach to the problem.

They need to be reverted (my tree can not be rebased.)  Should I do
that, or does someone want to send me the reverts?

thanks,

greg k-h
