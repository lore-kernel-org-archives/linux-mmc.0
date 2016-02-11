From: "Maciej W. Rozycki" <macro-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5] mmc: OCTEON: Add host driver for OCTEON MMC
 controller
Date: Thu, 11 Feb 2016 19:28:17 +0000
Message-ID: <alpine.DEB.2.00.1602111910240.15885@tp.orcam.me.uk>
References: <1455125775-7245-1-git-send-email-matt.redfearn@imgtec.com> <56BB7B2F.60307@caviumnetworks.com> <20160210234907.GC1640@darkstar.musicnaut.iki.fi> <56BBD6AD.2090902@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56BBD6AD.2090902-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Matt Redfearn <matt.redfearn-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, Aleksey Makarov <aleksey.makarov-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Chandrakala Chavva <cchavva-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Aleksey Makarov <aleksey.makarov-tx70/tkNEWbQT0dZR+AlfA@public.gmane.org>, Leonid Rosenboim <lrosenboim-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Peter Swain <pswain-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Aaron Williams <aaron.williams-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 11 Feb 2016, David Daney wrote:

> > > The vast majority of people that see it will not be able to change their
> > > firmware.  So it will be forever cluttering up their boot logs.
> > 
> > Until they switch to use APPENDED_DTB. :-)
> > 
> 
> I am philosophically opposed to making the DTB an internal kernel
> implementation detail.
> 
> For OCTEON boards, it is an ABI between the boot firmware and the kernel, and
> is impractical to change.
> 
> One could argue that many years ago, when the decision was made (by me), that
> we should have opted to carry in the kernel source code tree the DTS files for
> all OCTEON boards ever made, but we did not do that.  Due to the
> non-reversibility of time, the decision is hard to reverse.

 I concur, a very good decision as far as I'm concerned!

 I had the misfortune to work with some Freescale Power boards which used 
in-kernel DTS files in a hope to match the respective board's firmware 
(U-boot).  Needless to say, that didn't quite work.  The mapping of board 
resources was reportedly changed in some version of the firmware to give 
more flexibility and the DTS files bundled with Linux updated accordingly, 
however no version of the old files was kept around and maintained.  So a 
kernel upgrade, which turned out inevitable at one point, became a 
challenging task to update the DTS files so as to match the version of the 
firmware the boards had.

 With some pain I was eventually able to sort this out through patching 
the old DTS files to match the ever-changing DTS syntax and get them 
accepted for a DTB build and work to an acceptable extent with the then 
current version of Linux.  However some board resources were lost, for 
example the IDE interface was no longer accessible; fortunately I didn't 
need it, so I just left it like that and didn't figure out what else I'd 
have to do to regain access.

 So no, no standalone DTS/DTBs please, thank you very much.

  Maciej
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
