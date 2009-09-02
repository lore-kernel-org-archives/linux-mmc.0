From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: mmcqd cpu utilization
Date: Wed, 2 Sep 2009 14:57:27 -0500
Message-ID: <00ae01ca2c07$98d416f0$544ff780@am.dhcp.ti.com>
References: <007301ca2bf2$2888e2a0$544ff780@am.dhcp.ti.com> <20090902194036.07c1f72c@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20090902194036.07c1f72c@mjolnir.ossman.eu>
Sender: linux-omap-owner@vger.kernel.org
To: 'Pierre Ossman' <pierre@ossman.eu>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, hch@lst.de
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Pierre Ossman [mailto:pierre@ossman.eu]
> Sent: Wednesday, September 02, 2009 12:41 PM
> To: Madhusudhan
> Cc: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org; hch@lst.de
> Subject: Re: mmcqd cpu utilization
> 
> On Wed, 2 Sep 2009 12:23:59 -0500
> "Madhusudhan" <madhu.cr@ti.com> wrote:
> 
> > Hi,
> >
> > Has anyone monitored the cpu utilization percentage when a MMC/SD card
> is in
> > use? I have noticed that mmc_queue_thread "mmcqd" consumes a lot of cpu
> > cycles in a periodic fashion. What I mean here is that I see spikes of
> high
> > cpu utilization due to mmcqd. There will a cp or similar which will be
> > already consuming cpu to transfer data to the MMC/SD device. Further
> mmcqd
> > increases that load randomly to a high number.
> >
> > Has anyone seen similar behavior? Any thoughts?
> >
> 
> My guess would be that the omap driver doesn't (cannot?) use the
> hardware to wait for busy to end, so the system must poll.
> 
So your guess hints probably at "wait_for_completion(&complete)".
Am I correct?

Regards,
Madhu

> Anything better than that guess will require some profiling. :)
> 
> Rgds
> --
>      -- Pierre Ossman
> 
>   WARNING: This correspondence is being monitored by the
>   Swedish government. Make sure your server uses encryption
>   for SMTP traffic and consider using PGP for end-to-end
>   encryption.

