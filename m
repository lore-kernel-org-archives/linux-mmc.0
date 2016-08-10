From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 1/3] DT: bindings: mmc: Add property for 3.3V only support
Date: Wed, 10 Aug 2016 16:39:37 -0500
Message-ID: <CAL_JsqJ09hXYrp_pgAw9FXrBv+=grkm_zip6qB9XefujPECTxQ@mail.gmail.com>
References: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
 <1470488140-10104-2-git-send-email-stefan.wahren@i2se.com>
 <20160810184451.GA13473@rob-hp-laptop> <853617027.179290.63a6f478-ad48-40c8-82ca-760dd1afc040.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <853617027.179290.63a6f478-ad48-40c8-82ca-760dd1afc040.open-xchange-7tX72C7vayboQLBSYMtkGA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Otavio Salvador <otavio-fKevB0iiKLMBZ+LybsDmbA@public.gmane.org>, Holger Schurig <holgerschurig-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 10, 2016 at 3:27 PM, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> wrote:
> Hi,
>
>> Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> hat am 10. August 2016 um 20:44 geschrieben:
>>
>>
>> On Sat, Aug 06, 2016 at 12:55:38PM +0000, Stefan Wahren wrote:
>> > Currently there is no proper way to define that a MMC host supports
>> > only 3.3V. The property no-1-8-v is broken and has different meanings
>> > for different sdhci variants. So add a new property for 3.3V only
>> > support and mark no-1-8-v as deprecated.
>>
>> Why is it broken?
>
> i want to quote Ulf Hansson here [1]:
>
>   The problem with the "no-1-8-v" binding is that it's describing what
>   the hardware *can't* do. It thus becomes easy to abuse it.

Sounds like a quirk which is perfectly normal for a property. I'd
agree it should be what the h/w *can* do if h/w didn't have capability
bit that does that.

>   I suggest we stop using it, we should mark it deprecated.
>
> [1] - http://www.spinics.net/lists/linux-mmc/msg34604.html
>
>> How would I override a controller saying 1.8V is
>> supported and it is not?
>
> Sorry, i'm not sure that i understand your question. In case a board or a MMC
> controller doesn't support 1.8V, it usually supports only 3.3V which is the
> intension of this patch.

Some controllers have capability bits saying what voltages they
support, right? And those bits can be wrong (unless firmware sets them
I'd expect that is the common case) which as I read it is what
"no-1-8-v" was for. So with the "mmc-ddr-*v" properties, what does not
present mean and how do they relate to controller capability bits? I
assume they would override the controller bits, but you can only
override the capability bit not set case. I would think the property
not present means use the capability bit, not that that voltage is not
supported. I think you probably need tri-state properties here where
value 1 means supported, 0 means not supported, and not present means
use capability bit (or other method).

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
