From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH V4 2/4] mmc: pwrseq: Document DT bindings for the simple
 MMC power sequence
Date: Wed, 28 Jan 2015 11:18:12 +0100
Message-ID: <CABxcv=mCM63BobL+MP8LQhrh6HvtfromCouk2H6XdiFUm8ovmw@mail.gmail.com>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
 <1421658784-11980-3-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1421658784-11980-3-git-send-email-ulf.hansson@linaro.org>
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
> To support SOCs which specifies specific MMC power sequences, document
> some MMC DT bindings to be able to describe these hardwares.
>
> Let's also document bindings for a simple MMC power sequence provider,
> which purpose is to support a set of common properties between various
> SOCs.
>
> In this initial step, let's also document a top level description of
> the MMC power sequence and describe the compatible string used for the
> simple MMC power sequence provider.
>
> The simple MMC power sequence provider will initially support a reset
> GPIO. From several earlier posted patches, it's clear that such
> hardware exists. Especially some WLAN chips which are attached to an
> SDIO interface may use a GPIO reset.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
