From: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/2] mmc: dw_mmc: fix the wrong operation for reset
 controller
Date: Thu, 03 Nov 2016 14:19:15 +0900
Message-ID: <e7ce67f2-9e2a-6895-7bb3-842261915cd8@samsung.com>
References: <20161031024942.4415-1-jh80.chung@samsung.com>
 <CGME20161101215604epcas1p238d00f298016711e010b097c6aadc4b6@epcas1p2.samsung.com>
 <CALAqxLXs704Y-TGAQsggSnDohyFDYvQw=zYuiHRu9UKgHEfbFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <CALAqxLXs704Y-TGAQsggSnDohyFDYvQw=zYuiHRu9UKgHEfbFw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guodong Xu <guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Leo Yan <leo.yan-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 11/02/2016 06:56 AM, John Stultz wrote:
> On Sun, Oct 30, 2016 at 7:49 PM, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> This patch adds the "reset-names" as reset controller for dwmmc controller.
>> Linaro guys had reported the issue about booting stuck.
>>
>> Some SoCs are enabled the CONFIG_RESET_CONTROLLER.
>> then dwmmc controller are waiting for getting reset controller.
>> But if doesn't define "resets" property in device-tree, it should be stuck.
>>
>> If use the reset-names as reset controller for dwmmc controller,
>> it's more stable than now.
>> This commit is related with the below commit.
>>
>> Fixes: d6786fefe816 ("mmc: dw_mmc: add reset support to dwmmc host controller")
> 
> So I wasn't hit by the issue, as I don't tend to boot from SD on my
> hikey, but I did run these patches and I'm not seeing any issues with
> my Android environment.
> 
> So for what its worth:
> Acked-by: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Applied on my repository (fixes branch).

Best Regards,
Jaehoon Chung

> 
> thanks
> -john
> 
> 
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
