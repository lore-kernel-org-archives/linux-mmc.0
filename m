From: Alamy Liu <alamy.liu@gmail.com>
Subject: Re: [PATCH 1/2] mmc: cqhci: replace NUM_SLOTS with cq_host->num_slots
Date: Mon, 11 Feb 2019 15:04:28 -0800
Message-ID: <CAJ3kudvp11_6PdiHZA66ZHHHbH-ODTzNOQh4XUCh7dHRC8sO2Q@mail.gmail.com>
References: <20190114191724.29960-1-alamy.liu@gmail.com> <ee3dc963-53f0-e362-caa5-069ce0e6eae7@intel.com>
 <CAJ3kudsgJsZ1KFXdD9Vnfx0GypnEf+ba-D8t+Wy1e8GdLF=U0w@mail.gmail.com>
 <362c073b-d795-4431-f1dd-c203cc606a6f@codeaurora.org> <dcf57693-3daf-8277-53e9-1c4b094f2449@codeaurora.org>
 <CAJ3kuds-XgrhjiyS8j-5twOHde3NHsGaH5hFqeOm8HLXHi59aA@mail.gmail.com> <7614ec08-aac4-a82e-2534-262828aeec19@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7614ec08-aac4-a82e-2534-262828aeec19@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Asutosh Das (asd)" <asutoshd@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Thanks for the clarification.

On Mon, Feb 11, 2019 at 12:57 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 8/02/19 8:41 PM, Alamy Liu wrote:
> > The IP I'm using has fixed 32 slots for CQ once CQE is enabled in RTL.
> > There is no other RO register to say the slot number & which slot that
> > DCMD would use.
> >
> > I agree that most host controller would have 32 slots for CQ, and use
> > the last one for DCMD if enabled (easier design & save gates
> > count/size). (15th for DCMD if there were 16 slots in CQ, ...etc). It
> > also doesn't make sense to use a slot in the middle of slots for DCMD,
> > Both the code (both S.W. & H.W.) would become more complicated.
> > Although I don't see it is defined somewhere, I believe that every
> > designer would follow.
> > (H.W.: increasing gate count -> increasing die size -> increase $;
> > complicated design -> higher chance to have bug/error).
> > (H.W.: SDHC cq_depth: longer cq_depth -> more memory -> more $. The
> > decision would be the trade off between $ & performance. Also, the
> > SDHC is not necessary to be used in Cortex-A/Linux. Thus, 16/8
> > cq_depth is possible, although I don't know if there is one existed
> > out there)
> >
> > Another thinking: If all cq_depth is fixed to 32, the mmc driver core
> > doesn't even have to detect the cq_depth and eventually choose the
> > small one between HC & eMMC (queue.c::mmc_init_queue)
>
> The cqe_qdepth changes depending on whether DCMD is supported.  That is the
> kind of detail that belongs to the CQHCI driver not the mmc core.  For
> example, theoretically there could be more than one CQE driver
> implementation, but it is also nicer to keep a separation between CQHCI and
> mmc core.
>
> >
> > Best Regards
> >
> >
> > On Fri, Feb 8, 2019 at 2:34 AM Asutosh Das (asd)
> > <asutoshd@codeaurora.org> wrote:
> >>
> >> On 2/8/2019 8:07 AM, Ritesh Harjani wrote:
> >>> Hi Alamy,
> >>>
> >>> On 2/8/2019 1:00 AM, Alamy Liu wrote:
> >>>> It says in B.2.1 in the JESD84-B51.pdf (I don't have JESD84-B51A.pdf):
> >>>>
> >>>>     /The TDL is located in a memory location known to the CQE, and is
> >>>>     comprised of up to 32 fixed-size slots. Each slot is comprised of
> >>>>     one Task Descriptor and one Transfer Descriptor./
> >>>>
> >>>>
> >>>> So if the IP has 16 slots, it should still meet the specification.
> >>>> Then the configuration could be moved to DTS, maybe:
> >>>>
> >>>>     cqhci-slotnum = <16>;
> >>>>
> >>>>     cqhci-dcmd-slotno = <15>;
> >>>>
> >>> Does your IP defines this as 16 slots & DCMD slot to be 15?
> >>> Because if there is a deviation then IP may also define num_slots by
> >>> using some reserved registers.
> >>> Also in JESD84-B51.pdf, specific slot no. is used extensively for
> >>> defining policies(like in case of DCMD & CQCFG), so in that case
> >>> defining via DT may not be that helpful.
> >>> Unless there is no other way in your IP to determine the num_slots
> >>> except going via DT?
> >>>
> >>> Let others also provide an opinion here.
> >>>
> >>> Regards
> >>> Ritesh
> >>>
> >>>
> >>>>
> >>>> Please comment.
> >>>>
> >>>> Regards,
> >>>> Alamy
> >>>>
> >>>>
> >>>>
> >>>> On Thu, Jan 31, 2019 at 1:34 AM Adrian Hunter <adrian.hunter@intel.com
> >>>> <mailto:adrian.hunter@intel.com>> wrote:
> >>>>
> >>>>     On 14/01/19 9:17 PM, Alamy Liu wrote:
> >>>>     > Prevent to use fixed value (NUM_SLOTS) after it had been determined
> >>>>     > and saved in a variable (cq_host->num_slots).
> >>>>
> >>>>     num_slots is always 32 (i.e. NUM_SLOTS) so why not go the other
> >>>>     way and get
> >>>>     rid of num_slots and just use NUM_SLOTS?
> >>>>
> >>>>     >
> >>>>     > Signed-off-by: Alamy Liu <alamy.liu@gmail.com
> >>>>     <mailto:alamy.liu@gmail.com>>
> >>>>     > ---
> >>>>     >  drivers/mmc/host/cqhci.c | 2 +-
> >>>>     >  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>     >
> >>>>     > diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
> >>>>     > index 159270e947..26d63594b7 100644
> >>>>     > --- a/drivers/mmc/host/cqhci.c
> >>>>     > +++ b/drivers/mmc/host/cqhci.c
> >>>>     > @@ -699,7 +699,7 @@ static void cqhci_error_irq(struct mmc_host
> >>>>     *mmc, u32 status, int cmd_error,
> >>>>     >                * The only way to guarantee forward progress is
> >>>>     to mark at
> >>>>     >                * least one task in error, so if none is
> >>>>     indicated, pick one.
> >>>>     >                */
> >>>>     > -             for (tag = 0; tag < NUM_SLOTS; tag++) {
> >>>>     > +             for (tag = 0; tag < cq_host->num_slots; tag++) {
> >>>>     >                       slot = &cq_host->slot[tag];
> >>>>     >                       if (!slot->mrq)
> >>>>     >                               continue;
> >>>>     >
> >>>>
> >> Is it worth exploring to tie up the TDL memory allocations with the
> >> queue-depth? Because the queue-depth may vary with vendor; in most host
> >> controllers the slot size is 32. And since memory allocations are done
> >> on the basis of host slot size there's unused slots in the case of card
> >> advertising less than 32 queue-depth.
> >> The tricky part would be the DCMD handling though.
> >>
> >> In the IP in question, what slot is assigned to DCMD?
> >>
> >>
> >> --
> >> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
> >> Linux Foundation Collaborative Project
> >
>
