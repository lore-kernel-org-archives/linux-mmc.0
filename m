From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v3 01/15] phy: rockchip-emmc: give DLL some extra time to
 be ready
Date: Mon, 20 Jun 2016 12:38:37 -0700
Message-ID: <CAD=FV=XLExFZEoDbj+CMvkWkf_Tp2MLCo20X8RWQQPFzPxAXWg@mail.gmail.com>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org>
 <1466445414-11974-2-git-send-email-dianders@chromium.org>
 <CABXOdTeQhOSUeX+-as_6S5H1mnVnyBsEDU9ZsiC97Yb+qWiFew@mail.gmail.com>
 <CAD=FV=UMFEDzKT0VkVYxmzxKkFVKREhhXhm+McmdQDriHKhPKg@mail.gmail.com>
 <CABXOdTccLMbspfprfLP9CTkD9YbfJsPKOXV7RsVKfU94zPLhNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CABXOdTccLMbspfprfLP9CTkD9YbfJsPKOXV7RsVKfU94zPLhNg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Guenter Roeck <groeck-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Jun 20, 2016 at 12:36 PM, Guenter Roeck <groeck-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
> On Mon, Jun 20, 2016 at 12:30 PM, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>> Hi,
>>
>> On Mon, Jun 20, 2016 at 12:23 PM, Guenter Roeck <groeck-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> wrote:
>>> On Mon, Jun 20, 2016 at 10:56 AM, Douglas Anderson
>>> <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>>>> From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>>>
>>>> According to the databook, 10.2us is the max time for dll to be ready to
>>>> work. However in testing, some chips need 20us for dll to be ready. This
>>>
>>> Nitpick, but description (20uS) and code (more than 25 uS) don't match.
>>
>> Good catch.  If I spin the series I'll fix this, otherwise I'll assume
>> that the person applying this (Ulf?) can fix the description at their
>> discretion.
>>
>
> Not that it matters much, as the code is replaced in a later patch
> anyway. It might make more sense to merge the two patches into one.

Yes.  At the time I wrote it it was unclear what the status of the
original patch was (whether it would be applied sooner vs. later).  At
this point it seemed expedient to continue to keep the patches
separate since they had been reviewed and tested separately.  Earlier
I made the offer to combine and re-spin and I'm happy to do that if
requested.

-Doug
