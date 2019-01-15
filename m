From: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH V7 2/2] mmc: tegra: HW Command Queue Support for Tegra SDMMC
Date: Tue, 15 Jan 2019 11:10:46 +0800
Message-ID: <CABOV4+UkA48Jc9hTSkM=cEoH0zktmjazrcWVZZ1LMqRXSdjVuA@mail.gmail.com>
References: <1546457808-18270-1-git-send-email-skomatineni@nvidia.com>
 <1546457808-18270-3-git-send-email-skomatineni@nvidia.com>
 <5722018a-7654-c6f9-c2aa-2817b39b1a35@intel.com> <BN7PR12MB2836750BAFFAEAF8436C7C58C2850@BN7PR12MB2836.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BN7PR12MB2836750BAFFAEAF8436C7C58C2850@BN7PR12MB2836.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Chunyan Zhang <chunyan.zhang@unisoc.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 11, 2019 at 8:58 AM Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> >> +static int sdhci_tegra_add_host(struct sdhci_host *host) {
> >> +    struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >> +    struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> >> +    struct cqhci_host *cq_host;
> >> +    bool dma64;
> >> +    int ret;
> >> +
> >> +    if (!tegra_host->enable_hwcq)
> >> +            return sdhci_add_host(host);
> >> +
> >> +    host->v4_mode = true;
> >
> >Can you use sdhci_enable_v4_mode() here?
>
> Hi Adrian,
> sdhci_read_caps sets v4 mode thru sdhci_do_enable_v4_mode if v4_mode is true
> sdhci_setup_host calls sdhci_read_caps so I was setting v4_mode to true so v4 mode gets enabled during read caps.
>

Hi sowjanya,

I also would suggest to use sdhci_enable_v4_mode() instead of setting
host->v4_mode directly.
Enabling v4_mode in read caps was just because that I was worried
about v4 mode would be cleared after reset all on some controllers. If
that's not the case for all sd host controllers, I guess it can be
removed.

Thanks,
Chunyan
