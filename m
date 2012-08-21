From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Tue, 21 Aug 2012 07:14:20 -0400
Message-ID: <87vcgc5wfn.fsf@octavius.laptop.org>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
	<201208211101.21612.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <201208211101.21612.arnd@arndb.de> (Arnd Bergmann's message of
	"Tue, 21 Aug 2012 11:01:21 +0000")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Aug 21 2012, Arnd Bergmann wrote:
> On Tuesday 21 August 2012, Thomas Abraham wrote:
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt
>> b/Documentation/devicetree/bindings/mmc/mmc.txt
>> index 8a6811f..1aa527a 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
>> @@ -16,6 +16,8 @@ Optional properties:
>>  - wp-inverted: when present, polarity on the wp gpio line is inverted
>>  - non-removable: non-removable slot (like eMMC)
>>  - max-frequency: maximum operating clock frequency
>> +- broken-cd: when present, indicates that the cd-gpios line is not
>> +       connected to the card-detect pad of the MMC host controller.
>
> What is the difference between listing the cd line as broken and
> listing no cd line at all?

I think the documentation's incorrect here -- "broken-cd" should be used
without a cd-gpios node, and tells the driver that there is no working
WP and we'll need to poll the host (SDHCI_QUIRK_BROKEN_CARD_DETECTION):

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 25733ef..23ebdbb 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -198,6 +198,9 @@ static struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct device *dev)
 	if (clk_delay_cycles > 0)
 		pdata->clk_delay_cycles = clk_delay_cycles;
 
+	if (of_find_property(np, "broken-cd", NULL))
+		pdata->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+
 	return pdata;
 }
 #else

So, I'd say:

"- broken-cd: when present, indicates that there is no card-detect
   line available on the host; polling should be used instead."

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
