From: Orson Zhai <orsonzhai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH] mmc: sprd: add MMC host driver for Spreadtrum SoC
Date: Sat, 04 Jul 2015 12:03:39 +0800
Message-ID: <55975B1B.60008@gmail.com>
References: <1435735399-15333-1-git-send-email-chunyan.zhang@spreadtrum.com>	<CAL_JsqKcZ-7rM5YrkpJSP7OfECmRg4hWPRFy=UqZn1y74R8qsg@mail.gmail.com>	<CA+H2tpG+_pCR-j3nZ+SeAhpj6QfiPK2=Q0pwjndQoG9R4+LMYw@mail.gmail.com>	<CAL_JsqKk0KOheyGvc=EBkgH3K4fPDsppLQGtXjNA4cekW57bvQ@mail.gmail.com>,<CA+H2tpFO2uz3Pr4bxoesqc8teF+SYhw-GqKOdk_w4_p5KvJR6A@mail.gmail.com> <f3e0e99497ba4b729fb0e016677f4e16@SHMBX03.spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f3e0e99497ba4b729fb0e016677f4e16-GFC6RAiklXKXEiejXgtQ7QQSgKfZeEaX@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?gbk?Q?=22Billows_Wu_=28=CE=E4=BA=E9=CC=CE=29=22?= <Billows.Wu-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?gbk?Q?=22Chunyan_Zhang_=28=D5=C5=B4=BA=D1=DE=29=22?= <Chunyan.Zhang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>, "chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org" <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, =?gbk?Q?=22Wei_Qiao_=28=C7=C7=CE=B0=29=22?= <Wei.Qiao-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>, =?gbk?Q?=22Baolin_Wang_=28=CD=F5=B1=A6=C1=D6=29=22?= <Baolin.Wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>, =?gbk?Q?=22Ning_Yang_=28=D1=EE=C4=FE=29?= =?gbk?Q?=22?= <Ning.Yang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>, =?gbk?Q?=22Orson_Zhai_=28=B5=D4?= =?gbk?Q?=BE=A9=29=22?= <Orson.Zhai-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>, =?gbk?Q?=22Jason_W?= =?gbk?Q?u_=28=CE=E2=F6=AB=CB=AC=29=22?= <Jason.Wu-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org



On 2015=C4=EA07=D4=C203=C8=D5 13:44, Billows Wu (=CE=E4=BA=E9=CC=CE) wr=
ote:
> Hi Rob,
>
> Thanks for your reply.
> The MMC subsys core can figure out the type of the device attached. B=
ut it happaped after MMC probe function run over.
> If we want to distinguish MMC=A3=ACSD or Wi-Fi in controller's probe =
function, we may by controller's register physical address, for example=
  20600000.sdio=A3=AC2.400000.sdio or 20300000.sdio.   So we must know =
MMC controller's physical address is 0x20600000 and SD controller's phy=
sical address is 0x20300000. This reduces the code readability.
why not answer rob's 2nd comment on POWER_OFF flag in same time?
and you should use "in-line reply" without base64 encoding.

back to the question, i think you don't need to know the exact card typ=
e=20
at probe time only a little bit earlier than in later work queue.
just printing out the devname and card type at work queue is good enoug=
h.
say some logs in work-queue as "20600000.sdio detecting... card type: e=
mmc"

-orson
> If you have a good opinion how to distinguish MMC form SD or SDIO dev=
ice in host controller probe function not by physical address, please t=
ell us.
>
> Thanks!
> --billows
> ___________________________________
> From: Orson Zhai <orsonzhai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Sent: Friday, July 3, 2015 10:50 AM
> To: Rob Herring
> Cc: Chunyan Zhang (=D5=C5=B4=BA=D1=DE); chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org; Ulf Hansson=
; Lee Jones; Shawn Guo; Grant Likely; Rob Herring; Arnd Bergmann; Billo=
ws Wu (=CE=E4=BA=E9=CC=CE); Wei Qiao (=C7=C7=CE=B0); Baolin Wang (=CD=F5=
=B1=A6=C1=D6); Ning Yang (=D1=EE=C4=FE); Orson Zhai (=B5=D4=BE=A9); Jas=
on Wu (=CE=E2=F6=AB=CB=AC); linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel@vge=
r.kernel.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [RFC PATCH] mmc: sprd: add MMC host driver for Spreadtru=
m SoC
>
> On Thu, Jul 2, 2015 at 11:47 PM, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =
wrote:
>> On Thu, Jul 2, 2015 at 4:26 AM, Orson Zhai <orsonzhai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wro=
te:
>>> Hi Rob,
>>>
>>> Thanks for your quick reply.
>>> I have one question to your last comment.
>>>
>>> On Thu, Jul 2, 2015 at 1:50 AM, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=
 wrote:
>>>> On Wed, Jul 1, 2015 at 2:23 AM, Chunyan Zhang
>>>> <chunyan.zhang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org> wrote:
>>>>> From: Billows Wu <billows.wu-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
>> [...]
>>
>>>>> +const struct of_device_id sdhost_of_match[] =3D {
>>>>> +       {.compatible =3D "sprd,sd-sdhost-3.0", .data =3D &sd_caps=
_info,},
>>>>> +       {.compatible =3D "sprd,wifi-sdhost-3.0", .data =3D &wifi_=
caps_info,},
>>>>> +       {.compatible =3D "sprd,emmc-sdhost-3.0",  .data =3D &emmc=
_caps_info,},
>>>> What these are connected to is irrelevant to the driver and compat=
ible
>>>> string. All these differences belong in the DT unless the IP block=
s
>>>> are really different.
>>> It's my idea to let Billows do like this.
>>> I learn from SSP part in freescale  "arch/arm/boot/dts/imx28-evk.dt=
s"
>>> Their ssp0-ssp2 each have 2 roles, mmc or generic spi bus.
>>> And they may write one of their combo configuration like this:
>> That is a bit different as the host controller is operating in
>> completely different modes. In your case, the host controller is the
>> same and functions the same way, but just has different cards
>> attached.
>>
>>>   43                         ssp1: ssp@80012000 {
>>>   44                                 compatible =3D "fsl,imx28-mmc"=
;
>>>   45                                 bus-width =3D <8>;
>>>   46                                 wp-gpios =3D <&gpio0 28 0>;
>>>   47                         };
>>>   48
>>>   49                         ssp2: ssp@80014000 {
>>>   50                                 #address-cells =3D <1>;
>>>   51                                 #size-cells =3D <0>;
>>>   52                                 compatible =3D "fsl,imx28-spi"=
;
>>>   53                                 pinctrl-names =3D "default";
>>>   54                                 pinctrl-0 =3D <&spi2_pins_a>;
>>>   55                                 status =3D "okay";
>>>   56
>>>   57                                 flash: m25p80@0 {
>>>   58                                         #address-cells =3D <1>=
;
>>>   59                                         #size-cells =3D <1>;
>>>   60                                         compatible =3D "sst,ss=
t25vf016b";
>>>   61                                         spi-max-frequency =3D =
<40000000>;
>>>   62                                         reg =3D <0>;
>>>   63                                 };
>>>   64                         };
>>>
>>> Billows tell me they also have 3 roles in their sd host controller
>>> corresponding to 3 kinds of different operation.
>>> He used to create "sprd,name" property for this. Is it a good way o=
r
>>> anything else better?
>> Why do you need to know? You can define parameters which can't be
>> probed such as bus width, voltage, and clock freq. in DT for each
>> host. The MMC subsys core will figure out the type of device attache=
d.
> I think you're right.
> Thanks!
> -orson
>
>> Rob

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
