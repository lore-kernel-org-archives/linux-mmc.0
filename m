From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/3] mmc: tmio-mmc: add DMA SG synchronisation
Date: Thu, 6 Feb 2014 13:06:33 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1402061304001.1264@axis700.grange>
References: <Pine.LNX.4.64.1401311237080.3234@axis700.grange>
 <Pine.LNX.4.64.1401311248320.3234@axis700.grange> <52F3798C.4040906@codethink.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <52F3798C.4040906@codethink.co.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Ben

On Thu, 6 Feb 2014, Ben Dooks wrote:

> On 31/01/14 11:54, Guennadi Liakhovetski wrote:
> > According to the DMA API data has to be synchronised before starting
> > a DMA transfer to device and after completing a DMA transfer from device.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> I've got 1/3 and 2/3, but not 3/3 ?

Unfortunately that thread didn't make it to the ALKML - all patches 
bounced, so, they only arrived to sh and mmc. (A day before and a couple 
of hours later posting to ALKML worked just fine, just that one time...). 
You can view the whole thread here
http://thread.gmane.org/gmane.linux.kernel.mmc/24969/focus=24972

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
