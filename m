From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v11 4/5] powerpc/fsl: move mpc85xx.h to include/linux/fsl
Date: Thu, 21 Jul 2016 20:34:12 +0200
Message-ID: <3917663.1nRrfqKY9D@wuerfel>
References: <1468723822-30457-1-git-send-email-oss@buserror.net> <146909676646.16700.8383344640490662952@concordia> <1469119526.25630.42.camel@buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1469119526.25630.42.camel-fOR+EgIDQEHk1uMJSBkQmQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Scott Wood <oss-fOR+EgIDQEHk1uMJSBkQmQ@public.gmane.org>
Cc: Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yangbo Lu <yangbo.lu-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thursday, July 21, 2016 11:45:26 AM CEST Scott Wood wrote:
> 
> For the MMC issue I suggest using ifdef CONFIG_PPC and mfspr(SPRN_SVR) like
> the clock driver does[1] and we can revisit the issue if/when we need to do
> something similar on an ARM chip.

That sounds ok to me. having an mfspr check isn't nice but does the
job to work around existing bindings. For future chips, we can hopefully
find a way to identify most quirks early enough that the DT binding
can describe them using distinct compatible strings or other properties,
if necessary with the help of the boot loader.

Some other folks on MIPS were interested in having the soc_device
matching infrastructure and contacted me off-list, but they can of
course take the patch I sent and work from that.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
