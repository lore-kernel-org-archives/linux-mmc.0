From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v6 2/3] mmc: dw_mmc: Honor requests to set the clock to 0
 (turn off clock)
Date: Thu, 29 Aug 2013 09:34:14 -0700
Message-ID: <CAD=FV=VXpH31X3+LnJA6ewyrYzOZ1zu_4mL=93U9WnguR=3Nhw@mail.gmail.com>
References: <1377188348-3418-1-git-send-email-dianders@chromium.org>
	<1377188348-3418-3-git-send-email-dianders@chromium.org>
	<001201cea215$8c125e30$a4371a90$%jun@samsung.com>
	<521B1A87.4000500@samsung.com>
	<CAD=FV=WYMyGVmG-DXk1ke-yQCrfF74KDaZAUCW3qzf+Xfp-tpQ@mail.gmail.com>
	<000301cea486$0d813eb0$2883bc10$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000301cea486$0d813eb0$2883bc10$%jun@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, James Hogan <james.hogan@imgtec.com>, Grant Grundler <grundler@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Olof Johansson <olof@lixom.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Seungwon,

On Thu, Aug 29, 2013 at 12:04 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> I'd really still rather honor the MMC subsystem's request.  It
>> shouldn't _hurt_ to turn the clock off when the subsystem requests it,
> Even though turning off by clock programming doesn't hurt,
> it is costly behavior when considering low power mode of host's own support.

It is costly?  We are talking about these two commands, right?

  mci_writel(host, CLKENA, 0);
  mci_send_cmd(slot,
      SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT, 0);

Do you have a reason to believe that these are more costly than all of
the rest of the code that's executed when the user defines
CONFIG_MMC_CLKGATE?  You're still proposing doing all of the updates
of the clock when slot->clock is non-zero, right?  ...so at best
skipping this code will be 33% faster since the re-enable code
disables and then reenables the clock.  If it's the
"SDMMC_CMD_PRV_DAT_WAIT" that you're worried about then skipping this
code will only be 25% faster since there are already three calls with
SDMMC_CMD_PRV_DAT_WAIT in the enable code.


> Just now, how about focusing on the problem clock isn't updated properly after suspend/resume?

I tried to do that in the original patches, but you pointed out
(correctly) that we should do the correct fix rather than a hackier
fix.  IMHO the most correct fix is to honor the MMC core's request to
turn the clock off.  Partially honoring the MMC core (as you suggest)
is certainly less hacky that my original proposal but I still think
turning the clock off is better.


>> right?  One reason to honor the mmc core is that it will make things
>> cleaner if/when we support a voltage change operation.  The MMC core
>> has the logic for the voltage change, and part of that involves
>> turning off the clock.  We'll already need a bunch of special case
>> code in dw_mmc for voltage change, but it would be nice to avoid one
>> extra bit.
> Turning off clock during voltage switching would be another procedure.
> I guess it could be discussed later.

Agreed that we're not trying to get voltage switching done here, but
forward thinking is nice.  If there's no reason _not_ to turn the
clock off and it will help us later, let's do it. Also, we've already
agreed that MMC_CLKGATE isn't so useful for dw_mmc, so trying to do
something awkward to make MMC_CLKGATE slightly faster doesn't seem
worth it.


> I want to fix some minor change to prevent frequent message that Jaehoon pointed.

As far as I can tell, the frequent messages and whether or not to
actually turn the clock off are unrelated.  I will send up a patch
that fixes the frequent messages by caching the last value printed and
only printing if it changed.  I have verified that this works and that
the system still functions OK (can boot to prompt) with
CONFIG_MMC_CLKGATE.


Note: re-reading over some of the previous messages, it sounds like
you're proposing using the patch from your email directly, AKA:

http://article.gmane.org/gmane.linux.kernel/1542482

Did you test that patch?  Did it work for you?  It doesn't actually
compile cleanly for me (you removed the "force_clkinit" param in the
function but not the callers).  That's easy to fix, but implies that
this patch was just a proposal and not a tested solution.

...but aside from not compiling cleanly, I don't think it will work
for the same reasons that the original code didn't work.  Specifically
it doesn't address the core problem that we need to update
host->current_speed when the clock is 0.  Otherwise we won't re-init
and we run into the original problem, right?  To be certain I took
your patch and applied it, then fixed the callers of
dw_mci_setup_bus() not to pass a second parameter.  I did a
suspend/resume with no card in and then plugged a card in.  It didn't
work.


As I said above, new patch coming shortly.  As always: feel free to
point out any glaring mistakes I made in the above.  ;)  Note that I
will be out of communication for the next week or so and buried
beneath email for a few days after that, so my response might be a
little delayed.



-Doug
