From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 07/11] mmc: mmci: move ST specific register extensions
 access under condition.
Date: Tue, 13 May 2014 10:33:55 +0100
Message-ID: <5371E703.9050705@linaro.org>
References: <1398759492-12970-1-git-send-email-srinivas.kandagatla@linaro.org>	<1398759627-13256-1-git-send-email-srinivas.kandagatla@linaro.org> <CACRpkdbgScfdLUc64a0r4Jxq9UHCbmMiAwD_G1-LZq8B58sX7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbgScfdLUc64a0r4Jxq9UHCbmMiAwD_G1-LZq8B58sX7g@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, agross@quicinc.com, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



On 13/05/14 09:08, Linus Walleij wrote:
>> >         /* Keep ST Micro busy mode if enabled */
>> >-       datactrl |= host->datactrl_reg & MCI_ST_DPSM_BUSYMODE;
>> >+       if (host->hw_designer == AMBA_VENDOR_ST)
>> >+               datactrl |= host->datactrl_reg & MCI_ST_DPSM_BUSYMODE;
> Do not hard-check the hw_designer everywhere, follow the pattern
> if storing special stuff in the variant data.
>
Got it, I will fix this across other patches too.

> struct variant_data {
>          u32 datactrl_mask_busymode;
> (...)
>
> static struct variant_data variant_u300 = {
>          .datactrl_mask_busymode = MCI_ST_DPSM_BUSYMODE,
> (...)
> static struct variant_data variant_nomadik = {
