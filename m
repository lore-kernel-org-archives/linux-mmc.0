From: "Luca Porzio (lporzio)" <lporzio@micron.com>
Subject: RE: [PATCH v1 1/1] mmc: core: fix power class selection
Date: Tue, 3 Apr 2012 17:06:29 +0000
Message-ID: <26E7A31274623843B0E8CF86148BFE326FB57152@NTXAVZMBX04.azit.micron.com>
References: <1333436158-4762-1-git-send-email-subhashj@codeaurora.org>
	<CAKLKtzew2g7bXR3Xdz448cs8O_jQHp0ybG1r1VBUTXcoh2BDwA@mail.gmail.com>
	<000501cd11b1$75766770$60633650$@codeaurora.org>
 <CAKLKtzeYhQtfPLTvO--5cOg6h90t6OpiRmgPKu3cP7AfKBNnMQ@mail.gmail.com>
 <000401cd11b9$1940c6f0$4bc254d0$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <000401cd11b9$1940c6f0$4bc254d0$@codeaurora.org>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>, 'Saugata Das' <saugata.das@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "girish.shivananjappa@linaro.org" <girish.shivananjappa@linaro.org>, "Danilo Caraccio (dcaracci)" <dcaracci@micron.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

> 
> Yes, this makes sense. With current implementation, mmc_select_powerclass()
> should never really fail which means failure should be treated as fatal and
> we should really skip the card initialization.
> This patch is already pushed to mmc-next. So I will post another patch (by
> next week as I will be on vacation in this week) to skip the card
> initialization if mmc_select_powerclass fails.
> 
> Is this ok?
> 
> Regards,
> Subhash
> 

There was an error in the public JEDEC eMMC 4.5 version: PWR_CL_200_360 = EXT_CSD[237] 
is wrongly defined because HS200 can be supported only @1.2V or 1.8V. New Jedec spec 
revision might fix this.

I and Danilo did a quick check in the power class selection routines and it looks 
like the power class is set according to the OCR parsing.
The OCR parsing to check the supported voltage range does not totally cover 
the device capabilities because Vccq = 1.2V support is not encoded in the register.

If the above is true, this implies that indexes EXT_CSD_PWR_CL_200_360 will lead to an error.

DEVICE_TYPE = EXT_CSD[196] is more useful because it provides information on the 
Speed Rate and Voltage Range supported by the device.

Cheers,
    Luca
