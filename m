From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/2] mmc: pwrseq: add support for Marvell SD8787 chip
Date: Thu, 19 Jan 2017 21:30:29 +0100
Message-ID: <CAPDyKFrHvYNOCfAjASEHz75fVcaqt5fptFaqWp5nVPFnHuHV1g@mail.gmail.com>
References: <20170113052937.12538-1-matt@ranostay.consulting>
 <20170113052937.12538-3-matt@ranostay.consulting> <CAPDyKFpcKuybQmhqCkaAkOM5d+ubU8O8=adLm+PXwc=+N87vng@mail.gmail.com>
 <87efzyhkup.fsf@purkki.adurom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87efzyhkup.fsf@purkki.adurom.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Kalle Valo <kvalo@codeaurora.org>
Cc: Matt Ranostay <matt@ranostay.consulting>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

On 19 January 2017 at 21:10, Kalle Valo <kvalo@codeaurora.org> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> Twisting my head around how this could be integrated smoothly into
>> pwrseq simple. No, I just can find a good way forward without messing
>> up pwrseq simple itself.
>>
>> So, for now I decided (once more :-), that let's keep this as separate driver!
>>
>> Perhaps, following device specific mmc pwrseq drivers will needs
>> something similar, but in such case we can look into that then.
>> Thinking about cw1200 for example.
>>
>> Let's get Rob's ack for the DT bindings, seems almost there, then I
>> will queue this.
>
> Just to confirm, you will take the whole set (including the bindings
> patch)?

Yes, correct.

Kind regards
Uffe
