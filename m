From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: Support for various sdio wifi-chips on Allwinner
 tablets and SBCs
Date: Sat, 14 Jan 2017 22:08:46 +0800
Message-ID: <4020591484402926@web44j.yandex.ru>
References: <5844eef2-71bd-bbb9-dff6-92e01a393b36@gmail.com>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBB4XB5DBQKGQESBAIV4Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <5844eef2-71bd-bbb9-dff6-92e01a393b36-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <j.w.r.degoede-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org



08.08.2016, 03:25, "Hans de Goede" <j.w.r.degoede-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Hi All,
>
> Recently I've been working on getting the sdio-wifi, found on
> many a23 / a33 tablets as well as on some a10s hdmi sticks and
> on various h3 SBCs such as the Orange Pi, to work with the
> mainline kernel.
>
> If you use my sunxi-wip kernel branch (which has some dts bits
> to enable this as well as some misc. bits, which I'm all
> trying to get upstream) together with one of the following
> out of tree drivers, you should be able to get your wifi to
> work.
>
> RTL8723BS or RTL8703AS wifi:
> ----------------------------
> git clone https://github.com/jwrdegoede/rtl8723bs.git
> cd rtl8723bs
> make -j4 ARCH=arm CROSS_COMPILE=arm-linux-gnu- KSRC=../linux
>
> Do not forget to copy *.bin to /lib/firmware/rtlwifi/ on
> the target system.
>
> Many thanks to Bastien Nocera for his great work on the
> rtl8723bs driver, my repo just adds 2 small fixes
> to also make the rtl8703as work.
>
> RTL8189ES / RTL8189ETV
> ----------------------
> git clone https://github.com/jwrdegoede/rtl8189ES_linux.git
> cd rtl8189ES_linux.git
> make -j4 ARCH=arm CROSS_COMPILE=arm-linux-gnu- KSRC=../linux
>
> Thanks to Jean-Francois Moine for his initial work on getting
> the RTL8989ES code to run with upstream kernels.
>
> RTL8189FTV
> ----------
> git clone https://github.com/jwrdegoede/rtl8189ES_linux.git
> cd rtl8189ES_linux.git
> git checkout -B rtl8189fs origin/rtl8189fs
> make -j4 ARCH=arm CROSS_COMPILE=arm-linux-gnu- KSRC=../linux
>

Excuse me for replying such an old email...

If a distro want to provide both 8189es and 8189fs in a kernel package,
is blacklisting one of them on boards needed?

> ESP8089
> -------
> git clone https://github.com/jwrdegoede/esp8089.git
> git checkout -B cleanup origin/cleanup
> cd ../linux
> make -j4 ARCH=arm CROSS_COMPILE=arm-linux-gnu- modules M=../esp8089 CONFIG_ESP8089=m
>
> Do not forget to copy firmware/*.bin to /lib/firmware/ on
> the target system.
>
> Many thanks to Icenowy for his work on the esp8089 driver.
>
> I hope this is useful to at least some of you.
>
> A quick note for Orange Pi users, the older models H3 based
> Pi-s use a soldered on wifi module with the RTL8189ETV.
> The newer models (the PC Plus, Lite and Plus 2E) use the
> RTL8189FTV soldered directly onto the PCB.
>
> Regards,
>
> Hans
