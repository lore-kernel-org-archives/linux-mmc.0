From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v1 3/5] ARM: imx28evk: add mmc dt support
Date: Tue, 13 Mar 2012 12:45:02 -0500
Message-ID: <4F5F879E.4030407@gmail.com>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com> <1331628428-24017-4-git-send-email-b29396@freescale.com> <4F5F5C22.1080506@gmail.com> <20120313165214.GO26642@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120313165214.GO26642@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>, Dong Aisheng <b29396@freescale.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vinod.koul@linux.intel.com, rob.herring@calxeda.com, grant.likely@secretlab.ca, rdunlap@xenotime.net, kernel@pengutronix.de, cjb@laptop.org, shawn.guo@freescale.com
List-Id: linux-mmc@vger.kernel.org

On 03/13/2012 11:52 AM, Sascha Hauer wrote:
> On Tue, Mar 13, 2012 at 09:39:30AM -0500, Rob Herring wrote:
>> On 03/13/2012 03:47 AM, Dong Aisheng wrote:
>>> From: Dong Aisheng <dong.aisheng@linaro.org>
>>>
>>> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
>>> ---
>>>  arch/arm/boot/dts/imx28-evk.dts |   14 ++++++++++++++
>>>  arch/arm/boot/dts/imx28.dtsi    |   33 +++++++++++++++++++++++++++++++++
>>>  arch/arm/mach-mxs/imx28-dt.c    |    2 ++
>>>  3 files changed, 49 insertions(+), 0 deletions(-)
>>
>> snip
>>
>>> diff --git a/arch/arm/mach-mxs/imx28-dt.c b/arch/arm/mach-mxs/imx28-dt.c
>>> index 78d1129..429b88e 100644
>>> --- a/arch/arm/mach-mxs/imx28-dt.c
>>> +++ b/arch/arm/mach-mxs/imx28-dt.c
>>> @@ -23,6 +23,8 @@ static const struct of_dev_auxdata imx28_auxdata_lookup[] __initconst = {
>>>  	OF_DEV_AUXDATA("arm,pl011", MX28_DUART_BASE_ADDR, "duart", NULL),
>>>  	OF_DEV_AUXDATA("fsl,imx28-fec", MX28_ENET_MAC0_BASE_ADDR, "imx28-fec.0", NULL),
>>>  	OF_DEV_AUXDATA("fsl,imx28-fec", MX28_ENET_MAC1_BASE_ADDR, "imx28-fec.1", NULL),
>>> +	OF_DEV_AUXDATA("fsl,imx28-mmc", MX28_SSP0_BASE_ADDR, "mxs-mmc.0", NULL),
>>> +	OF_DEV_AUXDATA("fsl,imx28-mmc", MX28_SSP1_BASE_ADDR, "mxs-mmc.1", NULL),
>>
>> Why is this needed?
> 
> These are needed for the drivers which have still the mxs-mmc.* names
> to find their clocks. Alternatively we could also add the appropriate
> clocks to the clock file. Don't know if that's better though.

Ah, yes I should have known that... If clk lookup is all that's needed,
I'd suggest adding the necessary clk lookups either here or in the clock
code. Not much difference, but at least it removes the use of
*_BASE_ADDR defines.

Rob
