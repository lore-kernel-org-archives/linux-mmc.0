From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH V2 6/6] mmc: mmci: replace blksz_datactrlXX by
 get_datactrl_cfg callback
Date: Thu, 7 Mar 2019 16:46:49 +0000
Message-ID: <20190307164649.ywhgdikxf4nhb2sd@shell.armlinux.org.uk>
References: <1551976742-4358-1-git-send-email-ludovic.Barre@st.com>
 <1551976742-4358-7-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1551976742-4358-7-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Mar 07, 2019 at 05:39:02PM +0100, Ludovic Barre wrote:
> -	if (data->flags & MMC_DATA_READ)
> -		datactrl |= MCI_DPSM_DIRECTION;

Given that this is currently an invariant between all, it doesn't make
sense to have a separate public function and combine it into the
get_datactrl_cfg() implementations.  You may as well leave it in place
here, after you call get_datactrl_cfg().

> +	datactrl = host->ops->get_datactrl_cfg(host);

Otherwise, I don't see a problem with this, although it would be nice to
avoid the overhead of so many public functions, which could be done by
adding them as inline functions in mmci.h

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
