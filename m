From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 07/25] mmc: sdhci-pci: Use ACPI DSM to get driver strength
 for some Intel devices
Date: Wed, 19 Apr 2017 15:58:57 +0300
Message-ID: <d3a52420-e8f1-90dd-af8d-d12e18171f01@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
 <1490032253-6030-8-git-send-email-adrian.hunter@intel.com>
 <20170404084847.GB1439@katana>
 <47372fbd-9c16-725a-7f25-97481f09a6eb@intel.com>
 <20170419122419.GA3832@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:8548 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763389AbdDSNEq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Apr 2017 09:04:46 -0400
In-Reply-To: <20170419122419.GA3832@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

On 19/04/17 15:24, Wolfram Sang wrote:
> 
>>> do you think it makes sense then to have a similar encoded value from DT
>>> (maybe "mmc-fixed-driver-type-<n>" with n=0..4)?
>>
>> The _DSM, being a device-specific method does not have to support different
>> devices with different requirements whereas DT does.
> 
> So, it is more like a vendor specific property (e.g. "renesas,
> mmc-driver-type")? Sorry, I don't know much about ACPI.

Yes, it is effectively vendor-specific in this case.

