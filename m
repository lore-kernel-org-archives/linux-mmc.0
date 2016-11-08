From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v6 05/14] mmc: sdhci-msm: Update DLL reset sequence
Date: Wed, 09 Nov 2016 00:14:18 +0100
Message-ID: <4491681.Re2JGGCuz1@wuerfel>
References: <1478517877-23733-1-git-send-email-riteshh@codeaurora.org> <1478517877-23733-6-git-send-email-riteshh@codeaurora.org> <20161108230622.GN16026@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161108230622.GN16026-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alex.lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, mateusz.nowak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Yuliy.Izrailov-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, kdorfman-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, david.griego-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pramod.gurav-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Tuesday, November 8, 2016 3:06:22 PM CET Stephen Boyd wrote:
> > +
> > +             config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
> > +             config &= ~(0xFF << 10);
> > +             config |= mclk_freq << 10;
> > +
> > +             writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG_2);
> > +             /* wait for 5us before enabling DLL clock */
> 
> Usually there's a barrier between writel_relaxed() and delay
> because we don't know when the writel will be posted out and the
> delay is there to wait for the operation to happen. Probably
> should change this to be a writel() instead.
> 

The barrier in writel() is not for posted writes, it is to synchronize
with memory accesses *before* the write.

In general, if you want to ensure that a write has made it to the
device, you need to read back from the same address (the specific
behavior may depend on the bus).

While in general, using the non-relaxed accessors should be the
default (and there should be a comment for each *_relaxed access),
but I don't think using writel() would let you skip the delay here.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
