From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 2/4] mmc: mmci: move block size validation under relevant
 code
Date: Tue, 19 Aug 2014 13:08:21 +0100
Message-ID: <53F33E35.3000900@linaro.org>
References: <1408446785-1399-1-git-send-email-srinivas.kandagatla@linaro.org>	<1408446866-1649-1-git-send-email-srinivas.kandagatla@linaro.org> <CAPDyKFok=r__hx1RaXFgttCQkeocSADY59nSPTZ6DUXQdddBRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFok=r__hx1RaXFgttCQkeocSADY59nSPTZ6DUXQdddBRg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



On 19/08/14 12:55, Ulf Hansson wrote:
>>          writel(host->size, base + MMCIDATALENGTH);
>> >
>> >-       blksz_bits = ffs(data->blksz) - 1;
>> >-       BUG_ON(1 << blksz_bits != data->blksz);
> I don't like this BUG_ON at all, I would prefer if we remove it. The
> original patch "mmc: mmci: Support any block sizes for ux500v2", did
> so as well.
>
Yes, you are right this is redundant check, mmci_validate_data in 
mmci_request should catch this error anyway. we can remove this check 
totally and use your original patch.


--srini
> Now, if we still think removing it is fragile, let additional tests in
> mmci_validate_data() and return and error code from there.
