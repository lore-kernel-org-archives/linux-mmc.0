From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH 0/2] mmc: mmci: add quirk property to add stm32 transfer
 mode
Date: Thu, 21 Feb 2019 10:27:39 +0000
Message-ID: <20190221102739.cc37au6elqu6gvfe@shell.armlinux.org.uk>
References: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Feb 21, 2019 at 11:10:49AM +0100, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch series introduces a bitmap of hardware quirks that require
> some special action. This should reduce the number of boolean
> into variant structure. 
> And adds quirk bit to define sdmmc specific transfer modes.

Please find some other way to deal with these differences.  As far as
I'm concerned, introducing a quirk bitmask such as what was done in
sdhci is a complete disaster and leads to long-term maintanability
problems.

We already have a way to deal with variants in mmci.

> 
> Ludovic Barre (2):
>   mmc: mmci: introduce a quirks property into variant struct
>   mmc: mmci: add quirk property to add stm32 transfer mode
> 
>  drivers/mmc/host/mmci.c | 11 +++++++++++
>  drivers/mmc/host/mmci.h |  9 +++++++++
>  2 files changed, 20 insertions(+)
> 
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
