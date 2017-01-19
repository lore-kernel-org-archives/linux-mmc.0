From: Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH v3 2/2] mmc: pwrseq: add support for Marvell SD8787 chip
Date: Thu, 19 Jan 2017 22:10:22 +0200
Message-ID: <87efzyhkup.fsf@purkki.adurom.net>
References: <20170113052937.12538-1-matt@ranostay.consulting>
        <20170113052937.12538-3-matt@ranostay.consulting>
        <CAPDyKFpcKuybQmhqCkaAkOM5d+ubU8O8=adLm+PXwc=+N87vng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpcKuybQmhqCkaAkOM5d+ubU8O8=adLm+PXwc=+N87vng@mail.gmail.com>
        (Ulf Hansson's message of "Thu, 19 Jan 2017 15:13:12 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matt Ranostay <matt@ranostay.consulting>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> Twisting my head around how this could be integrated smoothly into
> pwrseq simple. No, I just can find a good way forward without messing
> up pwrseq simple itself.
>
> So, for now I decided (once more :-), that let's keep this as separate driver!
>
> Perhaps, following device specific mmc pwrseq drivers will needs
> something similar, but in such case we can look into that then.
> Thinking about cw1200 for example.
>
> Let's get Rob's ack for the DT bindings, seems almost there, then I
> will queue this.

Just to confirm, you will take the whole set (including the bindings
patch)?

-- 
Kalle Valo
