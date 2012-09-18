From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Subject: Re: [PATCH] mmc: sh-mmcif: avoid Oops on spurious interrupts
Date: Tue, 18 Sep 2012 17:44:56 +0900
Message-ID: <50583488.1010707@kmckk.co.jp>
References: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com> <20120803050039.GA1614@linux-sh.org> <20120809042844.GF1614@linux-sh.org> <87hasc3bv5.wl%kuninori.morimoto.gx@renesas.com> <874nobqntv.wl%kuninori.morimoto.gx@renesas.com> <20120810123804.GK1614@linux-sh.org> <502DDC97.5080501@kmckk.co.jp> <87wr0us6tg.wl%kuninori.morimoto.gx@renesas.com> <20120820031352.GC25767@linux-sh.org> <87obm6ry98.wl%kuninori.morimoto.gx@renesas.com> <20120820043853.GD25767@linux-sh.org> <87mx1qrx1x.wl%kuninori.morimoto.gx@renesas.com> <5031D9FF.8060801@kmckk.co.jp> <Pine.LNX.4.64.1208220840400.26767@axis700.grange> <50402A0D.7070106@kmckk.co.jp> <50581127.2000003@kmckk.co.jp> <Pine.LNX.4.64.1209180830550.31203@axis700.grange> <50582A8A.10008@kmckk.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <50582A8A.10008@kmckk.co.jp>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Tetsuyuki Kobayashi <koba@kmckk.co.jp>, yusuke.goda.sx@renesas.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello Guennadi

(09/18/2012 05:02 PM), Tetsuyuki Kobayashi wrote:

