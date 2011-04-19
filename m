From: Tony Olech <tony.olech@elandigitalsystems.com>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
 Re-Resubmission
Date: Tue, 19 Apr 2011 10:05:52 +0100
Message-ID: <1303203952.1622.19.camel@apple-mac>
References: <20B0EAA71DD7413A9A29D0493C6C1D87@AN00536>
	 <1295607004.1816.6.camel@apple-mac> <1299773604.1682.21.camel@apple-mac>
	 <201103151723.32942.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:61018 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab1DSJGB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2011 05:06:01 -0400
In-Reply-To: <201103151723.32942.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Tue, 2011-03-15 at 17:23 +0100, Arnd Bergmann wrote:
> On Thursday 10 March 2011, Tony Olech wrote:
...
> > +static ssize_t __show_operating_mode(struct vub300_mmc_host *vub300,
> > +                                   struct mmc_host *mmc, char *buf)
> > +{
> > +       int usb_packet_size = vub300->large_usb_packets ? 512 : 64;
> > +       if (vub300->vub_name[0])
> > +               return sprintf(buf, "VUB %s %s %d MHz %s %d byte USB packets"
> > +                               " using %s\n",
> > +                      (mmc->caps & MMC_CAP_SDIO_IRQ) ? "IRQs" : "POLL",
> > +                      (mmc->caps & MMC_CAP_4_BIT_DATA) ? "4-bit" : "1-bit",
> > +                      mmc->f_max / 1000000,
> > +                      pad_input_to_usb_pkt ? "padding input data to" : "with",
> > +                      usb_packet_size, vub300->vub_name);
> > +       else
> > +               return sprintf(buf, "VUB %s %s %d MHz %s %d byte USB packets"
> > +                               " and no offload processing\n",
> > +                      (mmc->caps & MMC_CAP_SDIO_IRQ) ? "IRQs" : "POLL",
> > +                      (mmc->caps & MMC_CAP_4_BIT_DATA) ? "4-bit" : "1-bit",
> > +                      mmc->f_max / 1000000,
> > +                      pad_input_to_usb_pkt ? "padding input data to" : "with",
> > +                      usb_packet_size);
> > +}
> > +
> > +static ssize_t show_operating_mode(struct device *dev,
> > +                                 struct device_attribute *attr, char *buf)
> > +{
> > +       struct mmc_host *mmc = container_of(dev, struct mmc_host, class_dev);
> > +       if (mmc) {
> > +               struct vub300_mmc_host *vub300 = mmc_priv(mmc);
> > +               return __show_operating_mode(vub300, mmc, buf);
> > +       } else {
> > +               return sprintf(buf, "VUB driver has no attached device");
> > +       }
> > +}
> 
> This sysfs attribute is rather hard to parse from user space, it looks
> like it's designed only to be read by humans. I think it would be better
> to use multiple attributes, each of which has only a single piece
> of information in it.
> 
> Some of these attributes however don't really belong into this driver
> but into the core, like the 1-bit / 4-bit mode. Please leave this out
> of your driver, and submit a separate patch to the mmc core if you
> think it's reasonable.

The purpose of this read-only interface is for VUB300 support
staff to obtain information from our customers. Our customers
are not like the people on this list. If you have ever tried
to do telephone support you would appreciate the difficulty
of getting a non-technical person to first of all find the
log files and then to extract the correct lines. It therefore
follows that if the 1 or 4 bit mode is useful info for the 
VUB300 support staff, then this read-only interface is the
appropriate single place for it to be provided. The overhead
of providing such an interface is negligible and the existance
of such an interface demonstrates that linux is no longer
designed only for geeks.

Tony Olech




