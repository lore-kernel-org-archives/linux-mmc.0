From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH V4 1/4] mmc: core: Initial support for MMC power sequences
Date: Wed, 28 Jan 2015 11:17:22 +0100
Message-ID: <CABxcv==xBNsh+NrVb8PcBVtxQOKDL79YMkwK=wOL0gJZriEUjw@mail.gmail.com>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
 <1421658784-11980-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1421658784-11980-2-git-send-email-ulf.hansson@linaro.org>
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

On Mon, Jan 19, 2015 at 10:13 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> System on chip designs may specify a specific MMC power sequence. To
> successfully detect an (e)MMC/SD/SDIO card, that power sequence must
> be followed while initializing the card.
>
> To be able to handle these SOC specific power sequences, let's add a
> MMC power sequence interface. It provides the following functions to
> help the mmc core to deal with these power sequences.
>
> mmc_pwrseq_alloc() - Invoked from mmc_of_parse(), to initialize data.
> mmc_pwrseq_pre_power_on()- Invoked in the beginning of mmc_power_up().
> mmc_pwrseq_post_power_on()- Invoked at the end in mmc_power_up().
> mmc_pwrseq_power_off()- Invoked from mmc_power_off().
> mmc_pwrseq_free() - Invoked from mmc_free_host(), to free data.
>
> Each MMC power sequence provider will be responsible to implement a set
> of callbacks. These callbacks mirrors the functions above.
>
> This patch adds the skeleton, following patches will extend the core of
> the MMC power sequence and add support for a specific simple MMC power
> sequence.
>
> Do note, since the mmc_pwrseq_alloc() is invoked from mmc_of_parse(),
> host drivers needs to make use of this API to enable the support for
> MMC power sequences. Moreover the MMC power sequence support depends on
> CONFIG_OF.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Patch looks good to me and I could successfully get the SDIO wlan chip
in the Snow Chromebook after extending the pwrseq_simple driver so on
Exynos5250 Snow Chromebook:

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
