From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH RFC 0/3] mmc: mxs-mmc: Implement DDR support
Date: Sat, 6 Aug 2016 15:10:16 +0200
Message-ID: <ef08cd86-8366-31b3-1f05-d0c7251cded6@denx.de>
References: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Fabio Estevam <fabio.estevam@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, devicetree@vger.kernel.org, Otavio Salvador <otavio@ossystems.com.br>, Holger Schurig <holgerschurig@gmail.com>, linux-mmc@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 08/06/2016 02:55 PM, Stefan Wahren wrote:
> Based on these discussions: [1], [2] this patch series implements
> DDR support for the MXS MMC host driver. This feature has never been
> ported from the vendor kernel.
> 
> It has been tested on a i.MX28 board with eMMC which is currently
> not in mainline (Duckbill 2).
> 
> * without DDR support
> dd if=/dev/zero of=test bs=8k count=10000
> 81920000 bytes (82 MB) copied, 14.3321 s, 5.7 MB/s
> 
> * with DDR support:
> dd if=/dev/zero of=test bs=8k count=10000
> 81920000 bytes (82 MB) copied, 13.4781 s, 6.1 MB/s

Not much of a speedup, how so ?

> [1] - http://www.spinics.net/lists/linux-mmc/msg32285.html
> [2] - http://www.spinics.net/lists/linux-mmc/msg34418.html
> 
> Stefan Wahren (3):
>   DT: bindings: mmc: Add property for 3.3V only support
>   mmc: core: add new cap for 3.3V only DDR MMCs
>   mmc: mxs-mmc: Implement DDR support
> 
>  Documentation/devicetree/bindings/mmc/mmc.txt |    7 +++++--
>  drivers/mmc/core/host.c                       |    2 ++
>  drivers/mmc/core/mmc.c                        |    6 ++++++
>  drivers/mmc/host/mxs-mmc.c                    |   22 ++++++++++++++++++++++
>  include/linux/mmc/host.h                      |    1 +
>  5 files changed, 36 insertions(+), 2 deletions(-)
> 


-- 
Best regards,
Marek Vasut
