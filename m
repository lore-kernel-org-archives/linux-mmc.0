From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH V2 1/2] sdhci: register defs for sd 3.0 HOST CONTROL 2
Date: Sun, 2 Jan 2011 10:53:38 -0800
Message-ID: <040140FF-A7E6-48F1-9E7B-E352B5790855@marvell.com>
References: <F78395C7-D00C-4E33-883D-657474EE80EC@marvell.com>
 <20110102182117.GA24820@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:53499 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754488Ab1ABSxl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 2 Jan 2011 13:53:41 -0500
In-Reply-To: <20110102182117.GA24820@void.printf.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>


On Jan 2, 2011, at 10:21 AM, Chris Ball wrote:

> Hi Philip,
> 
> On Sun, Jan 02, 2011 at 08:43:29AM -0800, Philip Rakity wrote:
>> 
>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>> Signed-off-by: Mark F. Brown <markb@marvell.com>
>> ---
>> drivers/mmc/host/sdhci.h |   17 ++++++++++++++++-
>> 1 files changed, 16 insertions(+), 1 deletions(-)
>> 
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 6e0969e..36f3861 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -145,7 +145,22 @@
>> 
>> #define SDHCI_ACMD12_ERR	0x3C
>> 
>> -/* 3E-3F reserved */
>> +#define SDHCI_HOST_CONTROL_2             0x3E
>> +#define SDCTRL_2_UHS_MODE_SEL_SDR12		0x0000
>> +#define SDCTRL_2_UHS_MODE_SEL_SDR25		0x0001
>> +#define SDCTRL_2_UHS_MODE_SEL_SDR50		0x0002
>> +#define SDCTRL_2_UHS_MODE_SEL_SDR104		0x0003
>> +#define SDCTRL_2_UHS_MODE_SEL_DDR50		0x0004
>> +#define SDCTRL_2_UHS_MODE_MASK			7
> 
> 0x0007 for consistency?

want me to resubmit for this ?

> 
>> +#define SDCTRL_2_SDH_V18_EN			0x0008
>> +#define SDCTRL_2_DRV_STRENGTH_SEL_B		0x0000

> Is this really 0?

Yes

> 
>> +#define SDCTRL_2_DRV_STRENGTH_SEL_A		0x0010
> 
> Is A really after B?
> 

Yes

>> +#define SDCTRL_2_DRV_STRENGTH_SEL_C		0x0020
>> +#define SDCTRL_2_DRV_STRENGTH_SEL_D		0x0030
>> +#define SDCTRL_2_EXE_TUNING			0x0040
>> +#define SDCTRL_2_SAMPLING_CLK_SEL		0x0080
>> +#define SDCTRL_2_ASYNC_INT_EN			0x4000
>> +#define SDCTRL_2_PRESET_VAL_EN			0x8000
>> 
>> #define SDHCI_CAPABILITIES	0x40
>> #define  SDHCI_TIMEOUT_CLK_MASK	0x0000003F
> 
> Thanks,
> 
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

