From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH 1/2] mmc: sdhci: add quirk
 SDHCI_QUIRK2_BROKEN_SDMA_BOUNDARY_BUFFER
Date: Mon, 17 Jul 2017 17:50:26 +0100
Message-ID: <08df140f-0630-f7ce-3e1a-9837f24e1796@linaro.org>
References: <20170628133504.17422-1-srinivas.kandagatla@linaro.org>
 <20170628133504.17422-2-srinivas.kandagatla@linaro.org>
 <CAPDyKFq-wnu2=9TqKBLGEEmbbqVLDKQ+rht8X2j8quNtuMzn9A@mail.gmail.com>
 <2440f065-ccd4-4575-4443-2acd1c23d6c4@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <2440f065-ccd4-4575-4443-2acd1c23d6c4@intel.com>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



On 17/07/17 13:47, Adrian Hunter wrote:
>> This change seems like a reasonable justification for adding a new
>> SDHCI quirk, even if we in general wants to avoid that.
>>
>> Adrian?
> If we add a quirk for every register we end up with a very ugly version of
> CONFIG_MMC_SDHCI_IO_ACCESSORS.  So CONFIG_MMC_SDHCI_IO_ACCESSORS is a better
> option.  Another possibility is to add a member to struct sdhci_host,
> initialized to SDHCI_DEFAULT_BOUNDARY_ARG, and write that.  Drivers could
> then change the value if necessary.
Second option seems to be better one. I will give it a try and see!

thanks,
srini
