From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: Make sure we don't get stuck when we get an
 error
Date: Tue, 20 May 2014 10:51:11 +0900
Message-ID: <003a01cf73cd$fa2ee160$ee8ca420$%jun@samsung.com>
References: <1395901126-6141-1-git-send-email-yuvaraj.cd@samsung.com>
 <CAKuRcOL_JVjOfLNspb14kRxcAXjpEwX4WkvmM+izryZbZBE4XA@mail.gmail.com>
 <CAPz6YkVwT0PrcLP1MJy0vVRw811+_7PwsV_ggKxQkqrjOWeWWw@mail.gmail.com>
 <002001cf6c59$b5b5e680$2121b380$%jun@samsung.com>
 <CAD=FV=X=9cTvST5cM=H9H23SMD28cHSExXt3YR=v2AQ6dFJY5w@mail.gmail.com>
 <001b01cf6e67$2183b400$648b1c00$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <001b01cf6e67$2183b400$648b1c00$%jun@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Seungwon Jeon' <tgih.jun@samsung.com>, 'Doug Anderson' <dianders@chromium.org>
Cc: 'Sonny Rao' <sonnyrao@chromium.org>, 'Yuvaraj Kumar' <yuvaraj.cd@gmail.com>, 'Grant Grundler' <grundler@chromium.org>, 'linux-samsung-soc' <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>, 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'sunil joshi' <joshi@samsung.com>, 'Tomasz Figa' <t.figa@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, May 13, 2014, Seungwon Jeon wrote:
> Hi Doug,
> 
> On Tue, May 13, 2014, Doug Anderson wrote:
> > Seungwon,
> >
> > On Sat, May 10, 2014 at 7:11 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > > On Fri, May 09, 2014, Sonny Rao wrote:
> > >> On Thu, May 8, 2014 at 2:42 AM, Yuvaraj Kumar <yuvaraj.cd@gmail.com> wrote:
> > >> > Any comments on this patch?
> > >> >
> > >>
> > >> I'll just add that without this fix, running the tuning loop for UHS
> > >> modes is not reliable on dw_mmc because errors will happen and you
> > >> will eventually hit this race and hang.  This can happen any time
> > >> there is tuning like during boot or during resume from suspend.
> > >>
> > >> > On Thu, Mar 27, 2014 at 11:48 AM, Yuvaraj Kumar C D
> > >> > <yuvaraj.cd@gmail.com> wrote:
> > >> >> From: Doug Anderson <dianders@chromium.org>
> > >> >>
> > >> >> If we happened to get a data error at just the wrong time the dw_mmc
> > >> >> driver could get into a state where it would never complete its
> > >> >> request.  That would leave the caller just hanging there.
> > >> >>
> > >> >> We fix this two ways and both of the two fixes on their own appear to
> > >> >> fix the problems we've seen:
> > >> >>
> > >> >> 1. Fix a race in the tasklet where the interrupt setting the data
> > >> >>    error happens _just after_ we check for it, then we get a
> > >> >>    EVENT_XFER_COMPLETE.  We fix this by repeating a bit of code.
> > > I think repeating is not good approach to fix race.
> > > In your case, XFER_COMPLETE preceded data error and DTO didn't come?
> > > It seems strange case.
> > > I want to know actual error value if you can reproduce.
> >
> > XFER_COMPLETE didn't necessarily precede data error.  Imagine this scenario:
> >
> > 1. Check for data error: nope
> > 2. Interrupt happens and we get a data error and immediately xfer complete
> > 3. Check for xfer complete: yup
> >
> > That's the state that we are handling.
> >
> > The system that dw_mmc uses where the interrupt handler has no locking
> > makes it incredibly difficult to get things right.  Can you propose an
> > alternate fix that would avoid the race?
> Thank you for detailed scenario.
> You're right.
> Have you consider using spin_lock() in interrupt handler?
> Then, we'll need to change spin_lock() to spin_lock_irqsave() in tasklet func.
> And other locks in driver may need to be adjusted properly.
> 
> To return above scenario:
> 1. Check for data error: nope
> 2. Check for xfer complete: nope -> escape tasklet.
> 3. Interrupt happens and we get a data error and immediately xfer complete
> 4. Check for data error (Again in tasklet) : yup
> 
> How about this change?
> 
> Thanks,
> Seungwon Jeon
> >
> >
> > >> >> 2. Fix it so that if we detect that we've got an error in the "data
> > >> >>    busy" state and we're not going to do anything else we end the
> > >> >>    request and unblock anyone waiting.
> > >> >>
> > >> >> Signed-off-by: Doug Anderson <dianders@chromium.org>
> > >> >> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
> > >> >> ---
> > >> >>  drivers/mmc/host/dw_mmc.c |   47 +++++++++++++++++++++++++++++++++++++++++++++
> > >> >>  1 file changed, 47 insertions(+)
> > >> >>
> > >> >> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > >> >> index 1d77431..4c589f1 100644
> > >> >> --- a/drivers/mmc/host/dw_mmc.c
> > >> >> +++ b/drivers/mmc/host/dw_mmc.c
> > >> >> @@ -1300,6 +1300,14 @@ static void dw_mci_tasklet_func(unsigned long priv)
> > >> >>                         /* fall through */
> > >> >>
> > >> >>                 case STATE_SENDING_DATA:
> > >> >> +                       /*
> > >> >> +                        * We could get a data error and never a transfer
> > >> >> +                        * complete so we'd better check for it here.
> > >> >> +                        *
> > >> >> +                        * Note that we don't really care if we also got a
> > >> >> +                        * transfer complete; stopping the DMA and sending an
> > >> >> +                        * abort won't hurt.
> > >> >> +                        */
> > >> >>                         if (test_and_clear_bit(EVENT_DATA_ERROR,
> > >> >>                                                &host->pending_events)) {
> > >> >>                                 dw_mci_stop_dma(host);
> > >> >> @@ -1313,7 +1321,29 @@ static void dw_mci_tasklet_func(unsigned long priv)
> > >> >>                                 break;
> > >> >>
> > >> >>                         set_bit(EVENT_XFER_COMPLETE, &host->completed_events);
> > >> >> +
> > >> >> +                       /*
> > >> >> +                        * Handle an EVENT_DATA_ERROR that might have shown up
> > >> >> +                        * before the transfer completed.  This might not have
> > >> >> +                        * been caught by the check above because the interrupt
> > >> >> +                        * could have gone off between the previous check and
> > >> >> +                        * the check for transfer complete.
> > >> >> +                        *
> > >> >> +                        * Technically this ought not be needed assuming we
> > >> >> +                        * get a DATA_COMPLETE eventually (we'll notice the
> > >> >> +                        * error and end the request), but it shouldn't hurt.
> > >> >> +                        *
> > >> >> +                        * This has the advantage of sending the stop command.
> > >> >> +                        */
> > >> >> +                       if (test_and_clear_bit(EVENT_DATA_ERROR,
> > >> >> +                                              &host->pending_events)) {
> > >> >> +                               dw_mci_stop_dma(host);
> > >> >> +                               send_stop_abort(host, data);
> > >> >> +                               state = STATE_DATA_ERROR;
> > >> >> +                               break;
> > >> >> +                       }
> > >> >>                         prev_state = state = STATE_DATA_BUSY;
> > >> >> +
> > >> >>                         /* fall through */
> > >> >>
> > >> >>                 case STATE_DATA_BUSY:
> > >> >> @@ -1336,6 +1366,23 @@ static void dw_mci_tasklet_func(unsigned long priv)
> > >> >>                                 /* stop command for open-ended transfer*/
> > >> >>                                 if (data->stop)
> > >> >>                                         send_stop_abort(host, data);
> > >> >> +                       } else {
> > >> >> +                               /*
> > >> >> +                                * If we don't have a command complete now we'll
> > >> >> +                                * never get one since we just reset everything;
> > >> >> +                                * better end the request.
> > >> >> +                                *
> > >> >> +                                * If we do have a command complete we'll fall
> > >> >> +                                * through to the SENDING_STOP command and
> > >> >> +                                * everything will be peachy keen.
> > >> >> +                                *
> > >> >> +                                * TODO: I guess we shouldn't send a stop?

Please remove TODO:
We already reset controller in dw_mci_data_complete() through "mmc: dw_mmc: change to use recommended reset procedure"?
I guess it depends on that patch.
Then, we don't need to stop sequence anymore.

Thanks,
Seungwon Jeon

> > >> >> +                                */
> > >> >> +                               if (!test_bit(EVENT_CMD_COMPLETE,
> > >> >> +                                             &host->pending_events)) {
> > >> >> +                                       dw_mci_request_end(host, mrq);
> > >> >> +                                       goto unlock;
> > >> >> +                               }
> > > Can you explain what happens above?
> > > What is it for?
> >
> > This was an alternate fix for the above, but appears to actually hit
> > in practice too.
> >
> > Said another way: if we don't add the extra checking for
> > EVENT_DATA_ERROR (above) we'll end up here.  ...and if we ever get
> > into this "else" and don't do _something_ then we'll wedge forever.
> >
> > -Doug
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
