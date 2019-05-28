From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/3] mmc: core: API for temporarily disabling
 auto-retuning due to errors
Date: Tue, 28 May 2019 08:42:08 -0700
Message-ID: <CAD=FV=XV1oudf-xW_s9CQMgF7MryX-UJRrqsUFDQE0DF8Yf80w@mail.gmail.com>
References: <20190517225420.176893-1-dianders@chromium.org>
 <20190517225420.176893-3-dianders@chromium.org> <05af228c-139b-2b7f-f626-36fb34634be5@broadcom.com>
 <4f39e152-04ba-a64e-985a-df93e6d15ff8@intel.com> <aa8e526f-b382-f3b7-74a5-e0fee09ae096@broadcom.com>
 <2d6fa51d-27af-4f90-2bd6-144112ce75ad@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2d6fa51d-27af-4f90-2bd6-144112ce75ad@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Double Lo <double.lo@cypress.com>, Brian Norris <briannorris@chromium.org>, Madhan Mohan R <madhanmohan.r@cypress.com>, Matthias Kaehlcke <mka@chromium.org>, Wright Feng <wright.feng@cypress.com>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, Jiong Wu <lohengrin1024@gmail.com>, Ritesh Harjani <riteshh@codeaurora.org>, Linux MMC List <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Avri Altman <avri.altman@wdc.com>, Martin Hicks <mort@bork.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, May 28, 2019 at 4:45 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 28/05/19 2:21 PM, Arend Van Spriel wrote:
> >
> >
> > On 5/28/2019 12:04 PM, Adrian Hunter wrote:
> >> On 26/05/19 9:42 PM, Arend Van Spriel wrote:
> >>> On 5/18/2019 12:54 AM, Douglas Anderson wrote:
> >>>> Normally when the MMC core sees an "-EILSEQ" error returned by a host
> >>>> controller then it will trigger a retuning of the card.  This is
> >>>> generally a good idea.
> >>>
> >>> Probably a question for Adrian, but how is this retuning scheduled. I recall
> >>> seeing something in mmc_request_done. How about deferring the retuning upon
> >>> a release host or is that too sdio specific.
> >>
> >> Below is what I have been carrying the last 4 years.  But according to
> >> Douglas'
> >> patch, the release would need to be further down.  See 2nd diff below.
> >> Would that work?
> >
> > That makes sense. The loop is needed because the device can be a bit bone
> > headed. So indeed after the loop the device should be awake and able to
> > handle CMD19.

IMO I'd rather not _defer_ the re-tuning.  I believe the correct thing
is to not schedule the re-tuning at all in response to the IO errors.
That's what my patch does.

Specifically the IO errors that come up in this case are not due to
being "out of tune".  They are due to the fact that the other SDIO
card may be in a transitory state and putting garbage on the bus.
Scheduling a retuning for later would be just a waste of time and
needlessly tie up the bus for the retune.

...or am I confused?


> What if tuning is needed to read SBSDIO_FUNC1_SLEEPCSR successfully?

Personally I think this would be pretty unlikely.  If we're at this
point we've already talked to the card quite a bit so we should have a
tuning that's pretty good.  If we're just slightly out of tune then we
should still get through the loop with a few retries and then we can
detect that we're out of tune later, with a more reliable command.

However, if you're worried about this, I can always re-enable the old
behavior if we have already looped a few times.  I suppose I could
increase the loop duration/count slightly too...  Please let me know
one way or the other.


-Doug
