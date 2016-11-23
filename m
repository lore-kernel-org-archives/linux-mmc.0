From: Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH v9 00/16] mmc: sdhci-msm: Add clk-rates, DDR, HS400
 support
Date: Tue, 22 Nov 2016 23:00:38 -0600
Message-ID: <20161123050038.GD16531@hector.attlocal.net>
References: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
 <CAPDyKFrRbf0+G5K=-jsaevAGbTqhTAss2zJv3QdiyCrv0BG-zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrRbf0+G5K=-jsaevAGbTqhTAss2zJv3QdiyCrv0BG-zA@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ritesh Harjani <riteshh@codeaurora.org>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Stephen Boyd <sboyd@codeaurora.org>, Shawn Lin <shawn.lin@rock-chips.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, David Brown <david.brown@linaro.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Asutosh Das <asutoshd@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Rajendra Nayak <rnayak@c>
List-Id: linux-mmc@vger.kernel.org

On Mon, Nov 21, 2016 at 11:06:13AM +0100, Ulf Hansson wrote:
> On 21 November 2016 at 07:37, Ritesh Harjani <riteshh@codeaurora.org> wrote:
> > Hi,
> >
> > This is v9 version of the patch series which adds support for MSM8996.
> > Adds HS400 driver support as well.
> > These are tested on internal msm8996 & db410c HW.
> >
> > The patch series is ready. Do we think we can apply these
> > patches for next now?
> 
> I guess the DTS changes can be picked up by Andy, so they can go via arm-soc?

Yeah I'll pick up the DTS change and the Documentation change.

> 
> Then, does the mmc changes depend on the clock changes? If so, I can
> pick them as well, but then I need an ack from Stephen....
> 
> Kind regards
> Uffe

Andy
