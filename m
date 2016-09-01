From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 2/4] mmc: tmio: Add tuning support
Date: Thu, 1 Sep 2016 16:19:07 +0200
Message-ID: <20160901141907.GF14300@verge.net.au>
References: <CAPDyKFpbMnOag7TZtQXxffXyq4XjTfz3vYM_atks15+d64QkfQ@mail.gmail.com>
 <20160825120424.GA3385@verge.net.au>
 <CAPDyKFpu85h3w2JkCjyQ15P8eWfkAkYcpxR4A6bD0EpQLw9rew@mail.gmail.com>
 <20160829120533.GA8647@verge.net.au>
 <CAPDyKFoL1xvv1yog2tY7pF9fWoiGQ9Gew_QbrA06dSrBiFyVEQ@mail.gmail.com>
 <20160830205146.GA14623@verge.net.au>
 <CAPDyKFpHzr-emfMsKyiJ4Ow-pjCCHWw6bBCEP6kEszOz09_pmA@mail.gmail.com>
 <20160901064644.GB15138@verge.net.au>
 <20160901083703.GA32374@verge.net.au>
 <CAPDyKFraiatvCcmhPLU+=M01Q9Dkd73QTQRJd_e=vBr-g4MwQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFraiatvCcmhPLU+=M01Q9Dkd73QTQRJd_e=vBr-g4MwQw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 01, 2016 at 11:55:27AM +0200, Ulf Hansson wrote:
> On 1 September 2016 at 10:37, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Sep 01, 2016 at 08:46:44AM +0200, Simon Horman wrote:
> >> On Wed, Aug 31, 2016 at 09:38:40AM +0200, Ulf Hansson wrote:
> >> > On 30 August 2016 at 22:51, Simon Horman <horms@verge.net.au> wrote:
> >> > > On Mon, Aug 29, 2016 at 04:05:55PM +0200, Ulf Hansson wrote:
> >> > >> On 29 August 2016 at 14:05, Simon Horman <horms@verge.net.au> wrote:
> >> > >> > On Fri, Aug 26, 2016 at 10:01:35AM +0200, Ulf Hansson wrote:
> >> > >> >> On 25 August 2016 at 14:04, Simon Horman <horms@verge.net.au> wrote:
> >> > >> >> > On Tue, Aug 23, 2016 at 05:02:56PM +0200, Ulf Hansson wrote:
> >> > >> >
> >> > >> > ...
> >> > >
> >> > > ...
> >> > >
> >> > >> > @@ -1271,6 +1278,7 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
> >> > >> >
> >> > >> >         mmc_retune_timer_stop(host->mmc);
> >> > >> >         mmc_retune_needed(host->mmc);
> >> > >> > +       host->use_saved_taps = true;
> >> > >>
> >> > >> I don't think you should trigger a re-tune here at all. Moreover you
> >> > >> don't need to keep track of whether you have valid tap values by using
> >> > >> the ->use_saved_taps variable, the mmc core deals with this for you.
> >> > >>
> >> > >> Instead, you should restore the tap values by invoking
> >> > >> host->select_tuning() from the ->runtime_resume() callback, although
> >> > >> only when host->mmc->can_retune == 1. We should probably add a helper
> >> > >> function in the mmc core for this check, instead of accessing
> >> > >> "can_retune" directly.
> >> > >
> >> > > Thanks, I was wondering what the best way to handle this is.
> >> > >
> >> > > I tried your suggestion above but it seems that host->mmc->can_retune is
> >> > > zero when ->runtime_resume() is called because of the following call paths:
> >> > >
> >> > > a) _mmc_sd_suspend()
> >> > >      -> mmc_power_off()
> >> > >         -> mmc_set_initial_state()
> >> > >            -> mmc_retune_disable
> >> > >    and
> >> > > b) mmc_sd_runtime_resume()
> >> > >      -> mmc_power_up
> >> > >         -> mmc_set_initial_state()
> >> > >            -> mmc_retune_disable
> >> > >
> >> > >> >         tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
> >> >
> >> > This is exactly what shall happen :-)
> >> >
> >> > If the mmc core suspends the card, it means it will also re-initialize
> >> > the card when resuming it. In that way the regular tuning sequence
> >> > will take place as a part of re-initialization of the card, so you
> >> > definitely must not restore tap values in these case. That is why you
> >> > should be using the can_retune to know when to restore the values.
> >>
> >> Understood. In that case things are working as expected.
> >
> > I do have one question. It seems to me that  host->mmc->can_retune == 1 on
> > resume. If so, when would the saved tap values be used?  I feel that I am
> > missing something here.
> 
> There are different "resumes" here, so this gets a bit tricky to
> discuss around. Let me give it another try.
> 
> First, let's assume we have a card inserted, initialized and tuned.
> This also means we have a cache of tuning (tap) values in the host.
> 
> When the *host* runtime PM suspends, which isn't related to when the
> card suspends, typically the card remains powered/initialized. Then,
> when the host runtime PM resumes the tuning values can be restored in
> the host controller, as those should still be working because the card
> has remained initialized.
> 
> When the card system PM suspends, the card will be put to sleep/power
> off (can_retune == 0). Sooner or later the host also becomes runtime
> PM suspended in this sequence.
> 
> When the card system PM resumes, the card will be woken up from sleep,
> power on and the re-initializations starts. Before the
> re-initializations starts, the host will be runtime PM resumed, but
> since can_retune == 0, no tuning values will be restored (correct).
> When the re-initialization sequence completes of the card, can_retune
> == 1 as a new tuning sequence has also been completed. This also means
> refreshed cached tunings values in the host, which it can use the next
> time it will be runtime PM resumed.
> 
> Hope this made more sense now.

Thanks for your detailed explanation. I understand now.
