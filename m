From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 08/11] mmc: mmci: Qcom fix MCICLK register settings.
Date: Tue, 13 May 2014 10:36:27 +0100
Message-ID: <5371E79B.2010402@linaro.org>
References: <1398759492-12970-1-git-send-email-srinivas.kandagatla@linaro.org>	<1398759638-13299-1-git-send-email-srinivas.kandagatla@linaro.org> <CACRpkdYyFWAYsPT1jvOLCpx9dOTL9P-J=45BNqEi5TZ4Zd3vVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYyFWAYsPT1jvOLCpx9dOTL9P-J=45BNqEi5TZ4Zd3vVw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, agross@quicinc.com, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Thanks Linus W.

On 13/05/14 09:19, Linus Walleij wrote:
> Again follow the pattern of storing register templates in the vendor_data
> struct. I think you will quickly realize how this can be cut down with
> new fields like .clk_4bitmode etc.
>
>> >  /* Modified PL180 on Versatile Express platform */
>> >  #define MCI_ARM_HWFCEN         (1 << 12)
>> >
>> >+/* Modified on Qualcomm Integrations */
> First: follow the convention set for the ST-specific registers that
> look e.g. like this:
I agree, Will fix these in next version.
>
> MCI_ST_8BIT_BUS i.e. MCI_<vendor>_SPECIFIER
> So the below becomes MCI_QCOM_CLK_WIDEBUS... etc.
>
