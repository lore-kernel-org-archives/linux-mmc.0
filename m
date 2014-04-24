From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/38] MMC updates, plus CuBox-i WiFi support
Date: Thu, 24 Apr 2014 11:17:26 +0100
Message-ID: <20140424101726.GH26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk> <CAPDyKFozP69yngKAkdwHYyyvi+pdLEm05udOmBiVshQFi4hnLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFozP69yngKAkdwHYyyvi+pdLEm05udOmBiVshQFi4hnLQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Anton Vorontsov <anton@enomsg.org>, Barry Song <baohua@kernel.org>, Ben Dooks <ben-linux@fluff.org>, Chris Ball <chris@printf.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jaehoon Chung <jh80.chung@samsung.com>, Kumar Gala <galak@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michal Simek <michal.simek@xilinx.com>, Pawel Moll <pawel.moll@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Seungwon Jeon <tgih.jun@samsung.com>, Shawn Guo <shawn.guo@freescale.com>, spear-devel@list.st.com, Stephen
List-Id: linux-mmc@vger.kernel.org

On Thu, Apr 24, 2014 at 10:25:42AM +0200, Ulf Hansson wrote:
> I have looked though the patches up until patch 33 and this is clearly
> a nice piece of clean-up /fixes work for sdhci. Besides my minor
> comments per patch, I don't have any objections code-review wise to
> proceed merging them.
> 
> I have also tried to applied them on Chris' mmc-next branch,
> unfortunate it fails at patch 23, so it would be nice to get a
> re-based patchset for the mmc-next branch.

I /could/ rebase it but then I wouldn't be able to produce the patch
sets/patches for others [*] (such as the Novena project) to derive
their kernel tree from my iMX6 patch set.

What I'd prefer is to keep the patch set intact, and provide Chris
with a pull request for it up to patch 33, which would need a
conflict fixed - and this would mean that I can be sure that what
I'm testing, and what I'm distributing is what Chris will also be
submitting.

* - this currently stands at 230 patches in all - mmc + l2c + fec +
    imx-drm + other iMX6 changes.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
