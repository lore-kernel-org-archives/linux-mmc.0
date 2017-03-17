From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 3/7] mmc: bcm2835: add sdhost controller to devicetree
Date: Fri, 17 Mar 2017 08:48:25 +0100
Message-ID: <CAPDyKFpX-P+K+88BNmkL0G7k0afqs_mSCcZS=ZVSavuhBjpCKA@mail.gmail.com>
References: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
 <1488964751-22763-6-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488964751-22763-6-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Lee Jones <lee@kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Eric Anholt <eric@anholt.net>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-rpi-kernel@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

- trimmed cc-list

On 8 March 2017 at 10:19, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Eric Anholt <eric@anholt.net>

Again this is arm soc material. You need to change the prefix of the
commit msg to also reflect that.

*If* I am going to pick this up I need acks.

Kind regards
Uffe

> ---
>  arch/arm/boot/dts/bcm2835-rpi.dtsi |  6 ++++++
>  arch/arm/boot/dts/bcm283x.dtsi     | 10 ++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> index 1e00a28..8b95832 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
> +++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> @@ -69,6 +69,12 @@
>         bus-width = <4>;
>  };
>
> +&sdhost {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&sdhost_gpio48>;
> +       bus-width = <4>;
> +};
> +
>  &pwm {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pwm0_gpio40 &pwm1_gpio45>;
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index 9798bc9..19099a5 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -350,6 +350,16 @@
>                         arm,primecell-periphid = <0x00241011>;
>                 };
>
> +               sdhost: mmc@7e202000 {
> +                       compatible = "brcm,bcm2835-sdhost";
> +                       reg = <0x7e202000 0x100>;
> +                       interrupts = <2 24>;
> +                       clocks = <&clocks BCM2835_CLOCK_VPU>;
> +                       dmas = <&dma 13>;
> +                       dma-names = "rx-tx";
> +                       status = "disabled";
> +               };
> +
>                 i2s: i2s@7e203000 {
>                         compatible = "brcm,bcm2835-i2s";
>                         reg = <0x7e203000 0x20>,
> --
> 1.8.3.1
>
