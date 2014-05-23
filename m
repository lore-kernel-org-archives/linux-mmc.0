From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 11/14] mmc: mmci: Add support to data commands via
 variant structure.
Date: Fri, 23 May 2014 10:10:08 +0100
Message-ID: <537F1070.5010303@linaro.org>
References: <1400146447-29803-1-git-send-email-srinivas.kandagatla@linaro.org>	<1400146660-30261-1-git-send-email-srinivas.kandagatla@linaro.org> <CACRpkdYZOpqyGJT4_Kf-TetiQoQrJwWbSrqUxDuRszutEM0HWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYZOpqyGJT4_Kf-TetiQoQrJwWbSrqUxDuRszutEM0HWw@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Thanks Linus W.

On 23/05/14 10:09, Linus Walleij wrote:
> On Thu, May 15, 2014 at 11:37 AM,  <srinivas.kandagatla@linaro.org> wrote:
>
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> On some SOCs like Qcom there are explicit bits in the command register
>> to specify if its a data transfer command or not. So this patch adds
>> support to such bits in variant data, giving more flexibility to the
>> driver.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij
>
