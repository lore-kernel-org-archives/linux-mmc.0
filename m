From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH v3 1/3] mmc: sprd: Add MMC host driver for Spreadtrum
 SoC
Date: Mon, 28 Sep 2015 15:37:43 +0800
Message-ID: <5608EE47.1020402@rock-chips.com>
References: <1439571353-30165-1-git-send-email-wuht06@gmail.com>
 <1439571353-30165-2-git-send-email-wuht06@gmail.com>
 <CAPDyKFp=XH+Vo_diRyhrMuB+v1rmTmxo3Lid3Wc-u1ohqNisKw@mail.gmail.com>
 <CAG_R4_VTXCV4NVMOwv-9F56-_pVsK0hU4go79ZhV3OFxwcF0mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:59040 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbbI1HiB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2015 03:38:01 -0400
In-Reply-To: <CAG_R4_VTXCV4NVMOwv-9F56-_pVsK0hU4go79ZhV3OFxwcF0mA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hongtao Wu <wuht06@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, shawn.lin@rock-chips.com, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=c5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Orson.Zhai@spreadtrum.com" <Orson.Zhai@spreadtrum.com>, "Chunyan.Zhang@spreadtrum.com" <Chunyan.Zhang@spreadtrum.com>, "Jason.Wu@spreadtrum.com" <Jason.Wu@spreadtrum.com>

On 2015/9/28 15:18, Hongtao Wu wrote:
>  >>
>
> On Thu, Sep 10, 2015 at 9:28 PM, Ulf Hansson <ulf.hansson@linaro.org
> <mailto:ulf.hansson@linaro.org>> wrote:
>  >
>  > On 14 August 2015 at 18:55, Hongtao Wu <wuht06@gmail.com
> <mailto:wuht06@gmail.com>> wrote:

[...]

>
> Yes, most of this data can be removed, such as caps, caps2, base_clk.
> However ocr_avail and signal_default_voltage are useful for us.
> We can't fetch ocr_avail from external regulator via
> mmc_regulator_get_supply,
> because our regulator driver can't supply mmc_regulator_get_ocrmask()
> interface for MMC driver.

Sorry for the noise but... IMO, your need to quirk your regulator driver 
stuffs rather than mmc.

> And sometimes our external regulator can not supply 3.0v or 1.8v default
> signal voltage that we expect. So this 3.0v or 1.8v default signal
> voltage are
> mandatory.
>



-- 
Best Regards
Shawn Lin

