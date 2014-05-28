From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 13/13] mmc: mmci: Add Qcom specific pio_read function.
Date: Wed, 28 May 2014 09:51:59 +0100
Message-ID: <5385A3AF.7060302@linaro.org>
References: <1400849362-7007-1-git-send-email-srinivas.kandagatla@linaro.org>	<1400849589-7626-1-git-send-email-srinivas.kandagatla@linaro.org> <CACRpkdb+pUn=9UkEVhK_2nL8C2wq_6qOuuRV52TRnj1hJiHvSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CACRpkdb+pUn=9UkEVhK_2nL8C2wq_6qOuuRV52TRnj1hJiHvSg@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



On 28/05/14 09:08, Linus Walleij wrote:
> On Fri, May 23, 2014 at 2:53 PM,  <srinivas.kandagatla@linaro.org> wrote:
>
>> +       if (unlikely(bytes)) {
>> +               unsigned char buf[4];
> (...)

>
> Please think twice about this.
> http://lwn.net/Articles/70473/
> http://lwn.net/Articles/420019/
> http://lwn.net/Articles/182369/
>
Thanks for the warning.

You are right. I think having likely/unlikely is not always right here.

thanks,
srini
> Yours,
> Linus Walleij
>
