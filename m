From: Aapo Vienamo <avienamo@nvidia.com>
Subject: Re: [PATCH 7/7] arm64: dts: tegra210-p2597: Remove no-1-8-v from
 sdmmc1
Date: Wed, 25 Jul 2018 11:12:59 +0300
Message-ID: <20180725111259.223970b5@dhcp-10-21-25-168>
References: <1532090746-15863-1-git-send-email-avienamo@nvidia.com>
        <1532090746-15863-8-git-send-email-avienamo@nvidia.com>
        <8946636e-5da7-baf1-5390-669f7442e6ff@kapsi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8946636e-5da7-baf1-5390-669f7442e6ff@kapsi.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <cyndis@kapsi.fi>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, 25 Jul 2018 09:58:37 +0300
Mikko Perttunen <cyndis@kapsi.fi> wrote:

> Looks like patch 6 will probably cause tegra-sdhci to start advertising 
> faster modes (see " if (!IS_ERR(host->mmc->supply.vqmmc))" in 
> sdhci-tegra.c). With that patch and this, will the SDHCI core start to 
> try putting us into these higher modes? Clearly that won't work yet 
> before the upcoming patches.

The SDHCI core won't do that yet at this point. The host capability bits
for the higher speed modes are currently masked by tegra_sdhci_reset()
in sdhci-tegra. The modes are unmasked in another patch after everything
that's required to support the modes has been implemented.

 -Aapo
