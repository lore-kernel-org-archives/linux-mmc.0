From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v9 00/16] mmc: sdhci-msm: Add clk-rates, DDR, HS400
 support
Date: Mon, 21 Nov 2016 15:11:38 -0800
Message-ID: <20161121231138.GY25626@codeaurora.org>
References: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
 <CAPDyKFrRbf0+G5K=-jsaevAGbTqhTAss2zJv3QdiyCrv0BG-zA@mail.gmail.com>
 <d4d05fb9-8a9e-6cf2-dc63-0edbd27a9e55@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d4d05fb9-8a9e-6cf2-dc63-0edbd27a9e55-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Brown <david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Georgi Djakov <georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alex Lemberg <alex.lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>, Mateusz Nowak <mateusz.nowak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yuliy Izrailov <Yuliy.Izrailov-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>, Asutosh Das <asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, David Griego <david.griego-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sahitya Tummala <stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Venkat Gopalakrishnan <venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rajendra Nayak <rnayak@codea>
List-Id: linux-mmc@vger.kernel.org

On 11/21, Ritesh Harjani wrote:
> 
> 
> On 11/21/2016 3:36 PM, Ulf Hansson wrote:
> >On 21 November 2016 at 07:37, Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> >>Hi,
> >>
> >>This is v9 version of the patch series which adds support for MSM8996.
> >>Adds HS400 driver support as well.
> >>These are tested on internal msm8996 & db410c HW.
> >>
> >>The patch series is ready. Do we think we can apply these
> >>patches for next now?
> >
> >I guess the DTS changes can be picked up by Andy, so they can go via arm-soc?
> Yes.
> 
> >
> >Then, does the mmc changes depend on the clock changes? If so, I can
> >pick them as well, but then I need an ack from Stephen....
> Ideal and preferable, would be that clk & mmc changes go in
> together. But either ways should be fine.
> 

There's only a runtime dependency where the clk rates will be
wrong if clk tree isn't merged. I'd rather just apply the clk
ones directly to clk tree and let all three trees come together
in linux-next and work.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
