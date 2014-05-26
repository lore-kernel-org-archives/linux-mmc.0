From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 13/13] mmc: mmci: Add Qcom specific pio_read function.
Date: Mon, 26 May 2014 18:10:28 +0100
Message-ID: <53837584.2010006@linaro.org>
References: <1400849362-7007-1-git-send-email-srinivas.kandagatla@linaro.org>	<1400849589-7626-1-git-send-email-srinivas.kandagatla@linaro.org> <CAPDyKFpGPBcg5zpLgrPbv86ekpVJrdOX-2LaZwoXQRAJwjc++w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpGPBcg5zpLgrPbv86ekpVJrdOX-2LaZwoXQRAJwjc++w@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org



On 26/05/14 15:34, Ulf Hansson wrote:
> This is hot path.
>
> As I suggested for the readl and writel wrapper functions, I think it
> would be better to use a function pointer in the struct mmci host,
> which you set up in the probe phase. That means the variant data don't
> need to be checked each an every time this function gets invoked.
>
>> >+
>> >                 if (status & MCI_TXACTIVE)
>> >                         len = mmci_pio_write(host, buffer, remain, status);
> So no changes needed for pio_write at this point? Or those will come later?
>

Yes, that sounds like more sensible approach to me. I will do this 
change in next version.

Thanks,
srini
>> >
>> >--
