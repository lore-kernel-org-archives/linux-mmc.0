From: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 0/5] make sdhci device drivers self registered
Date: Mon, 21 Mar 2011 20:52:34 +0800
Message-ID: <20110321125233.GA28098@S2100-06.ap.freescale.net>
References: <1300694823-8300-1-git-send-email-shawn.guo@linaro.org>
	<201103211339.45305.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201103211339.45305.arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Mar 21, 2011 at 01:39:45PM +0100, Arnd Bergmann wrote:
[...]
> 
> Hi Shawn,
> 
Hi Arnd,

> The changes you make look very nice, great work there!
> 
> I think the split of the series into five patches is not ideal
> because you have more interdependencies than necessary, and it's
> not clear that the series can be safely bisected, especially
> with the way you do all the Kconfig/Makefile updates at the
> end.
> 
> A nicer way to partition the series would be
> 
> 1.   Add sdhci_pltfm_init helper
> 2-5. Convert each of the users, including the respective
>      Kconfig/Makefile changes
> 6.   remove obsolete code from sdhci-pltfm.c
> 
> As I said, that's just a detail and the end result is the same.
> If you don't get any other feedback and Chris is happy with the
> changes, I wouldn't expect you to reshuffle all the patches just
> for this.
> 
> Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> 
Actually, I knew there should be better partition of the patch set,
and it just did not come into my mind :)  You suggestion does look
better.  I would take it in the next spin.

Thanks for the suggestion.

-- 
Regards,
Shawn
