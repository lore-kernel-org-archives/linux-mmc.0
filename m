From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] mmc: failure of block read wait for long time
Date: Mon, 20 Sep 2010 18:55:27 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0316062709@dbde02.ent.ti.com>
References: <1280230066-27612-1-git-send-email-s-ghorai@ti.com>
 <4C4EDD85.5060606@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030E417D80@dbde02.ent.ti.com>
 <4C4FED36.3010607@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B0315F026ED@dbde02.ent.ti.com>
 <4C8A19E7.30706@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B0315F026F6@dbde02.ent.ti.com>
 <4C8A2C5D.2050408@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B0315F0318B@dbde02.ent.ti.com>
 <4C971320.7050906@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B03160624F6@dbde02.ent.ti.com>
 <4C974A5D.5050608@nokia.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B03160626B5@dbde02.ent.ti.com>
 <4C975CFB.6070907@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45402 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753111Ab0ITNZi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2010 09:25:38 -0400
In-Reply-To: <4C975CFB.6070907@nokia.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
> Sent: Monday, September 20, 2010 6:39 PM
> To: Ghorai, Sukumar
> Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Adrian Hunter
> Subject: Re: [PATCH] mmc: failure of block read wait for long time
> 
> On 20/09/10 15:37, ext Ghorai, Sukumar wrote:
> >
> >
> >> -----Original Message-----
> >> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
> >> Sent: Monday, September 20, 2010 5:20 PM
> >> To: Ghorai, Sukumar
> >> Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> >> Adrian Hunter
> >> Subject: Re: [PATCH] mmc: failure of block read wait for long time
> >>
> >> On 20/09/10 11:57, Ghorai, Sukumar wrote:
> >>> Adrian,
> >>>
> >>>> -----Original Message-----
> >>>> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
> >>>> Sent: Monday, September 20, 2010 1:24 PM
> >>>> To: Ghorai, Sukumar
> >>>> Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> >>>> Adrian Hunter
> >>>> Subject: Re: [PATCH] mmc: failure of block read wait for long time
> >>>>
> >>>> On 14/09/10 08:15, ext Ghorai, Sukumar wrote:
> >>>>> Adrian,
> >>>>>
> >>>>> [..snip..]
> >>>>>>>>> [Ghorai] Adrian,
> >>>>>>>>> Yes this works and reduced the retry by 1/4 (2048 to 512 times
> for
> >>>> 1MB
> >>>>>>>> data read) form the original code;
> >>>>>>>>> Initially it was retrying for each page(512 bytes) after multi-
> >> block
> >>>>>>>> read fail; but this solution is retying for each segment(2048
> >> bytes);
> >>>>>>>>> 1. Now say block layrer reading 1MB and failed for the 1st
> segment.
> >>>> So
> >>>>>>>> it will still retry for 1MB/2048-bytes, i.e. 512 times.
> >>>>>>>>> 2. So do you think any good reason to retry again and again?
> >>>>>>>> If you have 1MB that is not readable, it sounds like the card is
> >>>> broken.
> >>>>>>>> Why are so many reads failing?  Has the card been removed?
> >>>>>>>>
> >>>>>>>> You might very rarely see ECC errors in a small number of sectors,
> >>>>>>>> but more than that sounds like something else is broken.
> >>>>>>>
> >>>>>>> [Ghorai] yes, one example is we remove the card when reading data,
> >>>>>>
> >>>>>> Well, that is a different case.  Once the card has gone, the block
> >>>> driver
> >>>>>> can (and will once the remove method is called) error out all I/O
> >>>>>> requests without sending them to MMC.  That doesn't happen until
> >> there
> >>>>>> is a card detect interrupt and a resulting rescan.
> >>>>>
> >>>>> [Ghorai] here we are discussing two problem,
> >>>>> 1. If IO failed how to stop retry; because of -
> >>>>> 	a. internal card error
> >>>>> 	b. issue in Filesystem, driver, or host controller issue
> >>>>> 	c. or cards removed.
> >>>>>
> >>>>> 2. And 2nd how to sync block-layer IO, if card removed,
> >>>>> 	a. case 1: when card removed interrupt support by the platform
> >>>>> 	b. case 2: when card removed interrupt does not support by the
> >>>> platform?
> >>>>>
> >>>>>>
> >>>>>> A possible solution is to put a flag on mmc_card to indicate
> >> card_gone
> >>>>>> that gets set as soon as the drivers card detect interrupt shows
> >> there
> >>>>>> is no card (hoping that we are not getting any bouncing on card
> >> detect)
> >>>>>> and then have mmc_wait_for_req() simple return -ENODEV immediately
> if
> >>>>>> the card_gone flag is set.  Finally, if the mmc block driver sees
> >>>>>> a -ENODEV error, it should also check the card_gone flag (via a new
> >>>>>> core function) and if the card is gone, do not retry - and perhaps
> >>>>>> even error out the rest of the I/O request queue as well.
> >>>>>
> >>>>> [Ghorai] your idea address the 2.a case, but not 2.b, 1.a, 1.b
> >>>>
> >>>> The card removal case can be extended to use the bus ops detect
> method
> >>>> when there is no card detect irq.  I will send a RFC patch.
> >>>>
> >>>> With respect to 1.a:
> >>>>     - If the card has an internal error, then it is broken.  The user
> >>>>     should remove the card and use a better one.  I do not see how
> >> reducing
> >>>>     retry delays really helps the user very much.  Arguably if the
> card
> >>>>     becomes unresponsive, the MMC core could provide a facility to
> >>>>     reinitialise the card, but that is yet another issue.
> >>>>
> >>>> With respect to 1.b:
> >>>>     - The file system cannot cause the block driver to have I/O
> errors.
> >>>>     - If there are errors in the driver they should be fixed.
> >>>>     - If there are hardware problems with the host controller, then
> >>>>     it is up to the host controller driver to deal with them e.g.
> >>>>     by resetting the controller.  I don't see what this has to do
> with
> >>>>     the block driver.
> >>>>
> >>>> You leave out the important case of ECC errors.  I am concerned about
> >>>> this because of the possibility that it happens inside a file system
> >>>> journal e.g. EXT4 journal.  Perhaps the journal may be recovered if
> the
> >>>> error only affects the last transaction, but perhaps not if it
> destroys
> >>>> other transactions - which could happen if the approach you suggest
> >>>> is taken.
> >>>>
> >>> [Ghorai] Thanks lot for your descriptive answer.
> >>> 1. Can you answer this? 2.b. case 2: when card removed interrupt does
> >> not support by the platform?
> >>
> >> As I wrote above: The card removal case can be extended to use the bus
> ops
> >> detect method when there is no card detect irq.  I will send a RFC
> patch.
> >>
> >>>
> >>> 2. Why block layer handling for inter-leave data? Can you give example
> >> diver who is returning interleave data? And how to tell application
> that
> >> buffer having interleave data?
> >>
> >> I am not sure what you mean by interleave data, but file systems  for
> >> example
> >> are free to map any block to any file, directory or file system object,
> >> so a consecutive series of sectors may contain unrelated data.  Up to a
> >> maximum
> >> size, the block layer merges I/O requests when the sectors are
> consecutive,
> >> so an I/O request can also contain unrelated data.
> >
> > [Ghorai]
> > 1. I don't think so, FS know where data exists and where is the free
> space. Except oth cluster.
> 
> I was not talking about free space.  I was giving an example
> of why it is not possible to assume anything about what is in
> an I/O request.
> 
> >
> > 2. Where its mentioned in block media that for segment-x[i],x[j] data
> read fail out of all all requested segments form [1..n].
> > And I never gone through any driver/protocol, that retry the next i+1th
> segment where ith-segment is failed. And for that my suggestion is
> preferred.
> 
> The SD/MMC protocol does not indicate which sector has the error.
> There is no possibility of trying the ith+1-segment because i is
> unknown.
[Ghorai] I understand, but I think still you are fever of retrying each and every sector(i, i+1, i+2, ..) for the all request segments sequentially, when single block read for the i-th sector failed.


> 
> >
> >>
> >>>
> >>>>>
> >>>>> And the solution I was proposing to return the status of IO failure
> as
> >>>> soon as possible to above layer; and handle the card removed
> interrupt
> >>>> separately or any other issue in h/w or s/w or combination of both.
> Or
> >>>> just think again when platform don't have the card remove interrupt.
> >>>>>
> >>>>> So my patch addresses the 1st part
> >>>>
> >>>> It is absolutely unacceptable to return I/O errors to the upper
> layers
> >>>> for segments that do not have errors.
> >>>>
> >>>>> And for the 2nd part we can submit the patch anytime.
> >>>>>
> >>>>>>
> >>>>>> I can suggest a patch if you want but I am on vacation next week so
> >>>>>> it will have to wait a couple of weeks.
> >>>>>>
> >>>>>>> And moreover we should not give the interleave data to apps, as we
> >>>> don't
> >>>>>> have option to tell application for the valid data.
> >>>>>>>
> >>>>> [..snip..]
> >>>>> http://comments.gmane.org/gmane.linux.kernel.mmc/2714
> >>>>>
> >>>>>>>
> >>>>>
> >>>>>
> >>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"
> in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >
> >

