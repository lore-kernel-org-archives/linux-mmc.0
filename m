From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: core: Do not hold re-tuning during CMD6 commands
Date: Tue, 28 Mar 2017 12:01:33 +0300
Message-ID: <a0df1a1d-a776-f1e6-1ee2-e66faff375d3@intel.com>
References: <1490336341-22292-1-git-send-email-chaotian.jing@mediatek.com>
 <1490336341-22292-2-git-send-email-chaotian.jing@mediatek.com>
 <13a83728-0031-5683-c371-4b517df32299@intel.com>
 <1490344369.22814.10.camel@mhfsdcap03>
 <03d54000-9ced-1b31-df80-d254f02433db@intel.com>
 <1490348427.22814.19.camel@mhfsdcap03>
 <CAPDyKFoo5sJ2XtjyiW1DLjhFdJySbDK7+N05vrKpeiZsp25qrA@mail.gmail.com>
 <1490578500.22814.31.camel@mhfsdcap03>
 <CAPDyKFoWyVrdk7bG1n=rTSOddvqaj-uTO70QoGmcKQK1Fhio2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFoWyVrdk7bG1n=rTSOddvqaj-uTO70QoGmcKQK1Fhio2w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>
Cc: srv_heupstream <srv_heupstream@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 28/03/17 11:30, Ulf Hansson wrote:
> [...]
> 
>>>
>>> If there is a problem in __mmc_switch(), let's try to fix it there first.
>>>
>> Anyway, it is a bug of retry 3 times at max but without check current
>> card status and ensure it's in transfer state before next retry.
> 
> Correct. Do you want to send a patch that fixes this? Otherwise I can do it...
> 
>>>>>> I think the purpose of "re-tune" is trying to cover particular case(eg.
>>>>>> voltage fluctuate or EMI or some glitch of host/device which caused CRC
>>>>>> error)
>>>>>
>>>>> No, re-tuning is to compensate for drift caused primarily by temperature change.
>>>>>
>>>> Yes, by JEDEC spec, temperature change cause timing drift of EMMC
>>>> device, but, as you mentioned, maybe I have a hardware problem of host,
>>>> but needs Software to cover it. so that we are doing our best to do
>>>> re-tune if got CRC error. if could recover it, then  it's better than
>>>> system hung.
>>>
>>> Exactly in what cases do you get CRC errors for CMD6. We need a full
>>> cmd log to understand and to help.
>>>
>>>>>> error) , but in such cases, too many cases are disable re-tune function
>>>>>> by mmc_retune_hold(), for example, in this case, if a response CRC error
>>>>>> got then we never have chance to recover it. then cause system cannot
>>>>>> access emmc or suspend/resume fail.
>>>>>
>>>>> Maybe you have a hardware problem.
>>>
>>> There is no way I am going to accept patches touching this part of the
>>> mmc core, without providing real evidence for how it solves a problem.
>>> To me, it seems like you are applying a workaround for another issue.
>>>
>>> Again, try to provide us with some more data and logs, then perhaps we
>>> can help narrow down the issues.
>>>
>>> Kind regards
>>> Uffe
>>
>> Below is the fail log of suspend fail.
>> the normal command tune result should be 0xffffff9ff, but some time, we
>> get the tune result of 0xffffffff, then we choose the 10 as the best
>> tune parameter, which is not stable.
>> I know that we should focus on why we get the result of 0xffffffff, this
>> may be result of device/host timing shifting while tuning. but what I
>> want to do is that when get a response CRC error, we can do re-tune to
>> recovery it, but not only return the -84 and cause suspend fail
>> eventually. if all hardware are perfect, then we don't need the re-tune
>> mechanism.
> 
> Thanks for elaborating!
> 
> Can you please also tell exactly which of the CMD6 commands in the
> suspend sequence that is triggering this problem? Cache flush? Power
> off notification?
> 
>>
>> as Adrian's comment, if temperature change at here caused CMD6 response
>> CRC error, then how to recovery it ?
> 
> So in your case, allowing re-tuning a little longer in __mmc_switch()
> solves your problem. Clearly there are cases when we need to prevent
> re-tuning when sending CMD6, however maybe not in all cases as we do
> today.
> 
> For example it seems reasonable to not hold retuning before sending
> CMD6 for cache flush, but instead it should be sufficient to hold it
> before polling for busy in __mmc_switch().
> 
> Adrian, what's your thoughts on this?

mmc_retune_hold() and mmc_retune_release() are designed to go around a group
of commands, but re-tuning can still be done before the first command. i.e.

	mmc_retune_hold
	<re-tune can happen here>
	cmd A
	<re-tune not allowed here>
	cmd B
	<re-tune not allowed here>
	cmd C
	mmc_retune_release

That is the same in the retry case:

	mmc_retune_hold
	<re-tune can happen here>
	cmd A
	<re-tune not allowed here>
	retry cmd A
	<re-tune not allowed here>
	cmd B
	<re-tune not allowed here>
	cmd C
	mmc_retune_release

The retry mechanism provided by mmc_wait_for_cmd() and friends really only
makes sense for simple commands.  In other cases, like this, we need to
consider what state the card is in.  For __mmc_switch we need to consider
whether the card is busy or whether a timing change been made.

> 
>>
>> [  129.106622]  (0)[96:mmcqd/0]mtk-msdc 11230000.mmc: phase:
>> [map:fffff9ff] [maxlen:21] [final:21] -->current result is OK and 21 is
>> stable
>> [  129.109404]  (0)[96:mmcqd/0]mtk-msdc 11230000.mmc: phase:
>> [map:ffffe03f] [maxlen:19] [final:22]
>> --------------------> below is next resume and re-init card:
>> [  129.778454]  (0)[96:mmcqd/0]mtk-msdc 11230000.mmc: Regulator set
>> error -22: 3300000 - 3300000
>> [  130.016987]  (0)[96:mmcqd/0]mtk-msdc 11230000.mmc: phase:
>> [map:ffffffff] [maxlen:32] [final:10] --> this result if not OK and 10
>> is not stable.
> 
> As you suspect the tuning didn't work out correctly, then why don't
> you retry one more time?

Or restore the previously known good result?

> 
>> [  130.019556]  (0)[96:mmcqd/0]mtk-msdc 11230000.mmc: phase:
>> [map:ffffc03f] [maxlen:18] [final:23]
>> [  130.124279]  (1)[1248:system_server]mmc0: cache flush error -84
>> [  130.125058]  (1)[1248:system_server]dpm_run_callback():
>> mmc_bus_suspend+0x0/0x4c returns -84
>> [  130.126104]  (1)[1248:system_server]PM: Device mmc0:0001 failed to
>> suspend: error -84
>>
>>
>>
> 
> Kind regards
> Uffe
> 
