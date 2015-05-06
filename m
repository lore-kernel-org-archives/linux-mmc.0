From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v5 1/1] arm64: dts: Add the arasan sdhc nodes in
 apm-storm.dtsi.
Date: Wed, 6 May 2015 14:41:54 +0200
Message-ID: <554A0C12.7080702@xilinx.com>
References: <1430817426-5241-1-git-send-email-stripathi@apm.com>
 <4635229.bceBxngCoe@wuerfel> <5549C68B.9090602@xilinx.com>
 <2568634.iEosTvMJpM@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <2568634.iEosTvMJpM@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Michal Simek <michal.simek@xilinx.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Langsdorf <mlangsdo@redhat.com>, Suman Tripathi <stripathi@apm.com>, "jcm@redhat.com" <jcm@redhat.com>, Anton Vorontsov <anton@enomsg.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "chris@printf.net" <chris@printf.net>, "patches@apm.com" <patches@apm.com>, Don Dutile <ddutile@redhat.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 05/06/2015 10:40 AM, Arnd Bergmann wrote:
> On Wednesday 06 May 2015 09:45:15 Michal Simek wrote:
>> On 05/06/2015 09:31 AM, Arnd Bergmann wrote:
>>> On Wednesday 06 May 2015 10:41:07 Suman Tripathi wrote:
>>>>>> @@ -533,6 +567,16 @@
>>>>>>                         interrupts = <0x0 0x4f 0x4>;
>>>>>>                 };
>>>>>>
>>>>>> +               sdhc0: sdhc@1c000000 {
>>>>>> +                       device_type = "sdhc";
>>>>>
>>>>> device_type generally should not be used (there are a few exceptions).
>>>>
>>>> Okay !!
>>>>
>>>
>>> While we're at it, please change sdhc@1c000000 to mmc@1c000000.
>>> Even though Linux does not care, we try to use the standard device
>>> names for consistency.
>>
>> Do we have a list of these names somewhere?
>> Normally I do use ePARP - generic names recommendation but mmc or sdhci
>> are not listed there.
>> Both combination mmc@ or sdhci@ are used in the kernel.
>>
>> On zynq and zynqmp we do use shdci@.
>>
> 
> Ah, I thought ePAPR listed mmc already. Using "sdhci" is a little too
> specific here, since a lot of mmc hosts are not sdhci compliant, and
> "sdhc" is completely wrong, because that identifies a specific card
> type, but a host that supports SDHC cards will generally also work
> with SD (less than 4GB) or SDXC (more than 48GB) cards.

Yes "sdhc" is completely wrong.

Based on our datasheet(also version used on Zynq and ZynqMP) this IP is
compliant with SD HC 3.00, SDIO 3.0, SD MC 3.01 SD MCS 1.01, MMC 4.51.
Not sure about the version which they use.
Also not sure which spec the IP should have to be able to say that we
can use sdhci name. Do you have exact SPEC name?

Thanks,
Michal
