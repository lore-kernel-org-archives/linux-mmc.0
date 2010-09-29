From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] mmc: failure of block read wait for long time
Date: Wed, 29 Sep 2010 11:29:18 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03564763C8@dbde02.ent.ti.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0315F026F6@dbde02.ent.ti.com>
	<4C8A2C5D.2050408@nokia.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0315F0318B@dbde02.ent.ti.com>
	<4C971320.7050906@nokia.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B03160624F6@dbde02.ent.ti.com>
	<4C974A5D.5050608@nokia.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B03160626B5@dbde02.ent.ti.com>
	<4C975CFB.6070907@nokia.com>
	<20100920133703.GC30793@n2100.arm.linux.org.uk>
	<2A3DCF3DA181AD40BDE86A3150B27B6B031610E332@dbde02.ent.ti.com>
	<20100922124309.GA15699@void.printf.net>
	<2A3DCF3DA181AD40BDE86A3150B27B6B03560991F7@dbde02.ent.ti.com>
	<4CA234C4.8070907@nokia.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356476230@dbde02.ent.ti.com>
	<4CA24A7B.2070005@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4CA24A7B.2070005@nokia.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
> Sent: Wednesday, September 29, 2010 1:35 AM
> To: Ghorai, Sukumar
> Cc: Chris Ball; linux-mmc@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Russell King - ARM Linux
> Subject: Re: [PATCH] mmc: failure of block read wait for long time
> 
> On 28/09/10 21:59, ext Ghorai, Sukumar wrote:
> > Adrian,
> >
> >> -----Original Message-----
> >> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
> >> Sent: Wednesday, September 29, 2010 12:03 AM
> >> To: Ghorai, Sukumar
> >> Cc: Chris Ball; linux-mmc@vger.kernel.org; linux-arm-
> >> kernel@lists.infradead.org; Russell King - ARM Linux
> >> Subject: Re: [PATCH] mmc: failure of block read wait for long time
> >>
> >> On 28/09/10 18:03, Ghorai, Sukumar wrote:
> >>> Chris and Adrian,
> >>>
> >>> [..snip..]
> >>>>
> >>>> Chris and Adrian,
> >>>>
> >>>> [..snip..]
> >>>>>
> >>>>>> -----Original Message-----
> >>> [..snip..]
> >>>>>> Subject: Re: [PATCH] mmc: failure of block read wait for long time
> >>>>>>
> >>>>>> On Wed, Sep 22, 2010 at 11:02:08AM +0530, Ghorai, Sukumar wrote:
> >>>>>>> Would you please review and merge this patch [1] (attached too)?
> >>>>>>> [1] http://comments.gmane.org/gmane.linux.kernel.mmc/2714
> >>>>>>
> >>>>>> I've been following the thread.  I believe Adrian has NACKed this
> >>>> patch,
> >>>>>> by saying "It is absolutely unacceptable to return I/O errors to
> the
> >>>>>> upper layers for segments that do not have errors."
> >>>>>
> >>>>> [Ghorai]
> >>>>> I think Russell also mentioned his opinion. Would you please add
> your
> >>>> idea
> >>>>> too?
> >>>>>
> >>>>> 1. I would prefer Adrian to explain again what this statement means,
> >> in
> >>>>> the context - data read fail and how we make it success?
> >>
> >> Because I/O requests are made up of segments and every segment can be a
> >> success or failure.
> > [Ghorai] don't you conflict your self for the comments you provide for
> following patch -
> > [PATCH] MMC: Refine block layer waiting for card state
> > [Adrian].. then why wait for lots of errors before doing it.
> 
> That patch needs a lot more work.  Please do not base your
> understanding on it.
[Ghorai] it's the similar problem when read fails and you also suggest how to break early. 

> 
> >
> >>
> >>>>>
> >>>>> 2. if data read fail for sector(x) why we have to try for
> >>>>> sector(x+1, ..x+n)?
> >>
> >> See answer to q. 1
> >>
> >>>>>
> >>>>> 3. how to inform reader function which sector having the valid data
> >> out
> >>>> of
> >>>>> (1...n) sectors.
> >>
> >> __blk_end_request() does that
> > [Ghorai] not true. Please check the code again.
> 
> Every time you call __blk_end_request() you specify success or
> failure for the specified numbers of bytes starting from the
> last position.
> 
> >
> >>
> >>>>>
> >>>>> 4. do we have any driver/code in Linux or any other os, which give
> >>>> inter-
> >>>>> leave data and return as success?
> >>
> >> Here is the problem with that question.  The *same* I/O request
> >> can have data for *different*sources.
> > [Ghorai] File system does not do that and can you test that once how
> data comes from difference soure?
> > Also conflicting your-self for the input you gave for the patch and as -
> > [PATCH] MMC: Refine block layer waiting for card state
> > [Adrian].. then why wait for lots of errors before doing it.
> >
> >>
> >>>>>
> >>>> [Ghorai] please reply with your input on my/ Russell's suggestion?
> >>> [Ghorai] any input?
> >>
> >> I have a question for you.  What use cases do you want to address
> >>    - other than card removal?
> 
> Please answer this question.
[Ghorai] say data error (including timeout), ECC error ..

> 
> > [Ghorai]
> > 1. can you reply to original input form Russell's on the same thread?
> 
> Russell did not make any suggestions.  He pointed out that some drivers,
> but not all (and not omap_hsmmc), indicate how many bytes were transferred.
> However it is difficult for me to explain how this will or will not help
> if
> you won't give more information about your use cases.
[Ghorai] any driver give the interleave data to apps? Can you test if you give the interleave data to FS how it behave? Even it can cause the system fault. And will spend day and night to find out the issue in which module - memory, host, card?

> 
> For example, in the case of ECC errors, there are usually only a few
> blocks
> in error, so only a few of the retries timeout, so retrying is not slow.
> That is very different in the case the card has been removed, or has
> become
> unresponsive - in which case every retry fails and has to timeout.
> 
> I still plan to address the card removal issue, but I am very busy, so
> don't
> hold your breath.
[Ghorai] so I will wait for your patch forever.
> 
> > 2. can you check if you return the interleave data to FS how it can
> behave?
[Ghorai] any time?
> > 3. still you don't have any reference driver which provide the
> interleave data.
> 
> A single I/O request could have resulted from merging I/O requests from
> two *different* file systems on two *different* partitions.  I provide as
> reference every single linux file system.
[Ghorai] Filesystem never marge two IO in a single request, and if say cache did not support (sync mode)?

[Ghorai] thanks that you want to provide the solution in different way and in different patch. I will wait for your patch forever. In the mean time will take this fix locally for system integration.

And in the mean time I will simulate a case when IO failed in between (say any request to sector number 100 to 200) will return the Data timeout. And will check how system behaves. 

> 
> >
> >
> >>
> >>>>
> >>>>>>
> >>>>>> I think it's possible to merge patches to improve the situation
> (such
> >>>>>> as the idea of noticing a card disappearing earlier), but your
> >> initial
> >>>>>> patch is not the patch to do that.  You should continue to work
> with
> >>>>>> Adrian -- when he's happy that a patch does not break the semantics
> >>>>>> above, we can consider merging it.
> >>>>>>
> >>>>>> Thanks,
> >>>>>>
> >>>>>> --
> >>>>>> Chris Ball<cjb@laptop.org>     <http://printf.net/>
> >>>>>> One Laptop Per Child
> >>>
> >
> >
