From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v4 1/4] mmc: dw_mmc: Invalidate cache of current_speed
 after suspend/resume
Date: Mon, 12 Aug 2013 16:14:38 +0900
Message-ID: <000c01ce972b$9ba23590$d2e6a0b0$%jun@samsung.com>
References: <1373470926-19314-1-git-send-email-dianders@chromium.org>
 <1375825071-20922-1-git-send-email-dianders@chromium.org>
 <1375825071-20922-2-git-send-email-dianders@chromium.org>
 <001801ce9504$d9976ab0$8cc64010$%jun@samsung.com>
 <CAD=FV=VmtoxnRzjsKF1rVTwvkJRAxKGUvNZHAEwuWaeVokzSZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAD=FV=VmtoxnRzjsKF1rVTwvkJRAxKGUvNZHAEwuWaeVokzSZA@mail.gmail.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Olof Johansson' <olof@lixom.net>, 'James Hogan' <james.hogan@imgtec.com>, 'Grant Grundler' <grundler@chromium.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>, 'Abhilash Kesavan' <a.kesavan@samsung.com>, 'Tomasz Figa' <tomasz.figa@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Sat, August 10, 2013, Doug Anderson wrote:
> Seungwon and Jaehoon,
> 
> On Fri, Aug 9, 2013 at 6:32 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > On Wed, August 07, 2013, Doug Anderson wrote:
> >> The dw_mmc driver keeps a cache of the current slot->clock in order to
> >> avoid doing a whole lot of work every time set_ios() is called.
> >> However, after suspend/resume the register values are bogus so we need
> >> to ensure that the cached value is invalidated.
> > This mismatch comes only in case MMC_PM_KEEP_POWER, right?
> 
> Actually, no.  I saw problems with the SD Card slot, which doesn't
> have MMC_KEEP_POWER.  Problems showed up when no card was inserted
> across suspend/resume.  In other words:
> 
> 1. At boot time, slot is all setup and configured to 400kHz.
> 
> 2. Suspend
> 
> 3. Resume; clock registers are reset (by suspend/resume) and not
> restored since dw_mmc still thinks slot is configured for 400kHz due
> to host->current_speed cache.
> 
> 4. Insert card.
> 
> 5. No code sees any need to change the clock for detecting the card,
> since everyone thinks it's at 400kHz.  ...but it's not.

Doug, your analysis is right.
But, let me suggest another approach.
After step #1, core layer actually call mmc_power_off because slot is empthy(get_cd() is '0').
Then, set_ios is requested with 'ios->clock'.
However, because current implementation doesn't update current_speed in case ios->clock is '0'.
It causes current_speed has invalid clock rate in resume of dw-mmc.

So, if we can update slot->clock properly, it will be fixed.

-static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
+static void dw_mci_setup_bus(struct dw_mci_slot *slot)
 {
        struct dw_mci *host = slot->host;
        u32 div;
        u32 clk_en_a;

-       if (slot->clock != host->current_speed || force_clkinit) {
+       if (slot->clock && (slot->clock != host->current_speed)) {


@@ -807,13 +807,11 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)

        mci_writel(slot->host, UHS_REG, regs);

-       if (ios->clock) {
-               /*
-                * Use mirror of ios->clock to prevent race with mmc
-                * core ios update when finding the minimum.
-                */
-               slot->clock = ios->clock;
-       }
+       /*
+        * Use mirror of ios->clock to prevent race with mmc
+        * core ios update when finding the minimum.
+        */
+       slot->clock = ios->clock;

Thanks,
Seungwon Jeon

> 
> 
> >> In many cases we got by without this since the core mmc code fiddles
> >> with the clock a lot.  If we've got a card present we're probably
> >> running it at something like 50MHz and the core will temporarily
> >> switch us to 400kHz after resume.  One case that didn't work (for me)
> >> is the case of having no card in the slot.  The slot is initted to
> >> 400kHz at boot time.  After suspend/resume the slot thinks it's still
> >> at 400kHz (due to the cache) so doesn't adjust timing.  When it tries
> >> to send the command at probe time it just times out and gets left in a
> >> bad state.
> > I understand this change although some part of commit message (boot time, probe time...) make me
> confused.
> 
> Sorry to be confusing.  I was trying to explain why the old code works
> fine in many cases.  It's because the core MMC code tends to adjust
> the clock a lot around suspend/resume.  When it does that, it works
> around this problem.  ...but I found one case where suspend/resume
> would happen and the MMC core didn't adjust the clock.
> 
> 
> > I guess this change intends to update clock programming forcedly.
> > It looks like another version of 'dw_mci_setup_bus(slot, true)'.
> > Eventually, this change does same?
> 
> Effectively, yes.  As Jaehoon points out, that means we can actually
> eliminate the "force" parameter to dw_mci_setup_bus().
> 
> 
> I will send a new version out that eliminates the "force" parameter
> and updates the commit message to (hopefully) be clearer.
> 
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
