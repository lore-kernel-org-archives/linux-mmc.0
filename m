From: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Subject: Re: Fixed index for mmcblk
Date: Tue, 31 Jul 2018 17:17:08 +0300
Message-ID: <abf2601e-799a-eb3d-c864-6959b818037b@mleia.com>
References: <CAOT_U5YXF5ZZBuo_Ugm4us6fhB8vgz9sXXqnTnmnODDr4UjkEA@mail.gmail.com>
Reply-To: vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCAMRWGQV4CRBZ66QHNQKGQEMKPBMCQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAOT_U5YXF5ZZBuo_Ugm4us6fhB8vgz9sXXqnTnmnODDr4UjkEA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Alan Martinovic <alan.martinovic-+NedCK/4fiIAvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 07/31/2018 04:18 PM, Alan Martinovic wrote:
> Hi,
> I have an embedded device which gets the roots information
> passed as a kernel parameter   root=/dev/mmcblk0p2
> 
> Am currently migrating to a new kernel and porting device
> tree changes to be based on the following dts:
> https://github.com/friendlyarm/linux/blob/sunxi-4.14.y/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
> https://github.com/friendlyarm/linux/blob/sunxi-4.14.y/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
> 
> What I've noticed is that the new kernel/device tree seems to change the
> index for mmcblk (it was mmcblk0 with the previous combination for
> mainline 4.14 kernel):
> 
> [    1.962308] sunxi-mmc 1c0f000.mmc: Got CD GPIO
> [    2.003604] sunxi-mmc 1c0f000.mmc: base:0xe0873000 irq:26
> ... ... ...
> [    2.092684] mmc1: host does not support reading read-only switch,
> assuming write-enable
> [    2.094600] mmc1: Problem switching card into high-speed mode!
> [    2.094725] mmc1: new SDHC card at address 0001
> [    2.095211] mmcblk1: mmc1:0001 00000 3.68 GiB
> [    2.097424]  mmcblk1: p1 p2 p3 p4
> 
> 
> The device tree has the following entries regarded to mmc:
> 
> &mmc0 {
>     bus-width = <4>;
>     cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>;
>     cd-inverted;
>     pinctrl-names = "default";
>     pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
>     boot_device = <0>;
>     status = "okay";
>     vmmc-supply = <&reg_vcc3v3>;
> };
> &mmc2 {
>     boot_device = <0>;
> };
> 
> Is there a way to have the index fixed and stable?
> 

You should use UUIDs or labels.

Please read carefully https://lkml.org/lkml/2016/4/29/674

--
Best wishes,
Vladimir
