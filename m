From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Highmem issues with MMC filesystem
Date: Thu, 18 Mar 2010 12:17:50 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003181205020.31128@xanadu.home>
References: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946>
	<alpine.LFD.2.00.1003170946250.31128@xanadu.home>
	<043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946>
	<alpine.LFD.2.00.1003171050160.31128@xanadu.home>
	<20100318092352.GD8267@n2100.arm.linux.org.uk>
	<c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
	<20100318112453.GA19544@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1003180904440.31128@xanadu.home>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C489CB4A@dbde02.ent.ti.com>
	<20100318141930.GF19544@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20100318141930.GF19544@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "V, Hemanth" <hemanthv@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "pierre@ossman.eu" <pierre@ossman.eu>, saeed bishara <saeed.bishara@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 18 Mar 2010, Russell King - ARM Linux wrote:

> On Thu, Mar 18, 2010 at 07:00:06PM +0530, Shilimkar, Santosh wrote:
> > Or could it be that there is appropriate cacheflush happening but data gets
> > stuck in CPU writebuffers instead of reaching to main memory. In this case
> > too DMA won't see the contents and a barrier (dsb) is necessary to ensure
> > that write buffer is drained before DMA takes over the buffer.

No, this is not the issue.

> What exactly is the problem that we're discussing?  Is it that the data
> on the block device is becoming corrupted, or is the data being read off
> the block device corrupted?

Data read from a DMA based block device is corrupted in memory and 
causing all sorts of misbehavior such as segmentation faults in user 
space, or EXT2 complaining about broken filesystem metadata.  This is 
serious enough to prevent a successful boot to a login prompt.  Of 
course the filesystem is just fine as using the same kernel and limiting 
the memory size so highmem doesn't get involved "fixes" the issue.  
Also keeping highmem pages active and adding a couple flush_cache_all() 
in some places also apparently "fixes" the issue.

Given that systems with VIVT caches have a full cache flush on each task 
switch, I added such a cache flush in the ARMv6 case as well to see what 
would happen.  And this _almost_ "fixed" the issue as long as there is 
enough running tasks at once on the system to enforce that cache flush 
often enough.  But with a single task running, such as gcc, then the 
segmentation faults come back.

See my previous email for my current hypothesis about the actual 
problem.


Nicolas
