From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 5/7] arm64: set CONFIG_MMC_BCM2835=y in defconfig
Date: Fri, 17 Mar 2017 08:44:08 +0100
Message-ID: <CAPDyKFruXXDgAJjeuaoUUwKYjfineZvPobin3vw_UZc6soJR+g@mail.gmail.com>
References: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
 <1488964751-22763-10-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488964751-22763-10-git-send-email-kraxel@redhat.com>
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Lee Jones <lee@kernel.org>, Will Deacon <will.deacon@arm.com>, Eric Anholt <eric@anholt.net>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-rpi-kernel@lists.infradead.org, Catalin Marinas <catalin.marinas@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

- trimmed cc list

On 8 March 2017 at 10:19, Gerd Hoffmann <kraxel@redhat.com> wrote:
> We need to enable this controller so that we can switch the SD card's
> pinmux over to it by default, which will improve storage performance.
>
> Read access (dd with 64k blocks on rpi2):
>   CONFIG_MMC_SDHCI_IPROC: 11-12 MB/s
>   CONFIG_MMC_BCM2835:     19-20 MB/s
>
> Differences on write access are pretty much in the noise.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7c48028..519a55c 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -398,6 +398,7 @@ CONFIG_MMC_DW_EXYNOS=y
>  CONFIG_MMC_DW_K3=y
>  CONFIG_MMC_DW_ROCKCHIP=y
>  CONFIG_MMC_SUNXI=y
> +CONFIG_MMC_BCM2835=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
>  CONFIG_LEDS_GPIO=y
> --
> 1.8.3.1
>
Normally this change should go via the arm64 tree. However as the new
CONFIG_MMC_BCM2835 is added in this series, perhaps it makes sense to
that I pick it up. In such case I need an ack from some of the arm64
soc
folkz, like Catalin/Will.

Kind regards
Uffe
