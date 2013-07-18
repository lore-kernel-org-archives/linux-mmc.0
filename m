From: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Subject: Re: =?GB2312?B?u9i4tDogQWJvdXQgb21hcDIgbW1jIGhvc3QgIGNsb3NlIHRvbw==?=
 =?GB2312?B?IGxvbmcgaXJxIGluIGlycWFjdGlvbi4=?=
Date: Thu, 18 Jul 2013 20:14:41 +0530
Message-ID: <51E7FF59.3030000@ti.com>
References: <201307181052572266628@gmail.com>
 <2013071816435162919513@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <2013071816435162919513-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: majianpeng <majianpeng-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, cjb <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thursday 18 July 2013 02:13 PM, majianpeng wrote:
>> Hi all,
>> 	Now i worked on omp2 and met a probelm which someplace close_irq for 3.6second.
>> The kernel version is 2.6.37. I used trace to find in irq_action:omap_hsmmc_irq.
>> This problem occured by removed the sdcard when there are io operations.
>>
>> I found the read problem is in omap_hsmmc_reset_controller_fsm.
>> In omap_hsmmc_reset_controller_fsm:
>>> static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
>>>                                                    unsigned long bit)
>>> {
>>>         unsigned long i = 0;
>>>         unsigned long limit = (loops_per_jiffy *
>>>                                 msecs_to_jiffies(MMC_TIMEOUT_MS));
>>
>>>         OMAP_HSMMC_WRITE(host->base, SYSCTL,
>>>                          OMAP_HSMMC_READ(host->base, SYSCTL) | bit);
>>
>>>         /*
>>>          * OMAP4 ES2 and greater has an updated reset logic.
>>>          * Monitor a 0->1 transition first
>>>          */
>>>         if (mmc_slot(host).features & HSMMC_HAS_UPDATED_RESET) {
>>>                 while ((!(OMAP_HSMMC_READ(host->base, SYSCTL) & bit))
>>>                                        && (i++ < limit))
>>>                         cpu_relax();
>>         }
>> In func, it used loops_per_jiffy  in order to avoid do many time exceed MMC_TIMEOUT_MS.
>> In face oops_per_jiify is like:
>> while(i++ < loops_per_jiffy)
>> 	cpu_relax();
>> But actually, it used as follow:
>>> while ((!(OMAP_HSMMC_READ(host->base, SYSCTL) & bit))
>>>                                       && (i++ < limit))
>> it add some operations like: read regisger, &, &&.
>> So the time may exceed MMC_TIMEOUT_MS.
>> I used those code to test and found it's ok:
>> for (i = 0 ; i < 10; i++){
>> 	if (!(OMAP_HSMMC_READ(host->base, SYSCTL) & bit))
>> 		  break;
>> 	j = limit/10;
>> 	while(j--)
>> 		cpu_relax();
>> }
>>
>> Using this the problom can't occur.
>> Am i missing something?
>>
>> Thanks!
>> Jianpeng Ma
> I do more test and found more interesting things
> 
> static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
>                                                     unsigned long bit)
> {
>        
> 
>          /*
>           * OMAP4 ES2 and greater has an updated reset logic.
>           * Monitor a 0->1 transition first
>           */
>          if (mmc_slot(host).features & HSMMC_HAS_UPDATED_RESET) {
>>                 while ((!(OMAP_HSMMC_READ(host->base, SYSCTL) & bit))
>>                                         && (i++ < limit))
>>                         cpu_relax();
> 	I modify above code as:
> 				while ((!(OMAP_HSMMC_READ(host->base, SYSCTL) & bit)) {
> 							i++;cpu_relax();
> 				}
>   When the problem occur, it  can't return from while.That's mean  the transition was already oocured befroe while.
> So it can't monitor a 0->1 transition.

Hi,

Which OMAP SoC are you testing on (OMAP4 ES2+ ? )

Can you try the below inlined patch

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index eccedc7..7dbc83f 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -973,10 +973,9 @@ static inline void omap_hsmmc_dbg_report_irq(struct omap_hsmmc_host *host,
 static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
 						   unsigned long bit)
 {
-	unsigned long i = 0;
-	unsigned long limit = (loops_per_jiffy *
-				msecs_to_jiffies(MMC_TIMEOUT_MS));
+	unsigned long timeout;

+	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
 	OMAP_HSMMC_WRITE(host->base, SYSCTL,
 			 OMAP_HSMMC_READ(host->base, SYSCTL) | bit);

@@ -985,14 +984,14 @@ static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
 	 * Monitor a 0->1 transition first
 	 */
 	if (mmc_slot(host).features & HSMMC_HAS_UPDATED_RESET) {
-		while ((!(OMAP_HSMMC_READ(host->base, SYSCTL) & bit))
-					&& (i++ < limit))
+		while ((!(OMAP_HSMMC_READ(host->base, SYSCTL) & bit)) &&
+			time_before(jiffies, timeout))
 			cpu_relax();
 	}
-	i = 0;

+	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
 	while ((OMAP_HSMMC_READ(host->base, SYSCTL) & bit) &&
-		(i++ < limit))
+		time_before(jiffies, timeout))
 		cpu_relax();

 	if (OMAP_HSMMC_READ(host->base, SYSCTL) & bit)
-- 
> 
> Thanks!
> Jianpeng Ma
> 
