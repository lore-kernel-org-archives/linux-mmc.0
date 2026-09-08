Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D92F57ED8C
	for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2026 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885015; cv=none; b=oOHXjriNwdOIf1td12YGVyJNaLI0l6T+Vz18g3XyY8pbmocinna7RXLql1BDFQLAb7pnVmI9rJ9rwIqfmsMowozZ640JsX3AX/DTDlGnjmf+uLEyqHz2hOC/AMcaey1tkEpANA0qIULYK3SSnF42HwJsRmaOfL0tF9qB4hhOKFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885015; c=relaxed/simple;
	bh=dmxM5AFaFDm6QVO/KiN5fevvjkB7YbWgNeIFaY9r+Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2PPyffe57mvvNI6t4tbDWWrmMizjPePEEW+9kKi4UiuqhnCz1Xh7uwTivMN3iZQ2T5LpHrE4BKHaDmc9CXukVgVNc7KMcgzPSnyvpk6069eSWaUEZJOuCrRyuxgGVM+/lQjWR+Xj67Q7aP6liU4VWGNIqRXoQ3uG5bk6ZB6jWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 48BBAEAF;
	Tue, 08 Sep 2026 18:30:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0DAC260FFE67; Tue,  8 Sep 2026 18:30:03 +0200 (CEST)
Date: Tue, 8 Sep 2026 18:30:02 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Ricky Wu <ricky_wu@realtek.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Matthew Schwartz <matthew.schwartz@linux.dev>,
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
	linux-mmc@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] mmc: rtsx_pci: Cope with hot-removal of MMC host
Message-ID: <aqA4CrSWVzReITXY@wunner.de>
References: <f20e08ef831f0bad278adcec44046742b54ab648.1786781008.git.lukas@wunner.de>
 <CAPx+jO9zmCd5qnPooexeRbNfOo7g4-BKBvsW6ZVpxvR22bw8xQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPx+jO9zmCd5qnPooexeRbNfOo7g4-BKBvsW6ZVpxvR22bw8xQ@mail.gmail.com>

On Tue, Sep 08, 2026 at 05:38:29PM +0200, Ulf Hansson wrote:
> On Sat, Aug 15, 2026 at 10:10AM Lukas Wunner <lukas@wunner.de> wrote:
> > Derek reports a lockup on hot-removal of a PCI-attached Realtek RTS525A
> > MMC host if a card is inserted.  He has root-caused it to the block
> > layer being unaware of the hot-removal and waiting indefinitely in
> > sync_filesystem().
> 
> Is this specific for a PCI based mmc host?

It is specific to *removable* mmc hosts.

> Can this be triggered by just removing a removable SD card?

I don't really know.  The reporter witnessed a lockup because the
card reader was removed upon resume from system sleep.  After
some digging it turned out that the lockup occurred in the call
to blk_report_disk_dead() from __del_gendisk():

https://lore.kernel.org/all/anqw0M6cQLEA0J6d@wunner.de/

Clearly, a call to blk_mark_disk_dead() is missing.  That changes
the behavior to avoid writing dirty data to disk if it's gone.

So the issue can be triggered by removing the SD card reader itself
while a card is inserted.  I cannot tell you whether hot-removing
only the card (but not the card reader) also triggers the issue.
I'm just trying to help fix an issue observed by someone else.
I do not have the hardware at my disposal for testing.
I was assuming that the mmc subsystem already has precautions in place
to support hot removal of cards and that only support for hot removal
of the card reader itself is missing.

There are plenty of Thunderbolt or USB-C docks with integrated MMC
card readers on the market, so this seems like an issue a lot of
users may run into.

> > For comparison, the NVMe subsystem copes with hot-removal by setting the
> > controller state to NVME_CTRL_DEAD in nvme_remove(), which in turn leads
> > to blk_mark_disk_dead() being called from nvme_mark_namespaces_dead().
> > That avoids the indefinite wait in sync_filesystem().
> >
> > Adopt this approach:  Detect hot-removal in rtsx_pci_sdmmc_drv_remove()
> > and invoke a new mmc_host_set_removed() helper which in turn invokes
> > mmc_card_set_removed().  Before flushing outstanding requests to the
> > card in mmc_blk_remove_req(), check for its removal and call
> > blk_mark_disk_dead().
> 
> I need more information to understand the problem and whether the NVMe
> approach is really suitable here.
> 
> What do other block subsystems do?

blk_mark_disk_dead() is the API made available by the block layer
to inform it that the disk is hot-removed.  I just followed the example
of the nvme system, which uses that API.

> > Other removable MMC hosts, in particular if attached via PCI or USB,
> > may need to be amended with a similar check for hot-removal.  The
> > present commit seeks to get that process going.
> 
> So it's specific for USB and PCI, why?

Because those buses allow hot-removal of the card reader.

Thanks,

Lukas
