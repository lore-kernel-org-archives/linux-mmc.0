From: Caleb Crome <caleb@crome.org>
Subject: Re: How to prevent high speed mode due to signal integrity problem
Date: Mon, 5 Dec 2016 17:24:02 -0800
Message-ID: <CAG5mAdxMxzgon6tSNpoYnRPOzdkBU0qkxQa-ECqMT0DqmbFGnQ@mail.gmail.com>
References: <CAG5mAdyAkc3bJS6VD-1s5pKkE7E7XDSA4eq5Ree9ysP5YZd96A@mail.gmail.com>
 <CAG5mAdyyOq-m61OfTAsE532CLDhQgejYL=dGv_Cg89PbbQZGZg@mail.gmail.com> <CAOMZO5A5ejaX6DE22DS2Fh_NNTmcpak4SWhbZhsjg6108rvwGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33028 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbcLFBYX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2016 20:24:23 -0500
Received: by mail-oi0-f45.google.com with SMTP id w63so362807212oiw.0
        for <linux-mmc@vger.kernel.org>; Mon, 05 Dec 2016 17:24:23 -0800 (PST)
In-Reply-To: <CAOMZO5A5ejaX6DE22DS2Fh_NNTmcpak4SWhbZhsjg6108rvwGw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, Dec 5, 2016 at 4:46 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Caleb,
>
> On Mon, Dec 5, 2016 at 10:36 PM, Caleb Crome <caleb@crome.org> wrote:
>> Hello,
>>    We have a board here where there is a signal integrity problem on the=
 MMC
>> bus.  It works fine at 25MHz, but does not work in higher speed modes.
>>
>> Is there an easy way to disable all the high speed modes?  Perhaps from =
the
>> device tree?
>>
>> I tried searching the archives, but gmane seems to be not working.
>>
>> I'm using a stock 4.8.11 kernel.
>> Host processor is i.MX6
>
> Would max-frequency =3D <25000000>; do the trick?
>
> Please take a look at Documentation/devicetree/bindings/mmc/mmc.txt .

Hi Fabio,
  Thanks for the quick feedback -- I was momentarily hopeful...
Unfortunatley, that doesn't seem to work.

I have set (using a solid-run hummingboard uSOM):
&usdhc2 {
    pinctrl-names =3D "default";
    pinctrl-0 =3D <
    &pinctrl_hummingboard_usdhc2_aux
   &pinctrl_hummingboard_usdhc2
   >;
   vmmc-supply =3D <&reg_3p3v>;
   cd-gpios =3D <&gpio1 4 GPIO_ACTIVE_LOW>;
   max-frequency =3D <25000000>;
   status =3D "okay";
};

and just for good measure I set:
&usdhc1 {
    max-frequency =3D <25000000>;
};
&usdhc3 {
   max-frequency =3D <25000000>;
};
&usdhc4 {
   max-frequency =3D <25000000>;
};
(though I'm pretty sure it's using SD2).

And it not only attempts to clock at 50MHz, but also at 200 MHz -- way
beyond what the board can support.

Basically, it doesn't seem to be heeding the max-frequency DT setting at al=
l.

I did in fact verify that the max-frequency value was read at
http://lxr.free-electrons.com/source/drivers/mmc/core/host.c#L216, and
the host->f_max frequency was set to =E2=80=AD25000000=E2=80=AC, but that f=
_max was
ignored it seems.

Any other ideas?
