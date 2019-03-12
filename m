From: Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 1/3] arm: dts: rk3288-tinker.dtsi: Fix SD card detection
Date: Tue, 12 Mar 2019 21:04:51 +0000
Message-ID: <AM3PR03MB09669404B737D39ADF5709F9AC490@AM3PR03MB0966.eurprd03.prod.outlook.com>
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <50094675.5IylMcgSg6@phil>
 <4a1ad220-103d-543e-56d1-3c6d6ad906ec@davidjohnsummers.uk>
 <4202578.jOHf0ez5fE@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4202578.jOHf0ez5fE@diego>
Content-Language: en-US
Content-ID: <53B447488D46304EA87F28F0E5A30D52@eurprd03.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?Windows-1252?Q?Heiko_St=FCbner?= <heiko@sntech.de>, David Summers <beagleboard@davidjohnsummers.uk>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "frowand.list@gmail.com" <frowand.list@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 2019-03-12 21:52, Heiko St=FCbner wrote:
> Hi David,
>
> Am Dienstag, 12. M=E4rz 2019, 21:34:00 CET schrieb David Summers:
>> On 12/03/2019 14:22, Heiko Stuebner wrote:
>>> Hi Jonas,
>>>
>>> Am Samstag, 9. M=E4rz 2019, 16:39:21 CET schrieb David Summers:
>>>> The Problem:
>>>>
>>>> On ASUS Tinker Board S, when booting from the eMMC, and there is card
>>>> in the sd slot, there are constant errors.
>>>>
>>>> Also when warm reboot, uboot can not access the sd slot
>>>>
>>>> Cause:
>>>>
>>>> Identified by Robin Murphy @ ARM. The Card Detect on rk3288
>>>> devices is pulled up by vccio-sd; so when the regulator powers this
>>>> off, card detect gives spurious errors. A second problem, is during
>>>> power down, vccio-sd apprears to be powered down. This causes a
>>>> problem when warm rebooting from the sd card. This was identified by
>>>> Jonas Karlman.
>>>>
>>>> History:
>>>>
>>>> A common fault on these rk3288 board, which impliment the reference
>>>> design.
>>>>
>>>> When this arose before:
>>>>
>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/2811=
53.
>>>> html
>>>>
>>>> And Ulf and Jaehoon clearly said this was a broken card detect design,
>>>> which should be solved via polling
>>>>
>>>> Solution:
>>>>
>>>> Hence broken-cd is set as a property. This cures the errors. The
>>>> powering down of vccio-sd during reboot is cured by adding
>>>> regulator-boot-on.
>>>>
>>>> This solutions has been fairly widely reviewed and tested.
>>>>
>>>> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
>>>> Reviewed by: Robin Murphy <robin.murphy@arm.com>
>>>> Reviewed by: Jonas Karlman <jonas@kwiboo.se>
>>> in v2, you gave a
>>> Tested-by: Jonas Karlman <jonas@kwiboo.se>
>>> it seems, which somehow transformed into a reviewed-by in v3.
>>>
>>> V3 did change a bit in its approach - for the better, but do you approve
>>> of adding that Reviewed-by above (and maybe also providing a Tested-by
>>> for the new approach)?
>>>
>>> Thanks
>>> Heiko
>> Hi all,
>>
>> Yes apologies for these signed-off lines etc wrong. Its still a learning
>> experiment for me!
>>
>> Both Robin and Jonas added a lot to Patch, as explained in the write up.
>> Robin came up with the cause of the fault, and Jonas noticed a second
>> fault. So the question is to give these two their due. I think what they
>> both added was important.
>>
>> Thanks Robin for the official "Reviewed-by".
>>
>> Jonas tested the second version, which kept power on vccio-sd all the
>> time, whereas v1 and v3 cured the problem with broken-cd. So although
>> both fixed the problem, they way performed is different. So don't think
>> I can say Jonas Tested-by v3.
> We'll just give Jonas a bit more time to reply then :-) .

I have now tested v3 on a Tinker Board and a Tinker Board S using u-boot 20=
19.01 on sd-card,
both devices can now soft reboot when running bootloader from sd-card thank=
s to the "regulator-boot-on".

I am happy to add both tags :-)

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

>
>> As for the tested by "TheSaint @ ArchLinux Arm", he actually tested just
>> above every single version of the patch, and a whole lot more before it
>> was sent in - he is our ASUS Tinker Board user on arch. He doesn't
>> really want his email in the open, but if push comes to shove he'll
>> allow it. Question is do you need this for the Patch to pass?
> No, that is not necessary. I'll just drop the line when applying.
> In general for a tag to mean something we need the Name, but any
> tags other than Signed-off-by are optional anyway.
>
>
>> Heiko, I'm happy to change the sign off etc, and resent the patch (as
>> v4). But would be the same patch. Think the question is what is best for
>> you. Don't want to send unneeded email ... anyway let me know (private
>> email?) and I'll do whatever is best for you.
> No, re-sending just to correct tags is not necessary in _my_ case
> as I generally just fix up the relevant lines myself when applying.
> Just keep in mind, other maintainers may handle this differently :-) .
>
>
>> P.S. Eventually I'll get better at these patches , alas the day job
>> keeps me too busy - and I forget the rules :(
> Really no problem, it's always a learning experience.
> So don't worry too much :-) .
>
>
> Heiko
>
>
