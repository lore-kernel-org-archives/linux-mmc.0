From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V4 2/4] mmc: cqhci: DMA Configuration prior to CQE
Date: Fri, 21 Dec 2018 09:41:22 +0200
Message-ID: <d0d38418-ddd4-b9ab-2951-10207540856b@intel.com>
References: <1545262938-20636-1-git-send-email-skomatineni@nvidia.com>
 <1545262938-20636-3-git-send-email-skomatineni@nvidia.com>
 <b6789159-c4ce-cc28-e7f5-33ab1e95175f@intel.com>
 <BN7PR12MB2836A1467A21CAE50125727AC2BF0@BN7PR12MB2836.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BN7PR12MB2836A1467A21CAE50125727AC2BF0@BN7PR12MB2836.namprd12.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Mikko Perttunen <mperttunen@nvidia.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 20/12/18 11:01 PM, Sowjanya Komatineni wrote:
> Hi Adrian,
> 
> Thank you for the feedback.
> 
>> This doesn't seem to relate to the host controller implementation.  
>> "The device" means the eMMC.
> 
> Yes, setting block size of 512B before enabling command queue is a device specific 
> requirement not host specific. So thought to update in cqhci driver to follow this 
> device specific sequence requirement. This also serves tegra sdhci host strictly
> following this device specific requirement.

Not sure what you mean.  The eMMC block size is set by CMD16.  In fact CMD16
is not used because 512B is the default so it never needs to be changed.

> 
>> We don't want to disable and re-enable in the request function,
>> so that change is not good for controllers that don't have your problem.
>> Another thing to consider is that the block size register may not need to be changed
>> - for example when cqhci is halted to allow a manual discard, the block size register is
>> not updated, so I would expect its value to be unchanged.
> 
> Once block size is set prior to enabling CQE, it stays same till command queue is 
> disabled and I don’t think it needs reconfiguration.
> 
>> There are ways you can solve this in your driver.  
>> You could look at using SDHCI I/O accessors, and/or implement your own ->enable() 
>> instead of calling sdhci_cqe_enable() directly.  Would that be feasible?
> 
> Sure, will provide updated patch that takes care of this inside tegra sdhci host once you 
> confirm that we don’t plan to fix this device specific sequence requirement in cqhci driver.
> 
> -Sowjanya
>  
> 
