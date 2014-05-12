From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Make sure we don't get stuck when we get an error
Date: Mon, 12 May 2014 14:50:41 -0700
Message-ID: <CAD=FV=X=9cTvST5cM=H9H23SMD28cHSExXt3YR=v2AQ6dFJY5w@mail.gmail.com>
References: <1395901126-6141-1-git-send-email-yuvaraj.cd@samsung.com>
	<CAKuRcOL_JVjOfLNspb14kRxcAXjpEwX4WkvmM+izryZbZBE4XA@mail.gmail.com>
	<CAPz6YkVwT0PrcLP1MJy0vVRw811+_7PwsV_ggKxQkqrjOWeWWw@mail.gmail.com>
	<002001cf6c59$b5b5e680$2121b380$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:39757 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865AbaELVum (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 May 2014 17:50:42 -0400
Received: by mail-vc0-f174.google.com with SMTP id lh14so5262114vcb.33
        for <linux-mmc@vger.kernel.org>; Mon, 12 May 2014 14:50:41 -0700 (PDT)
In-Reply-To: <002001cf6c59$b5b5e680$2121b380$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Sonny Rao <sonnyrao@chromium.org>, Yuvaraj Kumar <yuvaraj.cd@gmail.com>, Grant Grundler <grundler@chromium.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, sunil joshi <joshi@samsung.com>, Tomasz Figa <t.figa@samsung.com>

Seungwon,

On Sat, May 10, 2014 at 7:11 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Fri, May 09, 2014, Sonny Rao wrote:
>> On Thu, May 8, 2014 at 2:42 AM, Yuvaraj Kumar <yuvaraj.cd@gmail.com> wrote:
>> > Any comments on this patch?
>> >
>>
>> I'll just add that without this fix, running the tuning loop for UHS
>> modes is not reliable on dw_mmc because errors will happen and you
>> will eventually hit this race and hang.  This can happen any time
>> there is tuning like during boot or during resume from suspend.
>>
>> > On Thu, Mar 27, 2014 at 11:48 AM, Yuvaraj Kumar C D
>> > <yuvaraj.cd@gmail.com> wrote:
>> >> From: Doug Anderson <dianders@chromium.org>
>> >>
>> >> If we happened to get a data error at just the wrong time the dw_mmc
>> >> driver could get into a state where it would never complete its
>> >> request.  That would leave the caller just hanging there.
>> >>
>> >> We fix this two ways and both of the two fixes on their own appear to
>> >> fix the problems we've seen:
>> >>
>> >> 1. Fix a race in the tasklet where the interrupt setting the data
>> >>    error happens _just after_ we check for it, then we get a
>> >>    EVENT_XFER_COMPLETE.  We fix this by repeating a bit of code.
> I think repeating is not good approach to fix race.
> In your case, XFER_COMPLETE preceded data error and DTO didn't come?
> It seems strange case.
> I want to know actual error value if you can reproduce.

XFER_COMPLETE didn't necessarily precede data error.  Imagine this scenario:

1. Check for data error: nope
2. Interrupt happens and we get a data error and immediately xfer complete
3. Check for xfer complete: yup

That's the state that we are handling.

The system that dw_mmc uses where the interrupt handler has no locking
makes it incredibly difficult to get things right.  Can you propose an
alternate fix that would avoid the race?


>> >> 2. Fix it so that if we detect that we've got an error in the "data
>> >>    busy" state and we're not going to do anything else we end the
>> >>    request and unblock anyone waiting.
>> >>
>> >> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> >> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>
>> >> ---
>> >>  drivers/mmc/host/dw_mmc.c |   47 +++++++++++++++++++++++++++++++++++++++++++++
>> >>  1 file changed, 47 insertions(+)
>> >>
>> >> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> >> index 1d77431..4c589f1 100644
>> >> --- a/drivers/mmc/host/dw_mmc.c
>> >> +++ b/drivers/mmc/host/dw_mmc.c
>> >> @@ -1300,6 +1300,14 @@ static void dw_mci_tasklet_func(unsigned long priv)
>> >>                         /* fall through */
>> >>
>> >>                 case STATE_SENDING_DATA:
>> >> +                       /*
>> >> +                        * We could get a data error and never a transfer
>> >> +                        * complete so we'd better check for it here.
>> >> +                        *
>> >> +                        * Note that we don't really care if we also got a
>> >> +                        * transfer complete; stopping the DMA and sending an
>> >> +                        * abort won't hurt.
>> >> +                        */
>> >>                         if (test_and_clear_bit(EVENT_DATA_ERROR,
>> >>                                                &host->pending_events)) {
>> >>                                 dw_mci_stop_dma(host);
>> >> @@ -1313,7 +1321,29 @@ static void dw_mci_tasklet_func(unsigned long priv)
>> >>                                 break;
>> >>
>> >>                         set_bit(EVENT_XFER_COMPLETE, &host->completed_events);
>> >> +
>> >> +                       /*
>> >> +                        * Handle an EVENT_DATA_ERROR that might have shown up
>> >> +                        * before the transfer completed.  This might not have
>> >> +                        * been caught by the check above because the interrupt
>> >> +                        * could have gone off between the previous check and
>> >> +                        * the check for transfer complete.
>> >> +                        *
>> >> +                        * Technically this ought not be needed assuming we
>> >> +                        * get a DATA_COMPLETE eventually (we'll notice the
>> >> +                        * error and end the request), but it shouldn't hurt.
>> >> +                        *
>> >> +                        * This has the advantage of sending the stop command.
>> >> +                        */
>> >> +                       if (test_and_clear_bit(EVENT_DATA_ERROR,
>> >> +                                              &host->pending_events)) {
>> >> +                               dw_mci_stop_dma(host);
>> >> +                               send_stop_abort(host, data);
>> >> +                               state = STATE_DATA_ERROR;
>> >> +                               break;
>> >> +                       }
>> >>                         prev_state = state = STATE_DATA_BUSY;
>> >> +
>> >>                         /* fall through */
>> >>
>> >>                 case STATE_DATA_BUSY:
>> >> @@ -1336,6 +1366,23 @@ static void dw_mci_tasklet_func(unsigned long priv)
>> >>                                 /* stop command for open-ended transfer*/
>> >>                                 if (data->stop)
>> >>                                         send_stop_abort(host, data);
>> >> +                       } else {
>> >> +                               /*
>> >> +                                * If we don't have a command complete now we'll
>> >> +                                * never get one since we just reset everything;
>> >> +                                * better end the request.
>> >> +                                *
>> >> +                                * If we do have a command complete we'll fall
>> >> +                                * through to the SENDING_STOP command and
>> >> +                                * everything will be peachy keen.
>> >> +                                *
>> >> +                                * TODO: I guess we shouldn't send a stop?
>> >> +                                */
>> >> +                               if (!test_bit(EVENT_CMD_COMPLETE,
>> >> +                                             &host->pending_events)) {
>> >> +                                       dw_mci_request_end(host, mrq);
>> >> +                                       goto unlock;
>> >> +                               }
> Can you explain what happens above?
> What is it for?

This was an alternate fix for the above, but appears to actually hit
in practice too.

Said another way: if we don't add the extra checking for
EVENT_DATA_ERROR (above) we'll end up here.  ...and if we ever get
into this "else" and don't do _something_ then we'll wedge forever.

-Doug
