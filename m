From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 1/1] mmc: of_mmc_spi: fix card detect irq
Date: Mon, 27 May 2013 16:13:06 +0200
Message-ID: <20130527141306.GS24476@game.jcrosoft.org>
References: <1369571337-9300-1-git-send-email-plagnioj@jcrosoft.com>
 <51A25ECA.2060001@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <51A25ECA.2060001@cogentembedded.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 23:13 Sun 26 May     , Sergei Shtylyov wrote:
> Hello.
> 
> On 05/26/2013 04:28 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> >set missing irq type the IRQF_ONESHOT
> >
> >Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> >Cc: stable <stable@vger.kernel.org> # 3.4+
> >Cc: linux-mmc@vger.kernel.org
> >---
> >  drivers/mmc/host/of_mmc_spi.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
> >index d720b5e..cfb2e61 100644
> >--- a/drivers/mmc/host/of_mmc_spi.c
> >+++ b/drivers/mmc/host/of_mmc_spi.c
> >@@ -74,8 +74,8 @@ static int of_mmc_spi_init(struct device *dev,
> >  {
> >  	struct of_mmc_spi *oms = to_of_mmc_spi(dev);
> >-	return request_threaded_irq(oms->detect_irq, NULL, irqhandler, 0,
> >-				    dev_name(dev), mmc);
> >+	return request_threaded_irq(oms->detect_irq, NULL, irqhandler,
> >+		IRQF_ONESHOT, dev_name(dev), mmc);
> 
>     Please don't change the indentation.
too long > 80

Best Regards,
J.
