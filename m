From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/5] mmc: pwrseq: Document that simple sequence support
 more than one GPIO
Date: Wed, 28 Jan 2015 17:35:35 +0100
Message-ID: <54C90FD7.40601@collabora.co.uk>
References: <1422439819-29854-1-git-send-email-javier.martinez@collabora.co.uk>
 <1422439819-29854-2-git-send-email-javier.martinez@collabora.co.uk>
 <54C90F89.1040500@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <54C90F89.1040500@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Srinivas,

On 01/28/2015 05:34 PM, Srinivas Kandagatla wrote:
>> -- reset-gpios : contains a GPIO specifier. The reset GPIO is asserted at
>> -	initialization and prior we start the power up procedure of the card. It
>> -	will be de-asserted right after the power has been provided to the card.
>> +- reset-gpios : contains a list of GPIO specifiers. The reset GPIOs are asserted
>> +	at initialization and prior we start the power up procedure of the card.
>> +	Will be de-asserted right after the power has been provided to the card.
> Makes sense if you add "They" before last sentence.

Thanks, I'll change it.

Best regards,
Javier
