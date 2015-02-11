From: Addy <addy.ke@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix bug that cause mmc_test failture
Date: Wed, 11 Feb 2015 11:03:11 +0800
Message-ID: <54DAC66F.60301@rock-chips.com>
References: <1422273849-29773-1-git-send-email-addy.ke@rock-chips.com> <CAOesGMiWBjhfzWVXah2XO7=JQhriwdVgf0jmm1UjNQjB9PeGMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAOesGMiWBjhfzWVXah2XO7=JQhriwdVgf0jmm1UjNQjB9PeGMQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Dinh Nguyen <dinguyen@altera.com>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Doug Anderson <dianders@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, amstan@chromium.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-rockchip@lists.infradead.org, zhenfu.fang@
List-Id: linux-mmc@vger.kernel.org


On 2015/02=E6=9C=8810=E6=97=A5 17:34, Olof Johansson wrote:
> Hi Addy,
>
> On Mon, Jan 26, 2015 at 4:04 AM, Addy Ke <addy.ke@rock-chips.com> wro=
te:
>> The STOP command can terminate a data transfer between a memory card=
 and
>> mmc controller.
>>
>> As show in Synopsys DesignWare Cores Mobile Stroage Host Databook:
>> Data timeout and Data end-bit error will terminate further data tran=
sfer
>> by mmc controller. So we should not send abort command to terminate =
a
>> data transfer again if we got DRTO and EBE interrupt.
>>
>> After this patch, all mmc_test cases can pass on RK3288-Pink2 board.
>>
>> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> The drawback of having so many people on your to: list on a patch is
> that it's unclear who you want to review and merge it. Sometimes less
> is more.
I will remove some unnecessary mail address from list in the following=20
patch.
Thank you.
>
> In this case, it seems appropriate to have Ulf do so. Ulf, ping? This
> seems like a reasonable patch for 3.20 given that it fixes undesired
> behavior.
>
>
> -Olof
>
>
>


