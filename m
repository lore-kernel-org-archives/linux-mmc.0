From: Dinh Nguyen <dinguyen@opensource.altera.com>
Subject: Re: [GIT PULL 1/2] SOCFPGA updates for 3.18
Date: Wed, 10 Sep 2014 09:19:18 -0500
Message-ID: <54105DE6.9070807@opensource.altera.com>
References: <1409847105-27241-1-git-send-email-dinguyen@opensource.altera.com>
 <20140909141756.GA30100@amd> <4134101.OOENTRabu1@wuerfel>
 <20140909210232.GA539@amd>
 <CAPDyKFr35646zQUDUnv9LYy9jtY7r343hev9FrhxOfjVMb6MJw@mail.gmail.com>
 <20140910083337.GA5178@amd>
 <CAPDyKFoXiNOHQ3W=U08jU2PG-fz4F_7wuW-KNEoDfcQzrLKmVA@mail.gmail.com>
 <20140910110057.GA9354@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140910110057.GA9354@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: marex@denx.de, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, dinh.linux@gmail.com, "arm@kernel.org" <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-mmc <linux-mmc@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org



On 9/10/14, 6:00 AM, Pavel Machek wrote:
> Hi!
> 
>>>> 2) On the host level, the support for handle multiple slots in DT for
>>>> dw-mmc has been broken. While dw-mmc parsed the DT nodes for slots, it
>>>> screwed up configurations. Thus the support for slots have never
>>>> worked as expected from DT point of view.
>>>
>>> Well, DT is supposed to describe the hardware. From your description,
>>> it seems that linux does not support two slots on one controller and
>>> DT parsing code basically ignores the slots. (Logical, if it can't
>>> support two slots).
>>>
>>> So now we are breaking DT description due to Linux limitations. Which
>>>
>>> a) makes it hard for any other os not having same limitation
>>>
>>> b) makes it hard for people to fix the limitation
>>>
>>> c) does not really solve anything
>>
>> Yes it does, the problem in 2) gets fixed.
>>
>>>
>>> d) breaks backward compatibility with old dts
>>
>> According to 2), it has never worked - so we don't break anything.
> 
> Umm? u-SD worked for me in 3.14, 3.15 and 3.16 with the device tree,
> and with single-slot described in the device tree. Now I have to
> change dtb-s to keep working configuration, which is something device
> tree should never ever do.

I tested the DTB with and without the patch, and it all works fine.

Dinh
> 
> Is it so hard to just fix the multiple slot parsing?
> 
> 									Pavel
> 
