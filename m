From: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/6] mmc: omap_hsmmc: Clean up use/abuse of pdev->id
Date: Thu, 08 Mar 2012 23:53:35 -0500
Message-ID: <m2boo6pe7k.fsf@bob.laptop.org>
References: <1329996409-26861-1-git-send-email-rnayak@ti.com>
	<4F476228.7060607@ti.com> <4F54714E.6080805@ti.com>
	<4F57312E.4080104@ti.com> <m2pqcoihhu.fsf@bob.laptop.org>
	<4F589C94.9010601@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <4F589C94.9010601-l0cyMroinI0@public.gmane.org> (Rajendra Nayak's message of "Thu, 08
	Mar 2012 17:18:36 +0530")
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Mar 08 2012, Rajendra Nayak wrote:
> There's just one other cleanup patch here [1] to convert all pr_* prints
> in the driver to dev_*. Would be great if you can pick that as well.
>
> Thanks,
> Rajendra
>
> [1] http://marc.info/?l=linux-mmc&m=132999677405098&w=3

Thanks, I've pushed this to mmc-next for 3.4 now too.

- Chris.
-- 
Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>
One Laptop Per Child
