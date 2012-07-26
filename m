From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: Devicetree: Initialization order of mmc block devices?
Date: Thu, 26 Jul 2012 11:16:43 +0200
Message-ID: <50110AFB.9090300@de.bosch.com>
References: <5006571A.7060103@de.bosch.com>	<CAJe_ZhcY78ah81zsfwXxE=bMG4o6v9RwZV_DQyUj7g=d-1hR_w@mail.gmail.com>	<50068696.8070408@de.bosch.com>	<CAJe_Zhfmn4dUHk6xtudwCEurigvX64xce3VAozdjDdpSWSbRkA@mail.gmail.com>	<5006C40D.300@de.bosch.com>	<CAJe_Zhcyug17ZnKtmKnVhHT=Mm1PKdE68f21WWkUVtfCwNxSwg@mail.gmail.com>	<50094168.2090900@de.bosch.com> <CAJe_Zhfu-k0V7q527JSqdThn_c7WfNcaHmYOwBBaaRh+A=2hKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp2-v.fe.bosch.de ([139.15.237.6]:62891 "EHLO
	smtp2-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab2GZJTe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Jul 2012 05:19:34 -0400
In-Reply-To: <CAJe_Zhfu-k0V7q527JSqdThn_c7WfNcaHmYOwBBaaRh+A=2hKA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Jassi Brar <jaswinder.singh@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Wohlrab Knut (CM-AI/PJ-CA33)" <Knut.Wohlrab@de.bosch.com>

On 20.07.2012 13:56, Jassi Brar wrote:
> On 20 July 2012 17:00, Dirk Behme <dirk.behme@de.bosch.com> wrote:
>> On 19.07.2012 22:45, Jassi Brar wrote:
> 
>>>> This problem can occur on many devices with embedded MMC and removable
>>>> SD,
>>>> e.g. smart phones. So I think we should find an solution to define MMC
>>>> scan
>>>> order or device number/name in a device tree.
>>>>
>>> I assume your issue is that due to async nature of mmc scanning, the
>>> eMMC is detected later than external card, despite being the probe for
>>> eMMC's slot initiated first ?
>>> If so, we can do by simply associating 'N' of 'mmcblkN' with the slot
>>> index i.e, mmc_host.index (instead of mmc_blk_data.name_idx). Which is
>>> always in the order of probe calling. And we don't need to modify, or
>>> expect more of, DT for that.
>>
>> Do you mean something like
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1536,7 +1536,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct
>> mmc_card *card,
>>          */
>>
>>         snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
>> -                "mmcblk%d%s", md->name_idx, subname ? subname : "");
>> +                "mmcblk%d%s", card->host->index, subname ? subname : "");
>>
>>         blk_queue_logical_block_size(md->queue.queue, 512);
>>         set_capacity(md->disk, size);
>>
>> ?
>>
> Exactly!
> It seems too trivial and default for the author to have missed it, so
> I suspect I am overlooking something yet again. I would dig email
> archives to know more about that naming convention before dare submit
> a patch :)

What's about anything like this [1]?

Best regards

Dirk

[1]

---
  drivers/mmc/card/Kconfig |   27 +++++++++++++++++++++++++++
  drivers/mmc/card/block.c |    2 +-
  include/linux/mmc/host.h |    7 +++++++
  3 files changed, 35 insertions(+), 1 deletion(-)

Index: a/drivers/mmc/card/Kconfig
===================================================================
--- a/drivers/mmc/card/Kconfig
+++ b/drivers/mmc/card/Kconfig
@@ -50,6 +50,33 @@ config MMC_BLOCK_BOUNCE

  	  If unsure, say Y here.

+config MMC_SLOTINDEX
+	bool "Use host index for enumerating mmxblkN"
+	depends on MMC_BLOCK
+	default n
+	help
+	  On embedded devices, often there is a combination of
+	  removable mmc devices (e.g. MMC/SD cards) and hard
+	  wired ones (e.g. eMMC). Depending on the hardware
+	  configuration, the 'mmcblkN' node might change if
+	  the removable device is available or not at boot time.
+
+	  E.g. if the removable device is attached at boot time,
+	  it might become mmxblk0. And the hard wired one mmcblk1.
+	  But if the removable device isn't there at boot time,
+	  the hard wired one will become mmcblk0. This makes it
+	  somehow difficult to hard code the root device to the
+	  non-removable device and boot fast.
+
+	  Enabling this option will simply associating 'N' of
+	  'mmcblkN' with the slot index instead of the dynamic
+	  name index. The slot index is always the same, ensuring
+	  that the non-removable mmc device is associated always
+	  with the same mmcblkN. Independent of the availability of
+	  the removable one.
+
+	  If unsure, say N here.
+
  config SDIO_UART
  	tristate "SDIO UART/GPS class support"
  	help
Index: a/drivers/mmc/card/block.c
===================================================================
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1536,7 +1536,7 @@ static struct mmc_blk_data *mmc_blk_allo
  	 */

  	snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
-		 "mmcblk%d%s", md->name_idx, subname ? subname : "");
+		 "mmcblk%d%s", NAMEIDX, subname ? subname : "");

  	blk_queue_logical_block_size(md->queue.queue, 512);
  	set_capacity(md->disk, size);
Index: a/include/linux/mmc/host.h
===================================================================
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -437,4 +437,11 @@ static inline unsigned int mmc_host_clk_
  	return host->ios.clock;
  }
  #endif
+
+#ifdef CONFIG_MMC_SLOTINDEX
+#define NAMEIDX (card->host->index)
+#else
+#define NAMEIDX (md->name_idx)
+#endif
+
  #endif /* LINUX_MMC_HOST_H */
