From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 00/16] mmc: meson-gx: driver fixups and upgrades
Date: Tue, 22 Aug 2017 13:46:30 +0200
Message-ID: <1503402390.7032.11.camel@baylibre.com>
References: <20170821160301.21899-1-jbrunet@baylibre.com>
         <CAPDyKFoBebVf0wqJ+z5UHC+aMju2Qy0ONc1OVYrwzZKk+XgGTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:38466 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932551AbdHVLqi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Aug 2017 07:46:38 -0400
Received: by mail-wr0-f182.google.com with SMTP id p8so58951957wrf.5
        for <linux-mmc@vger.kernel.org>; Tue, 22 Aug 2017 04:46:37 -0700 (PDT)
In-Reply-To: <CAPDyKFoBebVf0wqJ+z5UHC+aMju2Qy0ONc1OVYrwzZKk+XgGTg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 2017-08-22 at 13:15 +0200, Ulf Hansson wrote:
> On 21 August 2017 at 18:02, Jerome Brunet <jbrunet@baylibre.com> wrote:
> > The patchset features several bugfixes, rework and upgrade for the
> > meson-gx MMC driver.
> > 
> > The main goal is to improve readability and enable new high speed
> > modes, such as eMMC DDR52 and sdcard UHS modes up to SDR50 (100Mhz)
> > 
> > SDR104 is not working with a few cards on the p200 and the
> > libretech-cc. I suspect that 200Mhz might be a bit too fast for the PCB
> > of these boards, adding noise to the signal and eventually breaking
> > the communication with some cards. The same cards are working well on a
> > laptop or the nanopi-k2 at 200Mhz.
> > 
> > This series has been tested on gxbb-p200, gxbb-nanopi-k2 and
> > gxl-s905x-libretech-cc
> > 
> > Changes since v1 [0]:
> > * Reorder patches to have fixes first, then rework and finally
> >   enhancements.
> > * Use CCF to manage clock phases
> > 
> > [0]: https://lkml.kernel.org/r/20170804174353.16486-1-jbrunet@baylibre.com
> > 
> > Jerome Brunet (16):
> >   mmc: meson-gx: fix mux mask definition
> >   mmc: meson-gx: remove CLK_DIVIDER_ALLOW_ZERO clock flag
> >   mmc: meson-gx: clean up some constants
> >   mmc: meson-gx: use _irqsave variant of spinlock
> >   mmc: meson-gx: cfg init overwrite values
> >   mmc: meson-gx: rework set_ios function
> >   mmc: meson-gx: rework clk_set function
> >   mmc: meson-gx: rework clock init function
> >   mmc: meson-gx: fix dual data rate mode frequencies
> >   mmc: meson-gx: work around clk-stop issue
> >   mmc: meson-gx: simplify interrupt handler
> >   mmc: meson-gx: implement card_busy callback
> >   mmc: meson-gx: use CCF to handle the clock phases
> >   mmc: meson-gx: implement voltage switch callback
> >   mmc: meson-gx: change default tx phase
> >   mmc: meson-gx: rework tuning function
> > 
> >  drivers/mmc/host/meson-gx-mmc.c | 718 +++++++++++++++++++++++++++--------
> > -----
> >  1 file changed, 497 insertions(+), 221 deletions(-)
> > 
> > --
> > 2.9.5
> > 
> 
> So far, I decided to pick patch 1 -> 3.

Thx Ulf.
Do you want me to respin w/o patch 1 -> 4 or shall I wait for further review on
the other changes ?

> 
> Kind regards
> Uffe

