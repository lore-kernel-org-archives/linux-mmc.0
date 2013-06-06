From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH] mmc: atmel-mci: remove include <mach/cpu.h>
Date: Thu, 6 Jun 2013 10:33:00 +0200
Message-ID: <20130606083300.GJ23653@game.jcrosoft.org>
References: <1365511500-13778-1-git-send-email-nicolas.ferre@atmel.com>
 <20130605094225.GC2805@ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20130605094225.GC2805@ludovic.desroches@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 11:42 Wed 05 Jun     , Ludovic Desroches wrote:
> On Tue, Apr 09, 2013 at 02:45:00PM +0200, Nicolas Ferre wrote:
> > Header file not needed anymore as we have removed
> > the calls to cpu_is_xxx() macro.
> > 
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Late but of course:
> 
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
> 
> > ---
> >  drivers/mmc/host/atmel-mci.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> > index e75774f..08e2b92 100644
> > --- a/drivers/mmc/host/atmel-mci.c
> > +++ b/drivers/mmc/host/atmel-mci.c
> > @@ -40,8 +40,6 @@
> >  #include <asm/io.h>
> >  #include <asm/unaligned.h>
> >  
> > -#include <mach/cpu.h>
> > -
> >  #include "atmel-mci-regs.h"
> >  
> >  #define ATMCI_DATA_ERROR_FLAGS	(ATMCI_DCRCE | ATMCI_DTOE | ATMCI_OVRE | ATMCI_UNRE)
> > -- 
> > 1.8.0
> > 