>>>> (2012/08/22 15:49), Guennadi Liakhovetski wrote:
>>>>> On some systems, e.g., kzm9g, MMCIF interfaces can produce spurious
>>>>> interrupts without any active request. To prevent the Oops, that results
>>>>> in such cases, don't dereference the mmc request pointer until we make
>>>>> sure, that we are indeed processing such a request.
>>>>>
>>>>> Reported-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
>>>>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>>>>> ---
>>>>>
>>>>> Hello Kobayashi-san
>>>>>
>>>>> On Mon, 20 Aug 2012, Tetsuyuki Kobayashi wrote:
>>>>>
>>>>> ...
>>>>>
>>>>>> After applying this patch on kzm9g board, I got this error regarding
>>>>>> eMMC.
>>>>>> I think this is another problem.
>>>>>>
>>>>>>
>>>>>> Unable to handle kernel NULL pointer dereference at virtual address
>>>>>> 00000008
>>>>>> pgd = c0004000
>>>>>> [00000008] *pgd=00000000
>>>>>> Internal error: Oops: 17 [#1] PREEMPT SMP ARM
>>>>>> Modules linked in:
>>>>>> CPU: 1    Not tainted  (3.6.0-rc2+ #103)
>>>>>> PC is at sh_mmcif_irqt+0x20/0xb30
>>>>>> LR is at irq_thread+0x94/0x16c
>>>>>
>>>>> [snip]
>>>>>
>>>>>> My quick fix is below.
>>>>>>
>>>>>> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
>>>>>> index 5d81427..e587fbc 100644
>>>>>> --- a/drivers/mmc/host/sh_mmcif.c
>>>>>> +++ b/drivers/mmc/host/sh_mmcif.c
>>>>>> @@ -1104,7 +1104,15 @@ static irqreturn_t sh_mmcif_irqt(int irq, void
>>>>>> *dev_id)
>>>>>>   {
>>>>>>          struct sh_mmcif_host *host = dev_id;
>>>>>>          struct mmc_request *mrq = host->mrq;
>>>>>> -       struct mmc_data *data = mrq->data;
>>>>>> +       /*struct mmc_data *data = mrq->data; -- this cause null
>>>>>> pointer access*/
>>>>>> +       struct mmc_data *data;
>>>>>> +
>>>>>> +       /* quick fix by koba */
>>>>>> +       if (mrq == NULL) {
>>>>>> +               printk("sh_mmcif_irqt: mrq == NULL:
>>>>>> host->wait_for=%d\n", host->wait_for);
>>>>>> +       } else {
>>>>>> +               data = mrq->data;
>>>>>> +       }
>>>>>>
>>>>>>          cancel_delayed_work_sync(&host->timeout_work);
>>>>>>
>>>>>>
>>>>>> With this patch, there is no null pointer accesses and got this log.
>>>>>>
>>>>>> sh_mmcif_irqt: mrq == NULL: host->wait_for=0
>>>>>> sh_mmcif_irqt: mrq == NULL: host->wait_for=0
>>>>>>    ...
>>>>>>
>>>>>> host->wait_for is 0. it is MMCIF_WAIT_FOR_REQUEST.
>>>>>> There is code such like:
>>>>>>
>>>>>>         host->wait_for = MMCIF_WAIT_FOR_REQUEST;
>>>>>>         host->mrq = NULL;
>>>>>>
>>>>>> So, at the top of sh_mmcif_irqt, if host->wait_for ==
>>>>>> MMCIF_WAIT_FOR_REQUEST,
>>>>>> host->mrq = NULL.
>>>>>> It is too earlier to access mrq->data before checking host->mrq. it may
>>>>>> cause null pointer access.
>>>>>>
>>>>>> Goda-san, could you check this and refine the code of sh_mmcif_irqt?
>>>>>
>>>>> Thanks for your report and a fix. Could you please double-check, whether
>>>>> the below patch also fixes your problem? Since such spurious interrupts
>>>>> are possible I would commit a check like this one, but in the longer run
>>>>> we want to identify and eliminate them, if possible. But since so far
>>>>> these interrupts only happen on 1 board model and also not on all units
>>>>> and not upon each boot, this could be a bit tricky.
>>>>>
>>>>> One more question - is this only needed for 3.7 or also for 3.6 / stable?
>>>>>
>>>>> Thanks
>>>>> Guennadi
>>>>>
>>>>>   drivers/mmc/host/sh_mmcif.c |    4 ++--
>>>>>   1 files changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
>>>>> index 5d81427..82bf921 100644
>>>>> --- a/drivers/mmc/host/sh_mmcif.c
>>>>> +++ b/drivers/mmc/host/sh_mmcif.c
>>>>> @@ -1104,7 +1104,6 @@ static irqreturn_t sh_mmcif_irqt(int irq, void
>>>>> *dev_id)
>>>>>   {
>>>>>       struct sh_mmcif_host *host = dev_id;
>>>>>       struct mmc_request *mrq = host->mrq;
>>>>> -    struct mmc_data *data = mrq->data;
>>>>>
>>>>>       cancel_delayed_work_sync(&host->timeout_work);
>>>>>
>>>>> @@ -1152,13 +1151,14 @@ static irqreturn_t sh_mmcif_irqt(int irq, void
>>>>> *dev_id)
>>>>>       case MMCIF_WAIT_FOR_READ_END:
>>>>>       case MMCIF_WAIT_FOR_WRITE_END:
>>>>>           if (host->sd_error)
>>>>> -            data->error = sh_mmcif_error_manage(host);
>>>>> +            mrq->data->error = sh_mmcif_error_manage(host);
>>>>>           break;
>>>>>       default:
>>>>>           BUG();
>>>>>       }
>>>>>
>>>>>       if (host->wait_for != MMCIF_WAIT_FOR_STOP) {
>>>>> +        struct mmc_data *data = mrq->data;
>>>>>           if (!mrq->cmd->error && data && !data->error)
>>>>>               data->bytes_xfered =
>>>>>                   data->blocks * data->blksz;
>>>>>
>>>>
>>>> I tried this patch. It seems better.
>>>> But I think this still have potential race condition.
>>>> I am afraid that one cpu enter sh_mmcif_irqt and other cpu write to
>>>> host->wait_for for new request at the same time.
>>>> How about add this code at the top of sh_mmcif_irqt or before returning
>>>> IRQ_WAKE_THREAD in sh_mmcif_intr ?
>>>>
>>>>      if (host->state == STATE_IDLE)
>>>>          return IRQ_HANDLED;
>>>>
>>>> I will rebase my test environment to v3.6-rc3 or later. Then I will
>>>> send you my .config.
>>>>
>>> How is this?
>>> I hope this fixed in v3.6.
>>
>> Sorry, I still haven't come round to looking at this. I think, one thing 
>> could halp, if you could try to find out what exactly those spurious 
>> interrupts look like, i.e., what's their interrupt status? You could try 
>> to print like
>>
>> diff -u a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
>> --- a/drivers/mmc/host/sh_mmcif.c
>> +++ b/drivers/mmc/host/sh_mmcif.c
>> @@ -1229,6 +1229,10 @@
>>  		host->sd_error = true;
>>  		dev_dbg(&host->pd->dev, "int err state = %08x\n", state);
>>  	}
>> +	if (host->state == STATE_IDLE) {
>> +		dev_info(&host->pd->dev, "Spurious IRQ status 0x%x", state);
>> +		return IRQ_HANDLED;
>> +	}
>>  	if (state & ~(INT_CMD12RBE | INT_CMD12CRE)) {
>>  		if (!host->dma_active)
>>  			return IRQ_WAKE_THREAD;
>>
>> Please, let me know, if it's not very easy for you ATM to perform the 
>> test, I'll try to do it myself then.
> 
> OK. It is easy for me.
> I got this log after mounting /dev/mmcblk2p1 (on eMMC) and executing
> tar command to make file accesses.
> This is based on v3.6-rc6.
> 
> [  149.968750] EXT4-fs (mmcblk2p1): warning: maximal mount count reached, running e2fsck is recommended
> [  150.296875] EXT4-fs (mmcblk2p1): mounted filesystem with ordered data mode. Opts: (null)
> [  221.539062] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
> [  221.585937] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
> [  222.039062] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
> [  222.226562] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
> [  222.382812] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
> [  223.109375] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
> [  223.406250] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
> [  223.734375] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
> [  223.750000] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
> [  224.398437] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
> [  230.289062] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
> 
It might too earlier to report. I got this log.

[  149.968750] EXT4-fs (mmcblk2p1): warning: maximal mount count reached, running e2fsck is recommended
[  150.296875] EXT4-fs (mmcblk2p1): mounted filesystem with ordered data mode. Opts: (null)
[  221.539062] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
[  221.585937] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
[  222.039062] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
[  222.226562] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
[  222.382812] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
[  223.109375] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
[  223.406250] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
[  223.734375] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
[  223.750000] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
[  224.398437] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
[  230.289062] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
[  998.554687] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1063.695312] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1663.203125] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1675.007812] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1683.898437] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1684.187500] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1684.343750] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1686.390625] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1687.843750] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1687.921875] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1687.976562] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1692.101562] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1692.281250] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1692.476562] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1692.960937] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1693.062500] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1696.195312] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1702.140625] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3800000
[ 1702.148437] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1719.453125] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1719.476562] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1721.171875] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3800000
[ 1721.171875] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1721.484375] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1721.507812] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1721.781250] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1721.804687] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1721.828125] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1721.851562] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1722.171875] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1723.437500] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1723.453125] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1723.484375] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1723.507812] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1723.531250] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x3000000
[ 1934.296875] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
[ 1935.125000] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000
[ 1968.226562] sh_mmcif sh_mmcif.0: Spurious IRQ status 0x7400000


After that, I tried the same thing without DMA by comment out like this.
In this case spurious IRQ never occurred. 

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board
index 765f60a..d5e6609 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -389,8 +389,8 @@ static struct resource sh_mmcif_resources[] = {
 static struct sh_mmcif_plat_data sh_mmcif_platdata = {
        .ocr            = MMC_VDD_165_195,
        .caps           = MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
-       .slave_id_tx    = SHDMA_SLAVE_MMCIF_TX,
-       .slave_id_rx    = SHDMA_SLAVE_MMCIF_RX,
+       /*.slave_id_tx  = SHDMA_SLAVE_MMCIF_TX,*/
+       /*.slave_id_rx  = SHDMA_SLAVE_MMCIF_RX,*/
 };



