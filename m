From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH] mmc: at91-mci: remove driver
Date: Tue, 30 Oct 2012 16:33:50 +0100
Message-ID: <20121030153350.GC19021@game.jcrosoft.org>
References: <1351520875-31891-1-git-send-email-ludovic.desroches@atmel.com>
 <87625txrou.fsf@octavius.laptop.org>
 <20121030150113.GB19021@game.jcrosoft.org>
 <87ehkgov3a.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <87ehkgov3a.fsf@octavius.laptop.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chris Ball <cjb@laptop.org>
Cc: nicolas.ferre@atmel.com, ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 11:09 Tue 30 Oct     , Chris Ball wrote:
> Hi,
> 
> On Tue, Oct 30 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >> Thanks!  Pushed to mmc-next for 3.8.
> >
> > if you don't mind I prefer to take it via at91
> >
> > I've a patch series that cleanup the platform_data it's difficult to merge
> > with this one
> 
> Hm, I don't understand why it should be difficult to merge.  Is it
> because this patch modifies arch/arm/mach-at91/include/mach/board.h?
> 
> If so, sounds like we should just take that change out of this patch
> and have it go into your platform data cleanup patch, and then I can
> merge the drivers/mmc change independently?  Let me know what you think.
I'm modifing and moiving the board.h so this file will not exist anymore

and the platform data are not anymore in arch/arm/mach-at91/include/mach/board.h

Best Regards,
J.
> 
> Thanks,
> 
> - Chris.
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
