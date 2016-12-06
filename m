From: Caleb Crome <caleb@crome.org>
Subject: Re: How to prevent high speed mode due to signal integrity problem
Date: Tue, 6 Dec 2016 06:35:11 -0800
Message-ID: <CAG5mAdwsrw=Znau=tqkQxXsUfUqXyFhwaHExu5=S34h=FR8ZrA@mail.gmail.com>
References: <CAG5mAdyAkc3bJS6VD-1s5pKkE7E7XDSA4eq5Ree9ysP5YZd96A@mail.gmail.com>
 <CAG5mAdyyOq-m61OfTAsE532CLDhQgejYL=dGv_Cg89PbbQZGZg@mail.gmail.com>
 <CAOMZO5A5ejaX6DE22DS2Fh_NNTmcpak4SWhbZhsjg6108rvwGw@mail.gmail.com>
 <CAG5mAdxMxzgon6tSNpoYnRPOzdkBU0qkxQa-ECqMT0DqmbFGnQ@mail.gmail.com> <CAG5mAdwmqSOnLvnNynhCJAVKeVVCrQCLRrRmbtvWjigXgksrpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36345 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753266AbcLFOfr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2016 09:35:47 -0500
Received: by mail-oi0-f52.google.com with SMTP id v84so378577088oie.3
        for <linux-mmc@vger.kernel.org>; Tue, 06 Dec 2016 06:35:32 -0800 (PST)
In-Reply-To: <CAG5mAdwmqSOnLvnNynhCJAVKeVVCrQCLRrRmbtvWjigXgksrpw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, Dec 5, 2016 at 6:08 PM, Caleb Crome <caleb@crome.org> wrote:
> On Mon, Dec 5, 2016 at 5:24 PM, Caleb Crome <caleb@crome.org> wrote:
>> On Mon, Dec 5, 2016 at 4:46 PM, Fabio Estevam <festevam@gmail.com> wrote=
:
>>> Hi Caleb,
>>>
>>> On Mon, Dec 5, 2016 at 10:36 PM, Caleb Crome <caleb@crome.org> wrote:
>>>> Hello,
>>>>    We have a board here where there is a signal integrity problem on t=
he MMC
>>>> bus.  It works fine at 25MHz, but does not work in higher speed modes.
>>>>
>>>> Is there an easy way to disable all the high speed modes?  Perhaps fro=
m the
>>>> device tree?
>>>>
>>>> I tried searching the archives, but gmane seems to be not working.
>>>>
>>>> I'm using a stock 4.8.11 kernel.
>>>> Host processor is i.MX6
>>>
>>> Would max-frequency =3D <25000000>; do the trick?
>>>
>>> Please take a look at Documentation/devicetree/bindings/mmc/mmc.txt .
>>
>> Hi Fabio,
>>   Thanks for the quick feedback -- I was momentarily hopeful...
>> Unfortunatley, that doesn't seem to work.
>>
>> I have set (using a solid-run hummingboard uSOM):
>> &usdhc2 {
>>     pinctrl-names =3D "default";
>>     pinctrl-0 =3D <
>>     &pinctrl_hummingboard_usdhc2_aux
>>    &pinctrl_hummingboard_usdhc2
>>    >;
>>    vmmc-supply =3D <&reg_3p3v>;
>>    cd-gpios =3D <&gpio1 4 GPIO_ACTIVE_LOW>;
>>    max-frequency =3D <25000000>;
>>    status =3D "okay";
>> };
>>
>> and just for good measure I set:
>> &usdhc1 {
>>     max-frequency =3D <25000000>;
>> };
>> &usdhc3 {
>>    max-frequency =3D <25000000>;
>> };
>> &usdhc4 {
>>    max-frequency =3D <25000000>;
>> };
>> (though I'm pretty sure it's using SD2).
>>
>> And it not only attempts to clock at 50MHz, but also at 200 MHz -- way
>> beyond what the board can support.
>>
>> Basically, it doesn't seem to be heeding the max-frequency DT setting at=
 all.
>>
>> I did in fact verify that the max-frequency value was read at
>> http://lxr.free-electrons.com/source/drivers/mmc/core/host.c#L216, and
>> the host->f_max frequency was set to =E2=80=AD25000000=E2=80=AC, but tha=
t f_max was
>> ignored it seems.
>>
>
> Okay, I take it back -- sort of.
>
> The f_max is not ignored -- if I set 5MHz, the clock is *usually* 5MHz.
>
> However, I have a trigger set with my scope, and it actually does
> switch to 200MHz mode momentarily.  I don't know whether or not this
> is the cause of my problems.
>
> Currently, my problem is that I get hard reboot just as the following
> happens:  (This is a different problem from before I switch
> max-frequency).
>
> [    5.293356] random: fast init done
> [    5.298871] ALSA device list:
> [    5.301973]   #0: On-board SPDIF
> [    5.318480] EXT4-fs (mmcblk0p2): mounting ext3 file system using
> the ext4 subsystem
> [    5.350791] mmc1: new SDIO card at address 0001
> [    5.379811] EXT4-fs (mmcblk0p2): mounted filesystem with ordered
> data mode. Opts: (null)
> [    5.388118] VFS: Mounted root (ext3 filesystem) on device 179:2.
> [    5.411692] devtmpfs: mounted
>
> U-Boot SPL 2013.10-rc4 (Dec 05 2016 - 14:09:51)
> Boot Device: SD1
> spl: error reading image u-boot.img, err - -1
> Load image from RAW...
>
>
> Here is an image of the scope capture showing the sd_clk transition
> from 5MHz to 200MHz in the middle of booting.
>
> https://drive.google.com/open?id=3D0BxzZmuc2tSowTzRHUms5RW9mUkE
>
> Thanks again,
>
> -Caleb

After some further investigation, I found a couple things:

Firstly, I had a weak power brick causing the spontanious reboot after
fixing max-frequency, so the max-frequency does seem to fix the
problem!  Thanks Fabio!

Secondly, the SD clock on the SD interface definitely switches to 200
MHz mode at times.  I'm not sure why.  I checked with 3.14, 4.8, and
4.9, all have this behavior.  However, there doesn't seem to be any
data flowing on the other pins during these intervals of 200MHz
clocking.

I checked the CMD pin, and all the data pins -- no transitions during
the 200MHz clock mode.  So.. my board runs, but a 200MHz clock on
SD_CLK definitely doesn't seem right.

Thanks again,
 - Caleb
