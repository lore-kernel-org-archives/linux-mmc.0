From: Guenter Roeck <groeck-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 05/15] phy: rockchip-emmc: Increase lock time allowance
Date: Mon, 20 Jun 2016 12:38:27 -0700
Message-ID: <CABXOdTe7ryiEU48FPZ6N48gbC84b1iU5G8ihRY=-c5sWBxLEQw@mail.gmail.com>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org>
 <1466445414-11974-6-git-send-email-dianders@chromium.org>
 <CABXOdTeO8--Rk2k8tk62uiPa6T=ZoDZjBQwMHyWpNBwJo2pinA@mail.gmail.com>
 <CAD=FV=XTk_mY3oJaJX8sUnUzvNf3z8PtjanKJ1a8oWKDi7TwSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAD=FV=XTk_mY3oJaJX8sUnUzvNf3z8PtjanKJ1a8oWKDi7TwSQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jun 20, 2016 at 12:36 PM, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> Hi,
>
> On Mon, Jun 20, 2016 at 12:29 PM, Guenter Roeck <groeck-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
>> On Mon, Jun 20, 2016 at 10:56 AM, Douglas Anderson
>> <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>>> Previous PHY code waited a fixed amount of time for the DLL to lock at
>>> power on time.  Unfortunately, the time for the DLL to lock is actually
>>> a bit more dynamic and can be longer if the card clock is slower.
>>>
>>> Instead of waiting a fixed 30 us, let's now dynamically wait until the
>>> lock bit gets set.  We'll wait up to 10 ms which should be OK even if
>>> the card clock is at the super slow 100 kHz.
>>>
>>
>> 10 ms active delay (no sleep) is actually quite long. Can this code sleep ?
>
> It is expected that in nearly all cases it will be much shorter than
> 10ms.  The longest expected (at 400kHz) is 1.3 ms and we should only
> be probing down to 300, 200, 100 kHz if we are having trouble
> communicating.  When running at a normal speed (50 MHz, 100 MHz, etc)
> it should be much smaller and closer to 10 us or less.  We could still
> try to sleep in some of these cases, but IMHO the extra code
> complexity for something like this that should happen very
> infrequently (only at bootup or if we decide to re-tune) is probably
> not worth it.  Also note that at boot eMMC is (probably) on the
> critical path, so there may be some boot speed benefits to continuing
> as quickly as possible.
>

Makes sense.

Thanks,
Guenter
