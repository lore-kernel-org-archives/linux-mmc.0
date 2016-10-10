From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: block: add missing header dependencies
Date: Mon, 10 Oct 2016 14:37:55 +0200
Message-ID: <CAPDyKFpTB-YM3J3dB7Us0Q_AF2fojm369eZmHw7M2v1ZiWJu2Q@mail.gmail.com>
References: <1475199459-4775-1-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1475199459-4775-1-git-send-email-baoyou.xie@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, tang.qiang007@zte.com.cn, xie.baoyou@zte.com.cn, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, han.fei@zte.com.cn, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 30 September 2016 at 03:37, Baoyou Xie <baoyou.xie@linaro.org> wrote:
> We get 1 warning when building kernel with W=1:
> drivers/mmc/card/block.c:2147:5: warning: no previous prototype for 'mmc_blk_issue_rq' [-Wmissing-prototypes]
>
> In fact, this function is declared in drivers/mmc/card/block.h,
> so this patch adds missing header dependencies.
>
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/card/block.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index c333511..0f2cc9f2 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -46,6 +46,7 @@
>  #include <asm/uaccess.h>
>
>  #include "queue.h"
> +#include "block.h"
>
>  MODULE_ALIAS("mmc:block");
>  #ifdef MODULE_PARAM_PREFIX
> --
> 2.7.4
>
