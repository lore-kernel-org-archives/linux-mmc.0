From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: REGRESSION: [PATCH] mmc: tegra: Use sdhci_pltfm_clk_get_max_clock
Date: Fri, 13 Jul 2018 15:04:13 +0100
Message-ID: <cd24b840-3509-1c03-373b-85026c01b0f7@nvidia.com>
References: <1528126540-27004-1-git-send-email-avienamo@nvidia.com>
 <CAPDyKFoip8gFssftJKzVHD9PAk+j=Z1CTo=0uY9cGASzW8VRJg@mail.gmail.com>
 <1531446183.5479.14.camel@toradex.com>
 <20180713155541.286425e9@dhcp-10-21-25-168>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713155541.286425e9@dhcp-10-21-25-168>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Stefan Agner <stefan.agner@toradex.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org


On 13/07/18 13:55, Aapo Vienamo wrote:
> This happens because sdhci_pltfm_clk_get_max_clock() does not actually
> return the maximum clock rate but the current one, leading to smaller
> clock rates on some platforms. I'll send a patch that fixes this for
> sdhci-tegra. Although this raises the question whether the current
> behaviour of sdhci_pltfm_clk_get_max_clock() is desirable or not.

Agree. There is something not right here. 

Cheers,
Jon

-- 
nvpublic
