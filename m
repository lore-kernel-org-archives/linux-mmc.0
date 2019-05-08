From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data
 hold time problem
Date: Wed, 8 May 2019 08:56:36 +0300
Message-ID: <1c091a34-b678-af8b-fb15-89aca485d3b0@intel.com>
References: <20190506170115.10840-1-scott.branden@broadcom.com>
 <20190506170115.10840-3-scott.branden@broadcom.com>
 <673b3d25-0256-9cd7-c89a-673546e69f3a@intel.com>
 <293b4f12-c74f-35fe-80d7-fdb25405e499@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <293b4f12-c74f-35fe-80d7-fdb25405e499@broadcom.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Branden <scott.branden@broadcom.com>, Ulf Hansson <ulf.hansson@linaro.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Trac Hoang <trac.hoang@broadcom.com>
List-Id: linux-mmc@vger.kernel.org

On 8/05/19 1:46 AM, Scott Branden wrote:
> Hi Adrian,
> 
> On 2019-05-06 11:31 p.m., Adrian Hunter wrote:
>> On 6/05/19 8:01 PM, Scott Branden wrote:
>>> From: Trac Hoang <trac.hoang@broadcom.com>
>>>
>>> The iproc host eMMC/SD controller hold time does not meet the
>>> specification in the HS50 mode.  This problem can be mitigated
>>> by disabling the HISPD bit; thus forcing the controller output
>>> data to be driven on the falling clock edges rather than the
>>> rising clock edges.
>>>
>>> Fixes: f5f968f2371c ("mmc: sdhci-iproc: suppress spurious interrupt with
>>> Multiblock read")
>> Is this fixes tag correct, because it doesn't seem related.  Maybe explain
>> that in the commit message.
> 
> I chose this tag to assist stable kernel maintainers so that the change does
> not produce merge conflicts backporting to older kernel versions.
> 
> In reality, the timing bug existed since the driver was first introduced but
> there is no need for this driver to be supported in kernel versions that old.

You don't need to use the Fixes tag for that.  You can put it on the Cc line
e.g.

Cc: stable@vger.kernel.org # v4.12+

> Do you want me to add such to the commit message?

Yes please.

> 
>>
>>> Signed-off-by: Trac Hoang <trac.hoang@broadcom.com>
>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>> ---
>>>   drivers/mmc/host/sdhci-iproc.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
>>> index 9d4071c41c94..2feb4ef32035 100644
>>> --- a/drivers/mmc/host/sdhci-iproc.c
>>> +++ b/drivers/mmc/host/sdhci-iproc.c
>>> @@ -220,7 +220,8 @@ static const struct sdhci_iproc_data
>>> iproc_cygnus_data = {
>>>     static const struct sdhci_pltfm_data sdhci_iproc_pltfm_data = {
>>>       .quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
>>> -          SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
>>> +          SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 |
>>> +          SDHCI_QUIRK_NO_HISPD_BIT,
>>>       .quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN,
>>>       .ops = &sdhci_iproc_ops,
>>>   };
>>>
> 
