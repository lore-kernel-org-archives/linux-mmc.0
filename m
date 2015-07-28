From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [RFC PATCH] mmc: Kconfig: Add dependency on GPIOLIB for Arasan
 driver
Date: Tue, 28 Jul 2015 10:30:16 +0200
Message-ID: <55B73D98.70604@xilinx.com>
References: <920802cde8579bdfad47baba85d85212735ed90e.1437745991.git.michal.simek@xilinx.com>
 <55B6A8B8.3040404@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55B6A8B8.3040404@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Weijun Yang <Weijun.Yang@csr.com>, Andrew Bresticker <abrestic@chromium.org>, Jean Delvare <jdelvare@suse.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-mmc@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>, addy ke <addy.ke@rock-chips.com>, Stephen Boyd <sboyd@codeaurora.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Georgi Djakov <gdjakov@mm-sol.com>, Kevin Hao <haokexin@gmail.com>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 07/27/2015 11:55 PM, Scott Branden wrote:
> Hi Michal,
> 
> comment in line
> 
> On 15-07-24 06:53 AM, Michal Simek wrote:
>> The patch "mmc: sdhci-of-arasan: Call OF parsing for MMC"
>> (sha1: 16b23787fc709fe60c5d2bd05927b1a3da33d4e9) introduce new
>> dependency on GPIOLIB which calls mmc_of_parse() ->
>> mmc_gpiod_request_cd() (slot-gpio.c) which calls devm_gpiod_get_index()
>> which returns -ENOSYS.
>>
>> Error log:
>> sdhci-arasan ff160000.sdhci: parsing dt failed (4294967258)
>> sdhci-arasan: probe of ff160000.sdhci failed with error -38
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> This problem is probably in all others drivers.
>> This is one way how this can be solved.
>> Maybe better way is to block return value for cd and wp.
> 
> It appears there is gpio code in sdhci.c as well.  This uses slot-gpio.
> 
> Perhaps a depends on needs to be added to MMC_SDHCI instead?

yes, I know and that's why I did this as RFC. But also not all drivers
calls mmc_of_parse to reach this fault.
Anyway I am happy to send v2 with GPIOLIB dependency for the whole MMC
subsystem.

Thanks,
Michal
