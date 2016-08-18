From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH RFC 1/3] DT: bindings: mmc: Add property for 3.3V only
 support
Date: Thu, 18 Aug 2016 15:25:35 +0300
Message-ID: <8f87c885-3c55-cac8-a9f5-e121ae031f90@intel.com>
References: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
 <1470488140-10104-2-git-send-email-stefan.wahren@i2se.com>
 <20160810184451.GA13473@rob-hp-laptop>
 <853617027.179290.63a6f478-ad48-40c8-82ca-760dd1afc040.open-xchange@email.1und1.de>
 <CAL_JsqJ09hXYrp_pgAw9FXrBv+=grkm_zip6qB9XefujPECTxQ@mail.gmail.com>
 <468a6704-a9f0-1715-ff64-9e331a6a80b1@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <468a6704-a9f0-1715-ff64-9e331a6a80b1@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Rob Herring <robh@kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Marek Vasut <marex@denx.de>, Otavio Salvador <otavio@ossystems.com.br>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Holger Schurig <holgerschurig@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 11/08/16 03:48, Shawn Lin wrote:
> + Adrian
> 
> Let's queue Adrian here who now maintains SDHCI stuff.

SDHCI drivers may not implement no-1-8-v in a consistent manner, but as far
as I can see, the meaning is still clear: 1.8V will not be used for either
supply or signaling.

SDHCI is complicated because the SDHCI specification does not cover eMMC.
>From the perspective of SDHCI, the only 1.8V modes are the UHS-I modes, so
support for 1.8V signaling is the same as support for one of those modes
(the spec even says as much).  But what happens is that the host controller
can support those modes but the board can't supply 1.8V so the drivers
remove capability for the modes.  Support for 1.8V supply has a capability
bit which drivers can override if necessary but removable SD cards don't
support 1.8V supply anyway, so the issue doesn't arise if the host
controller is only used for uSD cards.

> 
> On 2016/8/11 5:39, Rob Herring wrote:
>> On Wed, Aug 10, 2016 at 3:27 PM, Stefan Wahren <stefan.wahren@i2se.com>
>> wrote:
>>> Hi,
>>>
>>>> Rob Herring <robh@kernel.org> hat am 10. August 2016 um 20:44 geschrieben:
>>>>
>>>>
>>>> On Sat, Aug 06, 2016 at 12:55:38PM +0000, Stefan Wahren wrote:
>>>>> Currently there is no proper way to define that a MMC host supports
>>>>> only 3.3V. The property no-1-8-v is broken and has different meanings
>>>>> for different sdhci variants. So add a new property for 3.3V only
>>>>> support and mark no-1-8-v as deprecated.
>>>>
>>>> Why is it broken?
>>>
>>> i want to quote Ulf Hansson here [1]:
>>>
>>>   The problem with the "no-1-8-v" binding is that it's describing what
>>>   the hardware *can't* do. It thus becomes easy to abuse it.
>>
>> Sounds like a quirk which is perfectly normal for a property. I'd
>> agree it should be what the h/w *can* do if h/w didn't have capability
>> bit that does that.
>>
>>>   I suggest we stop using it, we should mark it deprecated.
>>>
>>> [1] - http://www.spinics.net/lists/linux-mmc/msg34604.html
>>>
>>>> How would I override a controller saying 1.8V is
>>>> supported and it is not?
>>>
>>> Sorry, i'm not sure that i understand your question. In case a board or a
>>> MMC
>>> controller doesn't support 1.8V, it usually supports only 3.3V which is the
>>> intension of this patch.
>>
>> Some controllers have capability bits saying what voltages they
>> support, right? And those bits can be wrong (unless firmware sets them
>> I'd expect that is the common case) which as I read it is what
>> "no-1-8-v" was for. So with the "mmc-ddr-*v" properties, what does not
>> present mean and how do they relate to controller capability bits? I
>> assume they would override the controller bits, but you can only
>> override the capability bit not set case. I would think the property
>> not present means use the capability bit, not that that voltage is not
>> supported. I think you probably need tri-state properties here where
>> value 1 means supported, 0 means not supported, and not present means
>> use capability bit (or other method).
>>
>> Rob
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 
