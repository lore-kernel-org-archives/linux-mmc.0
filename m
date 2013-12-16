From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Re: [PATCH 2/5] ARM: dts: sun4i: Add support for mmc
Date: Mon, 16 Dec 2013 13:34:42 +0100
Message-ID: <52AEF362.7080804@redhat.com>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com> <1387058295-20641-3-git-send-email-hdegoede@redhat.com> <20131215135854.GF3651@lukather> <52ADBD41.4050104@redhat.com> <20131216100253.GC3037@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDL4X2GMZUKRB2HGXOKQKGQE5CNQHYA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20131216100253.GC3037@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, =?ISO-8859-1?Q?David_Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 12/16/2013 11:02 AM, Maxime Ripard wrote:
> Hi Hans,
>
> Damn google-groups removed me from Cc :)
>
> On Sun, Dec 15, 2013 at 03:31:29PM +0100, Hans de Goede wrote:
>>>> @@ -376,6 +385,13 @@
>>>>   				allwinner,drive = <0>;
>>>>   				allwinner,pull = <0>;
>>>>   			};
>>>> +
>>>> +			sdc0_pins_a: sdc0@0 {
>>>> +				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
>>>> +				allwinner,function = "mmc0";
>>>> +				allwinner,drive = <3>;
>>>> +				allwinner,pull = <1>;
>>>
>>> Wow, you need both the pullups and a 40mA output?
>>
>> Yes and no. The pullups are enabled by uboot and the allwinner
>> sources, most of my testing has been done without them, which
>> seems to work fine. I've enabled them to be consisten with the
>> allwinner sources and u-boot.
>
> Henrik was suggesting that in most boards it's not required to set up
> the internal pullups. Maybe we can just disable them by default, and
> we will always be able to enable them at the board level if needed.

Ok, I'm fine with disabling the pull-ups by default.

>> As for drive = <3>, we need drive = <2> for normal modes,
>> and drive = <3> for ddr mode. I simply picked <3> to keep
>> things KISS. It should not matter much in power usage, as
>> it will only make the flanks of the signal more steep. Once the
>> desired output level is reached the current will drop off. It will
>> use more current when changing the level, but for half the time,
>> so the effective power usage (current * time) is the same.
>
> Ok, let's keep it to 40mA then. It will indeed be simpler :)

Ack.

>
>>> Ideally, I'd like this patch to be splitted into three:
>>>    - One that adds the MMC controller nodes to the DTSI
>>>    - One that adds the muxing options you need to the pinctrl node
>>>    - One that enables the controller on the boards
>>
>> Sounds like a good job for David. Note I've a lot more boards for
>> which I would like to add mmc support or dts files in general
>> (will do so as time permits).
>>
>> For those boards which already have a dts I'll send mmc adding dts
>> patches to David for now so he can add the changes to the patch-set.
>>
>> How do you want to deal with new boards ? Send the addition of the
>> base board to you (and CC David as he will need them in his tree too),
>> and then send a patch to add mmc to the dts to David ?
>
> I don't really like having a variable-sweep patch serie. Just send
> your DT additions to me, saying that you depend on the MMC serie from
> David.

Ok will do if / when I've dts files for new boards.

Regards,

Hans
