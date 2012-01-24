From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 19/31] ARM: amba: vexpress: get rid of private platform
 amba_device initializer
Date: Tue, 24 Jan 2012 14:27:47 +0000
Message-ID: <20120124142747.GJ19798@mudshark.cambridge.arm.com>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
 <E1RoAmA-0005FX-5m@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1RoAmA-0005FX-5m@rmk-PC.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, STEricsson <STEricsson_nomadik_linux@list.st.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 20, 2012 at 09:28:50AM +0000, Russell King - ARM Linux wrote:
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-vexpress/core.h     |   17 -----------------
>  arch/arm/mach-vexpress/ct-ca9x4.c |    8 ++++----
>  arch/arm/mach-vexpress/v2m.c      |   20 ++++++++++----------
>  3 files changed, 14 insertions(+), 31 deletions(-)

Looks good to me, and I've boot-tested it on my board as well.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
