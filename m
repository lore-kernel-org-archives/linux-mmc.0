From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: bcm2835: Take SWIOTLB memory size limitation into
 account
Date: Tue, 27 Aug 2019 15:49:35 +0200
Message-ID: <CAPDyKFo6cWqRkJg=aoVzjHiR_Q6CWHe4et7QimWeWVZyLntQ9Q@mail.gmail.com>
References: <1566628264-3289-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1566628264-3289-1-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Eric Anholt <eric@anholt.net>, Lukas Wunner <lukas@wunner.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, 24 Aug 2019 at 08:31, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> Make sure the sdhost driver doesn't use requests bigger than SWIOTLB
> can handle.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Applies for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/bcm2835.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 7e0d3a4..7ec0d95 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -1314,7 +1314,7 @@ static int bcm2835_add_host(struct bcm2835_host *host)
>         }
>
>         mmc->max_segs = 128;
> -       mmc->max_req_size = 524288;
> +       mmc->max_req_size = min_t(size_t, 524288, dma_max_mapping_size(dev));
>         mmc->max_seg_size = mmc->max_req_size;
>         mmc->max_blk_size = 1024;
>         mmc->max_blk_count =  65535;
> --
> 2.7.4
>
