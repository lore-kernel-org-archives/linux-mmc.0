From: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4] sdio: optimized SDIO IRQ handling for single irq
Date: Wed, 11 May 2011 10:40:13 -0400
Message-ID: <m3d3jp2tde.fsf@pullcord.laptop.org>
References: <1305100416-5395-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1305100416-5395-1-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> (Per
	Forlin's message of "Wed, 11 May 2011 09:53:35 +0200")
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Per,

On Wed, May 11 2011, Per Forlin wrote:
> Optimize performance for single irq
>
> Changes since v2.
>  * Rebase on mmc-next, change of line numbers no code changes.
>
> Stefan Nilsson XK (1):
>   sdio: optimized SDIO IRQ handling for single irq
>
>  drivers/mmc/core/sdio_irq.c |   33 ++++++++++++++++++++++++++++++++-
>  include/linux/mmc/card.h    |    1 +
>  2 files changed, 33 insertions(+), 1 deletions(-)

Odd, still doesn't apply here:

error: patch failed: drivers/mmc/core/sdio_irq.c:42
error: drivers/mmc/core/sdio_irq.c: patch does not apply

patch -p1 says:
Hunk #2 succeeded at 53 with fuzz 1.

So this still isn't rebased onto mmc-next properly.  There haven't been
any changes to drivers/mmc/core/sdio_irq.c since 2008, though, so now
I'm wondering where you got the fuzz from..

- Chris.
-- 
Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>
One Laptop Per Child
