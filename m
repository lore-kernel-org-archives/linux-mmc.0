Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7E1349CE9;
	Fri, 10 Jul 2026 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693401; cv=none; b=RsTgOKvMq+ES1dBJ86dd/l0uJmY4+pMFCoV6HBHOoWwahRH15WXgrBpcuVumaDvS3hXJtXGFoaTLCDieN5iY4PF+t7K34yD4+Ymt7P2P3GOqe3CHN2zuhy07gzve8C/RIXibcV4OSsE6XtZkl6+OPpcsKeY9aOnQqp4D818SRqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693401; c=relaxed/simple;
	bh=FmV7JutBGFUCIYNATXUVv+KrOOBIa9OEmjvuNwGi3ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5jdA7Ah8/l58pFgjglXl0uNrQ2Q0TbcicFnL7SVjbyROswBT/z4nzslStLpSFG2604wqOssLtqTNnWUuPHj+IY+g9Ox1mZWLTYiMo/Itx2Nse3b03Awcag0IbDOaGVUIOPXE19jFt6Ed3hu7lW6wPDy7wd+NGFX9l/Cship+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=00lq9LQN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="00lq9LQN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AA01F000E9;
	Fri, 10 Jul 2026 14:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783693399;
	bh=4bt4dOUWQPJ3eL8Ld/QbFb1jzYqzUaR+SApX5bEWdnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=00lq9LQN1MTMSEuNrdeO/F4ZJMdt4Pm+5QQNXmlD5yy5f/M+cG/f/ZoJ3VXRiC1hT
	 V8rgLPyEmqNZpvGzys6dfBQtx4hLCsC/oN+WchYnCt+Z7kOIQjlWmRebXLC3KyyZA1
	 Onb8butjNu+pDwckc3UDcEt7go0BESpzIxNcRJ7Y=
Date: Fri, 10 Jul 2026 16:23:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Sean Rhodes <sean@starlabs.systems>, Ulf Hansson <ulfh@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Ricky Wu <ricky_wu@realtek.com>,
	Lee Jones <lee@kernel.org>, Roger Tseng <rogerable@realtek.com>,
	Dan Carpenter <error27@gmail.com>,
	Jisheng Zhang <jszhang@kernel.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] rtsx_usb: fix tray-reader false card detect and
 autosuspend
Message-ID: <2026071004-stallion-profanity-cef3@gregkh>
References: <cover.1783352430.git.sean@starlabs.systems>
 <CAPx+jO-ShdxM_s7Tg3KpRtaT7EAxGnT1s4hqBEqRFZDECVWEwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPx+jO-ShdxM_s7Tg3KpRtaT7EAxGnT1s4hqBEqRFZDECVWEwA@mail.gmail.com>

On Fri, Jul 10, 2026 at 03:21:51PM +0200, Ulf Hansson wrote:
> On Mon, Jul 6, 2026 at 5:40 PM Sean Rhodes <sean@starlabs.systems> wrote:
> >
> > This series fixes the empty-tray detect loop seen on a Realtek RTS5129
> > USB SD reader, while also avoiding USB register accesses from the USB
> > runtime autosuspend callback.
> >
> > Compared with the previous RFC, this no longer qualifies media by issuing
> > SD/MMC commands from ->get_cd().  The rtsx_usb_sdmmc child still reports
> > the raw card-detect state initially, then lets the normal MMC rescan path
> > probe the media.  If an initialization command times out before a card is
> > attached, the SD child suppresses the raw SD_CD signal until the tray/card
> > detect line drops again.
> >
> > The parent rtsx_usb change removes USB I/O from runtime autosuspend and
> > keeps only the existing Memory Stick autosuspend deferral based on cached
> > card-status bits.  Raw SD_CD is not used as a parent autosuspend blocker,
> > because this reader can assert it for an empty tray.
> >
> > Runtime-tested on a StarLite Mk V with Realtek RTS5129 (0bda:0129), using
> > these changes as a matched rtsx_usb/rtsx_usb_sdmmc/rtsx_usb_ms module set
> > on Linux 7.0.0-27-generic.
> >
> > Device enumeration:
> >   Bus 001 Device 003: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129 Card Reader Controller
> >   /:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=xhci_hcd/12p, 480M
> >       |__ Port 004: Dev 003, If 0, Class=Vendor Specific Class, Driver=rtsx_usb, 480M
> >
> > Card inserted:
> >   mmc0: new UHS-I speed SDR50 SDXC card at address 544c
> >   mmcblk0: mmc0:544c LX2TB 1.82 TiB
> >    mmcblk0: p1
> >
> > Deep S3 with the card inserted:
> >   PM: suspend entry (deep)
> >   ACPI: PM: Waking up from system sleep state S3
> >   PM: suspend exit
> >
> > After resume, the card remained visible:
> >   NAME         SIZE TYPE FSTYPE MOUNTPOINTS
> >   mmcblk0      1.8T disk
> >   `-mmcblk0p1  1.8T part exfat
> >
> > Empty tray:
> >   mmc0: card 544c removed
> >   /sys/bus/usb/devices/1-4/power/control=auto
> >   /sys/bus/usb/devices/1-4/power/runtime_status=suspended
> >   /sys/bus/usb/devices/1-4/power/runtime_usage=0
> >
> > With the empty tray left inserted for about three minutes, no repeated
> > MMC detect attempts, command timeouts, or USB reset churn were observed.
> >
> > Sean Rhodes (2):
> >   misc: rtsx_usb: avoid USB I/O in runtime autosuspend
> >   mmc: rtsx_usb_sdmmc: suppress false CD after init timeout
> >
> >  drivers/misc/cardreader/rtsx_usb.c | 26 ++++++++++++++++++++------
> >  drivers/mmc/host/rtsx_usb_sdmmc.c  | 13 ++++++++++++-
> >  include/linux/rtsx_usb.h           |  3 +++
> >  3 files changed, 35 insertions(+), 7 deletions(-)
> >
> 
> I decided to queue the series for next to get it thoroughly tested.
> Potentially we should also tag these for stable kernels, but let's get
> it tested a bit more in next first.
> 
> Greg, please let me know if you have any objections that I pick this
> via my mmc tree, or please provide your ack.

No objection from me:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
