From: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/4] omap hsmmc device tree support
Date: Wed, 14 Mar 2012 11:37:24 -0400
Message-ID: <87pqcfdwi3.fsf@laptop.org>
References: <1331564560-23276-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1331564560-23276-1-git-send-email-rnayak-l0cyMroinI0@public.gmane.org> (Rajendra
	Nayak's message of "Mon, 12 Mar 2012 20:32:36 +0530")
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
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Mar 12 2012, Rajendra Nayak wrote:
> The series adds device tree support for OMAP hsmmc
> driver.
>
> Changes in V2:
> -1- Minor fixes based on comments from Grant.
> -2- Added a seperate compatible for omap3.
> -3- Added a new binding "ti,needs-special-reset"
> to handle some mmc modules which need special
> softreset sequence.
> -4- Updated board dts files with "status = disable;"
> for unused mmc modules.
>
> Rob,
> I retained your ack on patch 1 despite the additional
> binding that I added to handle the special softreset
> sequence. Let me know if you have any issues with it.
>
> Chris.
> Patch 1 and Patch 2 apply cleanly on mmc-next and can
> be taken in from the mmc tree after relevent acks from
> DT folks.
> Patch 3 and Patch 4 which update dts files, I plan to
> push via linux-omap/Tony's tree.

Thanks, I've pushed patches 1 and 2 to mmc-next for 3.4, with Balaji's
Tested-by.

- Chris.
-- 
Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>
One Laptop Per Child
