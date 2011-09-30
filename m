From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] arm: omap4: hsmmc: Fix Pbias configuration on
 regulator OFF
Date: Fri, 30 Sep 2011 10:41:48 -0700
Message-ID: <20110930174147.GJ6324@atomide.com>
References: <1317307500-5514-1-git-send-email-balajitk@ti.com>
 <1317307500-5514-2-git-send-email-balajitk@ti.com>
 <20110929162006.GG6324@atomide.com>
 <CANrkHUaJr3L+y33j=za-j6Kcsv1dy-rt0URc_9GgzpfOjqPTZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANrkHUaJr3L+y33j=za-j6Kcsv1dy-rt0URc_9GgzpfOjqPTZA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, kishore.kadiyala@ti.com, vishp@ti.com
List-Id: linux-mmc@vger.kernel.org

* T Krishnamoorthy, Balaji <balajitk@ti.com> [110930 07:43]:
> On Thu, Sep 29, 2011 at 9:50 PM, Tony Lindgren <tony@atomide.com> wrote:
> > * Balaji T K <balajitk@ti.com> [110929 07:11]:
> >> MMC1 data line IO's are powered down in before set regulator function.
> >> IO's should not be powered ON when regulator is OFF.
> >> Keep the IO's in power pown mode after regulator OFF.
> >> Delete incorrect comments which are not applicable for OMAP4.
> >
> > Care to check how this is different from what I added into fixes
> > branch as commit 3fe8df93b0992199e3a0026fc51e90b705f94e40?
> >
> > Is this a separate issue?
> 
> Yes.
> commit 3fe8df93b fixes USBC1 configuration.
> USBC1 IO was configured unnecessarily for MMC IO.
> 
> This patch keeps the MMC IO's in power down after regulator OFF
> otherwise it generates VMODE_ERROR due to mismatch in input (regulator)
> voltage and MMC IO drive voltage.

OK, can you please refresh it against the current fixes branch?

Thanks,

Tony
