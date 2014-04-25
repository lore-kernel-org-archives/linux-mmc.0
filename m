From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/38] MMC updates, plus CuBox-i WiFi support
Date: Fri, 25 Apr 2014 10:03:43 +0100
Message-ID: <20140425090343.GH26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk> <CAPDyKFozP69yngKAkdwHYyyvi+pdLEm05udOmBiVshQFi4hnLQ@mail.gmail.com> <20140424101726.GH26756@n2100.arm.linux.org.uk> <CAPDyKFrGReKF0ucer7D195boEoQW26=4vDXT+=Wn6BO-p_B1gQ@mail.gmail.com> <20140424105745.GM26756@n2100.arm.linux.org.uk> <CAPDyKFr=2=dg1NTYb1_EAgxXZq2Rd+o2Q2B5TE+GZwr8MUU1_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFr=2=dg1NTYb1_EAgxXZq2Rd+o2Q2B5TE+GZwr8MUU1_Q@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, Barry Song <baohua@kernel.org>, Ben Dooks <ben-linux@fluff.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jaehoon Chung <jh80.chung@samsung.com>, Kumar Gala <galak@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michal Simek <michal.simek@xilinx.com>, Pawel Moll <pawel.moll@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Seungwon Jeon <tgih.jun@samsung.com>, Shawn Guo <shawn.guo@freescale.com>, spear-devel@list.st.com, Stephe
List-Id: linux-mmc@vger.kernel.org

On Thu, Apr 24, 2014 at 01:13:05PM +0200, Ulf Hansson wrote:
> On 24 April 2014 12:57, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > This is nothing new or unexpected - it was last posted back in February,
> > and I elected that it should be held off until after the last merge
> > window.
> >
> > Unfortunately, I didn't have time to post it immediately after the merge
> > window closed, partly because it needed to be rebased on top of tglx's
> > IRQ changes on which it depends.  I was carrying those as separate commits
> > to the ones Thomas was carrying in his tree - and in the event, Thomas had
> > modified his patches slightly between sending me copies of them and the
> > versions he sent during the merge window.
> 
> Okay, so let's keep up the frequency here then. I only had some minor
> comments, please fix them and send a v2.

Right, so I've updated the patches, and added one ack to one patch.
That seems insufficient to me - the only platform these have been
tested on is iMX6, which is sdhci-esdhc-imx.c.

They _really_ need testing elsewhere too.  Or is the plan to merge
them and then see about getting people to test them and fix them up
afterwards?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
