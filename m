From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 RESEND 2/2] mmc: host: Add some quirks to be read from fdt in sdhci-pltm.c
Date: Wed, 29 Apr 2015 16:45:30 +0200
Message-ID: <2511590.IBzkZm5Ibi@wuerfel>
References: <1429630959-32649-1-git-send-email-stripathi@apm.com> <17258495.kJWOqBBcrn@wuerfel> <CAOHikRD6enDS2VyYH4Nz_+wz_m2v-61QyBDLixZxm-Y0qYtojA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOHikRD6enDS2VyYH4Nz_+wz_m2v-61QyBDLixZxm-Y0qYtojA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Anton Vorontsov <anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Mark Langsdorf <mlangsdo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, patches <patches-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wednesday 29 April 2015 19:55:53 Suman Tripathi wrote:
> >
> > The above assumes that the limitation is enforced by the bus (e.g. an
> > AHB bus can only do 32-bit DMA). It would be a little different if you
> > have a 64-bit AXI bus and the Arasan device itself is limited to 32-bit
> > independent of the width of the bus it is connected to. Can you find out
> > which of these two cases you have?
> >
> 
> We have 64 bit AXI and Arasan device or controller is 32 bit . So there is
> 64 bit AXI to 32 bit AHB translation.

Please be very specific here. If this is an AHB based MMC controller, you
should model that AHB bus in DT, with the 32-bit dma-ranges.

However, if this is an AXI based MMC controller that is limited to 32-bit
DMA, the correct change would be to make ensure that the driver never
asks for a 64-bit DMA mask with this hardware.

Both will result in a 32-bit dma mask being used, and high DMA handled
through the block bounce code or swiotlb, but it's best to ensure that
the DT representation matches the actual hardware as closely as possible,
so it keeps working when you change something in a future chip.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
