From: Prabu Thangamuthu <Prabu.T@synopsys.com>
Subject: RE: [PATCH 1/1] mmc: sdhci-pci: add Support of Synopsys DWC_MSHC IP
Date: Tue, 19 Apr 2016 05:17:49 +0000
Message-ID: <705D14B1C7978B40A723277C067CEDE2010A4B0FA7@IN01WEMBXB.internal.synopsys.com>
References: <705D14B1C7978B40A723277C067CEDE2010A4B0DFB@IN01WEMBXB.internal.synopsys.com>
 <20160418185517.GB10906@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:35263 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbcDSFR5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 01:17:57 -0400
In-Reply-To: <20160418185517.GB10906@kroah.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Prabu Thangamuthu <Prabu.T@synopsys.com>
Cc: "Ulf Hansson (ulf.hansson@linaro.org)" <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Guenter Roeck <linux@roeck-us.net>, Jiri Slaby <jslaby@suse.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Andrei Pistirica <andrei.pistirica@microchip.com>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Joshua Henderson <joshua.henderson@microchip.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Greg K-H,

> On  Tuesday, April 19, 2016 12:25 AM, Greg Kroah-Hartman Wrote:
>
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h index
> > 247da8c..01f743b 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2318,6 +2318,9 @@
> >  #define PCI_DEVICE_ID_CENATEK_IDE	0x0001
> >
> >  #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
> > +#define PCI_DEVICE_ID_MOBSTOR_HAPS51	0xc101
> > +#define PCI_DEVICE_ID_MSHC_HAPS51	0xc201
> > +#define PCI_DEVICE_ID_MSHC_HAPSDX	0xc202
> 
> Please read the top of this file for why you should not add any new entries to
> it. 

Thank you for pointing it. 
I will update the Patch accordingly.

Regards,
Prabu Thangamuthu.
