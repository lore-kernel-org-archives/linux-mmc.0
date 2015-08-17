From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: fix pio mode when internal dmac is enabled
Date: Mon, 17 Aug 2015 12:34:09 +0200
Message-ID: <CAPDyKFqdOZ4XmV+-wJbHV0uJepVetxkO5GLBkQ1Fm+mCkFM1ig@mail.gmail.com>
References: <3018549.c8iX1Dbrhm@diego>
	<CAPDyKFoCt=-PBWc+HPaF7Qe3DjgaiBo+-1GWYFvtZhgEsTPkMw@mail.gmail.com>
	<55D1B5A1.3050209@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55D1B5A1.3050209@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

[...]

>>> -               mmc->max_seg_size = mmc->max_req_size;
>>> -#endif /* CONFIG_MMC_DW_IDMAC */
>>> +               if (host->use_dma) {
>>> +                       mmc->max_segs = host->ring_size;
>>
>> I expect this may cause a compiler error since host->ring_size is only
>> available in the struct dw_mci *host when CONFIG_MMC_DW_IDMAC is set.
>>
>> I have already pulled in this patch from Jaehoon's pull request.
>> Perhaps I should only amend the patch and change the host->ring_size
>> to be always available no matter if CONFIG_MMC_DW_IDMAC is set or not?
>
> Sorry for this. if you can, i think good that CONFIG_MMC_DW_IDMAC is removed at struct dw_mci.
> Could you amend it?
> If you want to get patch, i will send patch at now.

No worries, I amend the patch myself.

Kind regards
Uffe
