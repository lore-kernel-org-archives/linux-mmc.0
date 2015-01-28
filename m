From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH V4 1/4] mmc: core: Initial support for MMC power sequences
Date: Wed, 28 Jan 2015 13:47:28 +0100
Message-ID: <CABxcv==6AtUxbaXSmYm3fx4961x_UsN_oCLmWbTY9EZR_iZN9g@mail.gmail.com>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
 <1421658784-11980-2-git-send-email-ulf.hansson@linaro.org>
 <CABxcv==xBNsh+NrVb8PcBVtxQOKDL79YMkwK=wOL0gJZriEUjw@mail.gmail.com>
 <CAPDyKFoze-26fPm+C=D_o3tMSXWeTV4=2ZfOKaC3uLtxCrtjvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFoze-26fPm+C=D_o3tMSXWeTV4=2ZfOKaC3uLtxCrtjvg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Russell King <linux@arm.linux.org.uk>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Arnd Bergmann <arnd@arndb.de>, Alexandre Courbot <gnurou@gmail.com>, NeilBrown <neilb@suse.de>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Doug Anderson <dianders@chromium.org>, Olof Johansson <olof@lixom.net>, Mark Brown <broonie@kernel.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hello Ulf,

On Wed, Jan 28, 2015 at 12:36 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> ---
>>
>> Patch looks good to me and I could successfully get the SDIO wlan chip
>> in the Snow Chromebook after extending the pwrseq_simple driver so on
>> Exynos5250 Snow Chromebook:
>
> By extending you mean?
>

Sorry, I shoud had mentioned it. I meant the "Add multiple GPIO and
external clock to MMC pwrseq_simple" series [0] I posted before.

>>
>> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>
>> Best regards,
>> Javier
>
> Thanks for testing and reviewing! I have applied your tags to the patches.
>

You are welcome, thanks a lot for working on this.

Best regards,
Javier

[0]: http://www.spinics.net/lists/arm-kernel/msg395445.html
