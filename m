From: Paolo Pisati <p.pisati@gmail.com>
Subject: Re: 3.15+: omap4: mmc: multi_v7: can't boot off mmc
Date: Thu, 11 Sep 2014 10:01:32 +0200
Message-ID: <20140911080132.GA7482@luxor.wired.org>
References: <20140910153316.GA12169@luxor.wired.org>
 <20140910165000.GA3026@splat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140910165000.GA3026@splat>
Sender: linux-omap-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Paolo Pisati <p.pisati@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mmc' <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Sep 10, 2014 at 11:50:01AM -0500, Nishanth Menon wrote:
> On 17:33-20140910, Paolo Pisati wrote:
> > I'm having an hard time making the vanilla v7_defconfig boot off the mmc on my
> > pandaboard:
> 
> V3.15:
> https://github.com/nmenon/kernel-test-logs/blob/v3.15/multi_v7_defconfig/pandaboard-vanilla.txt
> https://github.com/nmenon/kernel-test-logs/blob/v3.15/multi_v7_defconfig/pandaboard-es.txt

are you 100% sure that this is a pure multi_v7_defconfig? because, by default, 
REGULATOR_PBIAS is off.

> You might be interested in using partuuid to be careful about the probe
> order deltas that may take place.

i'm not sure i understood what you mean here.
-- 
bye,
p.
