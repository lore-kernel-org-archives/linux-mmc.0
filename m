From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RESEND v5 0/4] atmel-mci device tree support
Date: Tue, 24 Jul 2012 16:23:01 +0000
Message-ID: <201207241623.01588.arnd@arndb.de>
References: <1343136606-8874-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1343136606-8874-1-git-send-email-ludovic.desroches@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: plagnioj@jcrosoft.com, ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, cjb@laptop.org, nicolas.ferre@atmel.com
List-Id: linux-mmc@vger.kernel.org

On Tuesday 24 July 2012, ludovic.desroches@atmel.com wrote:
> I resend this set of patches because patches 2, 3 and 4 were acked by
> Jean-Christophe. Patch 1 was also acked by Jean-Christophe excepted for
> cd-inverted property since it was redundant with gpio bindings.
> 
> I thought we were agree to go ahead since it was a common binding already
> documented and it will concern all drivers.

I just looked at the patches for the first time, but it looks all great, so 

Acked-by: Arnd Bergmann <arnd@arndb.de>

> Chris are you agree to take patch 1/4? Others patches may go to at91 tree,
> isn't it?
> By the way, I have updated documentation in patch 1/4 in the same way as you
> did with the patch 'mmc: dt: Deduplicate binding docs by referencing mmc.txt'.
> I didn't remove common properties from slot part because I think it is not
> obvious to use these properties into the slot node.

If you want to take it all through the mmc tree, that's also fine with me.

	Arnd
