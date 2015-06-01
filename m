From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] mmc: sdhci-bcm2835: Clean up platform allocations
 if sdhci init fails.
Date: Mon, 1 Jun 2015 10:05:42 +0200
Message-ID: <CAPDyKFpah1Ym4wAVk3PN1PN8QoQjTNijbwBd3kT0QdKMqP0wWw@mail.gmail.com>
References: <1432933572-8695-1-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1432933572-8695-1-git-send-email-eric@anholt.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Anholt <eric@anholt.net>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 29 May 2015 at 23:06, Eric Anholt <eric@anholt.net> wrote:
> Signed-off-by: Eric Anholt <eric@anholt.net>

Thanks, applied!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-bcm2835.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
> index 0ef0343..32f4046 100644
> --- a/drivers/mmc/host/sdhci-bcm2835.c
> +++ b/drivers/mmc/host/sdhci-bcm2835.c
> @@ -173,8 +173,11 @@ static int bcm2835_sdhci_probe(struct platform_device *pdev)
>                 goto err;
>         }
>
> -       return sdhci_add_host(host);
> +       ret = sdhci_add_host(host);
> +       if (ret)
> +               goto err;
>
> +       return 0;
>  err:
>         sdhci_pltfm_free(pdev);
>         return ret;
> --
> 2.1.4
>
