From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: Devicetree: Initialization order of mmc block devices?
Date: Fri, 20 Jul 2012 13:30:48 +0200
Message-ID: <50094168.2090900@de.bosch.com>
References: <5006571A.7060103@de.bosch.com>	<CAJe_ZhcY78ah81zsfwXxE=bMG4o6v9RwZV_DQyUj7g=d-1hR_w@mail.gmail.com>	<50068696.8070408@de.bosch.com>	<CAJe_Zhfmn4dUHk6xtudwCEurigvX64xce3VAozdjDdpSWSbRkA@mail.gmail.com>	<5006C40D.300@de.bosch.com>
 <CAJe_Zhcyug17ZnKtmKnVhHT=Mm1PKdE68f21WWkUVtfCwNxSwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAJe_Zhcyug17ZnKtmKnVhHT=Mm1PKdE68f21WWkUVtfCwNxSwg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jassi Brar <jaswinder.singh@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Wohlrab Knut (CM-AI/PJ-CA31)" <Knut.Wohlrab@de.bosch.com>
List-Id: linux-mmc@vger.kernel.org

On 19.07.2012 22:45, Jassi Brar wrote:
> On 18 July 2012 19:41, Knut Wohlrab <knut.wohlrab@de.bosch.com> wrote:
>> On 07/18/2012 03:47 PM, Jassi Brar wrote:
>>> On 18 July 2012 15:19, Knut Wohlrab <knut.wohlrab@de.bosch.com> wrote:
>>>
>>>> If a SD card is inserted at boot time, its "mmcblk0", the embedded
>>>> MMC (eMMC) device "mmcblk1".  This makes it difficult to give the kernel
>>>> the
>>>> correct device for the eMMC root file system ("root=/dev/mmcblk?p1 ...").
>>>>
>>> How about  root=UUID=<eMMC-partition>  ?
>> Because we are talking about an embedded device, it is very difficult to get
>> a UUID of a eMMC partition into kernel command line with U-Boot. Handling of
>> UUID is also a big effort at board manufacturing.
>>
> I don't realize how bad is it if a common UUID is used on each cloned
> eMMC(non-removable) of every instance of a device. But of course only
> you know what's best for your product.
> 
>> This problem can occur on many devices with embedded MMC and removable SD,
>> e.g. smart phones. So I think we should find an solution to define MMC scan
>> order or device number/name in a device tree.
>>
> I assume your issue is that due to async nature of mmc scanning, the
> eMMC is detected later than external card, despite being the probe for
> eMMC's slot initiated first ?
> If so, we can do by simply associating 'N' of 'mmcblkN' with the slot
> index i.e, mmc_host.index (instead of mmc_blk_data.name_idx). Which is
> always in the order of probe calling. And we don't need to modify, or
> expect more of, DT for that.

Do you mean something like

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1536,7 +1536,7 @@ static struct mmc_blk_data 
*mmc_blk_alloc_req(struct mmc_card *card,
          */

         snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
-                "mmcblk%d%s", md->name_idx, subname ? subname : "");
+                "mmcblk%d%s", card->host->index, subname ? subname : "");

         blk_queue_logical_block_size(md->queue.queue, 512);
         set_capacity(md->disk, size);

?

A first quick test looks promising. We will go on testing this.

> Though I suspect there must be some
> serious reason why it's not already done that way.

Anybody with an idea? Any serious reason?

Many thanks and best regards

Dirk
