From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 07/11] mmc: sdhci: Program a relatively accurate SW
 timeout value
Date: Wed, 4 Apr 2018 15:48:15 +0300
Message-ID: <5453e71c-7dde-b305-5e0c-900bf4efe818@intel.com>
References: <20180307132020.30951-1-kishon@ti.com>
 <20180307132020.30951-8-kishon@ti.com>
 <1e87e5f9-13e1-765b-f077-26a55359b2c3@intel.com>
 <47752066-aeda-87bc-6928-1a9b80f1c45c@ti.com>
 <49210daa-b593-4b34-abf5-be81580723bc@intel.com>
 <29f640ac-b155-41c6-cf3f-8c66e1b300f1@ti.com>
 <1905d25f-d16d-50b1-54b0-35807d801a12@intel.com>
 <dacb62d3-086d-27a7-85cf-94916ce464b5@ti.com>
 <27e92e28-08b4-42b1-e4ef-32fa8ac785dc@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------5B1226B4B55F50EA6005BA6E"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <27e92e28-08b4-42b1-e4ef-32fa8ac785dc@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This is a multi-part message in MIME format.
--------------5B1226B4B55F50EA6005BA6E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 20/03/18 11:48, Kishon Vijay Abraham I wrote:
> Hi Adrian,
> 
> On Monday 19 March 2018 03:49 PM, Kishon Vijay Abraham I wrote:
>> Hi Adrian,
>>
>> On Monday 19 March 2018 03:30 PM, Adrian Hunter wrote:
>>> On 19/03/18 11:20, Kishon Vijay Abraham I wrote:
>>>> Hi Adrian,
>>>>
>>>> On Friday 16 March 2018 07:51 PM, Adrian Hunter wrote:
>>>>> On 16/03/18 08:29, Kishon Vijay Abraham I wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Thursday 15 March 2018 06:43 PM, Adrian Hunter wrote:
>>>>>>> On 07/03/18 15:20, Kishon Vijay Abraham I wrote:
>>>>>>>> sdhci has a 10 second timeout to catch devices that stop responding.
>>>>>>>> Instead of programming 10 second arbitrary value, calculate the total time
>>>>>>>> it would take for the entire transfer to happen and program the timeout
>>>>>>>> value accordingly.
>>>>>>>>
>>>>>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>>>>>> ---
>>>>>>>>  drivers/mmc/host/sdhci.c | 47 ++++++++++++++++++++++++++++++++++++++++-------
>>>>>>>>  drivers/mmc/host/sdhci.h | 10 ++++++++++
>>>>>>>>  2 files changed, 50 insertions(+), 7 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>>>>>> index 1dd117cbeb6e..baab67bfa39b 100644
>>>>>>>> --- a/drivers/mmc/host/sdhci.c
>>>>>>>> +++ b/drivers/mmc/host/sdhci.c
>>>>>>>> @@ -709,6 +709,36 @@ static u32 sdhci_sdma_address(struct sdhci_host *host)
>>>>>>>>  		return sg_dma_address(host->data->sg);
>>>>>>>>  }
>>>>>>>>  
>>>>>>>> +static void sdhci_calc_sw_timeout(struct sdhci_host *host,
>>>>>>>> +				  struct mmc_command *cmd,
>>>>>>>> +				  unsigned int target_timeout)
>>>>>>>> +{
>>>>>>>> +	struct mmc_data *data = cmd->data;
>>>>>>>> +	struct mmc_host *mmc = host->mmc;
>>>>>>>> +	u64 transfer_time;
>>>>>>>> +	struct mmc_ios *ios = &mmc->ios;
>>>>>>>> +	unsigned char bus_width = 1 << ios->bus_width;
>>>>>>>> +	unsigned int blksz;
>>>>>>>> +	unsigned int freq;
>>>>>>>> +
>>>>>>>> +	if (data) {
>>>>>>>> +		blksz = data->blksz;
>>>>>>>> +		freq = host->mmc->actual_clock ? : host->clock;
>>>>>>>> +		transfer_time = (u64)blksz * NSEC_PER_SEC * (8 / bus_width);
>>>>>>>> +		do_div(transfer_time, freq);
>>>>>>>> +		/* multiply by '2' to account for any unknowns */
>>>>>>>> +		transfer_time = transfer_time * 2;
>>>>>>>> +		/* calculate timeout for the entire data */
>>>>>>>> +		host->data_timeout = (data->blocks * ((target_timeout *
>>>>>>>> +						       NSEC_PER_USEC) +
>>>>>>>> +						       transfer_time));
>>>>>>>
>>>>>>> (target_timeout * NSEC_PER_USEC) might be 32-bit and therefore overflow
>>>>>>> for timeouts greater than about 4 seconds.
>>>>>>>
>>>>>>>> +	} else {
>>>>>>>> +		host->data_timeout = (u64)target_timeout * NSEC_PER_USEC;
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	host->data_timeout += MMC_CMD_TRANSFER_TIME;
>>>>>>>
>>>>>>> Need to allow for target_timeout == 0 so:
>>>>>>>
>>>>>>> 	if (host->data_timeout)
>>>>>>> 		host->data_timeout += MMC_CMD_TRANSFER_TIME;
>>>>>>>
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>  static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>>>>>>>>  {
>>>>>>>>  	u8 count;
>>>>>>>> @@ -766,6 +796,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>>>>>>>>  		if (count >= 0xF)
>>>>>>>>  			break;
>>>>>>>>  	}
>>>>>>>> +	sdhci_calc_sw_timeout(host, cmd, target_timeout);
>>>>>>>
>>>>>>> If you make the changes I suggest for patch 6, then this would
>>>>>>> move sdhci_calc_sw_timeout() into sdhci_set_timeout().
>>>>>>>
>>>>>>> I suggest you factor out the target_timeout calculation e.g.
>>>>>>>
>>>>>>> static unsigned int sdhci_target_timeout(struct sdhci_host *host,
>>>>>>> 					 struct mmc_command *cmd,
>>>>>>> 					 struct mmc_data *data)
>>>>>>> {
>>>>>>> 	unsigned int target_timeout;
>>>>>>>
>>>>>>> 	/* timeout in us */
>>>>>>> 	if (!data)
>>>>>>> 		target_timeout = cmd->busy_timeout * 1000;
>>>>>>> 	else {
>>>>>>> 		target_timeout = DIV_ROUND_UP(data->timeout_ns, 1000);
>>>>>>> 		if (host->clock && data->timeout_clks) {
>>>>>>> 			unsigned long long val;
>>>>>>>
>>>>>>> 			/*
>>>>>>> 			 * data->timeout_clks is in units of clock cycles.
>>>>>>> 			 * host->clock is in Hz.  target_timeout is in us.
>>>>>>> 			 * Hence, us = 1000000 * cycles / Hz.  Round up.
>>>>>>> 			 */
>>>>>>> 			val = 1000000ULL * data->timeout_clks;
>>>>>>> 			if (do_div(val, host->clock))
>>>>>>> 				target_timeout++;
>>>>>>> 			target_timeout += val;
>>>>>>> 		}
>>>>>>> 	}
>>>>>>>
>>>>>>> 	return target_timeout;
>>>>>>> }
>>>>>>>
>>>>>>> And call it from sdhci_calc_sw_timeout()
>>>>>>>
>>>>>>>>  
>>>>>>>>  	return count;
>>>>>>>>  }
>>>>>>>> @@ -1175,13 +1206,6 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>>>>>>>>  		mdelay(1);
>>>>>>>>  	}
>>>>>>>>  
>>>>>>>> -	timeout = jiffies;
>>>>>>>> -	if (!cmd->data && cmd->busy_timeout > 9000)
>>>>>>>> -		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
>>>>>>>> -	else
>>>>>>>> -		timeout += 10 * HZ;
>>>>>>>> -	sdhci_mod_timer(host, cmd->mrq, timeout);
>>>>>>>> -
>>>>>>>>  	host->cmd = cmd;
>>>>>>>>  	if (sdhci_data_line_cmd(cmd)) {
>>>>>>>>  		WARN_ON(host->data_cmd);
>>>>>>>> @@ -1221,6 +1245,15 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>>>>>>>>  	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
>>>>>>>>  		flags |= SDHCI_CMD_DATA;
>>>>>>>>  
>>>>>>>> +	timeout = jiffies;
>>>>>>>> +	if (host->data_timeout > 0) {
>>>>>>>
>>>>>>> This can be just:
>>>>>>>
>>>>>>> 	if (host->data_timeout) {
>>>>>>>
>>>>>>>> +		timeout += nsecs_to_jiffies(host->data_timeout);
>>>>>>>> +		host->data_timeout = 0;
>>>>>>>
>>>>>>> It would be better to initialize host->data_timeout = 0 at the top of
>>>>>>> sdhci_prepare_data().
>>>>>>>
>>>>>>> Also still need:
>>>>>>>
>>>>>>> 	else if (!cmd->data && cmd->busy_timeout > 9000) {
>>>>>>> 		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
>>>>>>
>>>>>> sdhci_calc_sw_timeout should have calculated the timeout for this case too no?
>>>>>
>>>>> Yes, but I was thinking you would only calculate when it was needed.
>>>>
>>>> I feel since we would have anyways calculated data_timeout, we should use that
>>>> instead unless you see a problem with that.
>>>
>>> I would prefer not to calculate data_timeout when a hardware timeout is
>>> being used.
>>>
>>
>> That differs from what I had thought. This patch tries to program a relatively
>> accurate SW timeout value (for data_timer) irrespective of whether hardware
>> timeout is used or not. This only tries to change the 10 Sec SW timeout value
>> programmed for all data transfer commands.
> 
> IMHO since we calculate the worst case timeout value we should be using that
> for all cases where we are able to calculate the timeout value so that we don't
> give a too high or too low timeout value. Let me know If this sounds okay to you.

I don't want to do the calculation for drivers that don't need it.

How about the 3 patches attached

--------------5B1226B4B55F50EA6005BA6E
Content-Type: text/x-patch;
 name="0001-mmc-sdhci-Add-quirk-to-disable-HW-timeout.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-mmc-sdhci-Add-quirk-to-disable-HW-timeout.patch"

>From 52d36e3bf42d189378603ecdad06ffda601cc545 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Thu, 29 Mar 2018 16:04:14 +0300
Subject: [PATCH 1/3] mmc: sdhci: Add quirk to disable HW timeout

Add quirk to disable HW timeout if the requested timeout is more than the
maximum obtainable timeout.

Also, if the quirk is set and ->get_max_timeout_count() is not implemented,
max_busy_timeout is set to zero.

Based-on-patch-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 38 ++++++++++++++++++++++++++++++++++----
 drivers/mmc/host/sdhci.h |  5 +++++
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3bf6117ee879..5299ea6b5c9c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -709,12 +709,15 @@ static u32 sdhci_sdma_address(struct sdhci_host *host)
 		return sg_dma_address(host->data->sg);
 }
 
-static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
+static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
+			     bool *too_big)
 {
 	u8 count;
 	struct mmc_data *data = cmd->data;
 	unsigned target_timeout, current_timeout;
 
+	*too_big = true;
+
 	/*
 	 * If the host controller provides us with an incorrect timeout
 	 * value, just skip the check and use 0xE.  The hardware may take
@@ -768,9 +771,12 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 
 	if (count >= 0xF) {
-		DBG("Too large timeout 0x%x requested for CMD%d!\n",
-		    count, cmd->opcode);
+		if (!(host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT))
+			DBG("Too large timeout 0x%x requested for CMD%d!\n",
+			    count, cmd->opcode);
 		count = 0xE;
+	} else {
+		*too_big = false;
 	}
 
 	return count;
@@ -790,6 +796,16 @@ static void sdhci_set_transfer_irqs(struct sdhci_host *host)
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
 
+static void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable)
+{
+	if (enable)
+		host->ier |= SDHCI_INT_DATA_TIMEOUT;
+	else
+		host->ier &= ~SDHCI_INT_DATA_TIMEOUT;
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+}
+
 static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	u8 count;
@@ -797,7 +813,17 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	if (host->ops->set_timeout) {
 		host->ops->set_timeout(host, cmd);
 	} else {
-		count = sdhci_calc_timeout(host, cmd);
+		bool too_big = false;
+
+		count = sdhci_calc_timeout(host, cmd, &too_big);
+
+		if (too_big &&
+		    host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT) {
+			sdhci_set_data_timeout_irq(host, false);
+		} else if (!(host->ier & SDHCI_INT_DATA_TIMEOUT)) {
+			sdhci_set_data_timeout_irq(host, true);
+		}
+
 		sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
 	}
 }
@@ -3619,6 +3645,10 @@ int sdhci_setup_host(struct sdhci_host *host)
 		mmc->max_busy_timeout /= host->timeout_clk;
 	}
 
+	if (host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT &&
+	    !host->ops->get_max_timeout_count)
+		mmc->max_busy_timeout = 0;
+
 	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
 	mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c95b0a4a7594..f6555c0f4ad3 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -437,6 +437,11 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
 /* Controller has CRC in 136 bit Command Response */
 #define SDHCI_QUIRK2_RSP_136_HAS_CRC			(1<<16)
+/*
+ * Disable HW timeout if the requested timeout is more than the maximum
+ * obtainable timeout.
+ */
+#define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.9.1


--------------5B1226B4B55F50EA6005BA6E
Content-Type: text/x-patch;
 name="0002-mmc-sdhci-Factor-out-target_timeout-calculation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-mmc-sdhci-Factor-out-target_timeout-calculation.patch"

>From c73df33aa4549301e0b93424990dc16de2b14923 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Wed, 4 Apr 2018 15:14:38 +0300
Subject: [PATCH 2/3] mmc: sdhci: Factor out target_timeout calculation

Factor out the target_timeout calculation so it can be re-used.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 48 ++++++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5299ea6b5c9c..7c0683b8baba 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -709,6 +709,35 @@ static u32 sdhci_sdma_address(struct sdhci_host *host)
 		return sg_dma_address(host->data->sg);
 }
 
+static unsigned int sdhci_target_timeout(struct sdhci_host *host,
+					 struct mmc_command *cmd,
+					 struct mmc_data *data)
+{
+	unsigned int target_timeout;
+
+	/* timeout in us */
+	if (!data) {
+		target_timeout = cmd->busy_timeout * 1000;
+	} else {
+		target_timeout = DIV_ROUND_UP(data->timeout_ns, 1000);
+		if (host->clock && data->timeout_clks) {
+			unsigned long long val;
+
+			/*
+			 * data->timeout_clks is in units of clock cycles.
+			 * host->clock is in Hz.  target_timeout is in us.
+			 * Hence, us = 1000000 * cycles / Hz.  Round up.
+			 */
+			val = 1000000ULL * data->timeout_clks;
+			if (do_div(val, host->clock))
+				target_timeout++;
+			target_timeout += val;
+		}
+	}
+
+	return target_timeout;
+}
+
 static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
 			     bool *too_big)
 {
@@ -732,24 +761,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
 		return 0xE;
 
 	/* timeout in us */
-	if (!data)
-		target_timeout = cmd->busy_timeout * 1000;
-	else {
-		target_timeout = DIV_ROUND_UP(data->timeout_ns, 1000);
-		if (host->clock && data->timeout_clks) {
-			unsigned long long val;
-
-			/*
-			 * data->timeout_clks is in units of clock cycles.
-			 * host->clock is in Hz.  target_timeout is in us.
-			 * Hence, us = 1000000 * cycles / Hz.  Round up.
-			 */
-			val = 1000000ULL * data->timeout_clks;
-			if (do_div(val, host->clock))
-				target_timeout++;
-			target_timeout += val;
-		}
-	}
+	target_timeout = sdhci_target_timeout(host, cmd, data);
 
 	/*
 	 * Figure out needed cycles.
-- 
1.9.1


--------------5B1226B4B55F50EA6005BA6E
Content-Type: text/x-patch;
 name="0003-mmc-sdhci-Program-a-relatively-accurate-SW-timeout-v.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0003-mmc-sdhci-Program-a-relatively-accurate-SW-timeout-v.pa";
 filename*1="tch"

>From 0976d161bfb9c9a35c5176c8059c4ed9a985a0b2 Mon Sep 17 00:00:00 2001
From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Wed, 7 Mar 2018 18:50:16 +0530
Subject: [PATCH 3/3] mmc: sdhci: Program a relatively accurate SW timeout
 value

sdhci has a 10 second timeout to catch devices that stop responding.
In the case of quirk SDHCI_QUIRK2_DISABLE_HW_TIMEOUT, instead of
programming 10 second arbitrary value, calculate the total time it would
take for the entire transfer to happen and program the timeout value
accordingly.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.h | 10 ++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7c0683b8baba..d67ac1bf7caa 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -738,6 +738,39 @@ static unsigned int sdhci_target_timeout(struct sdhci_host *host,
 	return target_timeout;
 }
 
+static void sdhci_calc_sw_timeout(struct sdhci_host *host,
+				  struct mmc_command *cmd)
+{
+	struct mmc_data *data = cmd->data;
+	struct mmc_host *mmc = host->mmc;
+	struct mmc_ios *ios = &mmc->ios;
+	unsigned char bus_width = 1 << ios->bus_width;
+	unsigned int blksz;
+	unsigned int freq;
+	u64 target_timeout;
+	u64 transfer_time;
+
+	target_timeout = sdhci_target_timeout(host, cmd, data);
+	target_timeout *= NSEC_PER_USEC;
+
+	if (data) {
+		blksz = data->blksz;
+		freq = host->mmc->actual_clock ? : host->clock;
+		transfer_time = (u64)blksz * NSEC_PER_SEC * (8 / bus_width);
+		do_div(transfer_time, freq);
+		/* multiply by '2' to account for any unknowns */
+		transfer_time = transfer_time * 2;
+		/* calculate timeout for the entire data */
+		host->data_timeout = data->blocks * target_timeout +
+				     transfer_time;
+	} else {
+		host->data_timeout = target_timeout;
+	}
+
+	if (host->data_timeout)
+		host->data_timeout += MMC_CMD_TRANSFER_TIME;
+}
+
 static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
 			     bool *too_big)
 {
@@ -831,6 +864,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 
 		if (too_big &&
 		    host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT) {
+			sdhci_calc_sw_timeout(host, cmd);
 			sdhci_set_data_timeout_irq(host, false);
 		} else if (!(host->ier & SDHCI_INT_DATA_TIMEOUT)) {
 			sdhci_set_data_timeout_irq(host, true);
@@ -845,6 +879,8 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	u8 ctrl;
 	struct mmc_data *data = cmd->data;
 
+	host->data_timeout = 0;
+
 	if (sdhci_data_line_cmd(cmd))
 		sdhci_set_timeout(host, cmd);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f6555c0f4ad3..23966f887da6 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -332,6 +332,14 @@ struct sdhci_adma2_64_desc {
 /* Allow for a a command request and a data request at the same time */
 #define SDHCI_MAX_MRQS		2
 
+/*
+ * 48bit command and 136 bit response in 100KHz clock could take upto 2.48ms.
+ * However since the start time of the command, the time between
+ * command and response, and the time between response and start of data is
+ * not known, set the command transfer time to 10ms.
+ */
+#define MMC_CMD_TRANSFER_TIME	(10 * NSEC_PER_MSEC) /* max 10 ms */
+
 enum sdhci_cookie {
 	COOKIE_UNMAPPED,
 	COOKIE_PRE_MAPPED,	/* mapped by sdhci_pre_req() */
@@ -555,6 +563,8 @@ struct sdhci_host {
 	/* Host SDMA buffer boundary. */
 	u32			sdma_boundary;
 
+	u64			data_timeout;
+
 	unsigned long private[0] ____cacheline_aligned;
 };
 
-- 
1.9.1


--------------5B1226B4B55F50EA6005BA6E--
