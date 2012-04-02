From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/8][git pull] mmc: omap: Assorted fixes for 3.4 merge window
Date: Mon, 02 Apr 2012 05:50:26 -0400
Message-ID: <87pqbqjwd9.fsf@laptop.org>
References: <1331905144-31655-1-git-send-email-svenkatr@ti.com>
	<87hax4kqsy.fsf@laptop.org>
	<CANfBPZ8o_Hdd7sUJ-DS-j9JOkQ=SRJcLChCfd7nCCPbaVVBkLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CANfBPZ8o_Hdd7sUJ-DS-j9JOkQ=SRJcLChCfd7nCCPbaVVBkLA@mail.gmail.com>
	(Venkatraman S.'s message of "Mon, 2 Apr 2012 13:22:44 +0530")
Sender: linux-omap-owner@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, balajitk@ti.com, balbi@ti.com
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Apr 02 2012, S, Venkatraman wrote:
> I've rebased patches 3-8 into a new branch (See below).
> I'll send you 1-2 on top of 3.4-rc2 once it's out. Is it Ok ?

Yes, thanks.

> > ==============
> The following changes since commit a4dfa827bb5b9a984d4000ffb80134b9495e4d8a:
>
>   mmc: sdio: Use empty system suspend/resume callbacks at the bus
> level (2012-04-01 00:35:06 -0400)
>
> are available in the git repository at:
>
>   git://github.com/svenkatr/linux.git omap-mmc-fixes-3.4
>
> for you to fetch changes up to 80f833a2f77b8d6464209c0bb00a39ad835356a0:
>
>   mmc: omap4: hsmmc: fix module re-insertion (2012-04-02 12:26:47 +0530)
>
> ----------------------------------------------------------------
> Balaji T K (3):
>       mmc: omap: use runtime put sync in probe error patch
>       mmc: omap: context save after enabling runtime pm
>       mmc: omap4: hsmmc: fix module re-insertion
>
> Felipe Balbi (3):
>       mmc: host: omap_hsmmc: trivial cleanups
>       mmc: host: omap_hsmmc: make it behave well as a module
>       mmc: host: omap_hsmmc: convert to module_platform_driver

Pushed to mmc-next for 3.4, and I normalized the commit message first
lines to:

        mmc: omap_hsmmc: description

Thanks very much,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
