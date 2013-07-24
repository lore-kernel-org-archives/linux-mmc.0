From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH] dma: edma: add device_slave_caps() support
Date: Wed, 24 Jul 2013 03:11:23 -0500
Message-ID: <51EF8C2B.2030409@ti.com>
References: <1374597804-3961-1-git-send-email-joelf@ti.com>
 <51EF8A52.90902@metafoo.de>
Reply-To: joelf@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51EF8A52.90902@metafoo.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Balaji TK <balajitk@ti.com>, Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Rajendra Nayak <rnayak@ti.com>, Sekhar Nori <nsekhar@ti.com>, Koen Kooi <koen@beagleboard.org>, Rob Herring <rob.herring@calxeda.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Jason Kridner <jkridner@beagleboard.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Dan Williams <djbw@fb.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>, Matt Porter <matt@ohporter.com>
List-Id: linux-mmc@vger.kernel.org

On 07/24/2013 03:03 AM, Lars-Peter Clausen wrote:
> On 07/23/2013 06:43 PM, Joel Fernandes wrote:
>> Implement device_slave_caps(). EDMA has a limited number of slots.
>> Slave drivers such as omap_hsmmc will query the driver to make
>> sure they don't pass in more than these many scatter segments.
>>
>> Signed-off-by: Joel Fernandes <joelf@ti.com>
>> ---
>> Vinod, or Dan- If this patch looks ok, can you please merge in for
>> -rc cycle? This patch is required to fix MMC support on AM33xx. This
>> patch is blocking 3 other patches which fix various MMC things. Thanks!
>>
>> Notes:
>> (1) this approach is temporary and only for -rc cycle to fix MMC on
>> AM335x. It will be replace by the RFC series in future kernels:
>> http://www.spinics.net/lists/arm-kernel/msg260094.html
>>
>> (2) Patch depends Vinod's patch at:
>> http://permalink.gmane.org/gmane.linux.kernel/1525112
>>
>>  drivers/dma/edma.c |    9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
>> index 7222cbe..81d5429 100644
>> --- a/drivers/dma/edma.c
>> +++ b/drivers/dma/edma.c
>> @@ -517,6 +517,14 @@ static void edma_issue_pending(struct dma_chan *chan)
>>  	spin_unlock_irqrestore(&echan->vchan.lock, flags);
>>  }
>>  
>> +static inline int edma_slave_caps(struct dma_chan *chan,
>> +	struct dma_slave_caps *caps)
>> +{
>> +	caps->max_sg_nr = MAX_NR_SG;
> 
> Hm, what about the other fields?
> 

Other fields are unused, the max segment size is supposed to be
calculated "given" the address width and burst size. Since these
can't be provided to get_caps, I have left it out for now.
See: https://lkml.org/lkml/2013/3/6/464

Even if it did, the "segment size" itself is unused in the MMC driver
that this is supposed to fix, unlike the "number of segments" which I'm
populating above.

If you know of a better way to populate max segment size, let me know.

Thanks,

-Joel
