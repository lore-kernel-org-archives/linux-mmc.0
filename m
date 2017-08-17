From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFC PATCH 3/7] mmc: sdhci: Add callback to set bus mode
Date: Thu, 17 Aug 2017 11:01:35 +0530
Message-ID: <59b63873-0071-663b-0551-774887ddba90@ti.com>
References: <20170807160142.12134-1-kishon@ti.com>
 <20170807160142.12134-4-kishon@ti.com>
 <c561b463-bf4b-1ad1-e053-19cec6d8fc28@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c561b463-bf4b-1ad1-e053-19cec6d8fc28@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
Cc: nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Adrian,

On Tuesday 15 August 2017 01:08 PM, Adrian Hunter wrote:
> On 07/08/17 19:01, Kishon Vijay Abraham I wrote:
>> Add callback to set bus mode in sdhci library so that the
>> controller driver can perform any bus mode specific configurations
>> in the callback function.
> 
> A quirk isn't needed.  Just hook ->set_ios() e.g.
> 
> 	host->mmc_host_ops.set_ios = sdhci_omap_set_ios;
> 
> Then sdhci_omap_set_ios() can call sdhci_set_ios() and then do the bus mode
> setting.

I'm not adding a quirk here.. but I got your point.

Thanks
Kishon
