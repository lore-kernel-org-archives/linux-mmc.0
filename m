From: Julian Calaby <julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Support for various sdio wifi-chips on Allwinner
 tablets and SBCs
Date: Sun, 4 Sep 2016 14:54:10 +1000
Message-ID: <CAGRGNgUMw26JBdCOoOimH=_zgA788cS=+Ttjt7k87C5qPK3_WA@mail.gmail.com>
References: <5844eef2-71bd-bbb9-dff6-92e01a393b36@gmail.com>
Reply-To: julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDQIP76OUQLBBB6SV27AKGQECG5HIPA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <5844eef2-71bd-bbb9-dff6-92e01a393b36-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: jwrdegoede-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi All,

On Mon, Aug 8, 2016 at 5:25 AM, Hans de Goede <j.w.r.degoede-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
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
> ESP8089
> -------
> git clone https://github.com/jwrdegoede/esp8089.git
> git checkout -B cleanup origin/cleanup
> cd ../linux
> make -j4 ARCH=arm CROSS_COMPILE=arm-linux-gnu- modules M=../esp8089
> CONFIG_ESP8089=m
>
> Do not forget to copy firmware/*.bin to /lib/firmware/ on
> the target system.
>
> Many thanks to Icenowy for her work on the esp8089 driver.

The popular ESP8266 microcontrollers that have become rather popular
recently are rebranded ESP8089s. If you want to test this driver and
lack a board with one built in, here are some instructions on using
ESP-03 boards as an SDIO WiFi card on a Raspberry Pi:

https://hackaday.io/project/8678-rpi-wifi

This project eventually evolved into a RasPi hat, however the initial
instructions should be usable with any development board with exposed
SDIO lines by anyone who isn't afraid of fine-pitch soldering.

Thanks,

-- 
Julian Calaby

Email: julian.calaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Profile: http://www.google.com/profiles/julian.calaby/
