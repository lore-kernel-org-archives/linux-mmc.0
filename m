From: Peter Korsgaard <peter-+2lRwdCCLRT2eFz/2MeuCQ@public.gmane.org>
Subject: Re: [PATCH] mmc: android-goldfish: fix potential panic due to null
 pointer
Date: Mon, 22 Aug 2016 14:33:01 +0200
Message-ID: <87bn0lrnk2.fsf@dell.be.48ers.dk>
References: <1471750476-335-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1471750476-335-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> (Shawn
 Lin's message of "Sun, 21 Aug 2016 11:34:36 +0800")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

>>>>> "Shawn" == Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> writes:

 > We should never compare virt_base with zero to indicate whether
 > we get the right buffer or not from dma_alloc_coherent. It's quite
 > architecture related. If failing to get the address from CMA or swoitlb
 > cases, the sub architecture code should decide the return value for it.
 > So we should never presume that zero always means the failure.

 > Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
 > ---

 >  drivers/mmc/host/android-goldfish.c | 2 +-
 >  1 file changed, 1 insertion(+), 1 deletion(-)

 > diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
 > index dca5518..6d8bd03 100644
 > --- a/drivers/mmc/host/android-goldfish.c
 > +++ b/drivers/mmc/host/android-goldfish.c
 > @@ -484,7 +484,7 @@ static int goldfish_mmc_probe(struct platform_device *pdev)
 host-> virt_base = dma_alloc_coherent(&pdev->dev, BUFFER_SIZE,
 >  					     &buf_addr, GFP_KERNEL);
 
 > -	if (host->virt_base == 0) {
 > +	if (!host->virt_base) {

Huh, these are equivalent?

-- 
Bye, Peter Korsgaard
