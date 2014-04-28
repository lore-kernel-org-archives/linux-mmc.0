From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 00/38] MMC updates, plus CuBox-i WiFi support
Date: Mon, 28 Apr 2014 10:42:35 -0600
Message-ID: <535E84FB.4080305@wwwdotorg.org>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Anton Vorontsov <anton@enomsg.org>, Barry Song <baohua@kernel.org>, Ben Dooks <ben-linux@fluff.org>, Chris Ball <chris@printf.net>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jaehoon Chung <jh80.chung@samsung.com>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-tegra@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Michal Simek <michal.simek@xilinx.com>, Pawel Moll <pawel.moll@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Seungwon Jeon <tgih.jun@samsung.com>, Shawn Guo <shawn.guo@freescale.com>, spear-devel@list.st.com, Thierry Reding <thierry.reding@gmail.com>, Ulf Hansson <ulf.hansson@linar>
List-Id: linux-mmc@vger.kernel.org

On 04/23/2014 12:55 PM, Russell King - ARM Linux wrote:
> All,
> 
> This is where I'm at with trying to clean up the SDHCI mess, and sort out
> issues I've noticed when trying to get UHS support working on CuBoxes.
> This is my full patch set, but I recommend not applying patch 37 as there
> appears to be a hardware issue preventing it working reliably.
> 
> In any case, patches 0-33 inclusive are the SDHCI clean up, based against
> v3.15-rc1.  Patches 34 and 35 are Olof's Wifi support, 36 is my fix against
> those, and 38 adds the Broadcom Wifi and BT support for CuBox.
> 
> The questions over how to handle these devices were never properly settled,
> so I recommend against merging patch 34 onwards.  As for the rest, I'm not
> planning on any further work, so it may be a good idea for people to
> consider testing them with a view to getting them merged.

The series,
Tested-by: Stephen Warren <swarren@nvidia.com>

(On an NVIDIA Tegra "Jetson TK1" board, with the patches applied on top
of next-20140428, also with Andrew Bresticker's Tegra SDHCI patches
"mmc: tegra: disable UHS modes" and "mmc: tegra: fix reporting of base
clock frequency" applied)
