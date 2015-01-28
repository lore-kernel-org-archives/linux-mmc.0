From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 5/5] ARM: dts: exynos5250-snow: Enable wifi power-on
Date: Wed, 28 Jan 2015 16:57:18 +0100
Message-ID: <54C906DE.9070308@collabora.co.uk>
References: <1422439819-29854-1-git-send-email-javier.martinez@collabora.co.uk>
 <1422439819-29854-6-git-send-email-javier.martinez@collabora.co.uk>
 <54C8EC38.6010702@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <54C8EC38.6010702@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arend van Spriel <arend@broadcom.com>
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hello Arend,

Thanks for your feedback.

On 01/28/2015 03:03 PM, Arend van Spriel wrote:
> On 01/28/15 11:10, Javier Martinez Canillas wrote:

>>   &dp {
>> @@ -531,17 +538,33 @@
>>   	status = "okay";
>>   	num-slots =<1>;
>>   	broken-cd;
>> +	cap-sdio-irq;
> 
> This seems like an unrelated change, right?
> 

Well, I found that enabling the SDIO IRQ signalling I had the double
of the transfer rate and I didn't think it justified a separate patch
but you are right and I'll split on v2.

> Regards,
> Arend
> 

Best regards,
Javier
