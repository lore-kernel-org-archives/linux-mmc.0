From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/3] mmc: sdhci: sdhci-pci-o2micro: Check if controller
 supports 8-bit width
Date: Thu, 13 Jun 2019 11:40:14 +0300
Message-ID: <94fa2a5e-e96d-acb3-46c2-5f6b1dea6711@intel.com>
References: <20190610185354.35310-1-rrangel@chromium.org>
 <20190610185354.35310-2-rrangel@chromium.org>
 <d4939761-317c-ee78-b1e5-c2cdd86a12b4@intel.com>
 <20190612150832.GB27989@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190612150832.GB27989@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Raul Rangel <rrangel@chromium.org>
Cc: linux-mmc@vger.kernel.org, ernest.zhang@bayhubtech.com, djkurtz@chromium.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 12/06/19 6:08 PM, Raul Rangel wrote:
> On Wed, Jun 12, 2019 at 04:09:47PM +0300, Adrian Hunter wrote:
>> On 10/06/19 9:53 PM, Raul E Rangel wrote:
>>> The O2 controller supports 8-bit EMMC access. mmc_select_bus_width()
>>> will be used to determine if the MMC supports 8-bit or 4-bit access.
>>
>> The problem is that the bit indicates a host controller capability, not how
>> many data lines there actually are on the board.  Will this break something
>> that does not have 8 lines?
> 
> So I asked the controller vendor about that:
>> The capability shows the host controller can support 1,4,and 8 bit bus
>> data transfer but it also depends on if HW can support it. Driver or FW
>> should implement the bus testing procedure that is defined in A.6.3.a
>> in JESD84-B51 spec to decide the real bus width that is supported in HW.
> 
> This seems to be what `mmc_select_bus_width()` is doing.

Good point.  Can you add this information to the commit message and add a
comment in the code.

> 
> I don't actually have any 4-bit hardware to test with though.
> 
> Thanks for the review!
> 
