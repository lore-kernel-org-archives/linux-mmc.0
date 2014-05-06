From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: TRIM timeout calculation
Date: Tue, 6 May 2014 10:44:17 +0200
Message-ID: <OF3A79004A.37D11855-ONC1257CD0.002FBD99-C1257CD0.00300021@transmode.se>
References: <OF5115E52C.11615B85-ONC1257CCF.005BB35E-C1257CCF.005CF8B5@transmode.se>	<CAPDyKFo8ir0aKCE9HgEQj2jbNQVxSt2ENPdEshDpuuy7MYE6CQ@mail.gmail.com>
	<OF5C054324.0517D62C-ONC1257CD0.0025B7D9-C1257CD0.00280C60@transmode.se> <CAPDyKFpSpT_XJycC+_i-_Y_fKgjmG7YfRu-TrSaqaOw_3diVGA@mail.gmail.com> <OF2CA434B5.1040E603-ONC1257CD0.002A68C4-C1257CD0.002B06CE@LocalDomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw1.transmode.se ([195.58.98.146]:51187 "EHLO gw1.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934434AbaEFIoU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 6 May 2014 04:44:20 -0400
In-Reply-To: <OF2CA434B5.1040E603-ONC1257CD0.002A68C4-C1257CD0.002B06CE@LocalDomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

Joakim Tjernlund/Transmode wrote on 2014/05/06 09:49:57:
> 
> Ulf Hansson <ulf.hansson@linaro.org> wrote on 2014/05/06 09:41:12:
> > 
> > On 6 May 2014 09:17, Joakim Tjernlund <joakim.tjernlund@transmode.se> 
wrote:
> > > Ulf Hansson <ulf.hansson@linaro.org> wrote on 2014/05/05 22:50:39:
> > >>
> > >> On 5 May 2014 18:55, Joakim Tjernlund 
<joakim.tjernlund@transmode.se>
> > > wrote:
> > >> > I got a Micron eMMC 4.41 memory and I am trying to use the TRIM
> > > function.
> > >> > my EXT_CSD_TRIM_MULT is 15 which gets me a tmo of 15*300=4500 ms
> > >> > Then in  mmc_calc_max_discard() I have:
> > >> >         max_discard = mmc_do_calc_max_discard(card, 
MMC_ERASE_ARG);
> > >> >         if (mmc_can_trim(card)) {
> > >> >                 max_trim = mmc_do_calc_max_discard(card,
> > > MMC_TRIM_ARG);
> > >> >                 if (max_trim < max_discard)
> > >> >                         max_discard = max_trim;
> > >> >         } else if (max_discard < card->erase_size) {
> > >> >                 max_discard = 0;
> > >> >         }
> > >> >         pr_debug("%s: calculated max. discard sectors %u for 
timeout
> > > %u
> > >> > ms\n",
> > >> >                  mmc_hostname(host), max_discard,
> > > host->max_busy_timeout);
> > >> > Now  mmc_do_calc_max_discard(card, MMC_TRIM_ARG) returns 0 
because the
> > >> > initial trim
> > >> > timeout is so high, 4500 ms:
> > >> >   mmc0: calculated max. discard sectors 0 for timeout 2684 ms

Just a data point, if I disable TRIM in the driver so that the code
falls back to ERASE I get:
  mmc0: calculated max. discard sectors 114688 for timeout 2684 ms
Big difference!

  Jocke
