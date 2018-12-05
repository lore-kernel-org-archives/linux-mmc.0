From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 0/7] mmc: Several fixes for bcm2835 driver
Date: Wed, 5 Dec 2018 15:23:05 +0100
Message-ID: <CAPDyKFqM6RB58n-ZdTipDQZ6v9rQe89ndrSNdhd7OtRkcSozww@mail.gmail.com>
References: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1541967839-2847-1-git-send-email-stefan.wahren-eS4NqCHxEME@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, msuchanek-l3A5Bk7waGM@public.gmane.org, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Sun, 11 Nov 2018 at 21:24, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> wrote:
>
> This patch series fixes several issues which has been discovered after
> submission.
>
> Changes in V2:
> - add my own signed-off-by to patches #1 and #2
>
> Michal Suchanek (1):
>   mmc: bcm2835: reset host on timeout
>
> Phil Elwell (1):
>   mmc: bcm2835: Recover from MMC_SEND_EXT_CSD
>
> Stefan Wahren (5):
>   mmc: bcm2835: Release DMA channel on driver unload
>   mmc: bcm2835: Avoid possible races on data requests
>   mmc: bcm2835: Terminate timeout work synchronously
>   mmc: bcm2835: Refactor dma_map_sg handling
>   mmc: bcm2835: Properly handle dmaengine_prep_slave_sg
>
>  drivers/mmc/host/bcm2835.c | 58 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 38 insertions(+), 20 deletions(-)
>
> --
> 2.7.4
>

Applied for next, thanks!

Kind regards
Uffe
